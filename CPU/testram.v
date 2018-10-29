`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:35:34 10/29/2018
// Design Name:   RAM
// Module Name:   Z:/Desktop/zzcpu/CPU/testram.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testram;

	// Inputs
	reg clk;
	reg read;
	reg [17:0] addr;
	reg [15:0] data_i;

	// Outputs
	wire [15:0] data_o;
	wire [17:0] RamAddr;
	wire RamOE;
	wire RamWE;
	wire RamEN;

	// Bidirs
	wire [15:0] RamData;

	// Instantiate the Unit Under Test (UUT)
	RAM uut (
		.clk(clk), 
		.read(read), 
		.addr(addr), 
		.data_i(data_i), 
		.data_o(data_o), 
		.RamAddr(RamAddr), 
		.RamData(RamData), 
		.RamOE(RamOE), 
		.RamWE(RamWE), 
		.RamEN(RamEN)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		read = 0;
		addr = 18'b000000000010101010;
		data_i = 16'h0006;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		clk = 1;
	end
      
endmodule

