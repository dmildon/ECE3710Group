`timescale 1ps/1ps

module tb_RegFile_Alu ();
	reg [3:0] RdestRegLoc, RsrcRegLoc;
	reg Clk, En, Rst, Imm_s;
	reg [15:0] Imm;
	reg [4:0] OpCode;
	
	wire [15:0] AluOutput, RdestOut; 
	wire [4:0] Flags;
	
//	integer i, j;
	
	RegFile_Alu uut(
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc), 
		.Clk(Clk), 
		.En(En), 
		.Rst(Rst), 
		.Imm(Imm),
		.Imm_s(Imm_s), 
		.OpCode(OpCode), 
		.AluOutput(AluOutput), 
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
 
	initial begin
		
		$display("Starting integrated testbench");
		
		$display("");
		
		Clk = 0;
		Rst = 1;
		En = 0;
		#5;
		Rst = 0;
		#5;
		Rst = 1;
		RdestRegLoc = 4'b0000;
		#5;
		$display("Rdest = %d", RdestOut);
		#5;
		
		OpCode = 4'b0000;
		Imm_s = 1;
		Imm = 5;
		
		
		
		En =  1;
		
		#5;
		$display("Rdest = %d", RdestOut);
		En = 0;
		#5;
		
		$display("Rdest = %d", RdestOut);
	end
	
	always #5 Clk = ~Clk;
endmodule
