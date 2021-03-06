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

	output [15:0] light,
	input [15:0] l,

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

	input data_ready,
	input tbre,
	input tsre,
	output wrn,
	output rdn
    );

clock _clk(
	.clk(clk),
	.clock(clock)
);

wire intercepted;
wire flush_id;
wire flush_ex;
wire flush_if;
wire stall_pc;
wire stall_if;


// IF - pc
// belongs to IF module
// wire [17:0] if_pc;
// wire pc_jump;
// wire hold;
// wire [17:0] pc_jump_val;

// pc _pc(
// 	.clk(clk),
// 	.rst(rst),
// 	.hold(hold),
// 	.pc_jump(pc_jump),
// 	.pc_jump_val(pc_jump_val),
// 	.pc(if_pc)
// );

// IF - IM
// belongs to IF module
// wire readINST;
// assign readINST = 1'b1;

// ram2 _ram2(
// 	.addr(if_pc),
// 	.data(datatmp),
// 	.Ram2Addr(Ram2Addr),
// 	.Ram2Data(Ram2Data),	//ָ������
// 	.Ram2OE(Ram2OE),
// 	.Ram2WE(Ram2WE),
// 	.read(readINST),
// 	.clk(clk)
// );

// IF
wire [15:0] pc_if_o;
wire ifjr_hdu_o;
wire prewrong_hdu_o;
wire precorrc_hdu_o;
wire preresult_if_o;
// signal from IM(RAM2) to IF & IF/ID
wire [15:0] ram2res_ram2_o;
// signal from ID to IF :
wire [15:0] address_jr_id_o;
wire isbranch_id_o;	// to HDU & IF
// signal from IF to IF/ID
wire [15:0] epc_if_o;
wire [15:0] pcplus1_if_o;

ifetch _if(
	.CLK(clock),
	.RST(rst),
	.stall_pc_i(stall_pc),
	.jr_i(ifjr_hdu_o),
	.address_jr_i(address_jr_id_o),
	.isbranch_i(isbranch_id_o),
	.prewrong_i(prewrong_hdu_o),
	.precorrc_i(precorrc_hdu_o),
	.preresult_o(preresult_if_o),
	//.instr_i(ram2res_ram2_o),
	.instr_i(l),
	.pc_o(pc_if_o),
	.pcplus1_o(pcplus1_if_o),
	.epc_o(epc_if_o)
);

// IF/ID
// signal from HDU to IF/ID
wire isintzero;
// signal from IF/ID to ID
wire [15:0] instr_ifid_o;
//assign instr_ifid_o = l;
wire [15:0] epc_ifid_o;
wire [15:0] pcplus1_ifid_o;

//assign light[15] = ifjr_hdu_o;
//assign light[14] = isbranch_id_o;
assign light[15:8] = pc_if_o[7:0];
assign light[7:0] = instr_ifid_o[7:0];
if_id _if_id(
	.CLK(clock),
	.RST(rst),
	.flush_if_i(flush_if),
	.isintzero_i(isintzero),
	.stall_if_i(stall_if),
	.epc_i(epc_if_o),
	.pcplus1_i(pcplus1_if_o),
	.instr_i(l),
	//.instr_i(ram2res_ram2_o),
	.epc_o(epc_ifid_o),
	.pcplus1_o(pcplus1_ifid_o),
	.instr_o(instr_ifid_o)
);

// ID
// signal from RegHeap to ID
wire [15:0] regdata1_rh_o;
wire [15:0] regdata2_rh_o;
// signal from ID to RegHeap
wire [3:0] readreg1_id_o;
wire [3:0] readreg2_id_o;
// signal from ID to ID/EX
wire [15:0] alusrc1_id_o;
wire [15:0] alusrc2_id_o;
wire [3:0] regsrc1_id_o;			// name of the ALU src register
wire [3:0] regsrc2_id_o;
wire [3:0] regsrc_sw_id_o;
wire [3:0] regdst_id_o;				// name of the register to which data is written back
wire regwrite_id_o;					// ctrl signal
wire memtoreg_id_o;
wire memread_id_o;
wire memwrite_id_o;
wire [15:0] memdata_id_o;
wire [3:0] aluop_id_o;
// signal from ID to Hazard detection unit
wire isjump_id_o;
wire ifbranch_id_o;


