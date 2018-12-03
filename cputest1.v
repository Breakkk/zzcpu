`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:55:13 12/03/2018
// Design Name:   zzcpu
// Module Name:   Z:/Desktop/cpu/zzcpu/cputest1.v
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

module cputest1;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] l;

	// Outputs
	wire [15:0] light;
	wire [17:0] Ram1Addr;
	wire Ram1OE;
	wire Ram1WE;
	wire Ram1EN;
	wire flush_id_output;
	wire regwrite_idex_output;
	wire memtoreg_idex_output;
	wire [3:0] aluop_idex_output;
	wire [3:0] regsrc1_idex_output;
	wire [3:0] regdst_exmem_output;
	wire [15:0] alures_exmem_output;
	wire regwrite_exmem_output;
	wire memtoreg_memwb_output;
	wire [15:0] memres_memwb_output;
	wire [15:0] memdata_id_output;
	wire [15:0] memdata_idex_output;
	wire [15:0] memdata_exmem_output;
	wire [15:0] memdata_ex_output;
	wire [15:0] rdata2_rh_output;
	wire [15:0] flush_ex_output;
	wire memread_idex_output;
	wire memwrite_idex_output;
	wire [3:0] regdst_idex_output;
	wire [15:0] alures_ex_output;

	// Bidirs
	wire [15:0] Ram1Data;

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
		.flush_id_output(flush_id_output),
		.regwrite_idex_output(regwrite_idex_output),
		.memtoreg_idex_output(memtoreg_idex_output),
		.aluop_idex_output(aluop_idex_output),
		.regsrc1_idex_output(regsrc1_idex_output),
		.regdst_exmem_output(regdst_exmem_output),
		.alures_exmem_output(alures_exmem_output),
		.regwrite_exmem_output(regwrite_exmem_output),
		.memtoreg_memwb_output(memtoreg_memwb_output),
		.memres_memwb_output(memres_memwb_output),
		.memdata_id_output(memdata_id_output),
		.rdata2_rh_output(rdata2_rh_output),
		.memdata_exmem_output(memdata_exmem_output),
		.memdata_ex_output(memdata_ex_output),
		.memdata_idex_output(memdata_idex_output),
		.flush_ex_output(flush_ex_output),
		.memread_idex_output(memread_idex_output),
		.memwrite_idex_output(memwrite_idex_output),
		.regdst_idex_output(regdst_idex_output),
		.alures_ex_output(alures_ex_output)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		l = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		l = 16'b0110110000000100;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0110111100000111;
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
		l = 16'b1101111110000000;
		#50;
		clk = 1;
		#50;
		clk = 0;
		l = 16'b0000100000000000;
		#50
		clk = 1;
		#50;
		clk = 0;
		#50
		clk = 1;
		#50;
		clk = 0;
		#50
		clk = 1;
		#50;
		clk = 0;

	end
      
endmodule

