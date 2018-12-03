`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:45 11/29/2018 
// Design Name: 
// Module Name:    ALU 
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
////////
//////////////////////////////////////////////////////////////////////////////////
module ALU#(parameter OPERRATOR_WIDTH = 4)(
		input [OPERRATOR_WIDTH-1:0] OP,
		input [15:0] srcdata_a,
		input [15:0] srcdata_b,
		output [15:0] result
    );
	reg [15:0] temp_result;
	
	parameter ADD = 4'b0000;
	parameter AND = 4'b0001;
	parameter OR = 4'b0010;
	parameter SLL = 4'b0011;
	parameter SRL = 4'b0100;
	parameter SRA = 4'b0101;
	parameter SUB = 4'b0110;
	parameter EQUAL = 4'b0111;
	parameter LESS = 4'b1000;
	parameter MOVE = 4'b1001;
	parameter EMPTY = 4'b1111;
	
	always  @(*)begin
		case(OP)
			ADD:begin
				temp_result[15:0] <= srcdata_a[15:0] + srcdata_b[15:0];
			end
			SUB:begin
				temp_result[15:0] <= srcdata_a[15:0] - srcdata_b[15:0];
			end
			AND:begin
				temp_result[15:0] <= srcdata_a[15:0] & srcdata_b[15:0];
			end
			OR:begin
				temp_result[15:0] <= srcdata_a[15:0] | srcdata_b[15:0];
			end
			SLL:begin
				temp_result[15:0] <= srcdata_a[15:0] << srcdata_b[15:0];
			end
			SRL:begin    
				temp_result[15:0] <= srcdata_a[15:0] >> srcdata_b[15:0];
			end
			SRA:begin    
				temp_result[15:0] <= ($signed(srcdata_a[15:0])) >>> srcdata_b[15:0];
			end
			EQUAL:begin    
				if(srcdata_a == srcdata_b)
					temp_result[15:0] <= 16'h0000;
				else
					temp_result[15:0] <= 16'h0001;
			end
			LESS:begin    
				if($signed(srcdata_a) < $signed(srcdata_b))
					temp_result[15:0] <= 16'h0001;
				else
					temp_result[15:0] <= 16'h0000;
			end
			MOVE:begin
				temp_result[15:0] <= srcdata_a[15:0];
			end
			default:begin   
				temp_result[15:0] <= 16'h0000;
			end 
		endcase
	end
	
	assign result[15:0] = temp_result[15:0];
endmodule
