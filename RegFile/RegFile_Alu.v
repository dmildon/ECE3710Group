module RegFile_Alu (RdestRegLoc, RsrcRegLoc, Clk, En, Rst, Imm,Imm_s, OpCode, TriBuffOut, Flags);

	input [3:0] RdestRegLoc, RsrcRegLoc;
	input Clk, En, Rst, Imm_s; //Imm_s is 1 when we want to use the Imm value, else its 0 if we want to use RegSrc
	input [15:0] Imm; //the 16 bit immediate value
	
	inout [15:0] TriBuffOut; //feeds in to Reg load and is outputed from the ALU
	
	input [4:0] OpCode;
	output [4:0] Flags;
	
	wire [15:0] RdestOut, RsrcOut, AluOutput;
	reg [15:0] RsrcAlu;
	
	RegFile myReg(
		.RdestRegLoc(RdestRegLoc), 
		.RsrcRegLoc(RsrcRegLoc), 
		.Clk(clk), 
		.En(En), 
		.Rst(Rst), 
		.Load(TriBuffOut), 
		.RdestOut(RdestOut), 
		.RsrcOut(RscrcOut)
	);
	
	ALU myALU(
		.Rsrc(RsrcAlu), 
		.Rdest(RdestOut), 
		.OpCode(OpCode), 
		.Flags(Flags), 
		.Out(AluOutput)
	); 
	
	TriStateBuff myBuff (
		.in(AluOutput),
		.en(Clk),
		.out(TriBuffOut)
	);
	
	always @(Imm_s) begin
		if (~Imm_s)
			RsrcAlu <= RsrcOut;
		
		else begin
			RsrcAlu <= Imm;
		end
	end
	
endmodule 


module TriStateBuff (in, en, out);

	input [15:0] in;
	input en;
   output reg [15:0] out;

	always @(*) begin
		out <= (en ? in : 'bz);
	end

endmodule 
