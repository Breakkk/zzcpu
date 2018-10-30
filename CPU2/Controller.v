`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:10 10/28/2018 
// Design Name: 
// Module Name:    Controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Controller(
    input [15:0] SW,
    input CLK,
    input RST,
    output [15:0] Light,
	 
    output [17:0] Ram1Addr,
    inout [15:0] Ram1Data,
	 
    output Ram1OE,
    output Ram1WE,
    output Ram1EN,
	 
    output [6:0] Led,
	 
	 input clk1,
	 
	 output reg wrn,
	 output reg rdn
    );

localparam W0 = 3'b000;
localparam W1 = 3'b001;
localparam W2 = 3'b010;
localparam R0 = 3'b011;
localparam R1 = 3'b100;
localparam R2 = 3'b101;

reg [2:0] c_state;
reg [2:0] n_state;

reg [17:0] startAddr;
reg [15:0] startValue;

reg [17:0] currAddr;
reg [15:0] currValue;

reg [15:0] ledLight;
reg [3:0] number;				//max: 10 values
reg read;

reg oe;

ledDecoder showLed(.index(number), .led(Led));
RAM ram(.next(CLK), .addr(currAddr), .data(currValue), .Ram1Addr(Ram1Addr), .Ram1Data(Ram1Data), .Ram1OE(Ram1OE), .Ram1WE(Ram1WE), .Ram1EN(Ram1EN), .read(read), .clk(clk1));

always@(posedge CLK or negedge RST)begin
	if(!RST)begin
		c_state <= W0;
		wrn <= 1'b1;
		rdn <= 1'b1;
	end
	else begin
		c_state <= n_state;
	end
end

always@(c_state)begin
	n_state = W0;
	case(c_state)
		W0:begin
			n_state = W1;
		end
		W1:begin
			n_state = W2;
		end
		W2:begin
			if(number == 4'h9) begin
				n_state = R0;
			end
			else begin
				n_state = W2;
			end
		end
		R0:begin
			n_state = R1;
		end
		R1:begin
			n_state = R2;
		end
		R2:begin
			n_state = R2;
		end
	endcase
end

always@(posedge CLK or negedge RST)begin
	if(!RST) begin
		number <= 4'b0000;
		read <= 1'b0;
		ledLight <= 16'h0000;
	end
	else begin
		case(c_state)
			W0:begin			// readAddr
				startAddr <= SW;
				currAddr <= SW;
				ledLight <= SW;
			end
			W1:begin			// readData and write into RAM +1
				currAddr <= startAddr;
				currValue <= SW;
				number <= number + 1'b1;
				ledLight[15:8] <= currAddr[7:0];
				ledLight[7:0] <= SW[7:0];
			end
			W2:begin			// loop write into RAM +9
				number <= number + 1'b1;
				currAddr <= currAddr + 1'b1;
				currValue <= currValue + 1'b1;
				ledLight[15:8] <= currAddr[7:0] + 1'b1;
				ledLight[7:0] <= currValue[7:0];
			end
			R0:begin
				read <= 1'b1;
			end
			R1:begin
				currAddr <= startAddr;
//				ledLight[15:8] <= startAddr[7:0];
//				ledLight[7:0] <= Ram1Data[7:0];
				ledLight <= Ram1Data;
			end
			R2:begin
				currAddr <= currAddr + 1'b1;
//				ledLight[15:8] <= currAddr[7:0] + 1'b1;
//				ledLight[7:0] <= Ram1Data[7:0];
				ledLight <= Ram1Data;
			end

		endcase
	end
end

assign Light = ledLight;

endmodule
