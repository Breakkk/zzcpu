`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:33 12/02/2018 
// Design Name: 
// Module Name:    ex_mem 
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
module ex_mem(
	input CLK,
	input RST,
    input flush_ex_i,
    input regwrite_i,
    input memtoreg_i,
    input memread_i,
    input memwrite_i,
    input [15:0] memdata_i,
    input [3:0] regdst_i,
    input [15:0] alures_i,
    output regwrite_o,
    output memtoreg_o,
    output memread_o,
    output memwrite_o,
    output [15:0] memdata_o,
    output [3:0] regdst_o,
    output [15:0] alures_o
    );

    reg regwrite = 1'b0;
    reg memtoreg = 1'b0;
	reg memread = 1'b0;
	reg memwrite = 1'b0;
	reg [15:0] memdata = 16'h0000;
    reg [3:0] regdst = 4'b1111;
    reg [15:0] alures = 16'h0000;
	
	assign regwrite_o = regwrite;
	assign memtoreg_o = memtoreg;
	assign memread_o = memread;
	assign memwrite_o = memwrite;
	assign memdata_o = memdata;
	assign regdst_o = regdst;
	assign alures_o = alures;
	
	always@(posedge CLK or negedge RST) begin
		if (!RST) begin
			regwrite = 1'b0;
			memtoreg = 1'b0;
			memread = 1'b0;
			memwrite = 1'b0;
		end else begin
			memtoreg <= ((!flush_ex_i) & memtoreg_i);
			memread <= ((!flush_ex_i) & memread_i);
			memwrite <= ((!flush_ex_i) & memwrite_i);
			regwrite <= ((!flush_ex_i) & regwrite_i);
			memdata <= memdata_i;
			alures <= alures_i;
			regdst <= regdst_i;
		end
	end

endmodule
