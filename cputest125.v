`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:23:13 12/05/2018
// Design Name:   zzcpu
// Module Name:   Z:/Desktop/cpu/zzcpu/cputest125.v
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

module cputest125;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] l;
	reg data_ready;
	reg tbre;
	reg tsre;

	// Outputs
	wire [15:0] light;
	wire [17:0] Ram1Addr;
	wire Ram1OE;
	wire Ram1WE;
	wire Ram1EN;
	wire [17:0] Ram2Addr;
	wire Ram2OE;
	wire Ram2WE;
	wire Ram2EN;
	wire wrn;
	wire rdn;

	// Bidirs
	wire [15:0] Ram1Data;
	wire [15:0] Ram2Data;

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
		.Ram1EN(Ram1EN), 
		.Ram2Addr(Ram2Addr), 
		.Ram2Data(Ram2Data), 
		.Ram2OE(Ram2OE), 
		.Ram2WE(Ram2WE), 
		.Ram2EN(Ram2EN), 
		.data_ready(data_ready), 
		.tbre(tbre), 
		.tsre(tsre), 
		.wrn(wrn), 
		.rdn(rdn)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		rst = 1;
		l = 0;
		data_ready = 0;
		tbre = 0;
		tsre = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		#5;
		rst = 1'b0;
		#5;
		rst = 1'b1;
		#5;
		clk = 0;
		l = 16'b0000100000000000;
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'b0110100100011111;
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'b0111000101111110;
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'b0110000111111100;
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'b00001000000000000;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
		#5;
		clk = 0;
		#5;
		clk = 1;
	end
      
endmodule

