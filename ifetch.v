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
    input RST,
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
    
    reg reset;  // reset pc

    reg [15:0] pc;
    reg [15:0] pc_lock;
    reg [15:0] pcplus1_lock;
    reg [15:0] pcplusimm_lock;
    
    reg [15:0] extendedimm;
    wire [15:0] pcplus1;
    wire [15:0] pcplusimm;
    wire [15:0] nextpc;

	reg /*[1:0] */[255:0]pretable/*[0:255]*/;
	integer i;
    initial
    begin
        for (i=255;i>=0;i=i-1)
        begin
            //pretable[i] = 2'b00;
            pretable[i] = 1'b0;
        end
    end
	
    reg preresult_lock;
    wire preresult;
    assign preresult = pretable[pc[7:0]]/*[1]*/;
    assign preresult_o = preresult_lock;
	always@(negedge CLK) begin
        if (prewrong_i) begin
            pretable[pc_lock[7:0]] <= !pretable[pc_lock[7:0]];
            // if (preresult_lock) begin
            //     if (pretable[pc_lock[7:0]] != 2'b00) begin
            //         pretable[pc_lock[7:0]] <= pretable[pc_lock[7:0]] - 1;
            //     end
            // end else begin         
            //     if (pretable[pc_lock[7:0]] != 2'b11) begin
            //         pretable[pc_lock[7:0]] <= pretable[pc_lock[7:0]] + 1;
            //     end
            // end
        end /*else if (precorrc_i) begin
            if (preresult_lock) begin
                if (pretable[pc_lock[7:0]] != 2'b11) begin
                    pretable[pc_lock[7:0]] <= pretable[pc_lock[7:0]] + 1;
                end
            end else begin
                if (pretable[pc_lock[7:0]] != 2'b00) begin
                    pretable[pc_lock[7:0]] <= pretable[pc_lock[7:0]] - 1;
                end
            end
        end*/
    end
	
    always@(*) begin
        if (instr_i[15:11] === 5'b00010) begin
            extendedimm <= {(instr_i[10] ? 5'b11111 : 5'b00000), instr_i[10:0]};
        end else begin
			extendedimm <= {(instr_i[7] ? 8'b11111111 : 8'b00000000), instr_i[7:0]};
        end
    end
    assign pcplus1 = pc + 16'h0001;
    assign pcplusimm = pc + 16'h0001 + extendedimm;
    assign nextpc = jr_i ? address_jr_i : (prewrong_i ? (preresult_lock ? pcplus1_lock : pcplusimm_lock) : ((preresult) ? pcplusimm : pcplus1));

    assign epc_o = (isbranch_i || jr_i) ? pc_lock : pc;
    assign pc_o = pc;
    assign pcplus1_o = pcplus1;

	
    always@(posedge CLK or negedge RST) begin
        if (!RST) begin
			pc <= 16'h0000;
            pc_lock <= 16'h0000;
            pcplus1_lock <= 16'h0000;
            pcplusimm_lock <= 16'h0000;
            preresult_lock <= 1'b0;
			reset <= 1'b1;
        end else begin
            if (!stall_pc_i) begin
				if (reset) begin
					reset <= 1'b0;
				end else begin
					pc_lock <= pc;
					pcplus1_lock <= pcplus1;
					pcplusimm_lock <= pcplusimm;
					pc <= nextpc;
                    preresult_lock <= preresult;
				end
            end
        end
    end
endmodule
