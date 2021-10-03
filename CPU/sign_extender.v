//Sign Extension
//A is the 8 bit immediate
//S is signed
//out is the signed extended immediate

module sign_extender(In ,S, Out);
	input wire[7:0] In;
	input wire S;
	output reg [15:0] Out;
	
	always@(*) begin
		if(S) begin
			if(In[7]) begin
				Out[15:8] = 8'b11111111;
				Out[7:0] = In;
			end

			else begin
				Out[15:8] = 8'b00000000;
				Out[7:0] = In;
			end

		end
		
		else begin
			Out[15:8] = 8'b00000000;
			Out[7:0] = In;
		end
	end
		
endmodule
