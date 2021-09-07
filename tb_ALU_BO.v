`timescale 1ps/1ps //Always include this 

module tb_ALU_BO(); //must match name of file and don't forget endmodule


	reg signed [15:0] Rsrc, Rdest;
	reg [4:0] OpCode;
	wire [15:0] Out;
	wire [4:0] Flags;

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


	integer i, j;
	reg [15:0] testWire, desired_result, j_val, i_val;
	

	
//declare test module
//module name, variable name, portmapping
//original or verilog file name of variable(test bench variable)

ALU uut(
	.Rsrc(Rsrc),
	.Rdest(Rdest),
	.OpCode(OpCode),
	.Out(Out), 
	.Flags(Flags)
	);
	
	

initial begin

	$display("Starting Boolean Algebra Testbench");
//	OpCode = SUB;
//	#1;
//	
//	// ADD TEST 
//	Rsrc = 1; 
//	Rdest = 1; 
//	OpCode = ADD;
//	
//	#10000; 
//	
//	OpCode = AND; 
//	Rsrc = 4; 
//	Rdest = -1;	
	
	
//OpCode = ADD;
//#1000;
//OpCode = AND;
//
//Rsrc = 1; 
//Rdest = -1; 
//
//#1000;
	


	for(i= 0; i<(2**16); i= i+1) begin
		i_val = i;
		
		for(j = 0; j<(2**16); j=j+1) begin
			
			j_val = j;
			OpCode = ADD;
			#5;
			
			Rsrc = i;
			Rdest = j;
			
			OpCode = AND;
			#5;
			
			desired_result = j_val & i_val;
			
			#5;
			if(desired_result != Out) begin 
				$display("ADD failed");
				$stop;
			end 
			
			// $display("%b and %b = %b,     (%b)", j_val, i_val, desired_result, Out);
			
		
		end
		
	end
	
	
end

endmodule
