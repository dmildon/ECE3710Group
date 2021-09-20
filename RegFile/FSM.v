module FSM (Instr, Rst, Clk, RdestOut, NS);
	input [15:0] Instr;
	input Rst, Clk;
	
	output [15:0] RdestOut;
	
	reg [2:0] PS;
	output reg [2:0] NS;
	
	reg [15:0] Imm;
	wire [4:0] Flags;
	reg [3:0] RdestRegLoc, RsrcRegLoc, ALUOpCode;
	reg rst, en, Imm_s;
	
	parameter S0 = 3'b000,
				 S1 = 3'b001,
				 S2 = 3'b010,
				 S3 = 3'b011,
				 S4 = 3'b100,
				 S5 = 3'b101,
				 S6 = 3'b110;
				 
	parameter ADD 		= 4'b0000;
	parameter SUB 		= 4'b0001;
	parameter CMP 		= 4'b0010;
	parameter AND 		= 4'b0011;
	parameter OR 		= 4'b0100;
	parameter XOR 		= 4'b0101;
	parameter NOT 		= 4'b0110;
	parameter LSH 		= 4'b0111;
	parameter RSH 		= 4'b1000;
	parameter ARSH 	= 4'b1001;
	parameter NOP	 	= 4'b1111;
	
	RegFile_Alu myRegAlu(
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Clk(RsrcRegLoc),
		.En(en),
		.Rst(rst),
		.Imm(Imm),
		.Imm_s(Imm_s),
		.OpCode(ALUOpCode),
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
		
	always @(negedge Rst, negedge Clk) begin
		if (~Rst) 
			PS <= S0;
		else 
			PS <= NS;
		
	end
	
	always @(negedge Clk) begin
		case (PS)
			S0: NS = S1;
			S1: 
				begin
					if (Instr[15:12] == 4'b0 || Instr[15:12] == 4'b1000)
						NS = S2;
					else if (Instr == 16'b0100000011110000)
						NS = S1;
					else
						NS = S3;
				end
			S2: NS = S4;
			S3: NS = S4;
			S4: NS = S5;
			S5: NS = S6;
			S6: NS = S1;
			default: NS = S0;
		endcase
	end
	
	always @(PS) begin
		case (PS)
			S0:
				begin
					rst = 0;
					RdestRegLoc = 0;
					RsrcRegLoc = 0;
					Imm = 0;
					en = 0;
				end
			S1: 
				begin
					rst = 1;
					RdestRegLoc = Instr[11:8];
				end
			S2: 
				begin
					RsrcRegLoc = Instr[3:0];
					Imm_s = 0;
					if (Instr[15:12] == 4'b1000)
						ALUOpCode = LSH;
					
					else begin
						case (Instr[7:4])
							0101: ALUOpCode = ADD;
							1001: ALUOpCode = SUB;
							1011:	ALUOpCode = CMP;
							0001: ALUOpCode = AND;
							0010:	ALUOpCode = OR;
							0011:	ALUOpCode = XOR;
							default: ALUOpCode = NOP;
						endcase
					end
				end
			S3: 
				begin
					Imm_s = 1;
					Imm = {Instr[7:0], 8'b0};
					case (Instr[15:12])
						0101: ALUOpCode = ADD;
						1001: ALUOpCode = SUB;
						1011: ALUOpCode = CMP;
						0001:	ALUOpCode = AND;
						0010: ALUOpCode = OR;
						0011: ALUOpCode = XOR;
					endcase
				end
			S4: //wait for ALU propagation
			S5: 
				begin
					en = 1;
				end
				
			S6: 
				begin
					en = 0;
				end
		endcase
	end
	
	
	
	
endmodule
