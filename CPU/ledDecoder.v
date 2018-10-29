`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:24 10/28/2018 
// Design Name: 
// Module Name:    ledDecoder 
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
module ledDecoder(
    input [3:0] index,
    output [6:0] led
    );

reg [6:0] out;

always @(index) begin
	case(index)
	4'h1: out = 7'b0000110;    // ---t----
	4'h2: out = 7'b1011011;    // |      |
	4'h3: out = 7'b1001111;    // lt    rt
	4'h4: out = 7'b1100110;    // |      |
	4'h5: out = 7'b1101101;    // ---m----
	4'h6: out = 7'b1111101;    // |      |
	4'h7: out = 7'b0000111;    // lb    rb
	4'h8: out = 7'b1111111;    // |      |
	4'h9: out = 7'b1101111;    // ---b----
	4'ha: out = 7'b1110111;
	4'hb: out = 7'b0011000;
	4'hc: out = 7'b1001001;
	4'hd: out = 7'b0110000;
	4'he: out = 7'b0001001;
	4'hf: out = 7'b0001011;
	4'h0: out = 7'b0111111;
	endcase
end

assign led = out;

endmodule
