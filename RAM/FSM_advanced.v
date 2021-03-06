module FSM_advanced (clk, q_a_out, q_b_out);
	input clk;
	output [15:0] q_a_out, q_b_out;
	
	parameter DATA_WIDTH=16;
	parameter ADDR_WIDTH=10;
	reg [(DATA_WIDTH-1):0] data_a, data_b;
	reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg we_a, we_b;

	
	reg [2:0] PS, NS;
	
	parameter S0 = 3'b000,
				 S1 = 3'b001,
				 S2 = 3'b010,
				 S3 = 3'b011,
				 S4 = 3'b100;
	
	
	RAM my_RAM (
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
			S2: NS <= S1;
				
			default: NS <= S0;
		endcase
	end
	
	always@(PS) begin
		case(PS)
			S0: begin
				data_a = 0;
				data_b = 1;
				addr_a = 0;
				addr_b = 1;
				we_a = 0;
				we_b = 1;
			end
			
			S1: begin
				data_a = q_a_out + q_b_out;
				data_b = q_a_out + q_b_out;
				addr_a = 0;
				addr_b = 1;
				we_a = 1;
				we_b = 0;
			end
			
			S2: begin
				data_a = q_a_out + q_b_out;
				data_b = q_a_out + q_b_out;
				addr_a = 0;
				addr_b = 1;
				we_a = 0;
				we_b = 1;
			end
			
		endcase
	end
endmodule
