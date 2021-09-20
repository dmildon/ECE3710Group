module FSM (Rst, Clk, RdestOut);
	input Rst, Clk;
	
	output [15:0] RdestOut;
	
	reg [2:0] PS, NS;
	reg [15:0] Imm;
	reg [3:0] RdestRegLoc, RsrcRegLoc, OpCode, i;
	reg en, Imm_s;
	
	wire [4:0] Flags;
	
	parameter S0 = 3'b000,
				 S1 = 3'b001,
				 S2 = 3'b010,
				 S3 = 3'b011,
				 S4 = 3'b100,
				 S5 = 3'b101,
				 S6 = 3'b110;

	parameter ADD  = 4'b0000;

	
	RegFile_Alu myRegAlu(
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Clk(Clk),
		.En(en),
		.Rst(Rst),
		.Imm(Imm),
		.Imm_s(Imm_s),
		.OpCode(OpCode),
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
		
	always@(negedge Rst, negedge Clk) begin
		if(~Rst) begin
			PS = S0;
//			NS = S0;
		end
		else begin
//			PS = NS;
			
			case(PS)
				S0: PS = S6;
				S6: PS = S1;
				S1: PS = S2;
				S2: PS = S3;
				S3: PS = S4;
				S4: PS = S5;
				S5: PS = S2;
				
				default: PS = S1;
			endcase
		end
	end
	
	always@(PS) begin
		case(PS)
			S0: begin
				RdestRegLoc	= 4'b0001;
				Imm_s = 1;
				Imm = 1;
				en = 0;
				OpCode = 4'b0000;
				
				i = 1;
				RsrcRegLoc = 4'b0;
			end
			S6: begin 
				en = 1;
				
				RdestRegLoc	= 	RdestRegLoc;
				RsrcRegLoc = RsrcRegLoc;
				Imm_s = Imm_s;
				i = i;
				OpCode = OpCode;
				Imm = Imm;
			end
			
			S1: begin
				en = 0;
				Imm_s = 0;
				i = i;
				
				OpCode = OpCode;
				RdestRegLoc	= 	RdestRegLoc;
				RsrcRegLoc = RsrcRegLoc;
				Imm = Imm;
			end
			S2: begin
				RsrcRegLoc = i;
				RdestRegLoc	= i - 1;
				en = 1;
				
				Imm_s = Imm_s;
				i = i;
				OpCode = OpCode;
				Imm = Imm;
			end
			S3: begin
				en = 0;
				
				RdestRegLoc	= 	RdestRegLoc;
				RsrcRegLoc = RsrcRegLoc;
				Imm_s = Imm_s;
				i = i;
				OpCode = OpCode;
				Imm = Imm;
			end
			S4: begin
				RdestRegLoc	= i + 1;
				RsrcRegLoc = i - 1;
				en = 1;
				
				Imm_s = Imm_s;
				i = i;
				OpCode = OpCode;
				Imm = Imm;
			end
			S5: begin
				en = 0;
				i = i + 1;
				
				RdestRegLoc	= 	RdestRegLoc;
				RsrcRegLoc = RsrcRegLoc;
				Imm_s = Imm_s;
				OpCode = OpCode;
				Imm = Imm;
			end
			endcase
	end
endmodule
