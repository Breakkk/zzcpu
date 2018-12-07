`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:40:27 12/02/2018
// Design Name:
// Module Name:    ram1
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
module ram1(
		input data_ready_i,
		input tbre_i,
		input tsre_i,
		output wrn_o,
		output rdn_o,
		output [17:0] Ram1Addr_o,
		inout [15:0] Ram1Data_io,
		output Ram1OE_o,
		output Ram1WE_o,
		output Ram1EN_o,

		input is_RAM1_i,
		input is_UART_i,
		input [17:0] addr_i,      //17:0 !!!!!!!!!!!!
		input [15:0] data_i,

		input isread_i,
		input iswrite_i,
		output [15:0] ram1res_o,
		input clk
    );

reg is_uart_read = 1'b0;
reg is_uart_write = 1'b0;
reg is_ram_read = 1'b0;

wire read;
assign read = !((!is_ram_read & is_RAM1_i) | (is_UART_i & is_uart_write));

assign rdn_o = !is_uart_read ? 1'b1 : !clk;
assign wrn_o = !is_uart_write ? 1'b1 : !clk;

wire oe;
wire we;
reg en = 1'b0;
assign Ram1OE_o = !is_ram_read ? 1'b1 : !clk;
assign Ram1WE_o = !is_ram_read ? !clk : 1'b1;
assign Ram1EN_o = en;

assign Ram1Data_io = !read ? data_i : 16'bz;
assign Ram1Addr_o = addr_i;

reg is_check;

reg [15:0] mem1res;
reg [15:0] uart_check;
assign ram1res_o = is_check ? uart_check : mem1res;
/*
assign oe = !is_ram_read ? 1'b1 : !clk;
assign we = !is_ram_read ? !clk : 1'b1;
*/
always @(*) begin
	case(is_UART_i)
		1'b0:begin
			is_uart_read <= 1'b0;
			is_uart_write <= 1'b0;
			is_check <= 1'b0;
		end
		1'b1:begin
			is_ram_read <= 1'b0;
			case(addr_i[15:0])
				16'hbf01:begin
					is_check <= 1'b1;
					is_uart_read <= 1'b0;
					is_uart_write <= 1'b0;
					uart_check [15:0] <= {14'b00000000000000,data_ready_i,(tbre_i & tsre_i)};
				end
				16'hbf00:begin
					is_check <= 1'b0;
					case({isread_i,iswrite_i})
						2'b01:begin							//write
							is_uart_read <= 1'b0;
							is_uart_write <= 1'b1;
						end
						2'b10:begin							//read
							is_uart_read <= 1'b1;
							is_uart_write <= 1'b0;
						end
						default:begin
							is_uart_read <= 1'b0;
							is_uart_write <= 1'b0;
						end
					endcase
				end
			endcase
		end
	endcase

	case(is_RAM1_i)
		1'b0:begin
			en <= 1'b1;
			is_ram_read <= 1'b1;
		end
		1'b1:begin
			case({isread_i,iswrite_i})
				2'b01:begin							//write
					en <= 1'b0;
					is_ram_read <= 1'b0;
				end
				2'b10:begin							//read
					en <= 1'b0;
					is_ram_read <= 1'b1;
				end
				default:begin
					en <= 1'b1;
					is_ram_read <= 1'b1;

				end
			endcase
		end
	endcase
end
always@(negedge clk) begin
	if (isread_i == 1'b1) begin
		mem1res <= Ram1Data_io;
	end
end
endmodule
