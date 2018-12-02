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
    input [15:0] epc_i,
    output [15:0] epc_o
    );
	
    // priority : Interception > LW > jr/branch
    
	wire stall_LW;
    wire precorrc;
	
    reg intercepted = 0;
	reg [15:0] epc;
	assign epc_o = epc;

    assign precorrc = (isbranch_i && (prediction_i === ifbranch_i));
	assign prewrong = (isbranch_i && (prediction_i ^ ifbranch_i));
	assign stall_LW = ((memtoreg_i && memread_i) && ((regsrc1_i === regdst_i) || (regsrc2_i === regdst_i)));
	
	//while stalling: prediction judgment and jump order is "stalled", too
	assign prewrong_o = (prewrong) && (!stall_LW) && (!intercepted);
	assign precorrc_o = (precorrc) && (!stall_LW) && (!intercepted);
	assign jr_o = isjump_i && (!stall_LW) && (!intercepted);
    assign isintzero_o = intercepted;
    assign flush_if_o = (((prewrong) || stall_LW) && (!intercepted));
    assign flush_id_o = intercepted;
    assign flush_ex_o = intercepted;

    always@(negedge CLK or posedge interception_i) begin
		if (interception_i) begin
            intercepted <= 1;
			epc <= epc_i;
        end else begin
			intercepted <= 0;
        end
    end
    


endmodule
