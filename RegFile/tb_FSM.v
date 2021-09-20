`timescale 1ps/1ps

module tb_FSM ();
	
	reg [15:0] Instr;
	reg Rst, Clk;
	
	wire [15:0] RdestOut;
	wire [2:0] NS;
	
	FSM uut(
		.Instr(Instr),
		.Rst(Rst),
		.Clk(Clk),
		.RdestOut(RdestOut),
		.NS(NS)
	);
	
	initial begin
		Clk = 0;
		Instr = 16'b0100000011110000;
		#100;
		
		Instr = 16'b0101000000000001; 
		#100; 
		
	end
	always	 #5 Clk = ~Clk;
endmodule
