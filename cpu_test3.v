`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:44:19 12/04/2018
// Design Name:   zzcpu
// Module Name:   G:/ISE_Project/zzcpu/cpu_test3.v
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

module cpu_test3;

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
		clk = 0;
		rst = 0;
		l = 0;
		data_ready = 0;
		tbre = 0;
		tsre = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		l = 16'b0110100100000001; //LI r001 <- 1
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0110101110110000; //LI r011 <- 1011 1111 (b0)
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0110111100000111;	// LI r111 <= 111
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0110101000000010;	// LI r010 <= 010
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0011001101100000;	//SLL r011 << 8
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b1101101101000000;	// SW (r011) <= r010
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b1101100100100000;	// SW (r001+0) <= r001
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		/*l = 16'b0100101100000001;	//ADDIU
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
		clk = 0;*/
		l = 16'b1101101101100000;	//SW mem[r011+0] <- r011
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0000100000000000;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b1001101111100000;	//LW r111 <- mem[r011 + 0]
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

