`timescale 1ps/1ps //Always include this 

module tb_ALU_wrapper(); //must match name of file and don't forget endmodule

	reg clk; 
	reg [9:0] data_input;
	reg ld_op_code;
	reg ld_src; 
	reg ld_dest; 
	
	wire [4:0] Flags;
	wire [15:0] Out;
	
//declare test module
//module name, variable name, portmapping
//original or verilog file name of variable(test bench variable)

ALU_wrapper uut(
	.clk(clk),
	.data_input(data_input),
	.ld_op_code(ld_op_code),
	.ld_src(ld_src), 
	.ld_dest(ld_dest),
	.Flags(Flags),
	.Out(Out)
	);
	
	

initial begin

	$display("Starting ALU Wrapper Testbench");
	clk = 0; 
	
	// OR Operation
	ld_op_code = 0; 
	data_input = 10'b0000000100; 
	#10;
	
end

always #5 clk = ~clk;

endmodule
