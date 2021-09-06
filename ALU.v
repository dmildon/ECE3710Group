module ALU (Rsrc, Rdest, OpCode, Out, Flags); 
	input [15:0] Rsrc, Rdest;
	input [4:0] OpCode;
	output reg [15:0] Out;
	output reg [4:0] Flags;
		/*
			Flags[0] = C
			Flags[1] = L
			Flags[2] = F
			Flags[3] = Z
			Flags[4] = N
		*/

	parameter ADD 		= 5'b00000;
	parameter ADDI 	= 5'b00001;
	parameter ADDU 	= 5'b00010;
	parameter ADDUI 	= 5'b00011;
	parameter ADDC 	= 5'b00100;
	parameter ADDCU 	= 5'b00101;
	parameter ADDCUI 	= 5'b00110;
	parameter ADDCI 	= 5'b00111;
	parameter SUB 		= 5'b01000;
	parameter SUBI 	= 5'b01001;
	parameter CMP 		= 5'b01010;
	parameter CMPI 	= 5'b01011;
	parameter CMPUI 	= 5'b01100;
	parameter AND 		= 5'b01101;
	parameter OR 		= 5'b01110;
	parameter XOR 		= 5'b01111;
	parameter NOT 		= 5'b10000;
	parameter LSH 		= 5'b10001;
	parameter LSHI 	= 5'b10010;
	parameter RSH 		= 5'b10011;
	parameter RSHI 	= 5'b10100;
	parameter ALSH 	= 5'b10101;
	parameter ARSH 	= 5'b10110;

	always@(OpCode)
		begin
			case(OpCode)
				ADD:
					begin
						add_sub myAdd (
							.rdest(Rdest),
							.rsrc(Rsrc),
							.Cin(0),
							.flags(Flags),
							.out(Out)
						);
					end
				
				SUB:
					begin
						add_sub mySub (
							.rdest(Rdest),
							.rsrc(Rsrc),
							.Cin(1),
							.flags(Flags),
							.out(Out)
						);
					end
				
				CMP:
					begin
						add_sub myCmp (
							.rdest(Rdest),
							.rsrc(Rsrc),
							.Cin(0),
							.flags(Flags),
							.out(Out)
						);
					end
				
				AND:
					begin
						AND myAnd (
							.A(Rsrc),
							.B(Rdest),
							.Out(Out)
						);
					end
				
				OR:
					begin
						OR myOr (
							.A(Rsrc),
							.B(Rdest),
							.Out(Out)
						);
					end
				
				XOR:
					begin
						XOR myXor (
							.A(Rsrc),
							.B(Rdest),
							.Out(Out)
						);
					end
				
				NOT:
					begin
						NOT myNot (
							.A(Rsrc),
							.Out(Out)
						);
					end
				
				LSH:
					begin
						LeftShift myLeftShift (
							.inValue(Rsrc),
							.outValue(Out)
						);
					end
				
				RSH:
					begin
						RightShift myRightShift (
							.inValue(Rsrc),
							.outValue(Out)
						);
					end
				
				ARSH:
					begin
					
					end
				
				default:
					begin
						
					end
			endcase 
		end
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
module add_sub (rdest, rsrc, Cin, flags, out);
	input  [15:0] rdest, rsrc;
	input  Cin;
	output reg [15:0] out;
	output reg [4:0] flags;
	
	always@(rsrc, rdest, Cin) begin
	
		// Subtraction 
		if(Cin)
			{flags[0], out} = rdest + ~rsrc + Cin;
		// Addition
		else
			{flags[0], out} = rsrc + rdest;
			
		if(out == 0)
			flags[3] = 1;
		else
			flags[3] = 0;
			
		if(rdest < rsrc)
			flags[1] = 1;
		else
			flags[1] = 0;
		
		if($signed(rdest) < $signed(rsrc))
			flags[4] = 1;
		else
			flags[4] = 0;
		
		if((rsrc[15] == 1 & rdest[15] == 1 & out[15] == 0) || 
		(rsrc[15] == 0 & rdest[15] == 0 & out[15] == 1))
			flags[2] = 1;
		else
			flags[2] = 0;
	end
	
