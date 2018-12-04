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
	output [17:0] Ram2Addr,
	inout [15:0] Ram2Data,
	output Ram2OE,
	output Ram2WE,
	output [15:0] mem2res_o,
	input read,	//0-read 1-write
	input clk
    );
reg [15:0] memres2;
assign mem2res_o = memres2;

wire oe;
wire we;

assign Ram2OE = oe;
assign Ram2WE = we;

assign Ram2Data = !read ? 16'bz : data;
assign Ram2Addr = addr;

assign oe = !read ? !clk : 1'b1;
assign we = !read ? 1'b1 : !clk;

always@(negedge clk) begin
	if (read == 1'b0) begin
		memres2 <= Ram2Data;
	end
end
endmodule
