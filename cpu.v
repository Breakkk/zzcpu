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
	
wire realclk;

// IF - pc
// belongs to IF module
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

// IF - IM
// belongs to IF module
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
// signal from IF/ID to ID
wire [15:0] instr;
wire [15:0] epc_if_o;

if_id _if_id(
	.clk(clk),
	.flush(),
	.pc_in(if_pc),
	.pc_out(epc_if_o),
	.inst_in(Ram2Data),
	.inst_out(instr)
);

// ID
// signal from ID to ID/EX
wire [15:0] alusrc1_id_o;
wire [15:0] alusrc2_id_o;
wire [3:0] regsrc1_id_o;			// name of the ALU src register
wire [3:0] regsrc2_id_o;
wire [3:0] regdst_id_o;				// name of the register to which data is written back
wire [15:0] epc_id_o;
wire flush_id;
wire regwrite_id_o;					// ctrl signal
wire memtoreg_id_o;
wire writereg_id_o;
wire memread_id_o;
wire memwrite_id_o;
wire aluop_id_o;
// signal from ID to EX/MEM
wire flush_ex;
// signal from external interception to ID
wire intercepted;
// signal from ID to Hazard detection unit
wire isjump_id_o;
// signal from ID to IF :
wire [15:0] address_jr_id_o;
wire isbranch_id_o;
wire isintzero_id_o;

id _id(
	.instr_i(instr),
	.epc_i(epc_if),
	.ex_intcp_i(intercepted),
	.regwrite_o(regwrite_id_o),
	.memtoreg_o(memtoreg_id_o),
	.writereg_o(writereg_id_o),
	.memread_o(memread_id_o),
	.memwrite_o(memwrite_id_o),
	.aluop_o(aluop_id_o),
	.alusrc1_o(alusrc1),
	.alusrc1_o(alusrc2),
	.regsrc1_o(regsrc1),
	.regsrc2_o(regsrc2),
	.regdst_o(regdst),
	.epc_o(epc_id_o),
	.flush_id_o(flush_id),
	.flush_ex_o(flush_ex),
	.isjump_o(isjump_id_o),
	.address_jr(address_jr_id_o),
	.isbranch_o(isbranch_id_o),
	.isintzero_o(isintzero)
}

// ID/EXE

// EXE

// EXE/MEM

// MEM

// MEM/WB

// WB

endmodule

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



//clock _clock(
//	.clk(clk),
//	.clock(realclk)
//);
