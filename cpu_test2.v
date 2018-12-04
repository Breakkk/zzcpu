`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:10:15 12/03/2018
// Design Name:   zzcpu
// Module Name:   G:/ISE_Project/zzcpu/cpu_test2.v
// Project Name:  CPU
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

module cpu_test2;

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
		l = 16'b0110100000000000; //LI
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0110101100001111; //LI r011 <- 1111
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
		l = 16'b1101100001100000;	//SW r0+0 <- r011
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0000100000000000;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b1001100011100000;
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
		#50;
	end
      
endmodule

