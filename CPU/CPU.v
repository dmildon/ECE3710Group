module CPU 
	(
		input Clk, Rst, key_data, key_clk,
		output [7:0] KeyCodeReg,
		output [7:0] red, green, blue,
		output hsync, vsync,
		output blankN, vgaClk
	);
	
	wire [3:0] RdestRegLoc, RsrcRegLoc, ALUOpCode;
	wire RegEn, Imm_s, Signed, RAMEn, PCEn, RamAddrSelect; 
	wire [1:0] LoadInSelect, PCState;
	wire [15:0] SignedImm, RamOutA, RamOutB, RsrcOut, AluOutput;
	wire [15:0] RdestOut,AluSrcIn, Load;
	wire [4:0] Flags;
	wire [7:0] Imm, KeyCode;
	wire [15:0] PCOut;
	wire [9:0] RamAddrA;
	
//	integer i;
	
	CPU_MUX imm_Mux (
		.in00(SignedImm),
		.in01(RsrcOut),
		.selector(Imm_s),
		.out(AluSrcIn)
	);
	
	CPU_3bit_MUX Alu_Mux (
		.in00(AluOutput),
		.in01(RamOutA),
		.in02(SignedImm),
		.in03({8'b0,KeyCode}),
		.in04(RsrcOut),
		.selector(LoadInSelect),
		.out(Load)
	);
	
	CPU_MUX Ram_Mux (
		.in00(RsrcOut),
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
		.RsrcOut(RsrcOut),
		.KeyCode(KeyCodeReg)
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
		.addr_a(RamAddrA[9:0]),
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
		.PCState(PCState),
		.ALUOpCode(ALUOpCode),
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Imm(Imm)
	);
	
	Program_Counter PC(
		.clk(Clk),
		.rst(Rst),
		.pc_en(PCEn),
		.sel(PCState),
		.imm(SignedImm),
		.mem_addr(RsrcOut),
		.cnt(PCOut)
	);
	
	sign_extender mySignExtender (
		.In(Imm),
		.S(Signed),
		.Out(SignedImm)
	);
	
	keyboard KEYS(
		.clk_kb(key_clk),
		.data_kb(key_data),
		.out_reg(KeyCode)
	);
	
	VGA myVGA (
		.clk(Clk),
		.in1({5'b0,RdestOut[9:0]}),
		.in2(RsrcOut), 	//first 10 bits of in1 are x coord [9:0]
								//first 10 bits of in2 are y coord [9:0]
								//10th bit of in2 is dead or alive [10] 0 is ship is not dead
								//11th bit of in2 is win or not [11] 0 is game is not won
								//12th bit of in2 is has game started? [12] 1 is game not yet started
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync),
		.blankN(blankN),
		.vgaClk(vgaClk)
	);
	
//	initial begin
//		i = 0;
//	end
	
//	always @(posedge Clk) begin
//		i = i + 1;
//	end
	
endmodule

module CPU_MUX #(parameter Data_width = 16) (in00, in01, selector, out);
	input selector;
	input [(Data_width - 1):0] in00, in01;
	
	
	output [(Data_width - 1):0] out;
	
	assign out = selector ? in00 : in01;
endmodule

//update later? all one mux?
module CPU_3bit_MUX (in00, in01, in02, in03, in04, selector, out);
	input [2:0] selector;
	input [15:0] in00, in01, in02, in03, in04;
	
	
	output [15:0] out;
	
	assign out = (selector == 2'b000) ? in00 :
					 (selector == 2'b001) ? in01 :
					 (selector == 2'b010) ? in02 :
					 (selector == 2'b011) ? in03 : in04;
endmodule







