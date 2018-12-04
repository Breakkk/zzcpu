`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:22:32 12/04/2018
// Design Name:   ram1
// Module Name:   G:/ISE_Project/zzcpu/ram1_test.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ram1_test;

	// Inputs
	reg data_ready_i;
	reg tbre_i;
	reg tsre_i;
	reg is_RAM1_i;
	reg is_UART_i;
	reg [17:0] addr_i;
	reg [15:0] data_i;
	reg isread_i;
	reg iswrite_i;
	reg clk;

	// Outputs
	wire wrn_o;
	wire rdn_o;
	wire [17:0] Ram1Addr_o;
	wire Ram1OE_o;
	wire Ram1WE_o;
	wire Ram1EN_o;
	wire [15:0] ram1res_o;

	// Bidirs
	wire [15:0] Ram1Data_io;

	// Instantiate the Unit Under Test (UUT)
	ram1 uut (
		.data_ready_i(data_ready_i), 
		.tbre_i(tbre_i), 
		.tsre_i(tsre_i), 
		.wrn_o(wrn_o), 
		.rdn_o(rdn_o), 
		.Ram1Addr_o(Ram1Addr_o), 
		.Ram1Data_io(Ram1Data_io), 
		.Ram1OE_o(Ram1OE_o), 
		.Ram1WE_o(Ram1WE_o), 
		.Ram1EN_o(Ram1EN_o), 
		.is_RAM1_i(is_RAM1_i), 
		.is_UART_i(is_UART_i), 
		.addr_i(addr_i), 
		.data_i(data_i), 
		.isread_i(isread_i), 
		.iswrite_i(iswrite_i), 
		.ram1res_o(ram1res_o), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		data_ready_i = 0;
		tbre_i = 0;
		tsre_i = 0;
		is_RAM1_i = 0;
		is_UART_i = 0;
		addr_i = 0;
		data_i = 0;
		isread_i = 0;
		iswrite_i = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		addr_i = {2'b00,16'hbf01};
		data_i = 16'h0004;
		is_UART_i = 1'b1;
		isread_i = 1'b1;
		#20
		clk = 1'b1;
		#20
		clk = 1'b0;
	end
      
endmodule

