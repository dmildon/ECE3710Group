// Quartus Prime Verilog Template
// True Dual Port RAM with single clock

module RAM_block_file
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=9)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	input [15:0] string_num,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);
	//integer i = string_num;

	// Declare the RAM variable
	//reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	(* ram_init_file = "instructions.mif" *) reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	
	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] = data_a;
			q_a = data_a;
		end
		else 
		begin
			q_a = ram[addr_a];
		end 
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] = data_b;
			q_b = data_b;
		end
		else 
		begin
			q_b = ram[addr_b];
		end 
	end

endmodule
