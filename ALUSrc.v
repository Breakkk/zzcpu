`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:14:56 12/01/2018 
// Design Name: 
// Module Name:    ALUSrc 
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
module ALUSrc#(parameter DATA_WID = 16)(
		
		input [2:0] ALU_SRC,
		input [DATA_WID-1:0] read_data_A,
		input [DATA_WID-1:0] read_data_B,
		input [DATA_WID-1:0] immediate,
		
		output reg [DATA_WID-1:0] srcdata_a,
		output reg [DATA_WID-1:0] srcdata_b,
		
		output [DATA_WID-1:0] memdata
    );
	
	parameter null = 3'b000;
	parameter r1_r2 = 3'b001;
	parameter r1_im = 3'b010;
	parameter r1_nu = 3'b011;
	parameter im_nu = 3'b100;
	parameter r2_r1 = 3'b101;
	
	always @(*) begin
		case(ALU_SRC)
			null:begin
				srcdata_a <= 16'h0000;
				srcdata_b <= 16'h0000;
			end
			r1_r2:begin
				srcdata_a <= read_data_A;
				srcdata_b <= read_data_B;
			end
			r1_im:begin
				srcdata_a <= read_data_A;
				srcdata_b <= immediate;
			end
			r1_nu:begin
				srcdata_a <= read_data_A;
				srcdata_b <= 16'h0000;
			end
			im_nu:begin
				srcdata_a <= immediate;
				srcdata_b <= 16'h0000;
			end
			r2_r1:begin
				srcdata_a <= read_data_B;
				srcdata_b <= read_data_A;
			end
		endcase
	end

	assign memdata = read_data_B;
endmodule
