`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:27 11/29/2018 
// Design Name: 
// Module Name:    if_id 
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
module if_id(
	input clk,
	input flush,
	input [17:0] pc_in,
	output reg [17:0] pc_out,
	input [17:0] inst_in,
	output reg [17:0] inst_out
    );
	 
always@ (posedge clk) begin 
	pc_out <= pc_in;
	inst_out <= inst_in;
end


endmodule
