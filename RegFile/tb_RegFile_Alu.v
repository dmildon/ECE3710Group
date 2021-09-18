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
		#10;
		Rst = 0;
		#10;
		Rst = 1;
		RdestRegLoc = 4'b0000;
		#20;
		$display("Rdest = %d", RdestOut); //Should be 0
		$display("AluOutput = %d", AluOutput); //Should be x
		#10;
		OpCode = 4'b0000; //ADD
		Imm_s = 1;
		Imm = 5;
		En =  1;
		#10;
//		Clk = 1;
		#10;
		$display("Rdest = %d", RdestOut); // Should be 5
		$display("AluOutput = %d", AluOutput); // Should be 5
		#10;
		Clk = 0;
		#10;
		Clk = 1;
		$display("Rdest = %d", RdestOut); //Should be 5
		$display("AluOutput = %d", AluOutput); //Should be 10
		#10;
		Clk = 0;
		En = 0;
		#10;
	end
endmodule
