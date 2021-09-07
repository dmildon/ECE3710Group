`timescale 1ps/1ps //Always include this 

module tb_ALU(); //must match name of file and don't forget endmodule


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

	$display("Starting Testbench");
	OpCode = SUB;
	#1;
	
	// ADD TEST 
	Rsrc = 1; 
	Rdest = 1; 
	OpCode = ADD;
	
	#10000; 
	
	OpCode = AND; 
	Rsrc = -1; 
	Rdest = -1;	
	
end

endmodule
