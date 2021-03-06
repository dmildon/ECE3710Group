`timescale 1ps/1ps

module tb_FSM_RAM ();
	
	reg clk;
	wire [15:0] q_a_out, q_b_out;
	
	FSM_advanced uut(
		.clk(clk), 
		.q_a_out(q_a_out),
		.q_b_out(q_b_out)
	);
	
	initial begin
		
		clk = 0;
		#5; 
				
	end
	always	 #5 clk = ~clk;
endmodule