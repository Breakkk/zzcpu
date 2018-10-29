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
	 
    output [6:0] Led
    );

localparam W0 = 2'b00;
localparam W1 = 2'b01;
localparam W2 = 2'b10;
localparam R0 = 2'b11;

reg [1:0] c_state;
reg [1:0] n_state;

reg [15:0] startAddr;
reg [15:0] startValue;

reg [15:0] currAddr;
reg [15:0] currValue;

reg [15:0] ledLight;
reg [3:0] number;				//max: 10 values
reg read;

ledDecoder showLed(.index(number), .led(Led));
RAM ram(.addr(currAddr), .data(currValue), .RamAddr(Ram1Addr), .RamData(Ram1Data), .RamOE(Ram1OE), .RamWE(Ram1WE), .RamEN(Ram1EN), .read(read));

always@(posedge CLK or negedge RST)begin
	if(!RST)begin
		c_state <= W0;
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
				read = 1'b1;
			end
			else begin
				n_state = W2;
			end
		end
		R0:begin
			n_state = R0;
		end
	endcase
end

always@(posedge CLK or negedge RST)begin
	if(!RST) begin
		number <= 4'b0000;
		read <= 1'b0;
	end
	else begin
		case(c_state)
			W0:begin			// readAddr
				startAddr <= SW;
				currAddr <= SW;
				ledLight <= SW;
			end
			W1:begin			// readData and write into RAM +1
				currAddr <= startAddr + number;
				currValue <= SW;
				number <= number + 1'b1;
				ledLight <= SW;
			end
			W2:begin			// loop write into RAM +9
				number <= number + 1'b1;
				currAddr <= currAddr + 1'b1;
				currValue <= currValue + 1'b1;
				ledLight <= number;
			end
			R0:begin
				
				ledLight <= 16'hFFFF;
			end
		endcase
	end
end

assign Light = ledLight;

endmodule
