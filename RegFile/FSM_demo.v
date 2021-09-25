module FSM_demo (Rst, Clk, RdestOut);
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
			NS <= S0;
		end
		else begin
			PS <= NS;
			case(NS)
				S0: NS <= S1;
				S1: NS <= S2;
				S2: NS <= S3;
				S3: NS <= S3;
				
				default: NS <= S0;
			endcase
		end
	end
	
	always@(PS) begin
		case(PS)
			S0: begin
				RdestRegLoc	= 4'b0000;
				Imm_s = 1;
				Imm = 1;
				en = 1;
				OpCode = 4'b0000;
				RsrcRegLoc = 4'b0;
			end
			
			S1: begin
				RdestRegLoc	= 4'b0001;
				Imm_s = Imm_s;
				Imm = 2;
				en = en;
				OpCode = OpCode;
				RsrcRegLoc = RsrcRegLoc;
			end
			
			S2: begin
				RdestRegLoc	= RdestRegLoc;
				Imm_s = 0;
				Imm = Imm;
				en = en;
				OpCode = OpCode;
				RsrcRegLoc = RsrcRegLoc;
			end
			
			S3: begin
				RdestRegLoc	= RdestRegLoc;
				Imm_s = Imm_s;
				Imm = Imm;
				en = 0;
				OpCode = OpCode;
				RsrcRegLoc = RsrcRegLoc;
			end
		endcase
	end

endmodule 