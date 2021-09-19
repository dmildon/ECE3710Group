`timescale 1ps/1ps

module tb_RegFile_Alu ();
	reg [3:0] RdestRegLoc, RsrcRegLoc;
	reg Clk, En, Rst, Imm_s;
	reg [15:0] Imm;
	reg [4:0] OpCode;
	
	wire [4:0] Flags;
	wire [15:0] RdestOut;
	
	parameter ADD 		= 4'b0000;
	parameter SUB 		= 4'b0001;
	parameter CMP 		= 4'b0010;
	parameter AND 		= 4'b0011;
	parameter OR 		= 4'b0100;
	parameter XOR 		= 4'b0101;
	parameter NOT 		= 4'b0110;
	parameter LSH 		= 4'b0111;
	parameter RSH 		= 4'b1000;
	parameter ARSH 	= 4'b1001;
	
	integer i;
	
	RegFile_Alu uut(
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrcRegLoc), 
		.Clk(Clk), 
		.En(En), 
		.Rst(Rst), 
		.Imm(Imm),
		.Imm_s(Imm_s), 
		.OpCode(OpCode), 
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
 
	initial begin
		
		$display("Starting integrated testbench");
		
		$display("Setup");
		
		Clk = 0;
		Rst = 1;
		En = 0;
		#5; //Clk=1
		Rst = 0;
		#5; //Clk=0
		Rst = 1;
		RdestRegLoc = 4'b0000;
		En =  1;
		OpCode = ADD;
		Imm_s = 1;
		Imm = 1;
		#10; //Clk=0
		En = 0;
		Imm_s = 0;
		if (RdestOut != 1) begin
			$display("Setup Failed");
			$stop;
		end
		$display("Setup finished without error.");
		
		
		$display("Test adding to different register");
		for (i = 1; i < 16; i = i + 1) begin
			RsrcRegLoc = 4'b0;
			RdestRegLoc = i;
			En = 1;
			#10; //Clk = 0
			En = 0;
			if (RdestOut != 1) begin
				$display("Test failed");
				$stop;
			end
			#10; //Clk = 0
		end
		
		$display("All Tests passed");
	end
	always #5 Clk = ~Clk;
endmodule
