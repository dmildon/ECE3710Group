`timescale 1ps/1ps

module tb_FSM_Reg_Alu();
	
	reg Rst, Clk;
	
	wire [6:0] o1,o2,o3,o4;
	
	FSM_Reg_Alu myThing (
	.rst(Rst), 
	.btn_clk(Clk), 
	.out1(o1),
	.out2(o2), 
	.out3(o3), 
	.out4(o4)
	);
	
	initial begin
		Rst = 1;
		Clk = 0;
		#10;
		
		Rst = 0;
		#23;
		
		Rst = 1;
		
		
	end
	always	 #50000000 Clk = ~Clk;
endmodule
