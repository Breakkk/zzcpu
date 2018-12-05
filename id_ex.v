`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:15:33 12/02/2018 
// Design Name: 
// Module Name:    id_ex 
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
module id_ex(
	input CLK,
	input RST,
    input regwrite_i,
    input memtoreg_i,
    input memread_i,
    input memwrite_i,
    input [15:0] memdata_i,
    input [3:0] aluop_i,
    input [15:0] alusrc1_i,
    input [15:0] alusrc2_i,
    input [3:0] regsrc1_i,
    input [3:0] regsrc2_i,
    input [3:0] regsrc_sw_i,
    input [3:0] regdst_i,
    input [15:0] epc_i,
    input flush_id_i,
    output regwrite_o,
    output memtoreg_o,
    output memread_o,
    output memwrite_o,
    output [3:0] aluop_o,
    output [15:0] alusrc1_o,
    output [15:0] alusrc2_o,
    output [3:0] regsrc1_o,
    output [3:0] regsrc2_o,
    output [3:0] regsrc_sw_o,
    output [15:0] memdata_o,
    output [3:0] regdst_o,
    output [15:0] epc_o
    );

	reg regwrite = 1'b0;
	reg memtoreg = 1'b0;
	reg memread = 1'b0;
	reg memwrite = 1'b0;
	reg [15:0] memdata = 16'h0000;
	reg [3:0] aluop = 4'b0000;
	reg [15:0] alusrc1 = 16'h0000;
	reg [15:0] alusrc2 = 16'h0000;
	reg [3:0] regsrc1 = 4'b1111;
	reg [3:0] regsrc2 = 4'b1111;
	reg [3:0] regsrc_sw = 4'b1111;
	reg [3:0] regdst = 4'b1111;
	reg [15:0] epc = 16'h0000;
	
	assign regwrite_o = regwrite;
	assign memtoreg_o = memtoreg;
	assign memread_o = memread;
	assign memwrite_o = memwrite;
	assign memdata_o = memdata;
	assign aluop_o = aluop;
	assign alusrc1_o = alusrc1;
	assign alusrc2_o = alusrc2;
	assign regsrc1_o = regsrc1;
	assign regsrc2_o = regsrc2;
	assign regsrc_sw_o = regsrc_sw;
	assign regdst_o = regdst;
	assign epc_o = epc;
	
	always@(posedge CLK or negedge RST) begin
		if (!RST) begin
			regwrite <= 1'b0;
			memtoreg <= 1'b0;
			memread <= 1'b0;
			memwrite <= 1'b0;
		end else begin
			regwrite <= ((!flush_id_i) & regwrite_i);
			memtoreg <= ((!flush_id_i) & memtoreg_i);
			memread <= ((!flush_id_i) & memread_i);
			memwrite <= ((!flush_id_i) & memwrite_i);
			memdata <= memdata_i;
			aluop <= aluop_i;
			alusrc1 <= alusrc1_i;
			alusrc2 <= alusrc2_i;
			regsrc1 <= regsrc1_i;
			regsrc2 <= regsrc2_i;
			regsrc_sw <= regsrc_sw_i;
			regdst <= regdst_i;
			epc <= epc_i;
		end
	end
endmodule
