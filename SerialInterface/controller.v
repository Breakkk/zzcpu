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
    input [15:0] SW,
    output reg [7:0] L,
    output [17:0] Ram1Addr,
    inout [15:0] Ram1Data,
	 input clk1,
    output Ram1OE,
    output Ram1WE,
    output Ram1EN,
    input data_ready,
    output reg rdn,
    inout tbre,
    inout tsre,
    output reg wrn,
	 output [3:0] test
    );
	 
	parameter clear = 2'b00;
	parameter read = 2'b01;
	parameter write = 2'b10;
	 
	parameter initialization = 4'b0000;
	parameter readIT1 = 4'b0001;
	parameter readIT2 = 4'b0010;
	parameter readIT3 = 4'b0011;
	parameter readIT4 = 4'b1111;
	parameter writeIT1 = 4'b0100;
	parameter writeIT2 = 4'b0101;
	parameter writeIT3 = 4'b0110;
	parameter writeIT4 = 4'b0111;
	
	parameter writeRAM1 = 4'b1000;
	parameter writeRAM2 = 4'b1001;
	parameter writeRAM3 = 4'b1010;
	parameter readRAM1 = 4'b1011;
	parameter readRAM2 = 4'b1100;
	parameter readRAM3 = 4'b1101;
	
	reg [3:0] state_c = initialization;
	reg [3:0] state_n;
	reg accept_flag;
	reg read_ready = 8'b0;
	reg [7:0] data = 8'b00000000;
	reg [7:0] read_data = 8'b00000000;
	reg [17:0] currAddr;
	
	assign test = state_c;
	
	reg running;
	reg readRam;
	reg OE;
	reg WE;
	reg EN;
	always @(posedge CLK or negedge RST)begin 
		if(RST==1'b0)begin
			state_c <= initialization;
			readRam <= 1'b0;
		end
		else begin
			state_c<=state_n;
		end
	end
	
	
	always  @(*)begin
		case(state_c)
			initialization:begin
				
				state_n = readIT1;
			end
			
			initialization:begin
				state_n = readIT1;
			end
			
			readIT1:begin
				rdn = 1'b1;
				state_n = readIT2;
			end
			readIT2:begin
				case(read_ready)
					1'b1:begin
						state_n = readIT3;
						rdn = 1'b0;
					end
					1'b0:begin
						state_n = readIT1;
					end
				endcase
			end
			
			readIT3:begin
				rdn = 1'b1;
				state_n = readIT4;
			end
			
			readIT4:begin
				rdn = 1'b1;
				state_n = writeRAM1;
			end
			//
			writeRAM1:begin
				rdn = 1'b1;
				state_n = writeRAM2;
			end
			
			writeRAM2:begin
				
				state_n = writeRAM3;
			end
			
			writeRAM3:begin
				
				state_n = readRAM1;
			end
			
			readRAM1:begin
				
				state_n = readRAM2;
			end
			
			readRAM2:begin
				
				state_n = readRAM3;
			end
			
			readRAM3:begin
				
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
			OE <= 1'b1;
			WE <= 1'b1;
			EN <= 1'b1;
			running <= 1'b0;
		end
		else if(state_c == initialization)begin  
			wrn <= 1'b1;
			OE <= 1'b1;
			WE <= 1'b1;
			EN <= 1'b1;
			L[7:0] <= 8'b10000010;
		end 
		
		//readIT
		else if(state_c == readIT1)begin  
			read_ready <= data_ready;
			accept_flag <= 1'b1;
			L[7:0] <= {Ram1Data[7:4],rdn,2'B01,data_ready};
		end 
		else if(state_c == readIT2)begin  
			L[7:0] <= {Ram1Data[7:4],rdn,2'B10,read_ready};//{7'b1111111,data_ready};Ram1Data[7:0];
			read_data[7:0] <= Ram1Data[7:0];
		end 
		else if(state_c == readIT3)begin 
			L[7:0] <= {Ram1Data[7:4],4'B0110};
			wrn <= 1'b1;
		end 
		else if(state_c == readIT4)begin 
			L[7:0] <= read_data[7:0];
			wrn <= 1'b1;
		end 
		//writeIT
		else if(state_c == writeIT1)begin  
			//data <= read_data + 8'b00000001;
			accept_flag <= 1'b0;
			L[7:0] <= Ram1Data[7:0];
			wrn <= 1'b0;
		end
		else if(state_c == writeIT2)begin  
			L[7:0] <= data[7:0];
			wrn <= 1'b1;
		end
		else if(state_c == writeIT3)begin  
			L[7:0] <= Ram1Data[7:0];
			
		end
		else if(state_c == writeIT4)begin  
			L[7:0] <= {tbre,6'b011110,tsre};
		end
		
		//RAM
		else if(state_c == writeRAM1)begin  
			running <= 1'b1;
			accept_flag <= 1'b0;
			wrn <= 1'b1;
		end
		else if(state_c == writeRAM2)begin  
			data <= read_data;
			currAddr <= SW;
		end
		else if(state_c == writeRAM3)begin  
			
		end
		
		else if(state_c == readRAM1)begin  
			accept_flag <= 1'b1;
		end
		else if(state_c == readRAM2)begin  
			data <= Ram1Data[7:0] + 1'b1;
			wrn <= 1'b1;
		end
		else if(state_c == readRAM3)begin  
			running <= 1'b0;
			accept_flag <= 1'b0;
		end
		else begin
		
		end
	end
	RAM ram(.next(CLK), .addr(currAddr), .data(currValue), .Ram1Addr(Ram1Addr), .Ram1Data(Ram1Data), .Ram1OE(Ram1OE), .Ram1WE(Ram1WE), .Ram1EN(Ram1EN), .read(accept_flag), .clk(clk1));
	assign Ram1Data = accept_flag ? 16'bz : {8'h00, data};
	assign Ram1OE = running ? 1'bz : OE;
	assign Ram1WE = running ? 1'bz : WE;
	assign Ram1EN = running ? 1'bz : EN;
	
	//
endmodule
