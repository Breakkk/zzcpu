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
		l = 16'h6AFF;	// LI R2 FF
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h6BC0;	// LI R3 C0
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h3360;	// SLL R3 R3 0
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h6DFF;	// LI R5 FF
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h35A0;	// SLL R5 R5 0
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h4D83;	// ADDIU R5 R3
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h6961;	// LI R1 61
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h4901;	// ADDIU R1 1
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'hDB02;	// SW R3 R1 2
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h9B82;	// LW R3 R4 2
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'hDB81;	// SW R3 R4 1
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h9B21;	// LW R3 R1 1
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h2CFA;	// BNEZ R4 FA
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h4D01;
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h4D01;	// ADDIU R5 1
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h2DF7;	// BNEZ R5 F7
		#5;
		clk = 1;
		#5;
		clk = 0;
		l = 16'h0800;	// NOP
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
		#5;
		clk = 0;
	end
      
endmodule

