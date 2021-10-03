module CPU 
	(
		input Clk, Rst
	);
	
	wire [3:0] RdestRegLoc, RsrcRegLoc, ALUOpCode;
	wire RegEn, Imm_s, Signed, RAMEn, PCEn;
	wire [15:0] RdestOut, SignedImm, RamOutA, RamOutB;
	wire [4:0] Flags;
	wire [7:0] Imm;
	wire [9:0] RamAddrA;

	
	RegFile_Alu myRegFile_ALU (
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Clk(Clk),
		.En(RegEn),
		.Rst(Rst),
		.Imm(SignedImm),
		.Imm_s(Imm_s),
		.OpCode(ALUOpCode),
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
	
	RAM myRAM (
		.data_a(16'bx),
		.data_b(16'bx),
		.addr_a(RamAddrA),
		.addr_b(10'bx),
		.we_a(RAMEn),
		.we_b(1'bx),
		.clk(Clk),
		.q_a_out(RamOutA),
		.q_b_out(RamOutB)
	);
	
	CPU_FSM myFSM(
		.Clk(Clk),
		.Instr(RamOutA),
		.ALUFlags(Flags),
		.Imm_s(Imm_s),
		.RegEn(RegEn),
		.RAMEn(RAMEn),
		.PCEn(PCEn),
		.Signed(Signed),
		.ALUOpCode(ALUOpCode),
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Imm(Imm)
	);
	
	Program_Counter PCLaptops_We_Love_You(
		.clk(Clk),
		.pc_en(PCEn),
		.cnt(RamAddrA)
	);
	
	sign_extender mySignExtender (
		.In(Imm),
		.S(Signed),
		.Out(SignedImm)
	);
	
	
	
endmodule
