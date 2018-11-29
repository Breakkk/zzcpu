`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:30 11/28/2018 
// Design Name: 
// Module Name:    Register 
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
module Register#(parameter WIDTH = 16, INIT = 0)(
	input [(WIDTH-1):0]d,
	input clk,
	input en_write,
	input reset,
	output reg [(WIDTH-1):0]q

	);

	
	always  @(posedge CLK)begin
		case(reset)
			1'b1:begin
				q[(WIDTH-1):0] <= 1'h0;
			end
			1'b0:begin
				q[(WIDTH-1):0] <= (en_write) ? d[(WIDTH-1):0] : q[(WIDTH-1):0];
			end
		endcase
	end

endmodule
