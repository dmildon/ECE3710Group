module ALU_wrapper (clk, data_input, ld_op_code, ld_src, ld_dest, Flags, Out);

	input clk; 
	input [9:0] data_input;
	input ld_op_code;
	input ld_src; 
	input ld_dest; 
	
	reg [15:0] Rsrc, Rdest;
	reg [4:0] OpCode;
	output [4:0] Flags;
	output [15:0] Out;
	
	ALU myALU(
		.Rsrc(Rsrc), 
		.Rdest(Rdest), 
		.OpCode(OpCode), 
		.Flags(Flags), 
		.Out(Out)
	); 

	//Register for opcode
	always@(negedge(ld_op_code)) begin
			
			if(ld_op_code == 0) begin 
				OpCode = data_input[4:0]; 
			end 
			
	end


	//Register for Rsrc
	always@(negedge(ld_src)) begin
			
			if(ld_src == 0) begin
				Rsrc = {data_input[9:0],6'b000000}; 
			end
	end
	
	
	//Register for Rdest
	always@(negedge(ld_dest)) begin
			
			if(ld_dest == 0) begin
				Rdest = {data_input[9:0],6'b000000}; 
			end 
	end
	

endmodule 