`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:07:04 11/29/2018
// Design Name:
// Module Name:    decoder
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module decoder#(
		parameter ADDRESS_WIDTH = 16,
		parameter INSTR_WIDTH =16,
		parameter OPERRATOR_WIDTH = 4,
		parameter REG_WIDTH = 4)(

		input [ADDRESS_WIDTH-1:0] PC,
		input [INSTR_WIDTH-1:0] instruction,

		//ID
		output reg [REG_WIDTH-1:0] r_reg_A,//A���Ĵ�����ַ
		output reg [REG_WIDTH-1:0] r_reg_B,//B���Ĵ�����ַ
		output reg [15:0] immediate,
		output reg [2:0] ALU_SRC,

		output reg [REG_WIDTH-1:0] regsrc_A,
		output reg [REG_WIDTH-1:0] regsrc_B,
		output reg [REG_WIDTH-1:0] regsrc_sw,

		output reg is_jump,
		output reg is_branch,

		output reg [1:0] eqz,

		//Ex
		output reg [OPERRATOR_WIDTH-1:0] ALU_OP,

		//MEM
		output reg mem_read,
		output reg mem_write,

		//WB
		output reg REG_WRI,
		output reg [REG_WIDTH-1:0] w_reg,//д�Ĵ�����ַ
		output reg MemToReg         //д���Ĵ�����������Դ��ALU 0 or MEM 1)

    );

	parameter SP = 4'b1000;
	parameter T = 4'b1001;
	parameter IH = 4'b1010;
	parameter RA = 4'b1011;
	parameter EPC = 4'b1100;
	parameter EMP_REG = 4'b1111;


	parameter ADD = 4'b0000;
	parameter AND = 4'b0001;
	parameter OR = 4'b0010;
	parameter SLL = 4'b0011;
	parameter SRL = 4'b0100;
	parameter SRA = 4'b0101;
	parameter SUB = 4'b0110;
	parameter EQUAL = 4'b0111;
	parameter LESS = 4'b1000;
	parameter MOVE = 4'b1001;
	parameter EMPTY = 4'b1111;

	parameter null = 3'b000;
	parameter r1_r2 = 3'b001;
	parameter r1_im = 3'b010;
	parameter r1_nu = 3'b011;
	parameter im_nu = 3'b100;
	parameter r2_r1 = 3'b101;

	parameter B_IMME = 2'b00;
	parameter EQU_ZERO = 2'b01;
	parameter NOT_EQU_ZERO = 2'b10;


	always @(*) begin
		case (instruction[15:11])
			5'b01001:begin 	//ADDIU
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= EMP_REG;
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= {1'b0,instruction[10:8]};
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[10:8]};
				MemToReg <= 1'b0;
			end
			5'b01000:begin 	//ADDIU3
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= EMP_REG;
				case(instruction[3])
					1'b1:begin immediate[15:0] <= {12'b111111111111,instruction[3:0]};end
					1'b0:begin immediate[15:0] <= {12'b000000000000,instruction[3:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= {1'b0,instruction[10:8]};
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[7:5]};
				MemToReg <= 1'b0;
			end
			5'b01100:begin 	//ADDSP	BTEQZ	 MTSP	 BTNEZ	SW_RS
				case(instruction[10:8])
					3'b011:begin	//ADDSP
						ALU_OP <= ADD;
						r_reg_A <= SP;
						r_reg_B <= EMP_REG;
						case(instruction[7])
							1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
							1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
						endcase
						ALU_SRC <= r1_im;

						regsrc_A <= SP;
						regsrc_B <= EMP_REG;
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= SP;
						MemToReg <= 1'b0;
					end
					3'b000:begin	//BTEQZ
						ALU_OP <= EMPTY;
						r_reg_A <= T;
						r_reg_B <= EMP_REG;
						case(instruction[7])
							1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
							1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
						endcase
						ALU_SRC <= null;

						regsrc_A <= EMP_REG;
						regsrc_B <= EMP_REG;
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b1;
						eqz <= EQU_ZERO;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b0;
						w_reg <= EMP_REG;
						MemToReg <= 1'b0;
					end
					3'b100:begin	//MTSP
						ALU_OP <= MOVE;
						r_reg_A <= {1'b0,instruction[7:5]};
						r_reg_B <= EMP_REG;
						immediate <= 16'h0000;
						ALU_SRC <= r1_nu;

						regsrc_A <= {1'b0,instruction[7:5]};
						regsrc_B <= EMP_REG;
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= SP;
						MemToReg <= 1'b0;
					end
					3'b001:begin	//BTNEZ
						ALU_OP <= EMPTY;
						r_reg_A <= T;
						r_reg_B <= EMP_REG;
						case(instruction[7])
							1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
							1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
						endcase
						ALU_SRC <= null;

						regsrc_A <= EMP_REG;
						regsrc_B <= EMP_REG;
						regsrc_sw <= EMP_REG;
						eqz <= NOT_EQU_ZERO;

						is_jump <= 1'b0;
						is_branch <= 1'b1;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b0;
						w_reg <= EMP_REG;
						MemToReg <= 1'b0;
					end
					3'b010:begin	//SW_RS
						ALU_OP <= ADD;
						r_reg_A <= SP;
						r_reg_B <= RA;
						case(instruction[7])
							1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
							1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
						endcase
						ALU_SRC <= r1_im;

						regsrc_A <= SP;
						regsrc_B <= EMP_REG;
						regsrc_sw <= RA;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b1;

						REG_WRI <= 1'b0;
						w_reg <= EMP_REG;
						MemToReg <= 1'b0;

					end
				endcase
			end
			5'b11100:begin		//ADDU	SUBU
				case(instruction[1:0])
					2'b01:begin		//ADDU
						ALU_OP <= ADD;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= {1'b0,instruction[7:5]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[4:2]};
						MemToReg <= 1'b0;
					end
					2'b11:begin		//SUBU
						ALU_OP <= SUB;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= {1'b0,instruction[7:5]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[4:2]};
						MemToReg <= 1'b0;
					end
				endcase

			end
			5'b00010:begin		//B
				ALU_OP <= EMPTY;
				r_reg_A <= EMP_REG;
				r_reg_B <= EMP_REG;
				case(instruction[10])
					1'b1:begin immediate[15:0] <= {5'b11111,instruction[10:0]};end
					1'b0:begin immediate[15:0] <= {5'b00000,instruction[10:0]};end
				endcase
				ALU_SRC <= null;

				regsrc_A <= EMP_REG;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b1;
				eqz <= B_IMME;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end
			5'b00100:begin		//BEQZ
				ALU_OP <= EMPTY;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= EMP_REG;
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= null;

				regsrc_A <= EMP_REG;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b1;
				eqz <= EQU_ZERO;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end
			5'b00101:begin		//BNQZ
				ALU_OP <= EMPTY;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= EMP_REG;
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= null;

				regsrc_A <= EMP_REG;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b1;
				eqz <= NOT_EQU_ZERO;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end
			5'b11101:begin
				case(instruction[4:0])
					5'b01100:begin		//AND
						ALU_OP <= AND;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= {1'b0,instruction[7:5]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[10:8]};
						MemToReg <= 1'b0;
					end
					5'b01010:begin		//CMP
						ALU_OP <= EQUAL;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= {1'b0,instruction[7:5]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= T;
						MemToReg <= 1'b0;

					end
					5'b00000:begin
						case(instruction[7:5])
							3'b000:begin		//JR
								ALU_OP <= EMPTY;
								r_reg_A <= {1'b0,instruction[10:8]};
								r_reg_B <= EMP_REG;
								immediate <= 16'h0000;
								ALU_SRC <= null;

								regsrc_A <= EMP_REG;
								regsrc_B <= EMP_REG;
								regsrc_sw <= EMP_REG;

								is_jump <= 1'b1;
								is_branch <= 1'b0;

								mem_read <= 1'b0;
								mem_write <= 1'b0;

								REG_WRI <= 1'b0;
								w_reg <= EMP_REG;
								MemToReg <= 1'b0;
							end
							3'b010:begin		//MFPC
								ALU_OP <= MOVE;
								r_reg_A <= EMP_REG;
								r_reg_B <= EMP_REG;
								immediate[15:0] <= PC[15:0];
								ALU_SRC <= im_nu;

								regsrc_A <= EMP_REG;
								regsrc_B <= EMP_REG;
								regsrc_sw <= EMP_REG;

								is_jump <= 1'b0;
								is_branch <= 1'b0;

								mem_read <= 1'b0;
								mem_write <= 1'b0;

								REG_WRI <= 1'b1;
								w_reg <= {1'b0,instruction[10:8]};
								MemToReg <= 1'b0;
							end
						endcase
					end
					5'b01101:begin		//OR
						ALU_OP <= OR;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= {1'b0,instruction[7:5]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[10:8]};
						MemToReg <= 1'b0;
					end
					5'b00010:begin		//SLT
						ALU_OP <= EMPTY;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= {1'b0,instruction[7:5]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= T;
						MemToReg <= 1'b0;

					end
					5'b00111:begin		//SRAV
						ALU_OP <= EMPTY;
						r_reg_A <= {1'b0,instruction[7:5]};
						r_reg_B <= {1'b0,instruction[10:8]};
						immediate <= 16'h0000;
						ALU_SRC <= r1_r2;

						regsrc_A <= {1'b0,instruction[7:5]};
						regsrc_B <= {1'b0,instruction[10:8]};
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[7:5]};
						MemToReg <= 1'b0;
					end
				endcase
			end
			5'b01101:begin		//LI
				ALU_OP <= MOVE;
				r_reg_A <= EMP_REG;
				r_reg_B <= EMP_REG;
				immediate[15:0] <= {8'b00000000,instruction[7:0]};
				ALU_SRC <= im_nu;

				regsrc_A <= EMP_REG;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[10:8]};
				MemToReg <= 1'b0;
			end
			5'b10011:begin		//LW
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= EMP_REG;
				case(instruction[4])
					1'b1:begin immediate[15:0] <= {11'b11111111111,instruction[4:0]};end
					1'b0:begin immediate[15:0] <= {11'b00000000000,instruction[4:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= {1'b0,instruction[10:8]};
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b1;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[7:5]};
				MemToReg <= 1'b1;

			end
			5'b10010:begin		//LW_SP
				ALU_OP <= ADD;
				r_reg_A <= SP;
				r_reg_B <= EMP_REG;
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= SP;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b1;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[10:8]};
				MemToReg <= 1'b1;

			end
			5'b11110:begin		//MFIH	MTIH
				case(instruction[0])
					1'b0:begin		//MFIH
						ALU_OP <= MOVE;
						r_reg_A <= IH;
						r_reg_B <= EMP_REG;
						immediate <= 16'h0000;
						ALU_SRC <= r1_nu;

						regsrc_A <= IH;
						regsrc_B <= EMP_REG;
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[10:8]};
						MemToReg <= 1'b0;
					end
					1'b1:begin		//MTIH
						ALU_OP <= MOVE;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= EMP_REG;
						immediate <= 16'h0000;
						ALU_SRC <= r1_nu;

						regsrc_A <= {1'b0,instruction[10:8]};
						regsrc_B <= EMP_REG;
						regsrc_sw <= EMP_REG;

						is_jump <= 1'b0;
						is_branch <= 1'b0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= IH;
						MemToReg <= 1'b0;
					end
				endcase
			end
			5'b00001:begin		//NOP
				ALU_OP <= EMPTY;
				r_reg_A <= EMP_REG;
				r_reg_B <= EMP_REG;
				immediate <= 16'h0000;
				ALU_SRC <= null;

				regsrc_A <= EMP_REG;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end
			5'b00110:begin
				case(instruction[1:0])
				2'b00:begin		//SLL
					ALU_OP <= SLL;
					r_reg_A <= {1'b0,instruction[7:5]};
					r_reg_B <= EMP_REG;
					if(instruction[4:2] == 3'b000)
					begin
						immediate[15:0] <= 16'b0000000000001000;
					end
					else
					begin
						immediate[15:0] <= {13'b0000000000000,instruction[4:2]};
					end
					ALU_SRC <= r1_im;

					regsrc_A <= {1'b0,instruction[7:5]};
					regsrc_B <= EMP_REG;
					regsrc_sw <= EMP_REG;

					is_jump <= 1'b0;
					is_branch <= 1'b0;

					mem_read <= 1'b0;
					mem_write <= 1'b0;

					REG_WRI <= 1'b1;
					w_reg <= {1'b0,instruction[10:8]};
					MemToReg <= 1'b0;
				end
				2'b11:begin		//SRA
					ALU_OP <= SRA;
					r_reg_A <= {1'b0,instruction[7:5]};
					r_reg_B <= EMP_REG;
					if(instruction[4:2] == 3'b000)
					begin
						immediate[15:0] <= 16'b0000000000001000;
					end
					else
					begin
						immediate[15:0] <= {13'b0000000000000,instruction[4:2]};
					end
					ALU_SRC <= r1_im;

					regsrc_A <= {1'b0,instruction[7:5]};
					regsrc_B <= EMP_REG;
					regsrc_sw <= EMP_REG;

					is_jump <= 1'b0;
					is_branch <= 1'b0;

					mem_read <= 1'b0;
					mem_write <= 1'b0;

					REG_WRI <= 1'b1;
					w_reg <= {1'b0,instruction[10:8]};
					MemToReg <= 1'b0;
				end
				endcase
			end
			5'b11011:begin		//SW
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= {1'b0,instruction[7:5]};
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= {1'b0,instruction[10:8]};
				regsrc_B <= EMP_REG;
				regsrc_sw <= {1'b0,instruction[7:5]};

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b1;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end
			5'b11010:begin		//SW_SP
				ALU_OP <= ADD;
				r_reg_A <= SP;
				r_reg_B <= {1'b0,instruction[10:8]};
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= SP;
				regsrc_B <= EMP_REG;
				regsrc_sw <= {1'b0,instruction[10:8]};

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b1;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end
			5'b01110:begin		//CMPI
				ALU_OP <= EQUAL;
				r_reg_A <= {1'b0,instruction[10:8]};
				r_reg_B <= EMP_REG;
				case(instruction[7])
					1'b1:begin immediate[15:0] <= {8'b11111111,instruction[7:0]};end
					1'b0:begin immediate[15:0] <= {8'b00000000,instruction[7:0]};end
				endcase
				ALU_SRC <= r1_im;

				regsrc_A <= {1'b0,instruction[10:8]};
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b0;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= T;
				MemToReg <= 1'b0;
			end
			5'b11111:begin		//INT
				ALU_OP <= EMPTY;
				case(instruction[3:0])
				4'b1111:begin
					r_reg_A <= EPC;
				end
				4'b0000:begin
					r_reg_A <= IH;
				end
				endcase
				r_reg_B <= EMP_REG;
				immediate <= 16'h0000;
				ALU_SRC <= null;

				regsrc_A <= EMP_REG;
				regsrc_B <= EMP_REG;
				regsrc_sw <= EMP_REG;

				is_jump <= 1'b1;
				is_branch <= 1'b0;

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				w_reg <= EMP_REG;
				MemToReg <= 1'b0;
			end

		endcase
	end

endmodule
