`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:53:36 12/01/2018 
// Design Name: 
// Module Name:    wb 
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
module wb(
    input memtoreg_i,
    input [15:0] alures_i,
    input [15:0] memres_i,
    output [15:0] res_o
    );
	
	assign res_o = (memtoreg_i) ? (memres_i) : (alures_i);


endmodule
