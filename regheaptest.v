`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:34:16 12/01/2018
// Design Name:   RegisterHeap
// Module Name:   Z:/Desktop/cpu/zzcpu/regheaptest.v
// Project Name:  zzcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterHeap
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regheaptest;

	// Inputs
	reg CLK;
	reg [3:0] rdreg1_i;
	reg [3:0] rdreg2_i;
	reg regwrite_i;
	reg [3:0] wrreg_i;
	reg [15:0] wdata_i;

	// Outputs
	wire [15:0] rdata1_o;
	wire [15:0] rdata2_o;

	// Instantiate the Unit Under Test (UUT)
	RegisterHeap uut (
		.CLK(CLK), 
		.rdreg1_i(rdreg1_i), 
		.rdreg2_i(rdreg2_i), 
		.regwrite_i(regwrite_i),
		.wrreg_i(wrreg_i), 
		.wdata_i(wdata_i), 
		.rdata1_o(rdata1_o), 
		.rdata2_o(rdata2_o)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		rdreg1_i = 0;
		rdreg2_i = 0;
		regwrite_i = 0;
		wrreg_i = 0;
		wdata_i = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		CLK = 1;
		wrreg_i = 4'b1000;
		wdata_i = 16'hf0f0;
		rdreg1_i = 4'b1000;
		rdreg2_i = 4'b1001;
		regwrite_i = 1;
		#10;
		CLK = 0;
		#10;
		CLK = 1;
		rdreg1_i = 4'b1000;
		rdreg2_i = 4'b1001;
		wrreg_i = 4'b0011;
		wdata_i = 16'hABCD;
		regwrite_i = 0;
		#10;
		CLK = 0;
		#10;
		CLK = 1;
		rdreg1_i = 4'b0011;
		rdreg2_i = 4'b1001;
		wrreg_i = 4'b1001;
		wdata_i = 16'hDDDD;
		regwrite_i = 1;
		#10;
		CLK = 0;
		
	end
      
endmodule

