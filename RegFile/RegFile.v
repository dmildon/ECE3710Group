module RegFile ();

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
