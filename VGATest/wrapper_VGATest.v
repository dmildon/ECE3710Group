module wrapper_VGATest (
	input clk,
	output [7:0] red, green, blue,
	output hsync, vsync,
	output blankN, vgaClk
);
	
	reg [15:0] ramIn1, ramIn2;
	integer i, j;
	
	VGATest vga (
		.clk(clk),
		.ramIn1(ramIn1),
		.ramIn2(250),
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
	end
	
	always @(posedge clk) begin
		if (i == 840000 - 1) begin
			ramIn1 = j % 640;
			j = j + 1;
			i = 0;
		end
		else 
			i = i + 1;
	end

endmodule
