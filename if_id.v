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
	input CLK,
	input flush_if_i,
	input isintzero_i,
	input stall_if_i,
	input [15:0] epc_i,
	input [15:0] pcplus1_i,
	input [15:0] instr_i,
	output reg [15:0] epc_o,
	output reg [15:0] pcplus1_o,
	output reg [15:0] instr_o
    );
	
	always@(posedge CLK) begin
		if (isintzero_i) begin
	  		instr_o <= 16'b1111100000000000;		// instrcution code of INT 0
		end else if (!stall_if_i) begin
			if (flush_if_i) begin
				instr_o <= 16'b0000100000000000;		// instruction code of NOP
			end else begin
				epc_o <= epc_i;
				pcplus1_o <= pcplus1_i;
				instr_o <= instr_i;
			end
		end
	end
	


endmodule
