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
	 input addr,
	 input data,
    output reg [17:0] Ram1Addr,
    inout [15:0] Ram1Data,
    output Ram1OE,
    output Ram1WE,
    output Ram1EN,
	 input read
    );
	 
localparam W0 = 4'B0000;
localparam W1 = 4'B0001;
localparam W2 = 4'B0010;

localparam R0 = 4'B0011;
localparam R1 = 4'B0100;
localparam R2 = 4'B0101;

reg oe;
reg we;
reg en;

reg [3:0]c_state; 
reg [3:0]n_state;

reg changeflag;

localparam clk_period = 10;  
reg clk;  

initial begin  
    clk = 0;  
    forever  
        #(clk_period/2) clk = ~clk;  
end  

always@(posedge clk)begin
	if(clk)begin
		if(read)begin
			c_state = R0;
		end
		else begin
			c_state = W1;
		end
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
			n_state = W0;
		end

		R0:begin
			n_state = R1;
		end
		R1:begin
			n_state = R2;
		end
		R2:begin
			n_state = R0;
		end
	endcase
end

always@(posedge clk)begin
	case(c_state)
		W0:begin			// readAddr
			Ram1Addr <= addr;
			Ram1Data <= data;
		end
		W1:begin			// readData and write into RAM +1
			we <= 1'b0;
		end
		W2:begin			// loop write into RAM +9
			we<= 1'b1;
		end
		R0:begin
			oe <= 1'b0;
		end
		R1:begin
			Ram1Data <= 16'hZ;
		end
		R2:begin
			Ram1Addr <= data;
		end
	endcase
end

assign Ram1OE = oe;
assign Ram1WE = we;
assign Ram1EN = en;

endmodule
