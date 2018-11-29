`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:30 11/29/2018 
// Design Name: 
// Module Name:    RegisterHeap 
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
module RegisterHeap#(parameter REG_WIDTH = 4)(

		input CLK,
		input [REG_WIDTH-1:0] r_reg_A,//A读寄存器地址
		input [REG_WIDTH-1:0] r_reg_B,//B读寄存器地址
		
		input EN_WRITE_REG,         //写使能
		input [REG_WIDTH-1:0] w_reg,//写寄存器地址
		input [15:0] w_data,         //待写入数据
		
		output [15:0] read_data_A,
		output [15:0] read_data_B
		
    );

	parameter NUM = 1<<REG_WIDTH;
	reg [15:0]REG_Heaps[0:NUM-1];
	
	always@(negedge CLK)//时钟信号下降沿
		begin
			case(EN_WRITE_REG)
				1'b1:begin
					
				end
				1'b0:begin
					//q[(WIDTH-1):0] <= (EN_WRITE) ? d[(WIDTH-1):0] : q[(WIDTH-1):0];
					REG_Heaps[w_reg] <= w_data;
				end
			endcase
		end
	
	assign read_data_A = REG_Heaps[r_reg_A];
	assign read_data_B = REG_Heaps[r_reg_B];
endmodule
