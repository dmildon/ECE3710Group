`timescale 1ps/1ps 
module tb_sign_extender(); 


	reg signed [7:0] in;
	reg s;
	wire [15:0] out;


	integer i, j;

sign_extender	uut(
	.In(in),
	.S(s), 
	.Out(out)
	);

initial 
	begin

		$display("Starting Testbench");
		//testing signed things
		in = 8'b11111111;
		s = 1;
		#5;
		
		in = 8'b00001111;
		s = 1;
		#5;
		
		in = 8'b11111111;
		s = 0;
		#5;
		
		in = 8'b00001111;
		s = 0;
		#5;
		
	end
endmodule
