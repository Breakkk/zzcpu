`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:32:16 12/02/2018 
// Design Name: 
// Module Name:    mem 
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
module mem(
		input memread_i,
		input memwrite_i,
		input [15:0] memdata_i,
		input [15:0] alures_i,
		
		/*input data_ready_in,
		input tbre_in,
		input tsre_in,
		input 
		*/
		
		output is_RAM2_o,
		//output [15:0] memres_o,
		output reg read_o,	//0-read 1-write
		
		output reg Ram1EN
		//output reg Ram2EN_o
		
		
		//inout [15:0] Ram1Data,
		//inout [15:0] Ram2Data,
    );
	 
	reg [1:0] res_from;  //00 - s_port 01 - ram1   10 - ram2
	//reg [15:0] port_result;
	
	//assign memres_o = !ram_from ? memres_1 : memres_2;
	assign is_RAM2_o = res_from[1];
	always @(*) begin
		case({memread_i,memwrite_i})
			2'b01:begin	//write
				Ram1EN <= 1'b0;
				read_o <= 1'b1;
			end
			2'b10:begin	//read
				Ram1EN <= 1'b0;
				read_o <= 1'b0;
				
			end
			default:begin
				Ram1EN <= 1'b1;
				read_o <= 1'b0;
				
			end
		endcase
		/*if(alures_i<=16'hbeff)begin			//ram2
			res_from = 2'b10;
			Ram1EN <= 1'b1;
			case({memread_i,memwrite_i})
				2'b01:begin							//write
					Ram2EN_o <= 1'b0;
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					Ram2EN_o <= 1'b0;
					read_o <= 1'b0;
				end
				default:begin
					Ram2EN_o <= 1'b1;
					read_o <= 1'b0;
				
				end
			endcase
		end
		else if(alures_i>=16'hbf02)begin  	//ram1
			res_from = 2'b01;
			Ram2EN_o <= 1'b1;
			case({memread_i,memwrite_i})
				2'b01:begin							//write
					Ram1EN <= 1'b0;
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					Ram1EN <= 1'b0;
					read_o <= 1'b0;
				end
				default:begin
					Ram1EN <= 1'b1;
					read_o <= 1'b0;
				
				end
			endcase
		end
		
		else begin  //s_port
			res_from = 2'b00;
			Ram1EN = 1'b1;
			Ram2EN_o = 1'b1;
			case(alures_i)
				16'hbbf01:begin
					port_result [15:0] <= {14'b00000000000000,data_ready_in,(tbre_in & tsre_in)};
				end
				
				16'hbbf00:begin
				end
			endcase
			
			case({memread_i,memwrite_i})
				2'b01:begin							//write
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					read_o <= 1'b0;
				end
				default:begin
					Ram1EN <= 1'b1;
				
				end
			endcase
		end*/
	end

endmodule
