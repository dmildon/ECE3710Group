module FSM_RAM_Wrapper (btn_clk, out1A, out2A, out3A, out1B, out2B, out3B);
	
	input btn_clk;
	wire [15:0] q_a_out, q_b_out;
	output [6:0] out1A, out2A, out3A, out1B, out2B, out3B;
	
	FSM_advanced myFSM(
	.clk(btn_clk), 
	.q_a_out(q_a_out),
	.q_b_out(q_b_out)
	);
	
	hexTo7Seg seg1(
		.x(q_a_out[11:8]),
		.z(out1A)
	
	);
	
	hexTo7Seg seg2(
		.x(q_a_out[7:4]),
		.z(out2A)
	
	);

	hexTo7Seg seg3(
		.x(q_a_out[3:0]),
		.z(out3A)
	);
	
	//----------------- out B ----------------//

	hexTo7Seg seg4(
		.x(q_b_out[11:8]),
		.z(out1B)
	
	);
	
	hexTo7Seg seg5(
		.x(q_b_out[7:4]),
		.z(out2B)
	
	);

	hexTo7Seg seg6(
		.x(q_b_out[3:0]),
		.z(out3B)
	);



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