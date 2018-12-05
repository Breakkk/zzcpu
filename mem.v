`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:32:16 12/02/2018
// Design Name:
// Module Name:    mem
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
module mem(
		input [15:0] alures_i,

		input [15:0] mem1_res_i,
		input [15:0] mem2_res_i,
		input memread_i,
		input memwrite_i,

		output is_RAM1_o,
		output is_UART_o,
		output is_RAM2_o,
		output [15:0] memres_o
    );

	reg [1:0] res_from;  //00 - s_port 01 - ram1   10 - ram2
	reg is_RAM1 = 1'b0;
	reg is_UART = 1'b0;
	reg is_RAM2 = 1'b0;

	assign memres_o = is_RAM2 ? mem2_res_i : mem1_res_i;
	assign is_RAM1_o = is_RAM1;
	assign is_UART_o = is_UART;
	assign is_RAM2_o = is_RAM2;

	always @(*) begin
		if(alures_i <= 16'h7Fff & alures_i >= 16'h0000)begin			//ram2
			is_RAM1 <= 1'b0;
			is_UART <= 1'b0;
			is_RAM2 <= (memread_i | memwrite_i);
			res_from <=2'b10;
		end
		else if(alures_i >= 16'h8000 & alures_i <= 16'hffff)begin  	//ram1
			is_RAM2 <= 1'b0;
			case(alures_i)
				16'hbf01:begin
					is_RAM1 <= 1'b0;
					is_UART <= 1'b1;
					res_from <=2'b00;
					//uart_result [15:0] <= {14'b00000000000000,data_ready_in,(tbre_in & tsre_in)};
				end
				16'hbf00:begin
					is_RAM1 <= 1'b0;
					is_UART <= 1'b1;
					res_from <=2'b00;
				end
				default:begin
					is_RAM1 <= 1'b1;
					is_UART <= 1'b0;
					res_from <= 2'b01;
				end
			endcase
		end
		else begin
			is_RAM2 <= 1'b0;
			is_RAM1 <= 1'b0;
			is_UART <= 1'b0;
		end


		/*if(alures_i<=16'hbeff)begin			//ram2
			res_from <= 2'b10;
			is_uart <= 1'b0;
			Ram1EN_o <= 1'b1;
			rdn_o <= 1'b1;
			wrd_o <= 1'b1;
			case({memread_i,memwrite_i})
				2'b01:begin							//write
					Ram2EN_o <= 1'b0;
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					Ram2EN_o <= 1'b0;
					read_o <= 1'b0;
				end
				default:begin
					Ram2EN_o <= 1'b1;
					read_o <= 1'b0;

				end
			endcase
		end
		else if(alures_i>=16'hbf02)begin  	//ram1
			res_from <= 2'b01;
			is_uart <= 1'b0;
			Ram2EN_o <= 1'b1;
			rdn_o <= 1'b1;
			wrd_o <= 1'b1;
			case({memread_i,memwrite_i})
				2'b01:begin							//write
					Ram1EN_o <= 1'b0;
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					Ram1EN_o <= 1'b0;
					read_o <= 1'b0;
				end
				default:begin
					Ram1EN_o <= 1'b1;
					read_o <= 1'b0;

				end
			endcase
		end

		else begin  //s_port
			res_from <= 2'b00;
			Ram1EN_o <= 1'b1;
			Ram2EN_o <= 1'b1;
			case(alures_i)
				16'hbf01:begin
					uart_result [15:0] <= {14'b00000000000000,data_ready_in,(tbre_in & tsre_in)};
				end
				16'hbf00:begin
					case({memread_i,memwrite_i})
						2'b01:begin							//write
							is_uart <= 1'b1;
							read_o <= 1'b1;
							rdn_o <= 1'b1;
						end
						2'b10:begin							//read
							is_uart <= 1'b1;
							read_o <= 1'b0;
							wrd_o <= 1'b1;
						end
					endcase
				end

				default:begin
					is_uart <= 1'b0;
					read_o <= 1'b0;
					rdn_o <= 1'b1;
					wrd_o <= 1'b1;
				end
			endcase

		end*/
	end

endmodule
