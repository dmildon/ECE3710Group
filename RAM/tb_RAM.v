`timescale 1ps/1ps
module tb_RAM ();
	parameter DATA_WIDTH=16;
	parameter ADDR_WIDTH=10;
	reg [(DATA_WIDTH-1):0] data_a, data_b;
	reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg we_a, we_b, clk;
	wire [(DATA_WIDTH-1):0] q_a_out, q_b_out;
	
	RAM uut (
		.data_a(data_a),
		.data_b(data_b),
		.addr_a(addr_a),
		.addr_b(addr_b),
		.we_a(we_a),
		.we_b(we_b),
		.clk(clk),
		.q_a_out(q_a_out),
		.q_b_out(q_b_out)
	);
	
	initial begin
		clk = 0;
		#5; //clk = 1
		addr_a = 13;
		addr_b = 47;
		we_a = 1;
		we_b = 1;
		data_a = 3;
		data_b = 7;
		#5; // clk = 0
		we_a =0;
		we_b = 0;
		#15; // clk = 1
		addr_a = 7;
		addr_b = 718;
		#10;
		addr_a = 42;
		addr_b = 101;
		#10;
		addr_a = 66;
		addr_b = 511;
		#10;
		addr_a = 1023;
		addr_b = 67;
		data_a = 43;
		data_b = 1776;
		we_a = 1;
		we_b = 1;
		#10;
		we_a = 0;
		we_b = 0;
		#10;
		
		
		
		
	end
	always #5 clk = ~clk;
endmodule