endmodule

module CMP (rdest, rsrc, flags, out);
	input  [15:0] rdest, rsrc;
	input  Cin = 1;
	output reg [15:0] out;
	output reg [4:0] flags;
	
	always@(rsrc, rdest, Cin) begin
		// Addition
		{flags[0], out} = rsrc + rdest;
			
		if(rdest < rsrc)
			flags[1] = 1;
		else
			flags[1] = 0;
		
		if($signed(rdest) < $signed(rsrc))
			flags[4] = 1;
		else
			flags[4] = 0;
		
		out = 16'bz;
	end
	
endmodule

module AND (A, B, Out); 
	input [15:0] A, B;
	output[15:0] Out;
	
	assign Out = (A & B);
	
endmodule


module OR (A, B, Out);
	input [15:0] A, B;
	output [15:0] Out;

	assign Out = A | B;

	endmodule 


module XOR (A, B, Out);
	input [15:0] A, B;
	output[15:0] Out;

	assign Out = A ^ B;
endmodule

module NOT (A, Out);
	input [15:0] A;
	output[15:0] Out;

	assign Out = !A;
endmodule


//Arithmetic shift
//input 16-bit inValue, 1 bit shift Dir
//shiftDir = 0 is left, shiftDir = 1 is right
//it would probably be easier to just do this opperation in the main module
module LeftShift(inValue, outValue);
	
	input [15:0] inValue;
	
	output reg [15:0] outValue;
	
	always@(inValue)
		begin
			//shift Left
			outValue = inValue <<< 1;
		end

endmodule


module RightShift(inValue, outValue);
	input [15:0] inValue;
	
	output reg [15:0] outValue;
	
	always@(inValue)
		begin
			//shift Right
			outValue = inValue >> 1;
		end
endmodule

module RightShiftA(inValue, outValue);
	input [15:0] inValue;
	
	output reg [15:0] outValue;
	
	always@(inValue)
		begin
			//shift Right
			outValue = inValue >>> 1;
		end
endmodule

//a is src input
//b is dest input
//s is signed bit 0 = unsigned
//L is output, 1 when a < b
//Z is 1 if a = b
//module compare(A,B,S,L,Z) begin
//	
//	input [15:0] A, B;
//	input wire S;
//	
//	output reg L,Z;
//	
//	//unsigned
//	if (S==0) begin
//		if(A > B) begin
//			L = 0;
//			Z = 0;
//		end
//			
//		else if(A == B) begin
//			L = 0;
//			Z = 1;
//		end
//			
//		else begin
//			L = 1;
//			z = 0;
//	end
//		
//	//sined //(c==1)
//	else begin	
//		//same sign
//		if(A[15] == B[15]) begin
//			//check if A is greater
//			if(A[14:0] > B[14:0]) begin
//				L = 0;
//				Z = 0;
//			end
//				
//			else if(A[14:0] < B[14:0]) begin
//				L = 1;
//				Z = 0;
//			end
//				
//				//otherwise B and A are equal
//			else begin
//				L = 0;
//				Z = 1
//			end
//				
//		end
//			
//			// B is negative therfore less than A 
//		else if(A[15] < B[15]) begin
//			L = 1;
//			Z = 0;
//		end
//			
//		// A is negative therfore less than B
//		else begin
//			L = 0;
//			Z = 0;
//		end
//			
//	end
//	
//
//endmodule 


//Sign Extension
//A is the 8 bit immediate
//S is signed
//out is the signed extended immediate
	
module signExtend(A,S, Out);
	
	input [7:0] A;
	input wire S;
	output reg [15:0] Out;
	
	always@(A, S) begin
		
		if(S) begin
			
			if(A[7]) begin
				Out[15:8] = 8'b11111111;
				Out[7:0] = A;
			end
		
			else begin 
				Out[15:8] = 8'b00000000;
				Out[7:0] = A;
			end 
		
		end
	
		else begin 
			Out[15:8] = 8'b00000000;
			Out[7:0] = A;
		end
	
	end
		
endmodule