wire [3:0] regdst_idex_o;
wire regwrite_idex_o;
wire [3:0] regdst_exmem_o;
wire regwrite_exmem_o;
wire [15:0] alures_exmem_o;
wire [15:0] alures_ex_o;

id _id(
	.instr_i(instr_ifid_o),
	.rdata1_i(regdata1_rh_o),
	.rdata2_i(regdata2_rh_o),
	.pcplus1_i(pcplus1_ifid_o),		//MFPC
	.exregdst_i(regdst_idex_o),			//input -- Forwarding Unit
	.exregwrite_i(regwrite_idex_o),
	.exregdata_i(alures_ex_o),
	.memregdst_i(regdst_exmem_o),
	.memregwrite_i(regwrite_exmem_o),
	.memregdata_i(alures_exmem_o),
	.readreg1_o(readreg1_id_o),
	.readreg2_o(readreg2_id_o),
	.regwrite_o(regwrite_id_o),			// ctrl code
	.memtoreg_o(memtoreg_id_o),
	.memread_o(memread_id_o),
	.memwrite_o(memwrite_id_o),
	.memdata_o(memdata_id_o),
	.aluop_o(aluop_id_o),				// alu
	.alusrc1_o(alusrc1_id_o),
	.alusrc2_o(alusrc2_id_o),
	.regsrc1_o(regsrc1_id_o),
	.regsrc2_o(regsrc2_id_o),
	.regsrc_sw_o(regsrc_sw_id_o),
	.regdst_o(regdst_id_o),
	.isjump_o(isjump_id_o),				// jump & branch handling
	.ifbranch_o(ifbranch_id_o),
	.address_jr(address_jr_id_o),
	.isbranch_o(isbranch_id_o)
);

// ID/EXE
wire [15:0] epc_idex_o;
// signal from ID/EX to EX
wire [3:0] aluop_idex_o;
wire [16:0] alusrc1_idex_o;
wire [16:0] alusrc2_idex_o;
wire [3:0] regsrc1_idex_o;
wire [3:0] regsrc2_idex_o;
wire [3:0] regsrc_sw_idex_o;
wire [15:0] memdata_idex_o;
// signal from ID/EX to EX/MEM
wire memtoreg_idex_o;					//isload = memtoreg & memread --- Hazard
wire memread_idex_o;
wire memwrite_idex_o;

id_ex _id_ex(
	.CLK(clock),
	.RST(rst),
	.regwrite_i(regwrite_id_o),			//input
	.memtoreg_i(memtoreg_id_o),
	.memread_i(memread_id_o),
	.memwrite_i(memwrite_id_o),
	.memdata_i(memdata_id_o),
	.aluop_i(aluop_id_o),
	.alusrc1_i(alusrc1_id_o),
	.alusrc2_i(alusrc2_id_o),
	.regsrc1_i(regsrc1_id_o),
	.regsrc2_i(regsrc2_id_o),
	.regsrc_sw_i(regsrc_sw_id_o),
	.regdst_i(regdst_id_o),
	.epc_i(epc_ifid_o),
	.flush_id_i(flush_id),
	.regwrite_o(regwrite_idex_o),
	.memtoreg_o(memtoreg_idex_o),
	.memread_o(memread_idex_o),
	.memwrite_o(memwrite_idex_o),
	.aluop_o(aluop_idex_o),
	.alusrc1_o(alusrc1_idex_o),
	.alusrc2_o(alusrc2_idex_o),
	.regsrc1_o(regsrc1_idex_o),
	.regsrc2_o(regsrc2_idex_o),
	.regsrc_sw_o(regsrc_sw_idex_o),
	.memdata_o(memdata_idex_o),
	.regdst_o(regdst_idex_o),
	.epc_o(epc_idex_o)
);

