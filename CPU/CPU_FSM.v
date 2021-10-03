module CPU_FSM 
	(  input Clk,
		input [15:0] Instr,
		input [4:0] ALUFlags,
		output reg Imm_s, RegEn, RAMEn, PCEn, Signed, //eventually we will need to have RAMEn for load/store
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
	parameter ARSH 	= 4'b1001;
	parameter MUL     = 4'b1010;
	
	parameter [2:0] S0 = 3'b000,
						 S1 = 3'b001,
						 S2 = 3'b010,
						 S3 = 3'b011,
						 S4 = 3'b100;
	reg [2:0] PS, NS;
	always @(posedge Clk) begin
		PS <= NS;
	end
	
	always @(negedge Clk) begin
		case(PS)
			S0: NS <= S1;
			S1: begin
					if (Instr[15:12] == 4'b0) begin
						if (Instr[7:4] == 4'b1101 || Instr[7:4] == 4'b0 || Instr[7:4] == 4'b0100 || 	Instr[7:4] == 4'b1000 || Instr[7:4] == 4'b1100 || Instr[7:4] == 4'b1111) begin
							NS <= S0;
						end
						else begin
							NS <= S2;
						end
					end
					
					else if (Instr[15:12] == 4'b0101 || Instr[15:12] == 4'b0110 || Instr[15:12] == 4'b0111 || Instr[15:12] == 4'b1110 || Instr[15:12] == 4'b1001 || Instr[15:12] == 4'b1010 || Instr[15:12] == 4'b1011 || Instr[15:12] == 4'b0001 || Instr[15:12] == 4'b0010 || Instr[15:12] == 4'b0011 || Instr[15:12] == 4'b1000) begin
						NS <= S2;
					end
					
					else if(Instr[15:12] == 4'b1000 && Instr[7:4] == 4'b0100) begin 
						NS <= S2; 
					end 
					
					else begin
						NS <= S0;
					end
				 end
			S2: begin
					if (Instr[15:12] == 4'b0) begin NS <= S3; end
					else begin NS <= S4; end
				 end
			S3: NS <= S0;
			S4: NS <= S0;
			
		endcase
	end
	
	always @(PS) begin
		case(PS)
			S0: begin
					PCEn = 1;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = 4'bx;
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
				 end
			S1: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = 4'bx;
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
				 end
			S2: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = Instr[11:8];
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
				 end
			S3: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 1;
					Signed = 0; 
					RsrcRegLoc = Instr[3:0];
					RdestRegLoc = Instr[11:8];
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
			S4: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 1;
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
		endcase
	end
	
endmodule
