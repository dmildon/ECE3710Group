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

//-------------------------------------------------------
// Addition and Subtraction module.
// Cin - Carry in --> Use to subtract.
//
// Flags:
// C - Carry bit: Carry/borrow after addition/subtraction.
// L - Low flag: l is 1 when rdest< rsrc  --> programmer check: when both unsigned.
// F - Flag bit: signal expectional situations.
// Z - Z bit: set to 1 if operands are equal.
// N - Neg bit: set to 1 if rdest < rsrc operand --> programmer check: when both signed.
//-------------------------------------------------------
module add_sub (rdest, rsrc, Cin, C, L, F, Z, N, out)
	input wire [15:0] rdest, rsc;
	input wire Cin;
	output wire [15:0] out;
	output wire C, L, F, Z, N;
	
	always@(rsrc, rdest, Cin)begin
		// Subtraction 
		if(Cin)
			{C, out} = rdest + ~rsrc + Cin;
		// Addition
		else
			{C, out} = rsrc + rdest;
			
		if(out == 0)
			Z = 1;
			
		if(rdest < rsrc)
			L = 1;
		
		if(rdest < rsrc)
			N = 1;
		
		if((rsrc[15] == 1 & rdest[15] == 1 & out[15] == 0) || 
		(rsrc[15] == 0 & rdest[15] == 0 & out[15] == 1))
			F = 1;
	end
	
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


//Arithmetic shift
//input 16-bit inValue, 1 bit shift Dir
//shiftDir = 0 is left, shiftDir = 1 is right
module shift(inValue, outValue, shiftDir);
	
	input [15:0] inValue;
	input shiftDir;
	
	output [15:0] outValue;
	
	//shift Left
	if(shiftDir == 0) begin
		outValue[15:1] = inValue[14:0];
		outValue[0] = 1;
	end
	
	//shirft R
	else begin
		outValue[14:0] = inValue [15:1];
		if (inValue[15] == 1) begin
			outValue[15] = 1;
		end
		
		else begin
			outValue[15] = 0;
		end
	end
	

endmodule




//a is src input
//b is dest input
//s is signed bit 0 = unsigned
//L is output, 1 when a < b
//Z is 1 if a = b
module compare(A,B,S,L,Z) begin
	
	input [15:0] A, B;
	input wire S;
	
	output reg L,Z;
	
	//unsigned
	if (S==0) begin
		if(A > B) begin
			L = 0;
			Z = 0;
		end
			
		else if(A == B) begin
			L = 0;
			Z = 1;
		end
			
		else begin
			L = 1;
			z = 0;
	end
		
	//sined //(c==1)
	else begin	
		//same sign
		if(A[15] == B[15]) begin
			//check if A is greater
			if(A[14:0] > B[14:0]) begin
				L = 0;
				Z = 0;
			end
				
			else if(A[14:0] < B[14:0]) begin
				L = 1;
				Z = 0;
			end
				
				//otherwise B and A are equal
			else begin
				L = 0;
				Z = 1
			end
				
		end
			
			// B is negative therfore less than A 
		else if(A[15] < B[15]) begin
			L = 1;
			Z = 0;
		end
			
		// A is negative therfore less than B
		else begin
			L = 0;
			Z = 0;
		end
			
	end

endmodule 

