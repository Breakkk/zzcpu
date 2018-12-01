`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:55 12/01/2018 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
    input memtoreg_i,
    input memread_i,
    input [3:0] regsrc1_i,
    input [3:0] regsrc2_i,
    output stall_LW_o,
    input isjump_i,
    output jr_o,
    input ifbranch_i,
    input prediction_i,
    output prewrong_o,
	output precorrc_o,
    input [3:0] regdst_i
    );
	
	wire stall;
	
	assign stall = ((memtoreg_i && memread_i) && ((regsrc1_i === regdst_i) || (regsrc2_i === regdst_i)));
	assign stall_LW_o = stall;
	
	//while stalling: prediction judgment and jump order is "stalled", too
	assign prewrong_o = (prediction_i ^ ifbranch_i) && (!stall);
	assign precorrc_o = (prediction_i ^~ ifbranch_i) && (!stall);
	assign jr_o = isjump_i && (!stall);


endmodule
