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
    output reg wrn
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
	
	parameter writeRAM = 4'b1000;
	parameter readRAM = 4'b1001;
	
	reg [3:0] state_c = initialization;
	reg [3:0] state_n;
	reg accept_flag;
	reg read_ready = 8'b0;
	reg [7:0] data = 8'b00000000;
	reg [7:0] read_data = 8'b00000000;
	
	reg OE;
	reg WE;
	reg EN;
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
				/*case(CO)    //SW1 2
					clear:begin
						state_n = initialization;
					end
					read:begin    //2'b01;
						state_n = readIT1;
					end
					write:begin   //2'b10;
						state_n = writeIT1;
					end
					default:begin  
						state_n=initialization;  
					end 
				endcase*/
				state_n = readIT1;
			end
			
			readIT1:begin
				read_ready = data_ready;
				rdn = 1'b1;
				state_n = readIT2;
				accept_flag = 1'b1;
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
				state_n = writeIT1;
			end
			
			
			//writeIT
			writeIT1:begin
				accept_flag = 1'b0;
				data = read_data + 8'b00000001;
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
		end
		else if(state_c == initialization)begin  
			wrn <= 1'b1;
			OE <= 1'b1;
			WE <= 1'b1;
			EN <= 1'b1;
			L[7:0] <= 8'b00000010;
		end 
		
		//readIT
		else if(state_c == readIT1)begin  
			L[7:0] <= {Ram1Data[7:4],rdn,2'B01,data_ready};
		end 
		else if(state_c == readIT2)begin  
			L[7:0] <= {Ram1Data[7:4],rdn,2'B10,read_ready};//{7'b1111111,data_ready};Ram1Data[7:0];
		end 
		else if(state_c == readIT3)begin 
			L[7:0] <= {Ram1Data[7:4],rdn,2'B11,read_ready};
			read_data[7:0] <= Ram1Data[7:0];
			wrn <= 1'b1;
		end 
		else if(state_c == readIT4)begin 
			L[7:0] <= read_data[7:0];
			wrn <= 1'b1;
		end 
		//writeIT
		else if(state_c == writeIT1)begin  
			//data <= data +8'b00000001;
			L[7:0] <= {tbre,6'b000010,tsre};
			wrn <= 1'b0;
		end
		else if(state_c == writeIT2)begin  
			L[7:0] <= data[7:0];
			wrn <= 1'b1;
		end
		else if(state_c == writeIT3)begin  
			L[7:0] <= {tbre,6'b001110,tsre};
			
		end
		else if(state_c == writeIT4)begin  
			L[7:0] <= {tbre,6'b011110,tsre};
		end		
		else begin
		
		end
	end
	
	assign Ram1Data = accept_flag ? 8'bzzzzzzzz:data;
	assign Ram1OE = OE;
	assign Ram1WE = WE;
	assign Ram1EN = EN;
	
	//
endmodule
