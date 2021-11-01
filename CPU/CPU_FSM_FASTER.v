module CPU_FSM_FASTER
	(  
		input Clk,
		input [15:0] Instr,
		input [4:0] ALUFlags,
		output reg Imm_s, RegEn, RAMEn, PCEn, Signed, RamAddrSelect, 
		output reg [1:0] LoadInSelect, PCState,
		output reg [3:0] ALUOpCode, RdestRegLoc, RsrcRegLoc,
		output reg [7:0] Imm
	);
	
	
	parameter ADD 		= 4'b0000;
	parameter SUB 		= 4'b0001;
	parameter CMP 		= 4'b0010;
	parameter AND 		= 4'b0011;
	parameter OR 		= 4'b0100;
	parameter XOR 		= 4'b0101;
	parameter NOT 		= 4'b0110;
	parameter LSH 		= 4'b0111;
	parameter RSH 		= 4'b1000;
	parameter ARSH 		= 4'b1001;
	parameter MUL     	= 4'b1010;
	
	parameter [3:0]
					S0  = 4'b0000,
					StateLoad  = 4'b0001,
					StateStore  = 4'b0010,
					StateScond  = 4'b0011,
					S4  = 4'b0100,
					S5  = 4'b0101,
					S6  = 4'b0110,
					S7  = 4'b0111,
					S8  = 4'b1000,
					S9  = 4'b1001,
					S10 = 4'b1010,
					S11 = 4'b1011,
					S12 = 4'b1100,
					S13 = 4'b1101,
					SFinal = 4'b1111;
	
	reg [3:0] PS, NS;
	wire [15:0] savedInstr;
	wire [4:0] savedFlags;
	wire CondOut;
	
	Register_FSM savedInstrModule(
		.in(Instr),
		.clk(Clk),
		.en(PS == S0),
		.out(savedInstr)
	);
	
	Register_FSM #(.width(5)) FLAGS(
		.in(ALUFlags),
		.clk(Clk),
		.en(PS == S0), // if Flags do be fucked
		.out(savedFlags)
	);
	
	ConditionDecoder SomeNameWeNeedToChangeLaterBecauseDawsonIsTooLazyToThinkOfAGoodOne (
		.cond((savedInstr[15:12] == 4'b0100 && savedInstr[7:4] == 4'b1101) ? savedInstr[3:0] : savedInstr[11:8]),
		.savedFlags(savedFlags),
		.out(CondOut)
	);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	always @(negedge Clk) begin //Advance PS on negedge clk
		PS <= NS;
	end
	
	always @(posedge Clk) begin //Select NS based on what PS is on posgedge clk
		case(PS)
			S0: begin
					//if R-type with imm
					if (Instr[15:12] == 4'b0101 || Instr[15:12] == 4'b0110 || Instr[15:12] == 4'b0111 || Instr[15:12] == 4'b1110 || Instr[15:12] == 4'b1001 || Instr[15:12] == 4'b1010 || Instr[15:12] == 4'b1011 || Instr[15:12] == 4'b0001 || Instr[15:12] == 4'b0010 || Instr[15:12] == 4'b0011 || (Instr[15:12] == 4'b1000 && Instr[7:5] == 4'b000))
						NS <= SFinal;
					
					//if R-type without imm
					else if ((Instr[15:12] == 4'b0000 && (~(Instr[7:4] == 4'b1101) || ~(Instr[7:4] == 4'b0000))) || (Instr[15:12] == 4'b1000 && Instr[7:4] == 4'b0100))
						NS <= SFinal;
					
					//if Load
					else if (Instr[15:12] == 4'b0100 && Instr[7:4] == 4'b0000)
						NS <= StateLoad;
					
					//if Store
					else if (Instr[15:12] == 4'b0100 && Instr[7:4] == 4'b0100)
						NS <= StateStore;
					
					//if scond
					else if (Instr[15:12] == 4'b0100 && Instr[7:4] == 4'b1101)
						NS <= StateScond;
					
					//if bcond
					else if (Instr[15:12] == 4'b1100)
						NS <= SFinal;
					
					//if jcond
					else if (Instr[15:12] == 4'b0100 && Instr[7:4] == 4'b1100)
						NS <= SFinal;
					
					//else NOP
					else
						NS <= SFinal;
				 end
				 
			SFinal: NS <= S0;
				 
			default: NS <= S0;
		endcase
	end
	
	always @(PS) begin //Do stuff when PS changes
		case(PS)
			S0: begin
			
						PCEn = 0;
						RAMEn = 0;
						RegEn = 1;
						RdestRegLoc = Instr[11:8];
						RamAddrSelect = 0;
						LoadInSelect = 2'b00;
						PCState = 2'b00;
						
					//if R-type with imm
					if (Instr[15:12] == 4'b0101 || Instr[15:12] == 4'b0110 || Instr[15:12] == 4'b0111 || Instr[15:12] == 4'b1110 || Instr[15:12] == 4'b1001 || Instr[15:12] == 4'b1010 || Instr[15:12] == 4'b1011 || Instr[15:12] == 4'b0001 || Instr[15:12] == 4'b0010 || Instr[15:12] == 4'b0011 || (Instr[15:12] == 4'b1000 && Instr[7:5] == 4'b000)) begin
						
						RsrcRegLoc = 4'bx;
						RdestRegLoc = Instr[11:8];
						Imm_s = 1;
						Imm = Instr[7:0];
						
						
						if(Instr[15:12] == 4'b0101 || Instr[15:12] == 4'b0111) begin 
							ALUOpCode = ADD; 
							Signed = 1; 
						end
						
						else if(Instr[15:12] == 4'b0110) begin 
							ALUOpCode = ADD; 
							Signed = 0;
						end
						
						else if(Instr[15:12] == 4'b1110) begin 
							ALUOpCode = MUL; 
							Signed = 1;
						end
						
						else if(Instr[15:12] == 4'b1001 || Instr[15:12] == 4'b1010) begin 
							ALUOpCode = SUB; 
							Signed = 1;
						end
						
						else if(Instr[15:12] == 4'b1011) begin 
							ALUOpCode = CMP; 
							Signed = 1;
						end
						
						else if(Instr[15:12] == 4'b0001) begin 
							ALUOpCode = AND; 
							Signed = 1;
						end
						
						else if(Instr[15:12] == 4'b0010) begin 
							ALUOpCode = OR; 
							Signed = 1;
						end
						
						else begin 
							ALUOpCode = XOR; 
							Signed = 1;
						end
					end
					
					//if R-type without imm
					else if ((Instr[15:12] == 4'b0000 && (~(Instr[7:4] == 4'b1101) || ~(Instr[7:4] == 4'b0000))) || (Instr[15:12] == 4'b1000 && Instr[7:4] == 4'b0100)) begin
						
						Signed = 0;
						RsrcRegLoc = Instr[3:0];
						Imm_s = 0;
						Imm = 8'bx;
						
						if (Instr[7:4] == 4'b0101 || Instr[7:4] == 4'b0110 || Instr[7:4] == 4'b0111)
							ALUOpCode = ADD;
							
						else if (Instr[7:4] == 4'b1110)
							ALUOpCode = MUL;
							
						else if (Instr[7:4] == 4'b1001 || Instr[7:4] == 4'b1010)
							ALUOpCode = SUB;
							
						else if (Instr[7:4] == 4'b1011)
							ALUOpCode = CMP;
						
						else if (Instr[7:4] == 4'b0001)
							ALUOpCode = AND;
						
						else if (Instr[7:4] == 4'b0010)
							ALUOpCode = OR;
						
						else if (Instr[7:4] == 4'b0011)
							ALUOpCode = XOR;
							
						else
							ALUOpCode = LSH;
					end
					//if Load
					
					//if Store
					
					//if Move
					
					//if scond
					
					//if bcond
					
					//if jcond
					
					//else NOP
					else begin
						Signed = 0; 
						RsrcRegLoc = 4'bx;
						ALUOpCode = 4'bx;
						Imm_s = 0;
						Imm = 8'bx;

					end
				 end
				 
				 
				 SFinal: begin
					PCEn = 1;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = 4'bx;
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 0;
					LoadInSelect = 2'b00;
					PCState = 2'b00;
				 end
				 
				 default: begin
					PCEn = 1;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = 4'bx;
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 0;
					LoadInSelect = 2'b00;
					PCState = 2'b00;
				 end
		endcase
	end
endmodule




































module Register_FSM #(parameter width = 16)(in, clk, en, out);
	input [(width-1):0] in;
	input clk, en;
	
	output reg [(width-1):0] out;
	
	always @(posedge clk) begin
		if (en)
			out <= in;
		else
			out <= out;
	end
endmodule 


module ConditionDecoder(cond, savedFlags, out);
	input [3:0] cond;
	input [4:0] savedFlags;
	output out;
	
	assign out = (cond == 4'b0000) ? savedFlags[3] :
					 (cond == 4'b0001) ? ~savedFlags[3] :
					 (cond == 4'b0010) ? savedFlags[0] :
					 (cond == 4'b0011) ? ~savedFlags[0] : 
					 (cond == 4'b0100) ? savedFlags[1] : 
					 (cond == 4'b0101) ? ~savedFlags[1] :
					 (cond == 4'b0110) ? savedFlags[4] :
					 (cond == 4'b0111) ? ~savedFlags[4] :
					 (cond == 4'b1000) ? savedFlags[2] :
					 (cond == 4'b1001) ? ~savedFlags[2] :
					 (cond == 4'b1010) ? ~(savedFlags[1] || savedFlags[3]) :
					 (cond == 4'b1011) ? savedFlags[1] || savedFlags[3] :
					 (cond == 4'b1100) ? ~(savedFlags[4] || savedFlags[3]) :
					 (cond == 4'b1101) ? savedFlags[4] || savedFlags[3] :
					 (cond == 4'b1110) ? 1 : 0;
endmodule










