module wrapper_VGATest (
	input clk,
	output [7:0] red, green, blue,
	output hsync, vsync,
	output blankN, vgaClk
);
	
	reg [15:0] ramIn1, ramIn2;
	integer i, j, k;
	
	VGATest vga (
		.clk(clk),
		.ramIn1(ramIn1),
		.ramIn2(ramIn2),
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync),
		.blankN(blankN),
		.vgaClk(vgaClk)
	);
	
	initial begin
		i = 0;
		j = 0;
		k = 0;
		ramIn1[15:0] = 16'b0;
		ramIn2[15:13] = 3'b0;
		ramIn2[9:0] = 10'b0;
		ramIn2[10] = 0;
		ramIn2[11] = 0;
		ramIn2[12] = 1;
	end
	
	always @(posedge clk) begin
		k = k + 1;
		if (k < (60 * 840000)) begin
			ramIn1[15:0] = 16'b0;
			ramIn2[15:13] = 3'b0;
			ramIn2[9:0] = 10'b0;
			ramIn2[10] = 0;
			ramIn2[11] = 0;
			ramIn2[12] = 1;
		end
		
		else if (k < (1340 * 840000)) begin
			ramIn2[15:13] = 3'b0;
			ramIn2[9:0] = 10'd250;
			ramIn2[10] = 0;
			ramIn2[11] = 0;
			ramIn2[12] = 0;
			if (i == 840000 - 1) begin
				ramIn1 = j % 640;
				j = j + 1;
				i = 0;
			end
			else 
				i = i + 1;
		end
		
		else if (k < (1400 * 840000)) begin
			ramIn1[15:0] = 16'b0;
			ramIn2[15:13] = 3'b0;
			ramIn2[9:0] = 10'b0;
			ramIn2[10] = 1;
			ramIn2[11] = 0;
			ramIn2[12] = 0;
		end
		
		else if (k < (1460 * 840000)) begin
			ramIn1[15:0] = 16'b0;
			ramIn2[15:13] = 3'b0;
			ramIn2[9:0] = 10'b0;
			ramIn2[10] = 0;
			ramIn2[11] = 1;
			ramIn2[12] = 0;
		end
	end

endmodule
