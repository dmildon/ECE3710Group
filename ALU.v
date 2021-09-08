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

	parameter ADD 		= 5'b0000;
	parameter SUB 		= 5'b0001;
	parameter CMP 		= 5'b0010;
	parameter AND 		= 5'b0011;
	parameter OR 		= 5'b0100;
	parameter XOR 		= 5'b0101;
	parameter NOT 		= 5'b0110;
	parameter LSH 		= 5'b0111;
	parameter RSH 		= 5'b1000;
	parameter ARSH 	= 5'b1001;

	wire [15:0] out_add, out_sub, out_cmp, out_and, out_or, out_xor, out_not, out_lsh, out_rsh, out_arsh; 
	wire [4:0] flags_add, flags_sub, flags_cmp;
	

	add_sub myAdd (
		.rdest(Rdest),
		.rsrc(Rsrc),
		.Cin(0),
		.flags(flags_add),
		.out(out_add)
	);
	
	
	add_sub mySub (
		.rdest(Rdest),
		.rsrc(~Rsrc),
		.Cin(1),
		.flags(flags_sub),
		.out(out_sub)
	);
	
	
	add_sub myCmp (
		.rdest(Rdest),
		.rsrc(Rsrc),
		.flags(flags_cmp),
		.out(out_cmp)
	);
	
	
	AND_ALU myAnd (
		.A(Rsrc),
		.B(Rdest),
		.Out(out_and)
	);
	
	
	OR_ALU myOr (
		.A(Rsrc),
		.B(Rdest),
		.Out(out_or)
	);
	
	
	XOR_ALU myXor (
		.A(Rsrc),
		.B(Rdest),
		.Out(out_xor)
	);
	
	
	NOT_ALU myNot (
		.A(Rsrc),
		.Out(out_not)
	);
	
	
	LeftShift myLeftShift (
		.inValue(Rsrc),
		.outValue(out_lsh)
	);
	
	
	RightShift myRightShift (
		.inValue(Rsrc),
		.outValue(out_rsh)
	);
	
	
	RightShiftA myRightShiftA (
		.inValue(Rsrc),
		.outValue(out_arsh)
	);
	
	always@(*)
		begin
			case(OpCode)
				ADD: begin Out = out_add; Flags = flags_add; end 
				SUB: begin Out = out_sub; Flags = flags_sub; end 
				CMP: begin Out = out_cmp; Flags = flags_cmp; end 
				AND: begin Out = out_and; Flags = 5'b0; end
				OR:  begin Out = out_or; Flags = 5'b0; end
				XOR: begin Out = out_xor; Flags = 5'b0; end
				NOT: begin Out = out_not; Flags = 5'b0; end
				LSH: begin Out = out_lsh; Flags = 5'b0; end
				RSH: begin Out = out_rsh; Flags = 5'b0; end
				ARSH: begin Out = out_arsh; Flags = 5'b0; end
				default: begin Out = out_add; Flags = 5'b0; end
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
	
	always@(rdest, rsrc, Cin) begin
	
		// Addition
		{flags[0], out} = rsrc + rdest + Cin;
		
		flags[1] = rdest < rsrc;
			
		flags[2] = (rsrc[15] & rdest[15] & ~out[15]) | (~rsrc[15] & ~rdest[15] & out[15]);

		flags[3] = 0;
		
		flags[4] = $signed(rdest) < $signed(rsrc);
	end
	
endmodule

module CMP (rdest, rsrc, flags, out);
	input  [15:0] rdest, rsrc;
	output reg [15:0] out;
	output reg [4:0] flags;
	
	always@(rsrc, rdest) begin
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

module AND_ALU (A, B, Out); 
	input [15:0] A, B;
	output[15:0] Out;
	
	assign Out = (A & B);
	
endmodule


module OR_ALU (A, B, Out);
	input [15:0] A, B;
	output [15:0] Out;

	assign Out = A | B;

	endmodule 


module XOR_ALU (A, B, Out);
	input [15:0] A, B;
	output[15:0] Out;

	assign Out = A ^ B;
endmodule

module NOT_ALU (A, Out);
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



