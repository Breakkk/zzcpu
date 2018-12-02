`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:07:23 12/03/2018
// Design Name:   id
// Module Name:   G:/ISE_Project/zzcpu/id_sim.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module id_sim;

	// Inputs
	reg [15:0] instr_i;
	reg [15:0] rdata1_i;
	reg [15:0] rdata2_i;
	reg [15:0] pcplus1_i;

	// Outputs
	wire [3:0] readreg1_o;
	wire [3:0] readreg2_o;
	wire regwrite_o;
	wire memtoreg_o;
	wire memread_o;
	wire memwrite_o;
	wire [15:0] memdata_o;
	wire [3:0] aluop_o;
	wire [15:0] alusrc1_o;
	wire [15:0] alusrc2_o;
	wire [3:0] regsrc1_o;
	wire [3:0] regsrc2_o;
	wire [3:0] regsrc_sw_o;
	wire [3:0] regdst_o;
	wire isjump_o;
	wire isbranch_o;
	wire ifbranch_o;
	wire [15:0] address_jr;

	// Instantiate the Unit Under Test (UUT)
	id uut (
		.instr_i(instr_i), 
		.rdata1_i(rdata1_i), 
		.rdata2_i(rdata2_i), 
		.pcplus1_i(pcplus1_i), 
		.readreg1_o(readreg1_o), 
		.readreg2_o(readreg2_o), 
		.regwrite_o(regwrite_o), 
		.memtoreg_o(memtoreg_o), 
		.memread_o(memread_o), 
		.memwrite_o(memwrite_o), 
		.memdata_o(memdata_o), 
		.aluop_o(aluop_o), 
		.alusrc1_o(alusrc1_o), 
		.alusrc2_o(alusrc2_o), 
		.regsrc1_o(regsrc1_o), 
		.regsrc2_o(regsrc2_o), 
		.regsrc_sw_o(regsrc_sw_o), 
		.regdst_o(regdst_o), 
		.isjump_o(isjump_o), 
		.isbranch_o(isbranch_o), 
		.ifbranch_o(ifbranch_o), 
		.address_jr(address_jr)
	);

	initial begin
		// Initialize Inputs
		instr_i = 0;
		rdata1_i = 0;
		rdata2_i = 0;
		pcplus1_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		instr_i = 16'b0100000011101100;
		rdata1_i = 16'b0000000000010000;
		rdata2_i = 16'b0000000000000000;
		pcplus1_i = 16'b0000000000000001;
	end
      
endmodule

