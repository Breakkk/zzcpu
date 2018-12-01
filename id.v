`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:54 12/01/2018 
// Design Name: 
// Module Name:    id 
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
module id#(
		parameter ADDRESS_WIDTH = 16,
		parameter INSTR_WIDTH =16,
		parameter OPERRATOR_WIDTH = 4,
		parameter REG_WIDTH = 4)(
		
	input [INSTR_WIDTH-1:0] instr_i,
	input [INSTR_WIDTH-1:0] epc_i,
	input ex_intcp_i,			// interception
	input [ADDRESS_WIDTH-1:0] rdata1_i,
	input [ADDRESS_WIDTH-1:0] rdata2_i,
	input [INSTR_WIDTH-1:0] pcplus1_i,
	
	// signal from ID to RegHeap
	output reg [REG_WIDTH-1:0] readreg1_o,			//-
	output reg [REG_WIDTH-1:0] readreg2_o,			//-
	
	output reg regwrite_o,		// ctrl code		//-   
	output reg memtoreg_o,								//-
	output reg memread_o,								//-
	output reg memwrite_o,								//-
	output reg [ADDRESS_WIDTH-1:0] memdata_o,		//-
	output reg [OPERRATOR_WIDTH-1:0] aluop_o,		//-		// alu
	output reg [ADDRESS_WIDTH-1:0] alusrc1_o,		//-
	output reg [ADDRESS_WIDTH-1:0] alusrc2_o,		//-
	output reg [REG_WIDTH-1:0] regsrc1_o,  		//-		// name of the ALU src register
	output reg [REG_WIDTH-1:0] regsrc2_o,			//-
	output reg [REG_WIDTH-1:0] regdst_o,			//-
	output [REG_WIDTH-1:0] epc_o,						//-
	output reg flush_id_o,											// interception handling
	// signal from ID to EX/MEM
	output reg flush_ex_o,
	// signal from ID to Hazard detection unit
	output reg isjump_o(isjump_id_o),							// jump & branch handling
	output reg isbranch_o(isbranch_id_o),
	// signal from ID to IF :
	output reg isintzero_o,
	output reg ifbranch_o(ifbranch_id_o),
	output reg [ADDRESS_WIDTH-1:0] address_jr(address_jr_id_o)
    );

	wire [2:0] ALU_src;
	wire [15:0] im_data;

	decoder _decoder(
		//in
		.PC(pcplus1_i),
		.instruction(instr_i),

		//out
		//ID
		.r_reg_A(readreg1_o),//reg A adress
		.r_reg_B(readreg2_o),//reg B adress
		.immediate(im_data),
		.ALU_SRC(ALU_src),

		.regsrc_A(regsrc1_o),
		.regsrc_B(regsrc2_o),

		//Ex
		.ALU_OP(aluop_o),

		//MEM
		.mem_read(memread_o),
		.mem_write(memwrite_o),

		//WB
		.REG_WRI(regwrite_o),
		.w_reg(regdst_o),//写寄存器地址
		.MemToReg(memtoreg_o)         //写入寄存器的数据来源（ALU 0 or MEM 1)

	);
	
	ALUSrc _alusrc(
		//in
		.ALU_SRC(ALU_src),
		.read_data_A(rdata1_i),
		.read_data_B(rdata2_i),
		.immediate(im_data),
		//out
		.srcdata_a(alusrc1_o),
		.srcdata_b(alusrc2_o),
		
		.memdata(memdata_o)
	);
	assign epc_o = epc_i;
endmodule
