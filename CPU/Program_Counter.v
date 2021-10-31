/* 2 bit selector type 00 <- default
 *							  01 <- Imm
 *							  10 <- MemAddr 
 */ 
module Program_Counter(clk, rst, pc_en, sel, imm, mem_addr, cnt);

	input clk, rst, pc_en; 
	input [2:0] sel; 
	input [15:0] imm, mem_addr; 
	
	output reg [15:0] cnt;
	
	parameter Default_s 	= 2'b00; 
	parameter Imm_s 		= 2'b01;
	parameter MemAddr_s 	= 2'b10;

	// initial set cnt to 0, and as soon as pc_en = 1, cnt = 1 on rising edge of clk 
	initial begin
		cnt = 16'd0;
	end 

	
	always@(posedge clk, negedge rst) begin 
		
		if(~rst) begin 
			cnt = 0; 
		end 
		
		else if(sel == Default_s && pc_en) begin 
			cnt = cnt + 16'b0000000000000001; 
		end 
		
		else if(sel == Imm_s && pc_en) begin 
			cnt = imm; 
		end 
		
		else if(sel == MemAddr_s && pc_en) begin 
			cnt = mem_addr; 
		end
		
	end 
endmodule
