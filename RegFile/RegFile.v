module RegFile (RdestRegLoc, RsrcRegLoc, Clk, En, Rst, Load, RdestOut, RsrcOut);
	input [3:0] RdestRegLoc, RsrcRegLoc;
	input Clk, En, Rst;
	input [15:0] Load;
	
	output [15:0] RdestOut, RsrcOut;
	
	
	parameter reg00 = 4'b0000;
	parameter reg01 = 4'b0001;
	parameter reg02 = 4'b0010;
	parameter reg03 = 4'b0011;
	parameter reg04 = 4'b0100;
	parameter reg05 = 4'b0101;
	parameter reg06 = 4'b0110;
	parameter reg07 = 4'b0111;
	parameter reg08 = 4'b1000;
	parameter reg09 = 4'b1001;
	parameter reg10 = 4'b1010;
	parameter reg11 = 4'b1011;
	parameter reg12 = 4'b1100;
	parameter reg13 = 4'b1101;
	parameter reg14 = 4'b1110;
	parameter reg15 = 4'b1111;
	
	wire [15:0] Out[15:0], enable;
	
	Dec4to16 decoder(
		.in(RdestRegLoc),
		.E(En),
		.en(enable)
	);
	
	genvar i;
	generate
	for (i = 0; i < 16; i = i + 1)
		begin:registerForLoop
			Register register (
				.in(Load),
				.clk(Clk),
				.en(enable[i]),
				.rst(Rst),
				.out(Out[i])
			);
		end
	endgenerate
	
	MUX RdestMux (
		.in00(Out[0]),
		.in01(Out[1]),
		.in02(Out[2]),
		.in03(Out[3]),
		.in04(Out[4]),
		.in05(Out[5]),
		.in06(Out[6]),
		.in07(Out[7]),
		.in08(Out[8]),
		.in09(Out[9]),
		.in10(Out[10]),
		.in11(Out[11]),
		.in12(Out[12]),
		.in13(Out[13]),
		.in14(Out[14]),
		.in15(Out[15]),
		.loc(RdestRegLoc),
		.out(RdestOut)
	);
	
	MUX RsrcMux (
		.in00(Out[0]),
		.in01(Out[1]),
		.in02(Out[2]),
		.in03(Out[3]),
		.in04(Out[4]),
		.in05(Out[5]),
		.in06(Out[6]),
		.in07(Out[7]),
		.in08(Out[8]),
		.in09(Out[9]),
		.in10(Out[10]),
		.in11(Out[11]),
		.in12(Out[12]),
		.in13(Out[13]),
		.in14(Out[14]),
		.in15(Out[15]),
		.loc(RsrcRegLoc),
		.out(RsrcOut)
	);
	
endmodule 


module Register(in, clk, en, rst, out);
	input [15:0] in;
	input clk, en, rst;
	
	output reg [15:0] out;
	
	always @(negedge rst, posedge clk) begin
		if (rst == 0)
			out <= 16'b0;
		
		else begin
			if (en)
				out <= in;
			else
				out <= out;
		end
	end
endmodule 


module Dec4to16(in, E, en);
	input [3:0] in;
	input E;
	output [15:0] en;
	
	assign en[0]  = ~in[3] & ~in[2] & ~in[1] & ~in[0] & E;
	assign en[1]  = ~in[3] & ~in[2] & ~in[1] &  in[0] & E;
	assign en[2]  = ~in[3] & ~in[2] &  in[1] & ~in[0] & E;
	assign en[3]  = ~in[3] & ~in[2] &  in[1] &  in[0] & E;
	assign en[4]  = ~in[3] &  in[2] & ~in[1] & ~in[0] & E;
	assign en[5]  = ~in[3] &  in[2] & ~in[1] &  in[0] & E;
	assign en[6]  = ~in[3] &  in[2] &  in[1] & ~in[0] & E;
	assign en[7]  = ~in[3] &  in[2] &  in[1] &  in[0] & E;
	assign en[8]  =  in[3] & ~in[2] & ~in[1] & ~in[0] & E;
	assign en[9]  =  in[3] & ~in[2] & ~in[1] &  in[0] & E;
	assign en[10] =  in[3] & ~in[2] &  in[1] & ~in[0] & E;
	assign en[11] =  in[3] & ~in[2] &  in[1] &  in[0] & E;
	assign en[12] =  in[3] &  in[2] & ~in[1] & ~in[0] & E;
	assign en[13] =  in[3] &  in[2] & ~in[1] &  in[0] & E;
	assign en[14] =  in[3] &  in[2] &  in[1] & ~in[0] & E;
	assign en[15] =  in[3] &  in[2] &  in[1] &  in[0] & E;
endmodule

module MUX(in00, in01, in02, in03, in04, in05, in06, in07, in08, in09, in10, in11, in12, in13, in14, in15, loc, out);
	input [15:0] in00, in01, in02, in03, in04, in05, in06, in07, in08, in09, in10, in11, in12, in13, in14, in15;
	input [3:0] loc;
	
	output [15:0] out;
	
	assign out = (loc == 4'b0000) ? in00 :
					 (loc == 4'b0001) ? in01 :
					 (loc == 4'b0010) ? in02 :
					 (loc == 4'b0011) ? in03 :
					 (loc == 4'b0100) ? in04 :
					 (loc == 4'b0101) ? in05 :
					 (loc == 4'b0110) ? in06 :
					 (loc == 4'b0111) ? in07 :
					 (loc == 4'b1000) ? in08 :
					 (loc == 4'b1001) ? in09 :
					 (loc == 4'b1010) ? in10 :
					 (loc == 4'b1011) ? in11 :
					 (loc == 4'b1100) ? in12 :
					 (loc == 4'b1101) ? in13 :
					 (loc == 4'b1110) ? in14 :
					 (loc == 4'b1111) ? in15 : 16'bx;
					 
endmodule
