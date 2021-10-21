module CPU_FSM 
	(  
		input Clk,
		input [15:0] Instr,
		input [4:0] ALUFlags,
		output reg Imm_s, RegEn, RAMEn, PCEn, Signed, RamAddrSelect, LoadInSelect,
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
	
	parameter [3:0] S0 = 4'b0000,
					S1 = 4'b0001,
					S2 = 4'b0010,
					S3 = 4'b0011,
					S4 = 4'b0100,
					S5 = 4'b0101,
					S6 = 4'b0110,
					S7 = 4'b0111,
					S8 = 4'b1000,
					S9 = 4'b1001;
	
	reg [3:0] PS, NS;
	wire [15:0] savedInstr;
	
	Register16Bit savedInstrModule(
		.in(Instr),
		.clk(Clk),
		.en(NS == S1),
		.out(savedInstr)
	);
	
	always @(negedge Clk) begin
		PS <= NS;
	end
	
	always @(posedge Clk) begin
		case(PS)
			S0: NS <= S1;
			S1: begin
					if (savedInstr[15:12] == 4'b0) begin
						if (savedInstr[7:4] == 4'b1101 || savedInstr[7:4] == 4'b0 || savedInstr[7:4] == 4'b0100 || 	savedInstr[7:4] == 4'b1000 || savedInstr[7:4] == 4'b1100 || savedInstr[7:4] == 4'b1111) begin
							NS <= S0;
						end
						else begin
							NS <= S2;
						end
					end
					
					else if (savedInstr[15:12] == 4'b0101 || savedInstr[15:12] == 4'b0110 || savedInstr[15:12] == 4'b0111 || savedInstr[15:12] == 4'b1110 || savedInstr[15:12] == 4'b1001 || savedInstr[15:12] == 4'b1010 || savedInstr[15:12] == 4'b1011 || savedInstr[15:12] == 4'b0001 || savedInstr[15:12] == 4'b0010 || savedInstr[15:12] == 4'b0011 || savedInstr[15:12] == 4'b1000) begin
						NS <= S2;
					end
					
					else if(savedInstr[15:12] == 4'b1000 && savedInstr[7:4] == 4'b0100) begin 
						NS <= S2; 
					end 

					else if (savedInstr[15:12] == 4'b0100 && (savedInstr[7:4] == 4'b0000 || savedInstr[7:4] == 4'b0100)) begin
						NS <= S5;
					end
					
					else begin
						NS <= S0;
					end
				 end
			S2: begin
					if (savedInstr[15:12] == 4'b0) begin NS <= S3; end
					else begin NS <= S4; end
				 end
			S3: NS <= S0;
			S4: NS <= S0;
			S5: begin
					if (savedInstr[7:4] == 4'b0000) begin
						NS <= S6;
					end
					else begin
						NS <= S7;
					end
				end
			S6: NS <= S9;
			S9: NS <= S8;
			S7: NS <= S8;
			S8: NS <= S0;

			default: NS <= S0;
			
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
					RamAddrSelect = 0;
					LoadInSelect = 0;
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
					RamAddrSelect = 0;
					LoadInSelect = 0;
				 end
			S2: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = savedInstr[11:8];
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 0;
					LoadInSelect = 0;
				 end
			S3: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 1;
					Signed = 0; 
					RsrcRegLoc = savedInstr[3:0];
					RdestRegLoc = savedInstr[11:8];
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 0;
					LoadInSelect = 0;
					
					if (savedInstr[7:4] == 4'b0101 || savedInstr[7:4] == 4'b0110 || savedInstr[7:4] == 4'b0111)
						ALUOpCode = ADD;
						
					else if (savedInstr[7:4] == 4'b1110)
						ALUOpCode = MUL;
						
					else if (savedInstr[7:4] == 4'b1001 || savedInstr[7:4] == 4'b1010)
						ALUOpCode = SUB;
						
					else if (savedInstr[7:4] == 4'b1011)
						ALUOpCode = CMP;
					
					else if (savedInstr[7:4] == 4'b0001)
						ALUOpCode = AND;
					
					else if (savedInstr[7:4] == 4'b0010)
						ALUOpCode = OR;
						
					else if (savedInstr[7:4] == 4'b0011)
						ALUOpCode = XOR;
						
					else
						ALUOpCode = LSH;				
				 end
			S4: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 1;
					RsrcRegLoc = 4'bx;
					RdestRegLoc = savedInstr[11:8];
					Imm_s = 1;
					Imm = savedInstr[7:0];
					RamAddrSelect = 0;
					LoadInSelect = 0;
					
					if(savedInstr[15:12] == 4'b0101 || savedInstr[15:12] == 4'b0111) begin 
						ALUOpCode = ADD; 
						Signed = 1; 
					end
					
					else if(savedInstr[15:12] == 4'b0110) begin 
						ALUOpCode = ADD; 
						Signed = 0;
					end
					
					else if(savedInstr[15:12] == 4'b1110) begin 
						ALUOpCode = MUL; 
						Signed = 1;
					end
					
					else if(savedInstr[15:12] == 4'b1001 || savedInstr[15:12] == 4'b1010) begin 
						ALUOpCode = SUB; 
						Signed = 1;
					end
					
					else if(savedInstr[15:12] == 4'b1011) begin 
						ALUOpCode = CMP; 
						Signed = 1;
					end
					
					else if(savedInstr[15:12] == 4'b0001) begin 
						ALUOpCode = AND; 
						Signed = 1;
					end
					
					else if(savedInstr[15:12] == 4'b0010) begin 
						ALUOpCode = OR; 
						Signed = 1;
					end
					
					else begin 
						ALUOpCode = XOR; 
						Signed = 1;
					end
					
				 end
			S5: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = savedInstr[3:0];
					RdestRegLoc = savedInstr[11:8];
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 0;
					LoadInSelect = 0;
				 end

			S6: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = savedInstr[3:0];
					RdestRegLoc = savedInstr[11:8];
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 1;
					LoadInSelect = 1;
				end
				
				S9: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 1;
					Signed = 0; 
					RsrcRegLoc = savedInstr[3:0];
					RdestRegLoc = savedInstr[11:8];
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 1;
					LoadInSelect = 1;
					 end
			
			S7: begin
					PCEn = 0;
					RAMEn = 1;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = savedInstr[3:0];
					RdestRegLoc = savedInstr[11:8];
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 1;
					LoadInSelect = 0;
				end
			
			S8: begin
					PCEn = 0;
					RAMEn = 0;
					RegEn = 0;
					Signed = 0; 
					RsrcRegLoc = 4'bx;
					RdestRegLoc = 4'bx;
					ALUOpCode = 4'bx;
					Imm_s = 0;
					Imm = 8'bx;
					RamAddrSelect = 0;
					LoadInSelect = 0;
				 end
		endcase
	end
endmodule


module Register16Bit(in, clk, en, out);
	input [15:0] in;
	input clk, en;
	
	output reg [15:0] out;
	
	always @(negedge clk) begin
		if (en)
			out <= in;
		else
			out <= out;
	end
endmodule 













