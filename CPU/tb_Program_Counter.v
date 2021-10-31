`timescale 1ps/1ps 
module tb_Program_Counter (); 
	
	reg clk, rst, pc_en; 
	reg [2:0] sel; 
	reg [15:0] imm, mem_addr; 
	wire [15:0] cnt;
	
	integer i; 

	Program_Counter uut(
		.clk(clk),
		.rst(rst),
		.pc_en(pc_en),
		.sel(sel), 
		.imm(imm),
		.mem_addr(mem_addr),
		.cnt(cnt) 
	);

	
	initial 
	
		begin

			$display("Starting Program_Counter Testbench");
			
			clk = 0; 
			pc_en = 0; 
			rst = 1; 
			sel = 2'b00; 
			imm = 0; 
			mem_addr = 0;
			
			// Check to see if cnt = 0 
			
			#10; // clk = 0  
			
			if(cnt != 0) begin 
				
				$display("Enable not set, counter should be 0"); 
				$stop; 
				
			end
			
			// Simple Counter Test 
			
			pc_en = 1; 
			
			for(i = 1; i < 11; i = i + 1) begin 
				
				#10 
				if(cnt != i) begin 
					
					$display("PC not correct, should be %d", i); 
					$stop; 
					
				end 
			
			end 
			
			pc_en = 0;
			#10; 
		
			if(cnt != 10) begin 
				$display("PC not correct, should be 10"); 
				$stop; 
			end 
		
			// Reset Test  
		
			rst = 0; 
			#10; /// Wait Full clock Cycle  
		
			if(cnt != 0) begin 
			
				$display("Rest test: cnt != 0"); 
				$stop; 
			
			end 
		
			// Imm Instructions Test 
			
			pc_en = 1; 
			rst = 1; 
			sel = 2'b01; 
			imm = 50;
			mem_addr = 0;		
			#10; 
			
			if(cnt != 50) begin 
				$display("PC not correct, should be %d", i); 
				$stop; 
			end
		
			// Count back up after recieving imm value 
			sel = 2'b00; 
			
			for(i = 51; i < 76; i = i + 1) begin 
				
				#10;
				
				if(cnt != i) begin 
					$display("PC not correct, should be %d", i); 
					$stop; 
				end 
				
			end 
			
			// Memory Address Test: 
			pc_en = 1; 
			rst = 1; 
			sel = 2'b10; 
			imm = 0;		
			
			// Count back up after recieving imm value 
		
			for(i = 100; i < 151; i = i + 2) begin 
				
				mem_addr = i; 
				#10;
				
				if(cnt != i) begin 
					$display("PC not correct, should be %d", i); 
					$stop; 
				end 
				
			end 
			
		
			$display("PASS ALL TESTS");
			$stop;
			
		end
	
	always #5 clk = ~clk;
	
endmodule
