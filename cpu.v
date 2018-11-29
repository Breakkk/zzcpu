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
	
	output [15:0] l,
	
	output [17:0] Ram1Addr,	//Ram1-data
	inout [15:0] Ram1Data,
	output Ram1OE,
	output Ram1WE,
	output Ram1EN,
	
	output [17:0] Ram2Addr,	//Ram2-program
	inout [15:0] Ram2Data,
	output Ram2OE,
	output Ram2WE,
	output Ram2EN,
	output wrn,
	output rdn
	
    );
//assign wrn = 1'b1;		//test ram 
//assign rdn = 1'b1;
//assign Ram2Addr = 17'b0;
//assign Ram2Data = 17'bz;
//assign Ram2OE = 1'b1;
//assign Ram2WE = 1'b1;
//assign Ram2EN = 1'b1;
//
//assign Ram1EN = 1'b0;
//wire [17:0] test_pc;
//wire [15:0] datatmp;
//wire t_read;
//reg [17:0]t;
//reg [15:0]d;
//reg tr;
//assign test_pc = t;
//assign datatmp = d;
//assign t_read = tr;
//
//ram1 _ram1(
//	.addr(test_pc),
//	.data(datatmp),
//	.Ram1Addr(Ram1Addr),
//	.Ram1Data(Ram1Data),	//指令内容
//	.Ram1OE(Ram1OE),
//	.Ram1WE(Ram1WE),
//	.read(t_read),
//	.clk(clk)
//);
//
//reg [5:0] cnt;
//
//always@ (posedge clk or negedge rst) begin
//	if(!rst) begin
//		cnt <= 0;
//		t <= 0;	//addr
//		tr <= 1'b1;	//read
//		d <= 16'h01ff;	//data
//	end
//	else begin
//		if(cnt == 2) begin
//			cnt <= cnt + 1;
//			tr <= 1'b0;
//			t <= 0;
//		end
//		else if (cnt > 2) begin
//			t <= t + 1;
//		end
//		else begin
//			cnt <= cnt + 1;
//			t <= t + 1;
//			d <= d + 16'h0100;
//		end
//	end
//end
//
//assign l = Ram1Data;


//al ways@ (posedge clk) begin
//	y <= 1'b1;
//end
//
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
	.Ram2Data(Ram2Data),	//指令内容
	.Ram2OE(Ram2OE),
	.Ram2WE(Ram2WE),
	.read(readINST),
	.clk(clk)
);

// IF/ID

if_id _if_id(
	.clk(clk),
	.flush(),
	.pc_in(if_pc),
	.pc_out(id_pc),
	.inst_in(Ram2Data),
	.inst_out(id_inst)
);

// ID



// ID/EXE

// EXE

// EXE/MEM

// MEM

// MEM/WB

// WB

endmodule
