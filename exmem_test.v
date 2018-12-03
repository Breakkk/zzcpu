`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:20:01 12/03/2018
// Design Name:   ex_mem
// Module Name:   Z:/Desktop/cpu/zzcpu/exmem_test.v
// Project Name:  zzcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ex_mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module exmem_test;

	// Inputs
	reg CLK;
	reg flush_ex_i;
	reg regwrite_i;
	reg memtoreg_i;
	reg memread_i;
	reg memwrite_i;
	reg [15:0] memdata_i;
	reg [3:0] regdst_i;
	reg [15:0] alures_i;

	// Outputs
	wire regwrite_o;
	wire memtoreg_o;
	wire memread_o;
	wire memwrite_o;
	wire [15:0] memdata_o;
	wire [3:0] regdst_o;
	wire [15:0] alures_o;

	// Instantiate the Unit Under Test (UUT)
	ex_mem uut (
		.CLK(CLK), 
		.flush_ex_i(flush_ex_i), 
		.regwrite_i(regwrite_i), 
		.memtoreg_i(memtoreg_i), 
		.memread_i(memread_i), 
		.memwrite_i(memwrite_i), 
		.memdata_i(memdata_i), 
		.regdst_i(regdst_i), 
		.alures_i(alures_i), 
		.regwrite_o(regwrite_o), 
		.memtoreg_o(memtoreg_o), 
		.memread_o(memread_o), 
		.memwrite_o(memwrite_o), 
		.memdata_o(memdata_o), 
		.regdst_o(regdst_o), 
		.alures_o(alures_o)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		flush_ex_i = 0;
		regwrite_i = 0;
		memtoreg_i = 0;
		memread_i = 0;
		memwrite_i = 0;
		memdata_i = 0;
		regdst_i = 0;
		alures_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		memdata_i = 16'hFF00;
		#10;
		CLK = 1;
	end
      
endmodule

