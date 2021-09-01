module ALU (Rsrc, Rdest, OpCode, Out, Flags)
input [15:0] Rsrc, Rdest;
input [4:0];
output reg [15:0] Out;
output reg [4:0] Flags;

parameter ADD 		= 5'b00000
parameter ADDI 	= 5'b00001
parameter ADDU 	= 5'b00010
parameter ADDUI 	= 5'b00011
parameter ADDC 	= 5'b00100
parameter ADDCU 	= 5'b00101
parameter ADDCUI 	= 5'b00110
parameter ADDCI 	= 5'b00111
parameter SUB 		= 5'b01000
parameter SUBI 	= 5'b01001
parameter CMP 		= 5'b01010
parameter CMPI 	= 5'b01011
parameter CMPUI 	= 5'b01100
parameter AND 		= 5'b01101
parameter OR 		= 5'b01110
parameter XOR 		= 5'b01111
parameter NOT 		= 5'b10000
parameter LSH 		= 5'b10001
parameter LSHI 	= 5'b10010
parameter RSH 		= 5'b10011
parameter RSHI 	= 5'b10100
parameter ALSH 	= 5'b10101
parameter ARSH 	= 5'b10110
parameter NOP 		= 5'b10111

case (OpCode)
	ADD:
		begin
			
		end
		
	ADDI:
		begin
			
		end
		
	ADDU:
		begin
			
		end
	
	ADDUI: 
		begin
			
		end
	
	ADDC:
		begin
			
		end
	
	ADDCU:
		begin
			
		end
	
	ADDCUI:
		begin
			
		end
	
	ADDCI:
		begin
			
		end
	
	SUB:
		begin
			
		end
	
	SUBI:
		begin
			
		end
	
	CMP:
		begin
			
		end
	
	CMPI:
		begin
			
		end
	
	CMPUI:
		begin
			
		end
	
	AND:
		begin
			
		end
	
	OR:
		begin
			
		end
	
	XOR:
		begin
			
		end
	
	NOT:
		begin
			
		end
	
	LSH:
		begin
			
		end
	
	LSHI:
		begin
			
		end
	
	RSH:
		begin
			
		end
	
	RSHI:
		begin
			
		end
	
	ALSH:
		begin
			
		end
	
	ARSH:
		begin
			
		end
	
	NOP:
		begin
			
		end
endcase 
endmodule 


module AND (A, B, Out)
input [15:0] A, B;
output reg [15:0] Out;

assign Out = A & B;
endmodule


module OR (A, B, Out)
input [15:0] A, B;
output reg [15:0] Out;

assign Out = A | B;
endmodule 


module XOR (A, B, Out)
input [15:0] A, B;
output reg [15:0] Out;

assign Out = A ^ B;
endmodule 


