`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:55 11/29/2018 
// Design Name: 
// Module Name:    ram2 
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
module ram2(

		output [17:0] Ram2Addr_o,
		inout [15:0] Ram2Data_io,
		output Ram2OE_o,
		output Ram2WE_o,
		output Ram2EN_o,
		
		input is_RAM2_mem_i,
		input [17:0] addr_mem_i,
		input [15:0] data_mem_i,
		input isread_mem_i,
		input iswrite_mem_i,
		input [15:0] addr_if_i,
		output [15:0] ram2res_o,
		input clk

		/*input [17:0] addr,
		input [15:0] data,
		output [17:0] Ram2Addr,
		inout [15:0] Ram2Data,
		output Ram2OE,
		output Ram2WE,
		output [15:0] mem2res_o,
		input read,	//0-read 1-write*/
    );
reg [15:0] memres2;
assign mem2res_o = memres2;

reg is_ram_read;

wire oe;
wire we;
reg en;
assign Ram2OE_o = !is_ram_read ? 1'b1 : !clk;
assign Ram2WE_o = !is_ram_read ? !clk : 1'b1;
assign Ram2EN_o = en;

assign Ram2Data_io = !is_ram_read ? data_mem_i : 16'bz;
assign Ram2Addr_o = is_RAM2_mem_i ? addr_mem_i : {2'b00,addr_if_i};

always @(*) begin
	case(is_RAM2_mem_i)
		1'b0:begin
			en <= 1'b0;
			is_ram_read <= 1'b1;
		end
		1'b1:begin
			case({isread_mem_i,iswrite_mem_i})
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
	if (isread_mem_i == 1'b1) begin
		memres2 <= Ram2Data_io;
	end
end
endmodule
