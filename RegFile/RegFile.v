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