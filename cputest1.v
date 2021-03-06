`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:55:13 12/03/2018
// Design Name:   zzcpu
// Module Name:   Z:/Desktop/cpu/zzcpu/cputest1.v
// Project Name:  zzcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: zzcpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cputest1;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] l;

	// Outputs
	wire [15:0] light;
	wire [17:0] Ram1Addr;
	wire Ram1OE;
	wire Ram1WE;
	wire Ram1EN;

	// Bidirs
	wire [15:0] Ram1Data;

	// Instantiate the Unit Under Test (UUT)
	zzcpu uut (
		.clk(clk), 
		.rst(rst), 
		.light(light), 
		.l(l), 
		.Ram1Addr(Ram1Addr), 
		.Ram1Data(Ram1Data), 
		.Ram1OE(Ram1OE), 
		.Ram1WE(Ram1WE), 
		.Ram1EN(Ram1EN)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		l = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		l = 16'b0110110000000100;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0110111100000111;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0000100000000000;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b1101111110000000;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0000100000000000;
		#50
		clk = 1;
		#50;
		clk = 0;
		#50
		clk = 1;
		#50;
		clk = 0;
		#50
		clk = 1;
		#50;
		clk = 0;

	end
      
endmodule

