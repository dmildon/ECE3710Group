module RegFile_wrapper (data_input, ld_Reg, ld_Setup, ld_Imm, ld_clk, Flags, out1, out2, out3, out4,RdestOut);

	input [9:0] data_input;
	input ld_Reg;
	input ld_Setup;
	input ld_Imm; 
	input ld_clk; 
	
	reg [3:0] RsrcLoc, RdestLoc;
	reg [4:0] OpCode;
	reg [15:0] imm_val;
	reg Rst,En, Imm_s;
	output [4:0] Flags;
	output wire [15:0] RdestOut;
	reg clk;
	output [6:0]out1, out2, out3, out4;
	
	//TODO: Add clock enable when an input is sent and turn it off after one tick. 
	initial begin
		//rst registers
		//Rst = 1;
		// #5;
		Rst = 0;
		clk = 0;
	end
	
	RegFile_Alu myRegALu(
		.RdestRegLoc(RdestLoc), 
		.RsrcRegLoc(RsrcLoc), 
		.Clk(clk), 
		.En(En), 
		.Rst(Rst), 
		.Imm(imm_val),
		.Imm_s(Imm_s), 
		.OpCode(OpCode), 
		.RdestOut(RdestOut),
		.Flags(Flags)
	);
	
	hexTo7Seg seg1(
		.x(RdestOut[15:12]),
		.z(out1)
	
	);
	
	hexTo7Seg seg2(
		.x(RdestOut[11:8]),
		.z(out2)
	
	);

	hexTo7Seg seg3(
		.x(RdestOut[7:4]),
		.z(out3)
	
	);

	hexTo7Seg seg4(
		.x(RdestOut[3:0]),
		.z(out4)
	
	);


	//Register for opcode
	always@(negedge(ld_Setup)) begin
			
			if(ld_Setup == 0) begin 
				OpCode = data_input[4:0]; 
				Imm_s = data_input[7];
				En = data_input[8];
				Rst = data_input[9];
			end 
			
	end


	//Register for Imm
	always@(negedge(ld_Imm)) begin
			
			if(ld_Imm == 0) begin
				imm_val = {data_input[9:0],6'b000000}; 
			end
	end
	
	
	//Register for loading Reg locations
	always@(negedge(ld_Reg)) begin
			
			if(ld_Reg == 0) begin
				RdestLoc = data_input[9:6];
				RsrcLoc = data_input[3:0];
			end 
	end
	
	always@(ld_clk) begin
		
		if(ld_clk == 0) begin
			clk = 1; 
		end 
		else begin 
			clk = 0; 
		end 
		
	end 
	
	/*
	always@(negedge(ld_clk)) begin
		
		if(ld_clk == 0) begin
			clk = 1; 
		end 
	end 
	
	always@(posedge(ld_clk)) begin
		
		if(ld_clk == 1) begin
			clk = 0; 
		end 
	end
	*/
	
	//Register for loading Enable / RST
	/*
	always@(negedge(ld_En_Rst)) begin
			
			if(ld_En_Rst == 0) begin
				En = data_input[1];
				Rst = data_input[0];
			end 
	end
	*/ 
	

endmodule 

module hexTo7Seg(
		input [3:0]x,
		output reg [6:0]z
		);
always @*
case(x)
	4'b0000 :			//Hexadecimal 0
	z = ~7'b0111111;
   4'b0001 :			//Hexadecimal 1
	z = ~7'b0000110;
   4'b0010 :			//Hexadecimal 2
	z = ~7'b1011011;
   4'b0011 : 			//Hexadecimal 3
	z = ~7'b1001111;
   4'b0100 : 			//Hexadecimal 4
	z = ~7'b1100110;
   4'b0101 : 			//Hexadecimal 5
	z = ~7'b1101101;
   4'b0110 : 			//Hexadecimal 6
	z = ~7'b1111101;
   4'b0111 :			//Hexadecimal 7
	z = ~7'b0000111;
   4'b1000 : 			//Hexadecimal 8
	z = ~7'b1111111;
   4'b1001 : 			//Hexadecimal 9
	z = ~7'b1100111;
	4'b1010 : 			//Hexadecimal A
	z = ~7'b1110111;
	4'b1011 : 			//Hexadecimal B
	z = ~7'b1111100;
	4'b1100 : 			//Hexadecimal C
	z = ~7'b1011000;
	4'b1101 : 			//Hexadecimal D
	z = ~7'b1011110;
	4'b1110 : 			//Hexadecimal E
	z = ~7'b1111001;
	4'b1111 : 			//Hexadecimal F	
	z = ~7'b1110001; 
   default :
	z = ~7'b0000000;
endcase
endmodule 