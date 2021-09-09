module ALU_wrapper (clk, data_input, ld_op_code, ld_src, ld_dest, Flags, Out, out1, out2, out3, out4);

	input clk; 
	input [9:0] data_input;
	input ld_op_code;
	input ld_src; 
	input ld_dest; 
	
	reg [15:0] Rsrc, Rdest;
	reg [4:0] OpCode;
	output [4:0] Flags;
	output reg [15:0] Out;
	output [6:0]out1;
	output [6:0]out2;
	output [6:0]out3;
	output [6:0]out4;
	
	ALU myALU(
		.Rsrc(Rsrc), 
		.Rdest(Rdest), 
		.OpCode(OpCode), 
		.Flags(Flags), 
		.Out(Out)
	); 
	
	hexTo7Seg seg1(
		.x(data_input[3:0]),
		.z(out1)
	
	);

	//Register for opcode
	always@(negedge(ld_op_code)) begin
			
			if(ld_op_code == 0) begin 
				OpCode = data_input[4:0]; 
			end 
			
	end


	//Register for Rsrc
	always@(negedge(ld_src)) begin
			
			if(ld_src == 0) begin
				Rsrc = {data_input[9:0],6'b000000}; 
			end
	end
	
	
	//Register for Rdest
	always@(negedge(ld_dest)) begin
			
			if(ld_dest == 0) begin
				Rdest = {data_input[9:0],6'b000000}; 
			end 
	end
	

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