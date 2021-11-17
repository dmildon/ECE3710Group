`timescale 1ps/1ps
module tb_VGATest ();
	reg clk;
	wire [7:0] red; 
	wire [7:0] green; 
	wire [7:0] blue;
	wire hsync;
	wire vsync;
	wire blankN;
	wire vgaClk;
	
	VGATest uut (
		.clk(clk),
		.red(red), 
		.green(green), 
		.blue(blue),
		.hsync(hsync), 
		.vsync(vsync),
		.blankN(blankN),
		.vgaClk(vgaClk)
	);
	
	initial begin
		clk = 0;
		#5;
	end
	always #5 clk = ~clk;
	
endmodule
