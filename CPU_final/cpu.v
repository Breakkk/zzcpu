`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:56 11/29/2018 
// Design Name: 
// Module Name:    cpu 
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
module zzcpu(
	input clk,
	input rst,
	output reg y,
	
	output [17:0] Ram1Addr,	//Ram1-data
	inout [15:0] Ram1Data,
	output Ram1OE,
	output Ram1WE,
	output Ram1EN,
	
	output [17:0] Ram2Addr,	//Ram2-program
	inout [15:0] Ram2Data,
	output Ram2OE,
	output Ram2WE,
	output Ram2EN
    );

always@ (posedge clk) begin
	y <= 1'b1;
end

// clock
wire realclk;

//clock _clock(
//	.clk(clk),
//	.clock(realclk)
//);

// IF 
wire [17:0] if_pc;
wire pc_jump;
wire hold;
wire [17:0] pc_jump_val; 

pc _pc(
	.clk(clk),
	.rst(rst),
	.hold(hold),
	.pc_jump(pc_jump),
	.pc_jump_val(pc_jump_val),
	.pc(if_pc)
);

wire readINST;
assign readINST = 1'b1;

ram2 _ram2(
	.addr(if_pc),
	.data(datatmp),
	.Ram2Addr(Ram2Addr),
	.Ram2Data(Ram2Data),	//Ö¸ÁîÄÚÈÝ
	.Ram2OE(Ram2OE),
	.Ram2WE(Ram2WE),
	.Ram2EN(Ram2EN),
	.read(readINST),
	.clk(clk)
);

// IF/ID

if_id(

);

// ID

// ID/EXE

// EXE

// EXE/MEM

// MEM

// MEM/WB

// WB

endmodule
