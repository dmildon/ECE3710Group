module CPU 
	(
		input Clk, Rst
	);
	
	RegFile_Alu myRegFile_ALU (
		.RdestRegLoc(),
		.RsrcRegLoc(),
		.Clk(Clk),
		.En(),
		.Rst(Rst),
		.Imm(),
		.Imm_s(),
		.OpCode(),
		.RdestOut(),
		.Flags()
	);
	
	RAM myRAM (
		.data_a(),
		.data_b(),
		.addr_a(),
		.addr_b(),
		.we_a(),
		.we_b(),
		.clk(Clk),
		.q_a_out(),
		.q_b_out()
	);
	
	CPU_FSM myFSM(
		.Clk(Clk),
		.Instr(),
		.ALUFlags(),
		.Imm_s(),
		.RegEn(),
		.RAMEn(),
		.PCEn(),
		.Signed(),
		.ALUOpCode(),
		.RdestRegLoc(),
		.RsrcRegLoc(),
		.Imm()
	);
	
	Program_Counter PCLaptops_We_Love_You(
		.clk(Clk),
		.pc_en(),
		.cnt()
	);
	
	
	
endmodule
