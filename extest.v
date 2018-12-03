`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:04:03 12/01/2018
// Design Name:   ex
// Module Name:   Z:/Desktop/cpu/zzcpu/extest.v
// Project Name:  zzcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ex
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module extest;

	// Inputs
	reg [3:0] aluop_i;
	reg [15:0] alusrc1_i;
	reg [15:0] alusrc2_i;
	reg [3:0] regsrc1_i;
	reg [3:0] regsrc2_i;
	reg [3:0] exregdst_i;
	reg exregwrite_i;
	reg [15:0] exregdata_i;
	reg [3:0] memregdst_i;
	reg memregwrite_i;
	reg [15:0] memregdata_i;
	reg [15:0] memdata_i;
	reg [3:0] regsrc_sw_i;

	// Outputs
	wire [15:0] alures_o;
	wire [15:0] memdata_o;

	// Bidirs

	// Instantiate the Unit Under Test (UUT)
	ex uut (
		.aluop_i(aluop_i), 
		.alusrc1_i(alusrc1_i), 
		.alusrc2_i(alusrc2_i), 
		.regsrc1_i(regsrc1_i), 
		.regsrc2_i(regsrc2_i),
		.exregdst_i(exregdst_i), 
		.exregwrite_i(exregwrite_i), 
		.exregdata_i(exregdata_i), 
		.memregdst_i(memregdst_i), 
		.memregwrite_i(memregwrite_i), 
		.memregdata_i(memregdata_i), 
		.alures_o(alures_o),
		.memdata_i(memdata_i),
		.regsrc_sw_i(regsrc_sw_i),
		.memdata_o(memdata_o)
	);

	initial begin
		// Initialize Inputs
		aluop_i = 0;
		alusrc1_i = 0;
		alusrc2_i = 0;
		regsrc1_i = 0;
		regsrc2_i = 0;
		exregdst_i = 0;
		exregwrite_i = 0;
		exregdata_i = 0;
		memregdst_i = 0;
		memregwrite_i = 0;
		memregdata_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#5;
		aluop_i = 4'b0000;
		alusrc1_i = 16'hFFF1;
		alusrc2_i = 16'h001F;
		regsrc1_i = 4'b0101;
		regsrc2_i = 4'b1111;

		regsrc_sw_i = 4'b0100;
		memdata_i = 16'h0F0F;

		exregdst_i = 4'b1111;
		exregwrite_i = 0;
		exregdata_i = 16'hFFF0;

		memregdst_i = 4'b0100;
		memregwrite_i = 1;
		memregdata_i = 16'hF0F0;
	end
      
endmodule

