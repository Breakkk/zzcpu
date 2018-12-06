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
    input CLK,
    input interception_i,
    input ram2_conflict_i,
    input memtoreg_i,
    input memread_i,
    input [3:0] regsrc1_i,
    input [3:0] regsrc2_i,
    input [3:0] regdst_i,
    input isjump_i,
    output jr_o,
    input ifbranch_i,
    input isbranch_i,
    input prediction_i,
    output prewrong_o,
	output precorrc_o,
    output flush_if_o,
    output flush_id_o,
    output flush_ex_o,
    output isintzero_o,
    output stall_pc_o,
    output stall_if_o,
    input [15:0] epc_i,
    output reg [15:0] epc_o
    );
	
    // priority : Interception > LW/RAM > jr/branch
    
	wire conflictLW;
    wire prewrong;
    wire precorrc;
	wire stall;     // stall PC & IF
    reg intercepted = 0;

    assign precorrc = (isbranch_i && (prediction_i === ifbranch_i));
	assign prewrong = (isbranch_i && (prediction_i ^ ifbranch_i));
	assign conflictLW = ((memtoreg_i && memread_i) && ((regsrc1_i === regdst_i) || (regsrc2_i === regdst_i)));
    assign stall = (conflictLW || ram2_conflict_i);
	
	// while stalling: prediction judgment and jump order is "stalled", too
	assign prewrong_o = (prewrong) && (!stall) /*&& (!intercepted)*/;
	assign precorrc_o = (precorrc) && (!stall) /*&& (!intercepted)*/;
	// assign jr_o = isjump_i && (!stall_LW) && (!intercepted);
    // while stalling, PC won't change, doesn't matter is jr order is true
    assign jr_o = isjump_i;

    assign isintzero_o = intercepted;
    // assign flush_if_o = (((prewrong) || stall_LW) && (!intercepted));
    // flush & insertion priority judgement moved to IF/ID
    assign flush_if_o = (prewrong || isjump_i);
    assign flush_id_o = intercepted;
    assign flush_ex_o = intercepted;
    assign stall_pc_o = stall;
    assign stall_if_o = stall;

    always@(negedge CLK or posedge interception_i) begin
		if (interception_i) begin
            intercepted <= 1;
			epc_o <= epc_i;
        end else begin
			intercepted <= 0;
        end
    end
    


endmodule
