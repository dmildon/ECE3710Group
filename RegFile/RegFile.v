module RegFile (RdestRegLoc, RsrcRegLoc, Clk, En, Rst, Load, RdestOut, RsrcOut);
	input [3:0] RdestRegLoc, RsrcRegLoc;
	input Clk, En, Rst;
	input [15:0] Load;
	
	output reg [15:0] RdestOut, RsrcOut;
	
	
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
	
	always @(posedge Clk) begin
		case(RdestRegLoc)
			reg00: begin RdestOut = Out[0]; end
			reg01: begin RdestOut = Out[1]; end
			reg02: begin RdestOut = Out[2]; end
			reg03: begin RdestOut = Out[3]; end
			reg04: begin RdestOut = Out[4]; end
			reg05: begin RdestOut = Out[5]; end
			reg06: begin RdestOut = Out[6]; end
			reg07: begin RdestOut = Out[7]; end
			reg08: begin RdestOut = Out[8]; end
			reg09: begin RdestOut = Out[9]; end
			reg10: begin RdestOut = Out[10]; end
			reg11: begin RdestOut = Out[11]; end
			reg12: begin RdestOut = Out[12]; end
			reg13: begin RdestOut = Out[13]; end
			reg14: begin RdestOut = Out[14]; end
			reg15: begin RdestOut = Out[15]; end	
		endcase
	end
	
	always @(posedge Clk) begin
		case(RsrcRegLoc)
			reg00: begin RsrcOut = Out[0]; end
			reg01: begin RsrcOut = Out[1]; end
			reg02: begin RsrcOut = Out[2]; end
			reg03: begin RsrcOut = Out[3]; end
			reg04: begin RsrcOut = Out[4]; end
			reg05: begin RsrcOut = Out[5]; end
			reg06: begin RsrcOut = Out[6]; end
			reg07: begin RsrcOut = Out[7]; end
			reg08: begin RsrcOut = Out[8]; end
			reg09: begin RsrcOut = Out[9]; end
			reg10: begin RsrcOut = Out[10]; end
			reg11: begin RsrcOut = Out[11]; end
			reg12: begin RsrcOut = Out[12]; end
			reg13: begin RsrcOut = Out[13]; end
			reg14: begin RsrcOut = Out[14]; end
			reg15: begin RsrcOut = Out[15]; end	
		endcase
	end
endmodule 


module Register(in, clk, en, rst, out);
	input [15:0] in;
	input clk, en, rst;
	
	output reg [15:0] out;
	
	always @(negedge rst, posedge clk) begin
		if (~rst)
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
