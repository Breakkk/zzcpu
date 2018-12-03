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
	input [ADDRESS_WIDTH-1:0] rdata1_i,
	input [ADDRESS_WIDTH-1:0] rdata2_i,
	input [INSTR_WIDTH-1:0] pcplus1_i,
	
	// signal from ID to RegHeap
	output [REG_WIDTH-1:0] readreg1_o,			//-
	output [REG_WIDTH-1:0] readreg2_o,			//-
	
	output regwrite_o,		// ctrl code		//-   
	output memtoreg_o,								//-
	output memread_o,								//-
	output memwrite_o,								//-
	output [ADDRESS_WIDTH-1:0] memdata_o,		//-
	output [OPERRATOR_WIDTH-1:0] aluop_o,		//-		// alu
	output [ADDRESS_WIDTH-1:0] alusrc1_o,		//-
	output [ADDRESS_WIDTH-1:0] alusrc2_o,		//-
	output [REG_WIDTH-1:0] regsrc1_o,  		//-		// name of the ALU src register
	output [REG_WIDTH-1:0] regsrc2_o,			//-
	output [REG_WIDTH-1:0] regsrc_sw_o,
	output [REG_WIDTH-1:0] regdst_o,			//-
	
	// signal from ID to Hazard detection unit
	output isjump_o,										//-			// jump & branch handling
	output isbranch_o,									//-
	// signal from ID to IF :
	output reg ifbranch_o,								//-
	output [ADDRESS_WIDTH-1:0] address_jr			//-
    );
 
	parameter B_IMME = 2'b00;
	parameter EQU_ZERO = 2'b01;
	parameter NOT_EQU_ZERO = 2'b10;
	

	wire [2:0] ALU_src;
	wire [15:0] im_data;
	wire IS_JUMP;
	wire IS_BRANCH;
	wire [1:0] equal_zero;
	
	always @(*) begin
		case(IS_BRANCH)
			1'b1:begin
				case(equal_zero)
					B_IMME:begin
						ifbranch_o <= 1'b1;
					end
					EQU_ZERO:begin
						case(rdata1_i)
						16'h0000:begin ifbranch_o <= 1'b1; end 
						default:begin ifbranch_o <= 1'b0; end 
						endcase
					end	
					NOT_EQU_ZERO:begin
						case(rdata1_i)
							16'h0000:begin ifbranch_o <= 1'b0; end 
							default:begin ifbranch_o <= 1'b1; end 
						endcase
					end
				endcase
			end
			1'b0:begin
				ifbranch_o <= 1'b0;
			end
		endcase
		
	end
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
		.regsrc_sw(regsrc_sw_o),
		
		.is_jump(IS_JUMP),
		.is_branch(IS_BRANCH),
		.eqz(equal_zero),
		
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
	
	assign address_jr = rdata1_i;
	
	assign isjump_o = IS_JUMP;
	assign isbranch_o = IS_BRANCH;
endmodule
