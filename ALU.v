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
module ALU(
		input [3:0] OP,
		input [15:0] srcdata_a,
		input [15:0] srcdata_b,
		output [15:0] result
    );
	reg [15:0] temp_result;
	
	parameter ADD = 3'b000;
	parameter AND = 3'b010;
	parameter OR = 3'b011;
	parameter SLL = 3'b100;
	parameter SRL = 3'b101;
	parameter SRA = 3'b110;
	
	always  @(*)begin
		case(OP)
			ADD:begin
				temp_result[15:0] <= srcdata_a[15:0] + srcdata_b[15:0];
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
				temp_result[15:0] <= srcdata_a[15:0] >>> srcdata_b[15:0];
			end
			default:begin   
			
			end 
		endcase
	end
	
	assign result[15:0] = temp_result[15:0];
endmodule
