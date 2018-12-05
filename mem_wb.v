`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:24 12/01/2018 
// Design Name: 
// Module Name:    mem_wb 
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
module mem_wb(
	input CLK,
	input RST,
    input memtoreg_i,
    input [3:0] regdst_i,
    input regwrite_i,
    input [15:0] alures_i,
    input [15:0] memres_i,
    output memtoreg_o,
    output [3:0] regdst_o,
    output regwrite_o,
    output [15:0] alures_o,
    output [15:0] memres_o
    );
	
    reg memtoreg;
    reg [3:0] regdst;
    reg regwrite;
    reg [15:0] alures;
    reg [15:0] memres;
	
	assign memtoreg_o = memtoreg;
	assign regdst_o = regdst;
	assign regwrite_o = regwrite;
	assign alures_o = alures;
	assign memres_o = memres;
	
	always@(posedge CLK or negedge RST) begin
		if (!RST) begin
			memtoreg <= 1'b0;
			regdst <= 1'b1111;
			regwrite <= 1'b0;
		end else begin
			memtoreg <= memtoreg_i;
			regdst <= regdst_i;
			regwrite <= regwrite_i;
			alures <= alures_i;
			memres <= memres_i;
		end
	end

endmodule
