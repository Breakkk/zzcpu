`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:27 11/29/2018 
// Design Name: 
// Module Name:    pc 
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
module pc(
	input clk,
	input rst,
	input hold, //
	input pc_jump,	//0-jump 1-not
	input pc_write,//0-writable 1-not
	input [17:0] pc_jump_val,
	output reg [17:0] pc
    );
	 
	initial pc = 16'h8000;
	
	always@ (posedge clk or negedge rst) begin
		if(!rst) begin
			pc <= 16'h8000;
		end
		else begin
			if(!pc_write) begin
				if(pc_jump) begin
					pc <= pc + 1;
				end
				else begin
					pc <= pc_jump_val;
				end
			end
		end
	end


endmodule
