`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:08:05 10/29/2018
// Design Name:   Controller
// Module Name:   Z:/Desktop/zzcpu/CPU/testcontroler.v
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

module testcontroler;

	// Inputs
	reg [15:0] SW;
	reg CLK;
	reg RST;

	// Outputs
	wire [15:0] Light;
	wire [17:0] Ram1Addr;
	wire Ram1OE;
	wire Ram1WE;
	wire Ram1EN;
	wire [6:0] Led;

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
		.Led(Led)
	);

	initial begin
		// Initialize Inputs
		SW = 0;
		CLK = 1;
		RST = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#50 RST = 0;	//150
		#50 RST = 1;
		
		SW = 16'h00F9;
		CLK = 0;
		#50 CLK = 1;	//250
		
		#50 SW = 16'h0007;
		CLK = 0;
		#50 CLK = 1;	//350 1
		
		#50 SW = 16'h0009;
		CLK = 0;
		#50 CLK = 1;	//450 2
		
		#50 SW = 16'h0008;
		CLK = 0;
		#50 CLK = 1;	//550 3
		
		#50 SW = 16'h0006;
		CLK = 0;
		#50 CLK = 1;	//650 4
		
		#50 SW = 16'h0004;
		CLK = 0;
		#50 CLK = 1;	//750 5
		
		#50 SW = 16'h0005;
		CLK = 0;
		#50 CLK = 1;	//850 6
		
		#50 SW = 16'h0001;
		CLK = 0;
		#50 CLK = 1;	//950 7
		
		#50 SW = 16'h0002;
		CLK = 0;
		#50 CLK = 1;	//1050 8
		
		#50 SW = 16'h0000;
		CLK = 0;
		#50 CLK = 1;	//1150 9
		
		#50 SW = 16'h0003;
		CLK = 0;
		#50 CLK = 1;	//1250 10
		
		#50 CLK = 0;
		#50 CLK = 1;	//1350 1
		
		#50 CLK = 0;
		#50 CLK = 1;	//1450 2
		
		#50 CLK = 0;
		#50 CLK = 1;	//1550 3
		
		#50 CLK = 0;
		#50 CLK = 1;	//1650 4
		
		#50 CLK = 0;
		#50 CLK = 1;	//1750 5
		
		#50 CLK = 0;
		#50 CLK = 1;	//1850 6
		
		#50 CLK = 0;
		#50 CLK = 1;	//1950 7
		
		#50 CLK = 0;
		#50 CLK = 1;	//2050 8
		
		#50 CLK = 0;
		#50 CLK = 1;	//2150 9
		
		#50 CLK = 0;
		#50 CLK = 1;	//2250 10
		
		#50 CLK = 0;
		#50 CLK = 1;	//2350 begin
	end
      
endmodule

