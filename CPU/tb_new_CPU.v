`timescale 1ps/1ps
module tb_new_CPU ();
	reg Clk, Rst, key_data, key_clk;
	wire [15:0] RdestOut;
	wire [7:0] red, green, blue;
	wire hsync, vsync, blankN, vgaClk;
	
	
	CPU uut (
		.Clk(Clk),
		.Rst(Rst),
		.key_data(key_data),
		.key_clk(key_clk),
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync),
		.blankN(blankN),
		.vgaClk(vgaClk),
		.RdestOut(RdestOut)
	);
	
	initial begin
		Clk = 0;
		Rst = 1;
		#5;
		Rst = 0;
		#5;
		Rst = 1;
		#5;
		
	end
	always #5 Clk = ~Clk;
endmodule
