module FSM (Rst, Clk, RdestOut);
	input Rst, Clk;
	
	output [15:0] RdestOut;
	
	reg [2:0] PS, NS;
	reg [15:0] Imm;
	reg [3:0] RdestRegLoc, RsrcRegLoc, ALUOpCode, i;
	reg en, Imm_s;
	
	wire [4:0] Flags;
	
	parameter S0 = 3'b000,
				 S1 = 3'b001,
				 S2 = 3'b010,
				 S3 = 3'b011,
				 S4 = 3'b100,
				 S5 = 3'b101;

	parameter ADD  = 4'b0000;

	
	RegFile_Alu myRegAlu(
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc),
		.Clk(RsrcRegLoc),
		.En(en),
		.Rst(Rst),
		.Imm(Imm),
		.Imm_s(Imm_s),
		.OpCode(ALUOpCode),
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
		
	always@(negedge Rst, negedge Clk) begin
		if(~Rst)
			PS <= S0;
		else
			PS <= NS;
	end
	
	always@(negedge Clk) begin
		case(PS)
			S0: NS = S1;
			S1: NS = S2;
			S2: NS = S3;
			S3: NS = S4;
			S4: NS = S5;
			S5: NS = S2;
			default: NS = S0;
			endcase
	end
	
	always@(PS) begin
		case(PS)
			S0: begin
				RdestRegLoc = 4'b0001;
				Imm_s = 1;
				Imm = 1;
				en = 1;
			end
			S1: begin
				en = 0;
				Imm_s = 0;
				i = 1;
			end
			S2: begin
				RsrcRegLoc = i;
				RdestRegLoc = i - 1;
				en = 1;
			end
			S3: begin
				en = 0;
			end
			S4: begin
				RdestRegLoc = i + 1;
				RsrcRegLoc = i - 1;
				en = 1;
			end
			S5: begin
				en = 0;
				i = i + 1;
			end
			endcase
	end
endmodule
