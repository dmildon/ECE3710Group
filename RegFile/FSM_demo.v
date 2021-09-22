/**
* Code here was edited by Sam Hirsch.
* This file should not be used in future assignments without further editting.
*/

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
	

	always @(negedge Clk)
		PS <= NS;
		
	always@(negedge Rst, posedge Clk) begin
		if(~Rst) begin
			NS <= S4;
		end
		else begin
			case(NS)
				S4: NS <= S0;
				S0: NS <= S1;
//				S5: NS <= S1;
				S1: NS <= S2;
				S2: NS <= S3;
				S3: NS <= S2;
				default: NS <= S4;
			endcase
		end
	end
	
	always@(PS) begin
		case(PS)
			// idle
			S4: begin
				RdestRegLoc	= 4'b0000;
				Imm_s = 1;
				Imm = 1;				
			        en = 0;
				OpCode = 4'b0000;
				RsrcRegLoc = 4'b0;
			end
			// load immediate 1 into R0
			S0: begin
				RdestRegLoc	= 4'b0000;
				Imm_s = 1;
				Imm = 1;
				en = 1;
				OpCode = 4'b0000;
				RsrcRegLoc = 4'b0;
			end
			
//			S5: begin
//				RdestRegLoc	= RdestRegLoc;
//				Imm_s = Imm_s;
//				Imm = 0;
//				en = en;
//				OpCode = OpCode;
//				RsrcRegLoc = RsrcRegLoc;
//			end
			
			// load immediate 1 into R1
			S1: begin
				RdestRegLoc	= 4'b0001;
				Imm_s = 1;
				Imm = 1;
				en = 1;
				OpCode = 4'b0;
				RsrcRegLoc = 4'b0001;
			end
			
			
			S2: begin
				RdestRegLoc	= 4'b0000;
				Imm_s = 0;
				Imm = 16'bx;
				en = 1;
				OpCode = 4'b0;
				RsrcRegLoc = 4'b0001;
			end
			
			S3: begin
				RdestRegLoc	= 4'b0001;
				Imm_s = 0;
				Imm = 16'bx;
				en = 1;
				OpCode = 4'b0;
				RsrcRegLoc = 4'b0000;
			end
			
			default: begin
				RdestRegLoc	= 4'bx;
				Imm_s = 1'bx;
				Imm = 16'bx;
				en = 1'bx;
				OpCode = 4'bx;
				RsrcRegLoc = 4'bx;
			end	
		       endcase
	end

endmodule 
