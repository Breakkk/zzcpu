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
	 input [17:0] addr,
	 input [15:0] data,
    output reg [17:0] Ram1Addr,
    inout [15:0] Ram1Data,
    output Ram1OE,
    output Ram1WE,
    output Ram1EN,
	 input read,
	 input clk,
	 input next,
	 input running
    );
	 
localparam W0 = 4'B0000;
localparam W1 = 4'B0001;
localparam W2 = 4'B0010;
localparam N  = 4'B0011;

reg oe;
reg we;
reg en;

reg flag;

reg [15:0] datain;

reg [3:0]c_state; 
reg [3:0]n_state;

assign Ram1OE = !running ? 1'bz : oe;
assign Ram1WE = !running ? 1'bz : we;
assign Ram1EN = !running ? 1'bz : 1'b0;

assign Ram1Data = flag ? 16'bz : datain;

always@(posedge clk or negedge next)begin
	if(!next)begin
		c_state <= W0;
	end
	else if(clk)begin
		c_state <= n_state;
	end
end

always@(c_state)begin
	case(c_state)
		W0:begin
			n_state = W1;
		end
		W1:begin
			n_state = W2;
		end
		W2:begin
			n_state = N;
		end
		N :begin
			n_state = N;
		end
	endcase
end

always@(posedge clk)begin
	case(c_state)
		W0:begin			// readAddr
			if(!read) begin
				Ram1Addr <= addr;
				datain <= data;
				oe <= 1'b1;
				flag <= 1'b0;
			end
			else begin
				oe <= 1'b0;
			end
		end
		W1:begin			// readData and write into RAM +1
			if(!read) begin
				we <= 1'b0;
			end
			else begin
				flag <= 1'b1;
			end
		end
		W2:begin			// loop write into RAM +9
			if(!read) begin
				we<= 1'b1;
			end
			else begin
				Ram1Addr <= addr;
			end
		end
		N :begin
		
		end
	endcase
end

endmodule
