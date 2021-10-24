module CPU 
	(
		input Clk, Rst,
		output [15:0] RdestOut
	);
	
	wire [3:0] RdestRegLoc, RsrcRegLoc, ALUOpCode;
	wire RegEn, Imm_s, Signed, RAMEn, PCEn, RamAddrSelect, LoadInSelect;
	wire[15:0] SignedImm, RamOutA, RamOutB, RsrcOut, AluOutput;
	wire [15:0] AluSrcIn, Load;
	wire [4:0] Flags;
	wire [7:0] Imm;
	wire [9:0] PCOut;
	wire [9:0] RamAddrA;
	
	CPU_MUX imm_Mux (
		.in00(SignedImm),
		.in01(RsrcOut),
		.selector(Imm_s),
		.out(AluSrcIn)
	);
	
	CPU_MUX Alu_Mux (
		.in00(RamOutA),
		.in01(AluOutput),
		.selector(LoadInSelect),
		.out(Load)
	);
	
	CPU_MUX #(.Data_width(10)) Ram_Mux (
		.in00(RsrcOut[9:0]),
		.in01(PCOut),
		.selector(RamAddrSelect),
		.out(RamAddrA)
	);
	
	RegFile myReg(
		.RdestRegLoc(RdestRegLoc), 
		.RsrcRegLoc(RsrcRegLoc), 
		.Clk(Clk), 
		.En(RegEn), 
		.Rst(Rst), 
		.Load(Load), 
		.RdestOut(RdestOut), 
		.RsrcOut(RsrcOut)
	);
	
	ALU myALU(
		.Rsrc(AluSrcIn), 
		.Rdest(RdestOut), 
		.OpCode(ALUOpCode), 
		.Flags(Flags), 
		.Out(AluOutput)
	);
	
	RAM myRAM (
		.data_a(RdestOut),
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
		.RamAddrSelect(RamAddrSelect),
		.LoadInSelect(LoadInSelect),
		.ALUOpCode(ALUOpCode),
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Imm(Imm)
	);
	
	Program_Counter PC(
		.clk(Clk),
		.rst(Rst),
		.pc_en(PCEn),
		.cnt(PCOut)
	);
	
	sign_extender mySignExtender (
		.In(Imm),
		.S(Signed),
		.Out(SignedImm)
	);
	
//	always @(*) begin
//		if (~Imm_s)
//			AluSrcIn <= RsrcOut;
//		else 
//			AluSrcIn <= SignedImm;
//		
//		if (LoadInSelect)
//			Load <= RamOutA;
//		else
//			Load <= AluOutput;
//		
//		if (RamAddrSelect)
//			RamAddrA <= RsrcOut[9:0];
//		else
//			RamAddrA <= PCOut;
//	end
	
endmodule

module CPU_MUX #(parameter Data_width = 16) (in00, in01, selector, out);
	input selector;
	input [(Data_width - 1):0] in00, in01;
	
	
	output [(Data_width - 1):0] out;
	
	assign out = selector ? in00 : in01;
endmodule
