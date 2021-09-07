`timescale 1ps/1ps //Always include this 

module tb_ALU(); //must match name of file and don't forget endmodule


	reg signed [15:0] Rsrc, Rdest;
	reg [4:0] OpCode;
	wire [15:0] Out;
	wire [4:0] Flags;

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
	
	// ADD TEST 
	OpCode = ADD; 
	Rsrc = 1; 
	Rdest = -1; 
	
	#10000; 
	
	OpCode = AND; 
	Rsrc = -1; 
	Rdest = -1;	
	
end

endmodule
