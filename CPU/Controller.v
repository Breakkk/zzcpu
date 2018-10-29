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

localparam INITADDR	= 2'b00;
localparam INPUTDATA= 2'b01;
localparam READDATA = 2'b10;

reg [2:0] c_state;
reg [15:0] startAddr;
reg [15:0] currAddr;
reg [15:0] currValue;
wire [15:0] outputValue;
reg [15:0] ledLight;
reg [3:0] number;				//max: 10 values
reg read;
reg ram_trigger;

ledDecoder showLed(.index(number), .led(Led));
RAM ram(.clk(ram_trigger), .read(read), .addr(currAddr), .data_i(currValue), .data_o(outputValue), .RamAddr(Ram1Addr), .RamData(Ram1Data), .RamOE(Ram1OE), .RamWE(Ram1WE), .RamEN(Ram1EN));

always@(posedge CLK or negedge RST)begin
	if(!RST)begin
		c_state = INITADDR;
		number = 4'b0000;
	end else begin
		case(c_state)
			INITADDR: begin
				startAddr = SW;
				currAddr = SW;
				c_state = INPUTDATA;
				read = 1'b0;
				ram_trigger = 1'b0;
				ledLight = startAddr;
			end
			INPUTDATA: begin
				currValue = SW;
				ram_trigger = 1'b1;
				#20 ram_trigger = 1'b0;
				if (number == 4'b1001) begin
					c_state = READDATA;
					currAddr = startAddr;
					number = 4'b0000;
					read = 1'b1;
				end else begin
					if (currAddr != startAddr) begin
						number = number + 1'b1;
					end
					currAddr = currAddr + 1'b1;
				end
				ledLight = {currAddr[8:0], currValue[8:0]};
			end
			READDATA: begin
				ram_trigger = 1'b1;
				#20 ram_trigger = 1'b1;
				if (number == 4'b1001) begin
					c_state = INITADDR;
					number = 4'b0000;
				end else begin
					currAddr = currAddr + 1'b1;
					number = number + 1'b1;
				end
				ledLight = {currAddr[8:0], outputValue[8:0]};
			end
		endcase
	end
end

assign Light = ledLight;

endmodule
