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
		parameter INS_WIDTH =16,
		parameter OPERRATOR_WIDTH = 4,
		parameter REG_WIDTH = 4)(
		
		input [ADDRESS_WIDTH-1:0] PC,
		input [INS_WIDTH-1:0] instruction,

		//ID   SP 1000 T 1001
		output reg [REG_WIDTH-1:0] r_reg_A,//A¶Á¼Ä´æÆ÷µØÖ·
		output reg [REG_WIDTH-1:0] r_reg_B,//B¶Á¼Ä´æÆ÷µØÖ·
		output reg [15:0]immediate,
		output reg [3:0] expandWid,
		
		output reg save,
		output reg restore,

		//Ex
		output reg [OPERRATOR_WIDTH-1:0] ALU_OP,

		//MEM
		output reg mem_read,
		output reg mem_write,

		//WB
		output reg REG_WRI,
		output reg [REG_WIDTH-1:0] w_reg,//Ð´¼Ä´æÆ÷µØÖ·
		output reg MemToReg         //Ð´Èë¼Ä´æÆ÷µÄÊý¾ÝÀ´Ô´£¨ALU 0 or MEM 1)

    );

	parameter SP = 4'b1000;
	parameter T = 4'b1001;
	parameter IH = 4'b1010;
	parameter RS = 4'b1011;
	parameter EPC = 4'b1100;

	parameter ADD = 4'b0000;
	parameter AND = 4'b0001;
	parameter OR = 4'b0010;
	parameter SLL = 4'b0011;
	parameter SRL = 4'b0100;
	parameter SRA = 4'b0101;
	parameter SUB = 4'b0110;
	parameter EQUAL = 4'b0111;
	parameter LESS = 4'b1000;
	parameter EMPTY = 4'b1111;

	always @(*) begin
		case (instruction[15:11])
			5'b01001:begin 	//ADDIU
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				expandWid <= 4'd8;
				immediate[7:0] = instruction[7:0];

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[10:8]};
				MemToReg <= 1'b0;
			end
			5'b01000:begin 	//ADDIU3
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				expandWid <= 4'd12;
				immediate[3:0] <= instruction[3:0];

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
						expandWid <= 4'd8;
						immediate[7:0] <= instruction[7:0];

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= SP;
						MemToReg <= 1'b0;
					end
					3'b000:begin	//BTEQZ
						ALU_OP <= EMPTY;
						r_reg_A <= T;
						expandWid <= 4'd8;
						immediate[7:0] <= instruction[7:0];

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b0;
						MemToReg <= 1'b0;
					end
					3'b100:begin	//MTSP
						ALU_OP <= MOVE;
						r_reg_A <= {1'b0,instruction[7:5]};

						mem_read = 1'b0;
						mem_write = 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= SP;
						MemToReg <= 1'b0;
					end
					3'b001:begin	//BTNEZ
						ALU_OP <= EMPTY;
						r_reg_A <= T;
						expandWid <= 4'd8;
						immediate[7:0] <= instruction[7:0];

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b0;
						MemToReg <= 1'b0;
					end
					3'b010:begin	//SW_RS
						ALU_OP <= EMPTY;
						r_reg_A <= RS;
						expandWid <= 4'd8;
						immediate[7:0] <= instruction[7:0];
						
						mem_read <= 1'b0;
						mem_write <= 1'b1;
						
						REG_WRI <= 1'b0;
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
				expandWid <= 4'd5;
				immediate[10:0] <= instruction[10:0];

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				MemToReg <= 1'b0;
			end
			5'b00100:begin		//BEQZ
				ALU_OP <= EMPTY;
				r_reg_A <= {1'b0,instruction[10:8]};
				expandWid <= 4'd8;
				immediate[7:0] <= instruction[7:0];

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				MemToReg <= 1'b0;
			end
			5'b00101:begin		//BNQZ
				ALU_OP <= EMPTY;
				r_reg_A <= {1'b0,instruction[10:8]};
				expandWid <= 4'd8;
				immediate[7:0] <= instruction[7:0];

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b0;
				MemToReg <= 1'b0;
			end
			5'b11101:begin
				case(instruction[4:0])
					5'b01100:begin		//AND
						ALU_OP <= AND;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						expandWid <= 4'd0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[10:8]};
						MemToReg <= 1'b0;
					end
					5'b01010:begin		//CMP
						ALU_OP <= EQAUL;
						r_reg_A <= {1'b0,instruction[10:8]};
						r_reg_B <= {1'b0,instruction[7:5]};
						expandWid = 4'd0;

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
								expandWid <= 4'd0;

								mem_read <= 1'b0;
								mem_write <= 1'b0;

								REG_WRI <= 1'b0;
								MemToReg <= 1'b0;
							end
							3'b010:begin		//MFPC
								ALU_OP <= MOVE;
								expandWid <= 4'd0;
								immediate[15:0] <= PC[15:0];
								
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
						expandWid <= 4'd0;
						
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
						expandWid <= 4'd0;
						
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
						expandWid <= 4'd0;
						
						mem_read <= 1'b0;
						mem_write <= 1'b0;
						
						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[7:5]};
					end
				endcase
			end
			5'b01101:begin		//LI
				ALU_OP <= EMPTY;
				expandWid = 4'd8;
				immediate[7:0] <= instruction[7:0];

				mem_read <= 1'b0;
				mem_write <= 1'b0;

				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[10:8]};
				MemToReg <= 1'b0;
			end
			5'b10011:begin		//LW
				ALU_OP <= ADD;
				r_reg_A <= {1'b0,instruction[10:8]};
				expandWid = 4'd11;
				immediate[4:0] <= instruction[4:0];
				
				mem_read <= 1'b1;
				mem_write <= 1'b0;
				
				REG_WRI <= 1'b1;
				w_reg <= {1'b0,instruction[7:5]};
				MemToReg <= 1'b1;

			end
			5'b10010:begin		//LW_SP
				ALU_OP <= ADD;
				r_reg_A <= SP;
				expandWid = 4'd8;
				immediate[7:0] <= instruction[7:0];
				
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
						expandWid <= 4'd0;

						mem_read <= 1'b0;
						mem_write <= 1'b0;

						REG_WRI <= 1'b1;
						w_reg <= {1'b0,instruction[10:8]};
						MemToReg <= 1'b0;
					end
					1'b1:begin		//MTIH
						ALU_OP <= MOVE;
						r_reg_A <= {1'b0,instruction[10:8]};
						expandWid <= 4'd0;

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
				expandWid <= 4'd0;
				
				mem_read <= 1'b0;
				mem_write <= 1'b0;
				
				REG_WRI <= 1'b0;
				MemToReg <= 1'b0;
			end
			5'b00110:begin		
				case(instruction[1:0])
				2'b00:begin		//SLL
					ALU_OP <= SLL;
					r_reg_A <= {1'b0,instruction[7:5]};
					expandWid <= 4'd12;
					if(instruction[4:2] == 3'b000)
					begin
						immediate[3:0] <= 4'b1000;
					end
					else 
					begin
						immediate[3:0] <= {1'b0,instruction[4:2]};
					end
					
					mem_read <= 1'b0;
					mem_write <= 1'b0;
					
					REG_WRI <= 1'b1;
					w_reg <= {1'b0,instruction[10:8]};
					MemToReg <= 1'b0;
				end
				2'b11:begin		//SRA
					ALU_OP <= SRA;
					r_reg_A <= {1'b0,instruction[7:5]};
					expandWid <= 4'd12;
					if(instruction[4:2] == 3'b000)
					begin
						immediate[3:0] <= 4'b1000;
					end
					else 
					begin
						immediate[3:0] <= {1'b0,instruction[4:2]};
					end
					
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
				r_reg_A <= RS;
				expandWid <= 4'd8;
				immediate[7:0] <= instruction[7:0];
				
				mem_read <= 1'b0;
				mem_write <= 1'b1;
				
				REG_WRI <= 1'b0;
				MemToReg <= 1'b0;
			end
			5'b11010:begin		//SW_SP

			end
			5'b01110:begin		//CMPI
				ALU_OP <= EQUAL;
				r_reg_A <= instruction[10:8];
				expandWid <= 4'd8;
				immediate[7:0] <= instruction[7:0];
				
				mem_read <= 1'b0;
				mem_write <= 1'b0;
				
				REG_WRI <= 1'b1;
				w_reg <= T;
				MemToReg <= 1'b0;
			end
			5'b11111:begin
				ALU_OP <= EMPTY;
				case(instruction[3:0])
				4'b1111:begin
					r_reg_A <= EPC;
				end
				4'b0000:begin
					r_reg_A <= IH;
				end
				endcase
			end
			
		endcase
	end

endmodule