// EXE ---- contains Forwarding Unit
// signal from EX/MEM to EX
// signal from MEM/WB to EX
wire [3:0] regdst_memwb_o;
wire regwrite_memwb_o;
wire [15:0] res_wb_o;
// signal from EX to EX/MEM
wire [15:0] memdata_ex_o;
//wire [3:0] regdst_ex_o;

ex _ex (
	.aluop_i(aluop_idex_o),					//input
	.alusrc1_i(alusrc1_idex_o),
	.alusrc2_i(alusrc2_idex_o),
	.regsrc1_i(regsrc1_idex_o),
	.regsrc2_i(regsrc2_idex_o),
	.regsrc_sw_i(regsrc_sw_idex_o),
	.memdata_i(memdata_idex_o),
	.exregdst_i(regdst_exmem_o),			//input -- Forwarding Unit
	.exregwrite_i(regwrite_exmem_o),
	.exregdata_i(alures_exmem_o),
	.memregdst_i(regdst_memwb_o),
	.memregwrite_i(regwrite_memwb_o),
	.memregdata_i(res_wb_o),
	.alures_o(alures_ex_o),
	.memdata_o(memdata_ex_o)
);

// EXE/MEM
// signal from EX/MEM to MEM
wire memread_exmem_o;
wire memwrite_exmem_o;
wire [15:0] memdata_exmem_o;
// signal from EX/MEM to MEM/WB
wire memtoreg_exmem_o;

ex_mem _ex_mem(
	.CLK(clock),
	.RST(rst),
	.flush_ex_i(flush_ex),					//input
	.regwrite_i(regwrite_idex_o),
	.memtoreg_i(memtoreg_idex_o),
	.memread_i(memread_idex_o),
	.memwrite_i(memwrite_idex_o),
	.memdata_i(memdata_ex_o),
	.regdst_i(regdst_idex_o),
	.alures_i(alures_ex_o),
	.regwrite_o(regwrite_exmem_o),			//output
	.memtoreg_o(memtoreg_exmem_o),
	.memread_o(memread_exmem_o),
	.memwrite_o(memwrite_exmem_o),
	.memdata_o(memdata_exmem_o),
	.regdst_o(regdst_exmem_o),
	.alures_o(alures_exmem_o)
);

// MEM
wire [15:0] ram1res_ram1_o;
wire is_RAM2_mem_o;
wire is_RAM1_mem_o;
wire is_UART_mem_o;
wire [15:0] memres_mem_o;


// assign wrn = 1'b1;
// assign rdn = 1'b1;
mem _mem(
	.alures_i(alures_exmem_o),
	.mem1_res_i(ram1res_ram1_o),
	.mem2_res_i(ram2res_ram2_o),
	.memread_i(memread_exmem_o),
	.memwrite_i(memwrite_exmem_o),
	.is_RAM2_o(is_RAM2_mem_o),
	.is_RAM1_o(is_RAM1_mem_o),
	.is_UART_o(is_UART_mem_o),
	.memres_o(memres_mem_o)
);

