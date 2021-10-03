`timescale 1ps/1ps
module tb_CPU ();
	reg Clk, Rst;
	
	CPU uut (
		.Clk(Clk),
		.Rst(Rst)
	);
	
	initial begin
		Clk = 0;
		Rst = 1;
		#5;
		Rst = 0;
		#5;
		Rst = 1;
		#5;
		
	end
	always #5 Clk = ~Clk;
endmodule