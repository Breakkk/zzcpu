`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:27 12/02/2018 
// Design Name: 
// Module Name:    ram1 
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
module ram1(
		input [17:0] addr,
		input [15:0] data,
		output [17:0] Ram1Addr,
		inout [15:0] Ram1Data,
		output Ram1OE,
		output Ram1WE,
		input read,	//0-read 1-write
		input clk
    );

wire oe;
wire we;

assign Ram1OE = oe;
assign Ram1WE = we;

assign Ram1Data = !read ? 16'bz : data;
assign Ram1Addr = addr;

assign oe = !read ? !clk : 1'b1;
assign we = !read ? 1'b1 : !clk;

endmodule