ram1 _ram1(
	.data_ready_i(data_ready),
	.tbre_i(tbre),
	.tsre_i(tsre),
	.wrn_o(wrn),
	.rdn_o(rdn),
	.Ram1Addr_o(Ram1Addr),
	.Ram1Data_io(Ram1Data),
	.Ram1OE_o(Ram1OE),
	.Ram1WE_o(Ram1WE),
	.Ram1EN_o(Ram1EN),
	.is_RAM1_i(is_RAM1_mem_o),
	.is_UART_i(is_UART_mem_o),
	.addr_i({2'b00,alures_exmem_o}),
	.data_i(memdata_exmem_o),
	.isread_i(memread_exmem_o),
	.iswrite_i(memwrite_exmem_o),
	.ram1res_o(ram1res_ram1_o),
	.clk(clock)
);

ram2 _ram2(
	.Ram2Addr_o(Ram2Addr),
	.Ram2Data_io(Ram2Data),
	.Ram2OE_o(Ram2OE),
	.Ram2WE_o(Ram2WE),
	.Ram2EN_o(Ram2EN),
	.is_RAM2_mem_i(is_RAM2_mem_o),
	.addr_mem_i({2'b00,alures_exmem_o}),
	.data_mem_i(memdata_exmem_o),
	.isread_mem_i(memread_exmem_o),
	.iswrite_mem_i(memwrite_exmem_o),
	.addr_if_i(pc_if_o),
	.ram2res_o(ram2res_ram2_o),
	.clk(clock)
);

// MEM/WB
wire [15:0] alures_memwb_o;
wire [15:0] memres_memwb_o;
wire memtoreg_memwb_o;
mem_wb _mem_wb(
	.CLK(clock),
	.RST(rst),
	.memtoreg_i(memtoreg_exmem_o),
	.regdst_i(regdst_exmem_o),
	.regwrite_i(regwrite_exmem_o),
	.alures_i(alures_exmem_o),
	.memres_i(memres_mem_o),
	.memtoreg_o(memtoreg_memwb_o),
	.regdst_o(regdst_memwb_o),
	.regwrite_o(regwrite_memwb_o),
	.alures_o(alures_memwb_o),
	.memres_o(memres_memwb_o)
);

// WB
wb _wb(
	.memtoreg_i(memtoreg_memwb_o),
	.alures_i(alures_memwb_o),
	.memres_i(memres_memwb_o),
	.res_o(res_wb_o)
);

// RegHeap
wire [15:0] epc_hdu_o;
RegisterHeap _regheap(
	.CLK(clock),
	.rdreg1_i(readreg1_id_o),
	.rdreg2_i(readreg2_id_o),
	.regwrite_i(regwrite_memwb_o),
	.wrreg_i(regdst_memwb_o),
	.wdata_i(res_wb_o),
	.epc_i(epc_hdu_o),
	.rdata1_o(regdata1_rh_o),
	.rdata2_o(regdata2_rh_o)
);

// Hazard detection unit
hazard _hazard(
	.CLK(clock),
	.interception_i(intercepted),			// Interception
	.ram2_conflict_i(is_RAM2_mem_o),			// SRAM Hazard
	.memtoreg_i(memtoreg_idex_o),			// Data Hazard -- LW
	.memread_i(memread_idex_o),
	.regsrc1_i(regsrc1_id_o),
	.regsrc2_i(regsrc2_id_o),
	.regsrc_sw_i(regsrc_sw_id_o),
	.regdst_i(regdst_idex_o),
	.memtoreg_mem_i(memtoreg_exmem_o),		// Data Hazard -- LW & JR/B
	.memread_mem_i(memread_exmem_o),
	.regdst_mem_i(regdst_exmem_o),
	.regsrc1_id_i(readreg1_id_o),
	.isjump_i(isjump_id_o),					// Control Hazard -- Jump
	.jr_o(ifjr_hdu_o),						// jr giving order to IF
	.isbranch_i(isbranch_id_o),				// Control Hazard -- Branch
	.ifbranch_i(ifbranch_id_o),				// do branch
	.prediction_i(preresult_if_o),			// prediction res
	.prewrong_o(prewrong_hdu_o),			// prediction wrong
	.precorrc_o(precorrc_hdu_o),			// prediction correct
	.flush_if_o(flush_if),
	.flush_id_o(flush_id),
	.flush_ex_o(flush_ex),
	.isintzero_o(isintzero),
	.stall_pc_o(stall_pc),
	.stall_if_o(stall_if),
	.epc_i(epc_idex_o),
	.epc_o(epc_hdu_o)
);

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
//	.Ram1Data(Ram1Data),	//ָ������
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
