module FSM_RAM (clk, q_a_out);
	
	input clk;
	output [15:0] q_a_out;
	
	parameter DATA_WIDTH=16;
	parameter ADDR_WIDTH=10;
	reg [(DATA_WIDTH-1):0] data_a, data_b;
	reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg we_a, we_b;
	wire [(DATA_WIDTH-1):0] q_b_out;
	
	reg [2:0] PS, NS;
	
	parameter S0 = 3'b000,
				 S1 = 3'b001,
				 S2 = 3'b010;
	
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
	
	
	always@(negedge clk) begin
		PS <= NS;
	end 
	
	
	always@(posedge clk) begin
		case(NS)
			S0: NS <= S1;
			S1: NS <= S2;
			S2: NS <= S2;
				
			default: NS <= S0;
		endcase
	end
	
	always@(PS) begin
		case(PS)
			S0: begin
				data_a = 0; 
				addr_a = 66; 
				we_a = 0; 
			end
			
			S1: begin
				data_a = q_a_out + 1; 
				addr_a = 66; 
				we_a = 1; 
			end
			
			S2: begin
				data_a = 0; 
				addr_a = 66; 
				we_a = 0; 
			end
			
		endcase
	end

endmodule 