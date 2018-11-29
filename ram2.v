`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:55 11/29/2018 
// Design Name: 
// Module Name:    ram2 
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
module ram2(
	input [17:0] addr,
	input [15:0] data,
	output reg [17:0] Ram2Addr,
	inout [15:0] Ram2Data,
	output Ram2OE,
	output Ram2WE,
	output Ram2EN,
	input read,	//0-read 1-write
	input clk
    );

wire oe;
wire we;

assign Ram2OE = oe;
assign Ram2WE = we;

assign Ram2Data = !read ? 16'bz : data;

assign oe = !read ? !clk : 1'b1;
assign we = !read ? 1'b1 : !clk;


endmodule
