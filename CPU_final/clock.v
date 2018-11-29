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
	output reg clock
    );

reg [20: 0] cnt;	 

initial cnt = 0;
initial clock = 0;

always@ (posedge clk) begin
	cnt <= cnt + 1;
	if(cnt == 2500000) begin
		clock <= !clock;
		cnt <= 0;
	end
end


endmodule
