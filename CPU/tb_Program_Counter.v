`timescale 1ps/1ps 
module tb_Program_Counter (); 

	reg clk; 
	reg pc_en; 
	wire [9:0] cnt;
	
	integer i; 

	Program_Counter uut(
		.clk(clk),
		.pc_en(pc_en),
		.cnt(cnt)
	);

	
	initial 
	
		begin

			$display("Starting Program_Counter Testbench");
			
			clk = 0; 
			pc_en = 0; 
		
			// Check to see if cnt = 0 
			#10; // clk = 0  
			
			if(cnt != 0) begin 
				
				$display("Enable not set, counter should be 0"); 
				$stop; 
				
			end
			
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
		
		// ADD test for jump/branch instructions later
		
		$display("Testbench Finished with no errors");
		$finish; 
		
		end
	
	always #5 clk = ~clk;
	
endmodule
