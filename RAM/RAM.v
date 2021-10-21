module RAM 
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] q_a_out, q_b_out
);
	wire [(DATA_WIDTH-1):0] q_a [1:0], q_b [1:0];
	RAM_block #(.FILENAME("C:/Users/Alex/OneDrive/Documents/Projects/BikeSensor (MurryClan)/ECE3710Group/RAM/RamInit000.txt")) RAM0 (
		.data_a(data_a),
		.data_b(data_b),
		.addr_a(addr_a[ADDR_WIDTH-2:0]),
		.addr_b(addr_b[ADDR_WIDTH-2:0]),
		.we_a(we_a),
		.we_b(we_b),
		.clk(clk),
		.q_a(q_a[0]),
		.q_b(q_b[0])
	);

	/*RAM_block #(.FILENAME("C:/Users/Alex/OneDrive/Documents/Projects/BikeSensor (MurryClan)/ECE3710Group/RAM/RamInit001.txt")) RAM1 (
		.data_a(data_a),
		.data_b(data_b),
		.addr_a(addr_a[ADDR_WIDTH-2:0]),
		.addr_b(addr_b[ADDR_WIDTH-2:0]),
		.we_a(we_a),
		.we_b(we_b),
		.clk(clk),
		.q_a(q_a[1]),
		.q_b(q_b[1])
	);*/
	
	always @(*) begin
		if (addr_a[9] == 0)
			q_a_out = q_a[0];
		else
			q_a_out = q_a[1];
		
		
		/*if (addr_b[9] == 0)
			q_b_out = q_b[0];
		else
			q_b_out = q_b[1];
			*/
	end
endmodule
