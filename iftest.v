`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:21:44 12/05/2018
// Design Name:   ifetch
// Module Name:   Z:/Desktop/cpu/zzcpu/iftest.v
// Project Name:  zzcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ifetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module iftest;

	// Inputs
	reg CLK;
	reg RST;
	reg stall_pc_i;
	reg jr_i;
	reg [15:0] address_jr_i;
	reg isbranch_i;
	reg prewrong_i;
	reg precorrc_i;
	reg [15:0] instr_i;

	// Outputs
	wire preresult_o;
	wire [15:0] pc_o;
	wire [15:0] pcplus1_o;
	wire [15:0] epc_o;

	// Instantiate the Unit Under Test (UUT)
	ifetch uut (
		.CLK(CLK), 
		.RST(RST), 
		.stall_pc_i(stall_pc_i), 
		.jr_i(jr_i), 
		.address_jr_i(address_jr_i), 
		.isbranch_i(isbranch_i), 
		.prewrong_i(prewrong_i), 
		.precorrc_i(precorrc_i), 
		.preresult_o(preresult_o), 
		.instr_i(instr_i), 
		.pc_o(pc_o), 
		.pcplus1_o(pcplus1_o), 
		.epc_o(epc_o)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
		stall_pc_i = 0;
		jr_i = 0;
		address_jr_i = 0;
		isbranch_i = 0;
		prewrong_i = 0;
		precorrc_i = 0;
		instr_i = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		RST = 1;
		#5;
		RST = 0;
		instr_i = 16'b0000100000000000;
		#5;
		CLK = 1;
		#5;
		CLK = 0;
		#5;
		CLK = 1;
		#5;
		CLK = 0;
		instr_i = 16'b0001011111111111;
		#5;
		CLK = 1;
		#5;
		CLK = 0;
		instr_i = 16'b0001001111111111;
		#5;
		CLK = 1;
		#5;
		CLK = 0;
		instr_i = 16'b0000001111111111;
		#5;
		CLK = 1;
		#5;
		CLK = 0;
		#5;
		CLK = 1;
		#5;
		CLK = 0;
	end
      
endmodule

