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

	// Outputs
	wire [15:0] alures_o;
	wire [15:0] alusrc1_o;
	wire [15:0] alusrc2_o;

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
		.alusrc1_o(alusrc1_o),
		.alusrc2_o(alusrc2_o)
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
		regsrc2_i = 4'b0011;
		exregdst_i = 4'b0101;
		exregwrite_i = 1;
		exregdata_i = 16'hFFF0;
		memregdst_i = 4'b0011;
		memregwrite_i = 1;
		memregdata_i = 16'h000F;
		#5;
		aluop_i = 4'b0000;
		alusrc1_i = 16'h000F;
		alusrc2_i = 16'h00F0;
		regsrc1_i = 4'b0101;
		regsrc2_i = 4'b0111;
		exregdst_i = 4'b0111;
		exregwrite_i = 1;
		exregdata_i = 16'h0F00;
		memregdst_i = 4'b0111;
		memregwrite_i = 1;
		memregdata_i = 16'hF000;
	end
      
endmodule

