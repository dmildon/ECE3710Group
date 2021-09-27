`timescale 1ps/1ps
module tb_RAM ();
	parameter DATA_WIDTH=16;
	parameter ADDR_WIDTH=10;
	reg [(DATA_WIDTH-1):0] data_a, data_b;
	reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg we_a, we_b, clk;
	wire [(DATA_WIDTH-1):0] q_a_out, q_b_out;
	integer i, j, k, l;
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
		addr_b = 1;
		we_b = 1;
		data_b = 1;
		#5; // clk = 0
		we_a = 0;
		we_b = 0;
		#10;
		
		j = 0; k = 1; l = 0;
		for(i = 1; i < 1023; i = i + 2) begin
			addr_a = i;
			addr_b = i + 1;
			data_a = 12;
			data_b = 66;
			we_a = 1;
			we_b = 1;
			#10; // clk = 0
			if (q_a_out != 12 && q_b_out != 66) begin
				$display("Everything failed. Abort now");
				$stop;
			end
			#10;
		end
		
		
	end
	always #5 clk = ~clk;
endmodule
