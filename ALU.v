module ALU ()

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


