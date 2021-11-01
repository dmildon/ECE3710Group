module Program_Counter(clk, rst, pc_en, cnt);

	input clk, rst; 
	input pc_en; 

	output reg [9:0] cnt;

	// initial set cnt to 0, and as soon as pc_en = 1, cnt = 1 on rising edge of clk 

	initial begin
		cnt = 10'b0000000000;
	end 

	always@(posedge clk, negedge rst)
    
		begin
			if(~rst) begin 
				cnt = 10'b0;
			end 
			
			else begin 
				if(pc_en)
					cnt <= cnt + 1; 
			end 
  
		end

endmodule
