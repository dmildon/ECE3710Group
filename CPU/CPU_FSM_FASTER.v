module CPU_FSM 
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
					S1  = 4'b0001,
					S2  = 4'b0010,
					S3  = 4'b0011,
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
					SEnd = 4'b1111;
	
	reg [3:0] PS, NS;
	wire [15:0] savedInstr;
	wire [4:0] savedFlags;
	wire CondOut;
	
	Register_FSM savedInstrModule(
		.in(Instr),
		.clk(Clk),
		.en(PS == S1),
		.out(savedInstr)
	);
	
	Register_FSM FLAGS(
		.in(ALUFlags),
		.clk(Clk),
		.en(PS == S3 || PS == S4), // if Flags do be fucked
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
					
					NS <= StateRtypeImm;
					
					//if R-type without imm
					NS <= StateRtypeNoImm;
					
					//if Load
					NS <= StateLoad;
					
					//if Store
					NS <= StateStore;
					
					//if scond
					NS <= StateScond;
					
					//if bcond
					NS <= StateBcond;
					
					//if jcond
					NS <= StateJcond;
					
					//else NOP
					NS <= SFinal;
				 end
		endcase
	end
	
	always @(PS) begin //Do stuff when PS changes
		case(PS)
			S0: begin
					//if R-type with imm
					
					//if R-type without imm
					
					//if Load
					
					//if Store
					
					//if Move
					
					//if scond
					
					//if bcond
					
					//if jcond
					
					//else NOP
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










