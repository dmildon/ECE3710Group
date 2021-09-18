`timescale 1ps/1ps
module tb_RegFile ();
	reg [3:0] RdestRegLoc, RsrcRegLoc;
	reg Clk, En, Rst;
	reg [15:0] Load;
	
	wire [15:0] RdestOut, RsrcOut;
	
	integer i, j;
	
	RegFile uut (
		.RdestRegLoc(RdestRegLoc),
		.RsrcRegLoc(RsrsRegLoc),
		.Clk(Clk),
		.En(En),
		.Rst(Rst),
		.Load(Load),
		.RdestOut(RdestOut),
		.RsrcOut(RsrcOut)
	);
	
	initial begin
		Rst = 1;
		Clk = 0;
		En = 0;
		#5;
		Rst = 0;
		#10;
		Rst = 1;
		$display("Testing Reset");
		for (i = 0; i < 16; i = i + 1) begin
			RdestRegLoc = i;
			#10;
			if (RdestOut != 16'b0) begin
				$display ("Rdest Reset Failed");
				$stop;
			end
		end
		$display("Reset Passed");
		
		
		$display("Test write info to regs");
		for (i = 0; i < 16; i = i + 1) begin
			RdestRegLoc = i;
			En = 1;
			Load = 1;
			#20;
			if (RdestOut != 1) begin
				$display("Write to RdestReg failed");
				$stop;
			end
			
			for (j = 0; j < 16; j = j + 1) begin
				RdestRegLoc = j;
				En = 0;
				#10;
				if (j != i) begin
					if (RdestOut != 0) begin
						$display("Write to RdestReg failed");
						$stop;
					end
				end
			end
			Rst = 1;
			#10;
			Rst = 0;
			#10;
			Rst = 1;
			#10;
		end
		$display("Writing to Regs passed");
		
		Rst = 0;
		#10;
		Rst = 1;
		$display("Testing Reset Again");
		for (i = 0; i < 16; i = i + 1) begin
			RdestRegLoc = i;
			#10;
			if (RdestOut != 16'b0) begin
				$display ("Rdest Reset Failed");
				$stop;
			end
		end
		$display("Reset Passed Again");
		
		
		$display("All tests passed");
		
	end
	always #5 Clk = ~Clk;
endmodule
