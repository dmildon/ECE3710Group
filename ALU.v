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

	wire [15:0] out_add, out_sub, out_and, out_or, out_xor, out_not, out_lsh, out_rsh, out_arsh;
	reg [15:0] Rsrc_add; 
	wire [4:0] flags_add, flags_sub, flags_cmp;
	reg Cin_wire;
	
	
	add_sub myAdd (
		.rdest(Rdest),
		.rsrc(Rsrc_add),
		.Cin(Cin_wire),
		.flags(flags_add),
		.out(out_add)
	);
	
	
	CMP myCmp (
		.rdest(Rdest),
		.rsrc(Rsrc),
		.flags(flags_cmp)
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
				ADD:  begin Rsrc_add = Rsrc; Cin_wire = 0; Out = out_add; Flags = flags_add; end 
				SUB:  begin Rsrc_add = ~Rsrc; Cin_wire = 1; Out = out_add; Flags = flags_add; end 
				CMP:  begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = 16'bx; Flags = flags_cmp; end 
				AND:  begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_and; Flags = 5'bx; end
				OR:   begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_or; Flags = 5'bx; end
				XOR:  begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_xor; Flags = 5'bx; end
				NOT:  begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_not; Flags = 5'bx; end
				LSH:  begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_lsh; Flags = 5'bx; end
				RSH:  begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_rsh; Flags = 5'bx; end
				ARSH: begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_arsh; Flags = 5'bx; end
				default: begin Rsrc_add = 16'bx; Cin_wire = 1'bx; Out = out_add; Flags = 5'bx; end
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
	output [15:0] out;
	output [4:0] flags;
	
	assign {flags[0], out} = rsrc + rdest + Cin;
	assign flags[1] = rdest < rsrc;
	assign flags[2] = (rsrc[15] & rdest[15] & ~out[15]) | (~rsrc[15] & ~rdest[15] & out[15]);
	assign flags[3] = rdest == rsrc;
	assign flags[4] = $signed(rdest) < $signed(rsrc);
endmodule


module CMP (rdest, rsrc, flags);
	input  [15:0] rdest, rsrc;
	output [4:0] flags;
	
	assign flags[0] = 1'bx;
	assign flags[1] = rdest < rsrc;
	assign flags[2] = 1'bx;
	assign flags[3] = rdest == rsrc;
	assign flags[4] = $signed(rdest) < $signed(rsrc);
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

	assign Out = ~A;
endmodule


module LeftShift(inValue, outValue);
	input [15:0] inValue;
	output [15:0] outValue;
	
	assign outValue = inValue <<< 1;
endmodule


module RightShift(inValue, outValue);
	input [15:0] inValue;
	output [15:0] outValue;
	
	assign outValue = inValue >> 1;
endmodule


module RightShiftA(inValue, outValue);
	input [15:0] inValue;
	output [15:0] outValue;
	
	assign outValue = $signed(inValue) >>> 1;
endmodule
