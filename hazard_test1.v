`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:51:40 12/03/2018
// Design Name:   hazard
// Module Name:   Z:/Desktop/cpu/zzcpu/hazard_test1.v
// Project Name:  zzcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hazard
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module hazard_test1;

	// Inputs
	reg CLK;
	reg interception_i;
	reg memtoreg_i;
	reg memread_i;
	reg [3:0] regsrc1_i;
	reg [3:0] regsrc2_i;
	reg [3:0] regdst_i;
	reg isjump_i;
	reg ifbranch_i;
	reg isbranch_i;
	reg prediction_i;
	reg [15:0] epc_i;

	// Outputs
	wire jr_o;
	wire prewrong_o;
	wire precorrc_o;
	wire flush_if_o;
	wire flush_id_o;
	wire flush_ex_o;
	wire isintzero_o;
	wire [15:0] epc_o;

	// Instantiate the Unit Under Test (UUT)
	hazard uut (
		.CLK(CLK), 
		.interception_i(interception_i), 
		.memtoreg_i(memtoreg_i), 
		.memread_i(memread_i), 
		.regsrc1_i(regsrc1_i), 
		.regsrc2_i(regsrc2_i), 
		.regdst_i(regdst_i), 
		.isjump_i(isjump_i), 
		.jr_o(jr_o), 
		.ifbranch_i(ifbranch_i), 
		.isbranch_i(isbranch_i), 
		.prediction_i(prediction_i), 
		.prewrong_o(prewrong_o), 
		.precorrc_o(precorrc_o), 
		.flush_if_o(flush_if_o), 
		.flush_id_o(flush_id_o), 
		.flush_ex_o(flush_ex_o), 
		.isintzero_o(isintzero_o), 
		.epc_i(epc_i), 
		.epc_o(epc_o)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		interception_i = 0;
		memtoreg_i = 0;
		memread_i = 0;
		regsrc1_i = 0;
		regsrc2_i = 0;
		regdst_i = 0;
		isjump_i = 0;
		ifbranch_i = 0;
		isbranch_i = 0;
		prediction_i = 0;
		epc_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		epc_i = 16'hFFFF;
		#1;
		interception_i = 1;
		#1;
		epc_i = 16'hFF00;
		#1;
		CLK = 1;
		#3;
		interception_i = 0;
		CLK = 0;
	end
      
endmodule

