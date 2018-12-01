`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:49:23 12/01/2018
// Design Name:   hazard
// Module Name:   Z:/Desktop/cpu/zzcpu/hazardtest.v
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

module hazardtest;

	// Inputs
	reg memtoreg_i;
	reg memread_i;
	reg [3:0] regsrc1_i;
	reg [3:0] regsrc2_i;
	reg isjump_i;
	reg ifbranch_i;
	reg prediction_i;
	reg [3:0] regdst_i;

	// Outputs
	wire stall_LW_o;
	wire jr_o;
	wire prewrong_o;
	wire precorrc_o;

	// Instantiate the Unit Under Test (UUT)
	hazard uut (
		.memtoreg_i(memtoreg_i), 
		.memread_i(memread_i), 
		.regsrc1_i(regsrc1_i), 
		.regsrc2_i(regsrc2_i), 
		.stall_LW_o(stall_LW_o), 
		.isjump_i(isjump_i), 
		.jr_o(jr_o), 
		.ifbranch_i(ifbranch_i), 
		.prediction_i(prediction_i), 
		.prewrong_o(prewrong_o),
		.precorrc_o(precorrc_o),
		.regdst_i(regdst_i)
	);

	initial begin
		// Initialize Inputs
		memtoreg_i = 0;
		memread_i = 0;
		regsrc1_i = 0;
		regsrc2_i = 0;
		isjump_i = 0;
		ifbranch_i = 0;
		prediction_i = 0;
		regdst_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#5;
		memtoreg_i = 1;
		memread_i = 1;
		prediction_i = 1;
		#3;
		regsrc1_i = 4'b0011;
		regsrc2_i = 4'b0101;
		regdst_i = 4'b0011;
		isjump_i = 0;
		#2;
		ifbranch_i = 1;
		
		#5;
		memtoreg_i = 1;
		memread_i = 1;
		prediction_i = 0;
		#3;
		regsrc1_i = 4'b1001;
		regsrc2_i = 4'b1101;
		regdst_i = 4'b1001;
		isjump_i = 1;
		#2;
		ifbranch_i = 0;

	end
      
endmodule

