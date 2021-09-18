`timescale 1ps/1ps
module tb_RegFile_wrapper();
	
	reg [9:0] data_input;
	reg ld_Reg;
	reg ld_Setup;
	reg ld_Imm; 
	reg ld_clk; 
	
	wire [4:0]  Flags;
	wire [6:0]  out1, out2, out3, out4;
	wire [15:0] aluOutput; 
	
	
	RegFile_wrapper uut (
		.data_input(data_input),
		.ld_Reg(ld_Reg),
		.ld_Setup(ld_Setup),
		.ld_Imm(ld_Imm),
		.ld_clk(ld_clk),
		.Flags(Flags),
		.out1(out1),
		.out2(out2),
		.out3(out3), 
		.out4(out4),
		.aluOutput(aluOutput)
	);
	
	initial begin
		
		$display("Starting ALU Wrapper Testbench");
		
		data_input = 10'b0001000000; 
		ld_Reg = 0; 
		
		#10; 
		
		ld_Reg = 1;
		data_input = 10'b0110000000; 
		ld_Setup = 0;
			
		#10; 
		
		ld_Setup = 1;
		data_input = 10'b0100000000; 
		ld_Imm = 0;
		
		#10; 
		ld_Imm = 0;
		
		ld_clk = 0; 
		 
		 #10; 
		ld_clk = 1; 
		
		$display("ALU OUTPUT: %b", aluOutput);
			
	end
	
endmodule
