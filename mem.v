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
		//output [15:0] memres_o,
		output reg read_o,	//0-read 1-write
		
		output reg Ram1EN
		//output reg Ram2EN_o
		
		
		//inout [15:0] Ram1Data,
		//inout [15:0] Ram2Data,
    );
	 
	//reg ram_from;  //0 - ram1   1 - ram2
	
	//assign memres_o = !ram_from ? memres_1 : memres_2;
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
			ram_from = 1'b1;
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
				
				end
			endcase
			Ram1EN = 1'b1;
		end
		else if(alures_i>=16'hbf02)begin  	//ram1
			ram_from = 1'b0;
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
				
				end
			endcase
			Ram2EN_o = 1'b1;
		end
		else begin  //s_port
			ram_from = 1'b1;
			Ram1EN = 1'b1;
			Ram2EN_o = 1'b1;
		end*/
	end

endmodule
