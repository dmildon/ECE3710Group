/* 2 bit selector type 00 <- default
 *							  01 <- Imm
 *							  10 <- MemAddr 
 */ 
module Program_Counter(clk, rst, pc_en, sel, imm, mem_addr, cnt);

	input clk, rst, pc_en; 
	input [1:0] sel; 
	input [15:0] imm, mem_addr; 
	
	output reg [15:0] cnt;
	
	parameter Default_s 	= 2'b00; 
	parameter Imm_s 		= 2'b01;
	parameter MemAddr_s 	= 2'b10;

	// initial set cnt to 0, and as soon as pc_en = 1, cnt = 1 on rising edge of clk 
	initial begin
		cnt = 16'b0;
	end 

	
	always@(posedge clk, negedge rst) begin 
		
		if(~rst) begin 
			cnt = 16'b0; 
		end 
		
		else begin
			if((sel == Default_s) && pc_en) begin 
				cnt <= cnt + 1; 
			end 
			
			else if((sel == Imm_s) && pc_en) begin 
				cnt <= cnt + $signed(imm) -1;
			end 
			
			else if((sel == MemAddr_s) && pc_en) begin 
				cnt <= mem_addr -1; 
			end
			
			else begin
				cnt <= cnt;
			end
		end
		
	end 
endmodule
