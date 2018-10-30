`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:19:19 10/29/2018
// Design Name:   Controller
// Module Name:   E:/2018Aut/CPU/test.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg [15:0] SW;
	reg CLK;
	reg RST;
	reg clk1;

	// Outputs
	wire [15:0] Light;
	wire [17:0] Ram1Addr;
	wire Ram1OE;
	wire Ram1WE;
	wire Ram1EN;
	wire [6:0] Led;
	wire wrn;
	wire rdn;

	// Bidirs
	wire [15:0] Ram1Data;

	// Instantiate the Unit Under Test (UUT)
	Controller uut (
		.SW(SW), 
		.CLK(CLK), 
		.RST(RST), 
		.Light(Light), 
		.Ram1Addr(Ram1Addr), 
		.Ram1Data(Ram1Data), 
		.Ram1OE(Ram1OE), 
		.Ram1WE(Ram1WE), 
		.Ram1EN(Ram1EN), 
		.Led(Led), 
		.clk1(clk1), 
		.wrn(wrn), 
		.rdn(rdn)
	);

	initial begin
		// Initialize Inputs
		SW = 0;
		CLK = 0;
		RST = 0;
		clk1 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#100 SW=;
		#20 
	end
      
endmodule

