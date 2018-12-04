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
		
		input data_ready_in,
		input tbre_in,
		input tsre_in,
		input [15:0] mem1_res_i,
		input [15:0] mem2_res_i,
		
		output is_RAM2_o,
		output reg read_o,	//0-read 1-write
		output [15:0] memres_o,
		
		output reg Ram1EN_o,
		output reg Ram2EN_o,
		
		output reg rdn_o,
		output reg wrd_o
    );
	 
	reg [1:0] res_from;  //00 - s_port 01 - ram1   10 - ram2
	reg is_uart;
	reg [15:0] uart_result;
	
	assign memres_o = res_from[1] ? mem2_res_i : mem1_res_i;
	assign is_RAM2_o = res_from[1];
	
	always @(*) begin
		/*case({memread_i,memwrite_i})
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
		endcase*/
		if(alures_i<=16'hbeff)begin			//ram2
			res_from <= 2'b10;
			is_uart <= 1'b0;
			Ram1EN_o <= 1'b1;
			rdn_o <= 1'b1;
			wrd_o <= 1'b1;
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
			res_from <= 2'b01;
			is_uart <= 1'b0;
			Ram2EN_o <= 1'b1;
			rdn_o <= 1'b1;
			wrd_o <= 1'b1;
			case({memread_i,memwrite_i})
				2'b01:begin							//write
					Ram1EN_o <= 1'b0;
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					Ram1EN_o <= 1'b0;
					read_o <= 1'b0;
				end
				default:begin
					Ram1EN_o <= 1'b1;
					read_o <= 1'b0;
				
				end
			endcase
		end
		
		else begin  //s_port
			res_from <= 2'b00;
			is_uart <= 1'b1;
			Ram1EN_o <= 1'b1;
			Ram2EN_o <= 1'b1;
			case(alures_i)
				16'hbf01:begin
					uart_result [15:0] <= {14'b00000000000000,data_ready_in,(tbre_in & tsre_in)};
				end
				16'hbf00:begin
					
				end
			endcase
			
			/*case({memread_i,memwrite_i})
				2'b01:begin							//write
					read_o <= 1'b1;
				end
				2'b10:begin							//read
					read_o <= 1'b0;
				end
				default:begin
					Ram1EN <= 1'b1;
				
				end
			endcase*/
		end
	end

endmodule
