`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:22 12/01/2018 
// Design Name: 
// Module Name:    ex 
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
module ex(
    input [3:0] aluop_i,
    input [15:0] alusrc1_i,
    input [15:0] alusrc2_i,
    input [3:0] regsrc1_i,
    input [3:0] regsrc2_i,
    input [3:0] exregdst_i,
    input exregwrite_i,
    input [15:0] exregdata_i,
    input [3:0] memregdst_i,
    input memregwrite_i,
    input [15:0] memregdata_i,
    output [15:0] alures_o
    );

	// ATTENTION:  reg name in regsrc1(2)_i must refer to the source of alusrc1(2)_i
	// when reg name is 4'b1111, it means that the concerning alu data source doesn't come from any reg
	wire [15:0] alusrc1;
	wire [15:0] alusrc2;
	wire conflict_src1_ex;
	wire conflict_src2_ex;
	wire conflict_src1_mem;
	wire conflict_src2_mem;
	
	assign conflict_src1_ex = ((exregwrite_i) && (exregdst_i === regsrc1_i));
	assign conflict_src2_ex = ((exregwrite_i) && (exregdst_i === regsrc2_i));
	assign conflict_src1_mem = ((memregwrite_i) && (memregdst_i === regsrc1_i));
	assign conflict_src2_mem = ((memregwrite_i) && (memregdst_i === regsrc2_i));
	
	assign alusrc1 = ((conflict_src1_ex) ? (exregdata_i) : ((conflict_src1_mem) ? (memregdata_i) : (alusrc1_i)));
	assign alusrc2 = ((conflict_src2_ex) ? (exregdata_i) : ((conflict_src2_mem) ? (memregdata_i) : (alusrc2_i)));
	
	//assign alusrc1_o = alusrc1;
	//assign alusrc2_o = alusrc2;
	ALU _ALU(
		.OP(aluop_i),
		.srcdata_a(alusrc1),
		.srcdata_b(alusrc2),
		.result(alures_o)
	);
	
endmodule
