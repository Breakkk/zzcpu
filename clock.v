`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:57:07 11/29/2018
// Design Name:
// Module Name:    clock
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
module clock(
	input clk,
	output clock
    );
assign clock = clk;
/*
reg [20: 0] cnt;
initial cnt = 0;
initial clock = 0;

always@ (posedge clk) begin
	cnt <= cnt + 1;
	if(cnt == 1) begin
		cnt <= 0;
	end
	clock <= !clock;
end*/


endmodule
