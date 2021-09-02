module ALU ()

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


