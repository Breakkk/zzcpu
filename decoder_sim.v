`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:23:50 12/03/2018
// Design Name:   decoder
// Module Name:   G:/ISE_Project/zzcpu/decoder_sim.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decoder_sim;

	// Inputs
	reg [15:0] PC;
	reg [15:0] instruction;

	// Outputs
	wire [3:0] r_reg_A;
	wire [3:0] r_reg_B;
	wire [15:0] immediate;
	wire [2:0] ALU_SRC;
	wire [3:0] regsrc_A;
	wire [3:0] regsrc_B;
	wire [3:0] regsrc_sw;
	wire is_jump;
	wire is_branch;
	wire [1:0] eqz;
	wire [3:0] ALU_OP;
	wire mem_read;
	wire mem_write;
	wire REG_WRI;
	wire [3:0] w_reg;
	wire MemToReg;

	// Instantiate the Unit Under Test (UUT)
	decoder uut (
		.PC(PC), 
		.instruction(instruction), 
		.r_reg_A(r_reg_A), 
		.r_reg_B(r_reg_B), 
		.immediate(immediate), 
		.ALU_SRC(ALU_SRC), 
		.regsrc_A(regsrc_A), 
		.regsrc_B(regsrc_B), 
		.regsrc_sw(regsrc_sw), 
		.is_jump(is_jump), 
		.is_branch(is_branch), 
		.eqz(eqz), 
		.ALU_OP(ALU_OP), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.REG_WRI(REG_WRI), 
		.w_reg(w_reg), 
		.MemToReg(MemToReg)
	);

	initial begin
		// Initialize Inputs
		PC = 0;
		instruction = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		PC = 16'h000042;
		instruction = 16'b1110100000000010;//slt
		#10;
		instruction = 16'b0011001001100111;
	end
   /*assign PC = 16'h000042;
	assign instruction = 16'b1110100000000010;*/
endmodule

