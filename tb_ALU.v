`timescale 1ps/1ps //Always include this 

module tb_ALU(); //must match name of file and don't forget endmodule


	reg signed [15:0] Rsrc, Rdest;
	reg [4:0] OpCode;
	wire [15:0] Out;
	wire [4:0] Flags;

	parameter ADD 		= 5'b0000;
	parameter SUB 		= 5'b0001;
	parameter CMP 		= 5'b0010;
	parameter AND 		= 5'b0011;
	parameter OR 		= 5'b0100;
	parameter XOR 		= 5'b0101;
	parameter NOT 		= 5'b0110;
	parameter LSH 		= 5'b0111;
	parameter RSH 		= 5'b1000;
	parameter ARSH 	= 5'b1001;


	integer i, j;
	reg [15:0] testWire, desired_result_and, desired_result_or, desired_result_xor, desired_result_not,desired_result_lsh,desired_result_rsh, desired_result_arsh, j_val, i_val;
	
//declare test module
//module name, variable name, portmapping
//original or verilog file name of variable(test bench variable)

ALU uut(
	.Rsrc(Rsrc),
	.Rdest(Rdest),
	.OpCode(OpCode),
	.Out(Out), 
	.Flags(Flags)
	);

initial 
	begin

		$display("Starting Testbench");
		OpCode = SUB;
		#1;
		
		// ADD TEST 
		Rsrc = -1; 
		Rdest = 2**16 - 2**15; 
		OpCode = ADD;
		#10000;
		
		
		//Self checking ADD
		$display("Testing ADD");
		for (i = 0; i < 2**4; i = i + 1)
			begin
				testWire = i;
				for (j = 0; j < 2**4; j = j + 1)
					begin
						OpCode = 4'b1111;
						
						#100;
						Rsrc = i;
						Rdest = j;
						OpCode = ADD;
						#100;
						
						if (Out == testWire)
							begin
								testWire = testWire + 1;
							end
						else 
							begin
								$display("ADD failed");
								$stop;
							end
					end
			end
			
			
		for (i = 2**16 - 2**4; i < 2**16; i = i + 1)
			begin
				testWire = i + 2**16 - 2**4;
				for (j = 2**16 - 2**4; j < 2**16; j = j + 1)
					begin
						OpCode = 4'b1111;
						
						#100;
						Rsrc = i;
						Rdest = j;
						OpCode = ADD;
						#100;
						
						if (Out == testWire)
							begin
								testWire = testWire + 1;
							end
						else 
							begin
								$display("ADD failed");
								$stop;
							end
					end
			end
	
		//sub tests
		$display ("Testing SUB");
		for (i = 2**4 - 1; i >= 0; i = i - 1)
			begin
				testWire = i;
				for (j = 0; j < 2**4; j = j + 1)
					begin
						OpCode = 4'b1111;
						
						#100;
						Rsrc = j;
						Rdest = i;
						OpCode = SUB;
						#100;
						
						if (Out == testWire)
							begin
								testWire = testWire - 1;
							end
						else 
							begin
								$display("SUB failed");
								$stop;
							end
					end
			end
		
		
		for (i = 2**16 - 1; i <= 2**16 - 2**4; i = i - 1)
			begin
				testWire = i + 2**16 - 2**4;
				for (j = 2**16 - 2**4; j < 2**16; j = j + 1)
					begin
						OpCode = 4'b1111;
						
						#100;
						Rsrc = j;
						Rdest = i;
						OpCode = SUB;
						#100;
						
						if (Out == testWire)
							begin
								testWire = testWire - 1;
							end
						else 
							begin
								$display("SUB failed");
								$stop;
							end
					end
			end
		
		
		//Self checking C flag
		$display("Testing C Flag");
		i = 2**16-2**4;
		for (j = 2**2; j < 2**6; j = j + 1)
			begin
				OpCode = 4'b1111;
				
				#100;
				Rsrc = i;
				Rdest = j;
				OpCode = ADD;
				#100;
				
				if (j >= 2**4 && !Flags[0])
					begin
						$display("C Failed in Add");
						$stop;
					end
				else if (j < 2**4 && Flags[0])
					begin
						$display("C Failed in Add");
						$stop;
					end
		
				#5;
				OpCode = CMP;
				if (Flags[0] != 1'bx)
					begin
						$display("C Failed in CMP");
						$stop;
					end
			end
		
		//Self checking L flag
		$display("Testing L Flag");
		i = 2**2;
		for (j = 0; j < 2**4; j = j + 1)
			begin
				OpCode = 4'b1111;
				
				#100;
				Rsrc = i;
				Rdest = j;
				OpCode = ADD;
				#100;
				
				if (j < 2**2 && !Flags[1])
					begin
						$display("L Failed in Add");
						$stop;
					end
				else if (j >= 2**2 && Flags[1])
					begin
						$display("L Failed in Add");
						$stop;
					end
		
				#5;
				OpCode = CMP;
				if (j < 2**2 && !Flags[1])
					begin
						$display("L Failed in Add");
						$stop;
					end
				else if (j >= 2**2 && Flags[1])
					begin
						$display("L Failed in Add");
						$stop;
					end
			end
	
		//Self checking F flag
		$display("Testing F Flag");
		#50;
		Rsrc = -1;
		Rdest = 16'b1000000000000000;
		#50;
		OpCode = ADD;
		#50;
	
		if(!Flags[2]) 
			begin
				$display("F Failed in Add");
				$stop;
			end
		
		#5;
		OpCode = CMP;
		#5;
		
		if(Flags[2] != 1'bx) 
			begin
				$display("F Failed in Add");
				$stop;
			end
	
		Rsrc = 1;
		Rdest = 1;
		
		#5;
		OpCode = ADD;
		#5;
	
		if(Flags[2]) 
			begin
				$display("F Failed in Add");
				$stop;
			end
		
		#5;
		OpCode = CMP;
		#5;
	
		if(Flags[2] != 1'bx) 
			begin
				$display("F Failed in Add");
				$stop;
			end
	
		Rsrc = 16'b0100000000000000;
		Rdest = 16'b0100000000000000;
	
		#5;
		OpCode = ADD;
		#5;
		
		if(!Flags[2])
			begin
				$display("F Failed in Add");
				$stop;
			end
		
		#5;
		OpCode = CMP;
		#5;
	
		if(Flags[2] != 1'bx) 
			begin
				$display("F Failed in Add");
				$stop;
			end
	
		$display("Testing Z bit");
		for(i = 0; i < 16; i = i + 1) 
			begin
				for(j = 0; j < 16; j = j + 1) 
					begin
						Rsrc = i;
						Rdest = j;
						#5;
						OpCode = ADD;
						#5;
						
						if(i == j && !Flags[3]) 
							begin
								$display("Z Failed in Add");
								$stop;
							end
						else if(i != j && Flags[3]) 
							begin
								$display("Z Failed in Add");
								$stop;
							end
						
						#5;
						OpCode = CMP;
						#5;
						if(i == j && !Flags[3]) 
							begin
								$display("Z Failed in Add");
								$stop;
							end
						else if(i != j && Flags[3]) 
							begin
								$display("Z Failed in Add");
								$stop;
							end
					end
			end
	
		$display("Testing N bit");
		for(i = 0; i < 16; i = i + 1) 
			begin
				for(j = 0; j < 16; j = j + 1) 
					begin
						Rsrc = i;
						Rdest = j;
						#5;
						OpCode = ADD;
						#5;
						
						if($signed(j) < $signed(i) && !Flags[4]) 
							begin
								$display("N Failed in Add");
								$stop;
							end
						else if($signed(j) >= $signed(i) && Flags[4]) 
							begin
								$display("N Failed in Add");
								$stop;
							end
						
						#5;
						OpCode = CMP;
						#5;
						if($signed(j) < $signed(i) && !Flags[4]) 
							begin
								$display("N Failed in Add");
								$stop;
							end
						else if($signed(j) >= $signed(i) && Flags[4]) 
							begin
								$display("N Failed in Add");
								$stop;
							end
					end
			end
	
	
	
		$display("Starting Boolean Algebra Testbench");
	
		for(i= 0; i<(2**16); i= i+1) 
			begin
				i_val = i;
				Rsrc = i;
				
				//for(j = 0; j<(2**16); j=j+1) begin 
				//if we want to run exaustive tests we can uncomment this loop and set j_val to j not 16'b1010111100001100
					
					j_val = 16'b1010111100001100;
					OpCode = ADD;
					#5;
					
					Rdest = j_val;
					desired_result_and = j_val & i_val;
					desired_result_or = j_val | i_val;
					desired_result_xor = j_val ^ i_val;
					
					
					OpCode = AND;
					#5;
					if(desired_result_and != Out) 
						begin 
							$display("AND failed");
							$stop;
						end 
					#5;// <--- I (Alex) dont think these need to be here because I dont need to wait to change or. 
					  // However Nate and I put them there and I dont want to remove if it needs to be here
					
					OpCode = OR;
					#5;
					if(desired_result_or != Out) 
						begin 
							$display("OR failed");
							$stop;
						end 
					#5;
					
					OpCode = XOR;
					#5;
					if(desired_result_xor != Out) 
						begin 
							$display("Xor failed");
							$stop;
						end
					//end //<---this is to exit the commented out for loop
				
					desired_result_not = ~i_val;
					desired_result_lsh = i_val << 1;
					desired_result_rsh = i_val >> 1;
					desired_result_arsh = $signed(i_val) >>> 1;
				
					OpCode = NOT;
					#5;
					if(desired_result_not != Out) 
						begin 
							$display("Not failed");
							$stop;
						end 
					#5;
				
					OpCode = LSH;
					#5;
					if(desired_result_lsh != Out) 
						begin 
							$display("Left Shift failed");
							$stop;
						end 
					#5;
				
					OpCode = RSH;
					#5;
					if(desired_result_rsh != Out) 
						begin 
							$display("Right Shift failed");
							$stop;
						end 
					#5;
				
					OpCode = ARSH;
					#5;
					if(desired_result_arsh != Out) 
						begin 
							$display("Arithmetic Right Shift failed");
							$stop;
						end 
					#5;
				
			end
		$display("Boolean Algebra Testbench Finished with no errors");
	
	end

endmodule
