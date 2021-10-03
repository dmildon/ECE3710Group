`timescale 1ps/1ps
module tb_RAM_block ();
	parameter DATA_WIDTH=16;
	parameter ADDR_WIDTH=9;
	reg [(DATA_WIDTH-1):0] data_a, data_b;
	reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg we_a, we_b, clk;
	wire [(DATA_WIDTH-1):0] q_a, q_b;
	
	RAM_block_file uut (
		.data_a(data_a),
		.data_b(data_b),
		.addr_a(addr_a),
		.addr_b(addr_b),
		.we_a(we_a),
		.we_b(we_b),
		.clk(clk),
		.q_a(q_a),
		.q_b(q_b)
	);
	
	initial begin
		clk = 0;
		#5;
		addr_a = 0;
		addr_b = 1;
		we_a = 1;
		we_b = 1;
		data_a =66;
		data_b = 77;
		#5;
		we_a =0;
		we_b = 0;
		#5;
		addr_a = 2;
		addr_b = 3;
		#5;
		addr_a = 4;
		addr_b = 5;
		#5;
		addr_a = 6;
		addr_b = 511;
		
		
		
	end
	always #5 clk = ~clk;
endmodule
