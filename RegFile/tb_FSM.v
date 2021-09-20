`timescale 1ps/1ps

module tb_FSM ();
	
	reg Rst, Clk;
	
	wire [15:0] RdestOut;
	
	FSM uut(
	.Rst(Rst),
	.Clk(Clk), 
	.RdestOut(RdestOut)
	);
	
	initial begin
		Rst = 1;
		Clk = 0;
		#10;
		
		Rst = 0;
		#23;
		
		Rst = 1;
		
		
	end
	always	 #5 Clk = ~Clk;
endmodule
