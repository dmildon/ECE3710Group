module RegFile (RdestRegLoc, RsrcRegLoc, Clk, En, Rst, Load, RdestOut, RsrcOut);
	input [3:0] RdestRegLoc, RsrcRegLoc;
	input Clk, En, Rst;
	input [15:0] Load;
	
	output [15:0] RdestOut, RsrcOut;
	
	wire [15:0] Out[15:0];
	
	genvar i;
	
	generate
	for (i = 0; i < 16; i = i + 1)
		begin
			Register register (
				.in(Load),
				.clk(Clk),
				.en(Dec[i] & En),
				.rst(Rst),
				.out(Out[i]) //eventually go to mux when we are there
			);
		end
	endgenerate
	always (/*some vars go here*/)
	begin
		case //follows output of decoder
			begin
				00...001: begin Out0 = RdestOut; end
			end
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
				out <= X;
			else
				out <= out;
		end
	end
endmodule 

module Dec4to16(in, en);
	input [3:0] in;
	output [15:0] en;
	
	assign en[0]  = ~in[3] & ~in[2] & ~in[1] & ~in[0];
	assign en[1]  = ~in[3] & ~in[2] & ~in[1] &  in[0];
	assign en[2]  = ~in[3] & ~in[2] &  in[1] & ~in[0];
	assign en[3]  = ~in[3] & ~in[2] &  in[1] &  in[0];
	assign en[4]  = ~in[3] &  in[2] & ~in[1] & ~in[0];
	assign en[5]  = ~in[3] &  in[2] & ~in[1] &  in[0];
	assign en[6]  = ~in[3] &  in[2] &  in[1] & ~in[0];
	assign en[7]  = ~in[3] &  in[2] &  in[1] &  in[0];
	assign en[8]  =  in[3] & ~in[2] & ~in[1] & ~in[0];
	assign en[9]  =  in[3] & ~in[2] & ~in[1] &  in[0];
	assign en[10] =  in[3] & ~in[2] &  in[1] & ~in[0];
	assign en[11] =  in[3] & ~in[2] &  in[1] &  in[0];
	assign en[12] =  in[3] &  in[2] & ~in[1] & ~in[0];
	assign en[13] =  in[3] &  in[2] & ~in[1] &  in[0];
	assign en[14] =  in[3] &  in[2] &  in[1] & ~in[0];
	assign en[15] =  in[3] &  in[2] &  in[1] &  in[0];
endmodule
