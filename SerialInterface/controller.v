`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:05 10/28/2018 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input CLK,
    input RST,
    input [7:0] SW,
	 input [1:0] CO,
    output reg [7:0] L,
    inout [7:0] Ram1Data,
    output reg Ram1OE,
    output reg Ram1WE,
    output reg Ram1EN,
    inout data_ready,
    output reg rdn,
    inout tbre,
    inout tsre,
    output reg wrn
    );
	 
	parameter clear = 2'b00;
	parameter read = 2'b01;
	parameter write = 2'b10;
	 
	parameter initialization = 4'b0000;
	parameter readIT1 = 4'b0001;
	parameter readIT2 = 4'b0010;
	parameter readIT3 = 4'b0011;
	parameter writeIT1 = 4'b0100;
	parameter writeIT2 = 4'b0101;
	parameter writeIT3 = 4'b0110;
	parameter writeIT4 = 4'b0111;
	
	reg [3:0] state_c;
	reg [3:0] state_n;
	
	reg [7:0] data;
	
	always @(posedge CLK or negedge RST)begin 
		if(RST==1'b0)begin
			state_c <= initialization;
		end
		else begin
			state_c<=state_n;
		end
	end
	
	
	always  @(*)begin
		case(state_c)
			initialization:begin
				/*case(CO)
					clear:begin
						state_n = initialization;
					end
					read:begin
						state_n = readIT1;
					end
					write:begin
						state_n = writeIT1;
					end
					default:begin  
						state_n=state_c;  
					end 
				endcase*/
				state_n = writeIT1;
			end
			
			readIT1:begin
				state_n = readIT2;
			end
			readIT2:begin
				if(data_ready == 1'b1)
					state_n = readIT3;
				else
					state_n = readIT1;
			end
			readIT3:begin
				state_n = writeIT1;
			end
			
			//writeIT
			writeIT1:begin
				state_n = writeIT2;
			end
			writeIT2:begin
				state_n = writeIT3;
			end
			writeIT3:begin
				if (tbre == 1'b1) state_n = writeIT4;
				else state_n = writeIT3;
			end
			writeIT4:begin
				if (tsre == 1'b1) state_n = initialization;
				else state_n = writeIT4;
			end
			default:begin  
				state_n=state_c;  
			end 
		endcase
	end
	
	always @(posedge CLK or negedge RST)begin 
		if(RST==1'b0)begin
			wrn <= 1'b1;
			Ram1OE <= 1'b1;
			Ram1WE <= 1'b1;
			Ram1EN <= 1'b1;
		end
		else if(state_c == initialization)begin  
			L[7:0] <= 8'b10101010;
			wrn <= 1'b1;
			Ram1OE <= 1'b1;
			Ram1WE <= 1'b1;
			Ram1EN <= 1'b1;
		end 
		
		else if(state_c == readIT1)begin  
			rdn <= 1'b1;
			data[7:0] <= 8'bzzzzzzzz;
		end 
		else if(state_c == readIT2)begin  
			rdn <= 1'b0;
		end 
		else if(state_c == readIT3)begin 
			rdn <= 1'b1;
			L[7:0] <= Ram1Data[7:0];
			data[7:0] <= Ram1Data[7:0];
		end 
		
		//writeIT
		else if(state_c == writeIT1)begin  
			//data <= data +8'b00000001;
			L[7:0] <= {tbre,6'b111111,tsre};
			data <= 8'b10011001;
			wrn <= 1'b0;
		end
		else if(state_c == writeIT2)begin  
			L[7:0] <= {tbre,6'b000000,tsre};
			wrn <= 1'b1;
		end
		else if(state_c == writeIT3)begin  
			L[7:0] <= 8'b00000111;
			
		end
		else if(state_c == writeIT4)begin  
			L[7:0] <= 8'b00001111;
		end		
		else begin
		
		end
	end
	
	assign Ram1Data = data;
	//
endmodule
