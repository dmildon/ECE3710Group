`timescale 1ps/1ps
module tb_RegFile_wrapper();
	
	reg [9:0] data_input;
	reg ld_Reg, ld_Setup, ld_Imm, clk, en;
	
	wire [4:0] Flags;
	wire [6:0] out1, out2, out3, out4;
	wire[15:0] RdestOut;
	
	
	RegFile_wrapper uut (
		.data_input(data_input),
		.ld_Reg(ld_Reg),
		.ld_Setup(ld_Setup),
		.ld_Imm(ld_Imm),
		.clk(clk),
		.en(en),
		.Flags(Flags),
		.out1(out1),
		.out2(out2),
		.out3(out3), 
		.out4(out4),
		.RdestOut(RdestOut)
	);
	
	initial begin
		//initialize the clock
		clk = 0;
		en = 0;
		
		
		//resets all registers to 0
		data_input = 8'b00000000;
		ld_Setup = 1;
		#5; //clk = 1
		ld_Setup = 0;
		#5;//clk = 0
		data_input = 8'b10000000;
		ld_Setup = 1;
		#5; //clk = 0
		ld_Setup = 0;
		#10; //clk = 0
		
		
		//choose a register for rdest and rsrc
		data_input = 8'b00000001; //Rdest = reg0; Rsrc = reg1
		ld_Reg = 1;
		#5; //clk = 1
		ld_Reg = 0;
		#5; //clk = 0
		
		
		//set immediate value
		data_input = 1;
		ld_Imm = 1;
		#5; //clk = 1
		ld_Imm = 0;
		#5 //clk = 0
		
		
		//prepare to load the immediate
		data_input = 8'b10010000;
		ld_Setup = 1;
		#5; //clk = 1
		ld_Setup = 0;
		#5; //clk = 0
		
		
		en = 1;
		#10; //clk = 0
		en = 0;
		
		
		
		
		
		
		
		
		
//		clk = 1; 
//		$display("Starting Regfile + ALU Wrapper Testbench");
//		
//		data_input = 10'b0001000000; 
//		ld_Reg = 0; 
//		#10; 
//		
//		ld_Reg = 1;
//		data_input = 10'b0000000000; 
//		ld_Setup = 0;
//		#10; 
//		
//		ld_Setup = 1;
//		data_input = 10'b1111000000; 
//		ld_Imm = 0; 	
//		#10; 
//		
//		ld_Imm = 1; 
//		ld_Inst = 0; 
//		#10; 
		
		
		
		//rst all registers
		/*
		data_input = 10'b1000000000; 
		ld_Setup = 1;
		ld_clk = 1; 
		ld_Imm = 1;
		ld_Reg = 1;
		
		#5; 
		ld_Setup = 0;
		
		#5; 
		ld_Setup = 1;
		
		 
		
		 #10;
		//simulate actual user input ADD 8 to the first register
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
		
		//step through again so its on the pos edge
		ld_clk = 0; 
		 #10; 
		ld_clk = 1; 
		#10;
		ld_clk = 0; 
		#10;
		ld_clk = 1;	
		#10;
		ld_clk = 0; 
		#10;
		*/ 
			
	end
	always #5 clk = ~clk;
	
	
endmodule
