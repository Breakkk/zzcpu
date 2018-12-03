`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:03:51 12/03/2018
// Design Name:   ram1
// Module Name:   G:/ISE_Project/zzcpu/ram1_test.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ram1_test;

	// Inputs
	reg [17:0] addr;
	reg [15:0] data;
	reg read;
	reg clk;

	// Outputs
	wire [17:0] Ram1Addr;
	wire Ram1OE;
	wire Ram1WE;

	// Bidirs
	wire [15:0] Ram1Data;

	// Instantiate the Unit Under Test (UUT)
	ram1 uut (
		.addr(addr), 
		.data(data), 
		.Ram1Addr(Ram1Addr), 
		.Ram1Data(Ram1Data), 
		.Ram1OE(Ram1OE), 
		.Ram1WE(Ram1WE), 
		.read(read), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		addr = 0;
		data = 0;
		read = 0;
		clk = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
       clk = 1'b1;
		 addr = 18'b000000000000000001;
		 data = 16'h0004;
		 read = 1'b1;
		 #10
		 clk = 1'b0;
		 
		 #10
		 clk = 1'b1;
		 addr = 18'b000000000000000001;
		 read = 1'b0;
		 
		 #10
		 clk = 1'b0;
		 
		// Add stimulus here

	end
      
endmodule

