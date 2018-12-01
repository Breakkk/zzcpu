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
module RegisterHeap#(parameter REG_WIDTH = 4,parameter NUM = 16)(

		input CLK,
		input [REG_WIDTH-1:0] rdreg1_i,//A¶Á¼Ä´æÆ÷µØÖ·
		input [REG_WIDTH-1:0] rdreg2_i,//B¶Á¼Ä´æÆ÷µØÖ·
		
		input regwrite_i,
		input [REG_WIDTH-1:0] wrreg_i,//Ğ´¼Ä´æÆ÷µØÖ·
		input [15:0] wdata_i,        //´ıĞ´ÈëÊı¾İ
		
		output [15:0] rdata1_o,
		output [15:0] rdata2_o
		
    );

	reg [15:0]REG_Heaps[0:NUM-1];
	// 4'b0000 - 4'b0111: R0 - R7;
	// 4'b1000 - 4'b1100(4'b1011): SP T IH RS(EPC)
	assign rdata1_o = REG_Heaps[rdreg1_i];
	assign rdata2_o = REG_Heaps[rdreg2_i];
	
	always@(negedge CLK)//Ê±ÖÓĞÅºÅÏÂ½µÑØ
		begin
			case(regwrite_i)
				1'b1:begin
					
				end
				1'b0:begin
					REG_Heaps[wrreg_i] <= wdata_i;
				end
			endcase
		end
	
endmodule
