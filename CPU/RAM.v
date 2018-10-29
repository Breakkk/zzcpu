`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:27 10/28/2018 
// Design Name: 
// Module Name:    RAM 
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
module RAM(
	input	clk,
	input	read,
	input	addr,
	input	[15:0] data_i,
	output	reg[15:0] data_o,
    output	[17:0] RamAddr,
    inout	[15:0] RamData,
    output	reg	RamOE,
    output	reg	RamWE,
    output	reg	RamEN
);

localparam t_AA = 15;	//address access time - READ
localparam t_SA = 10;	//address setup time - WRITE
localparam t_PWE1 = 12;	//WE pulse width(OE = LOW) - WRITE
localparam t_PWE2 = 10;	//WE pulse width - WRITE
localparam t_H = 5;	//Hold from write end - WRITE

reg [15:0] dataBuf;
reg [17:0] addrBuf;
reg finished;

initial begin
	RamEN <= 1'b0;
	RamWE <= 1'b1;
	RamOE <= 1'b1;
	finished = 1'b1;
end

assign RamAddr = addrBuf;
assign RamData = dataBuf;

task RAM_READ;
	begin
		finished = 1'b0;
		dataBuf = 16'bz;
		addrBuf = addr;
		RamOE = 1'b0;
		#(t_AA) data_o = dataBuf;
		finished = 1'b1;
	end
endtask

task RAM_WRITE;
	begin
		finished = 1'b1;
		dataBuf = data_i;
		addrBuf = addr;
		#(t_SA) RamWE = 1'b0;
		#(t_PWE1) RamWE = 1'b1;
		#(t_H) finished = 1'b1;
	end
endtask

always@(posedge clk)begin
	if (read == 1'b1) begin
		wait(finished) RAM_READ();
	end else begin
		wait(finished) RAM_WRITE();
	end
end

endmodule
