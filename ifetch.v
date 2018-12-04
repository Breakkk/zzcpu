`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:15:28 12/04/2018 
// Design Name: 
// Module Name:    ifetch 
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
module ifetch(
    input CLK,
    input stall_pc_i,
    input jr_i,
    input [15:0] address_jr_i,
    input isbranch_i,
    input prewrong_i,
    input precorrc_i,
    output preresult_o,
    input [15:0] instr_i,
    output [15:0] pc_o,
    output [15:0] pcplus1_o,
    output [15:0] epc_o
    );
    
    // fake prediction
    assign preresult_o = 1'b0;

    reg [15:0] pc;
    reg [15:0] pc_lock;
    reg [15:0] pcplus1_lock;
    reg [15:0] pcplusimm_lock;
    
    reg [15:0] extendedimm;
    wire [15:0] pcplus1;
    wire [15:0] pcplusimm;
    wire [15:0] nextpc;

    always@(*) begin
        if (instr_i[15:11] === 5'b00010) begin
            extendedimm <= {(instr_i[10] ? 5'b11111 : 5'b00000), instr_i[10:0]};
        end else begin
            extendedimm <= {(instr_i[7] ? 8'b11111111 : 5'b00000000), instr_i[7:0]};
        end
    end
    assign pcplus1 = pc + 16'h0001;
    assign pcplusimm = pc + 16'h0001 + extendedimm;
    assign nextpc = jr_i ? address_jr_i : (prewrong_i ? pcplusimm_lock : pcplus1);
    // always@(*) begin
    //     if (jr_i) begin
    //         nextpc <= address_jr_i;
    //     end else if ()
    // end

    assign epc_o = (isbranch_i || jr_i) ? pc_lock : pc;
    assign pc_o = pc;
    assign pcplus1_o = pcplus1;

    always@(posedge CLK) begin
        if (!stall_pc_i) begin
            pc_lock = pc;
            pcplus1_lock = pcplus1;
            pcplusimm_lock = pc;
            pc = nextpc;
        end
    end
endmodule
