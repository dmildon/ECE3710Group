`timescale 1ps/1ps
module tb_CPU_FSM ();
	reg Clk;
	reg [15:0] Instr;
	reg [4:0] ALUFlags;
	wire Imm_s, RegEn, RAMEn, PCEn, Signed, RamAddrSelect, LoadInSelect; //eventually we will need to have RAMEn for load/store
	wire [3:0] ALUOpCode, RdestRegLoc, RsrcRegLoc;
	wire [7:0] Imm;
	
	CPU_FSM uut (
		.Clk(Clk),
		.Instr(Instr),
		.ALUFlags(ALUFlags),
		.Imm_s(Imm_s),
		.RegEn(RegEn),
		.RAMEn(RAMEn),
		.PCEn(PCEn),
		.Signed(Signed),
		.RamAddrSelect(RamAddrSelect),
		.LoadInSelect(LoadInSelect),
		.ALUOpCode(ALUOpCode),
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Imm(Imm)
	);
	
	initial begin
		Clk = 0;
		#5;
	end
	
	always #5 Clk = ~Clk;
	
endmodule
