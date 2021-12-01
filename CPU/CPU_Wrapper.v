module CPU_Wrapper (
	input btn_clk, btn_rst, key_data, key_clk,
	output [6:0] out1A, out2A, out3A, out4A,
	output [7:0] red, green, blue,
	output hsync, vsync,
	output blankN, vgaClk
);
	wire slowClk;
	wire [15:0] RdestOut;
	
	ClkDivider myDiv(
		.clk(btn_clk),
		.rst(btn_rst),
		.clk_div(slowClk)
	);
	
	CPU myCPU(
		.Clk(btn_clk), 
		.Rst(btn_rst),
		.KeyCodeReg(RdestOut),
		.key_clk(key_clk),
		.key_data(key_data),
		.red(red),
		.green(green),
		.blue(blue),
		.hsync(hsync),
		.vsync(vsync),
		.blankN(blankN),
		.vgaClk(vgaClk)
	);
	
	hexTo7Seg seg1(
		.x(RdestOut[15:12]),
		.z(out1A)
	
	);
	
	hexTo7Seg seg2(
		.x(RdestOut[11:8]),
		.z(out2A)
	
	);

	hexTo7Seg seg3(
		.x(RdestOut[7:4]),
		.z(out3A)
	);
	
	hexTo7Seg seg4(
		.x(RdestOut[3:0]),
		.z(out4A)
	
	);
	


endmodule 

module ClkDivider (
    input clk,
    input rst,
    output reg clk_div
    );
     
	  localparam constantNumber = 10000000;
	  
	  reg [31:0] count;
 
	always @ (posedge(clk), negedge(rst))
		begin
			if (rst == 1'b0)
				count <= 32'b0;
			else if (count == constantNumber - 1)
				count <= 32'b0;
			else
				count <= count + 1;
		end
		
	always @ (posedge(clk), negedge(rst))
		begin
			if (rst == 1'b0)
				clk_div <= 1'b0;
			else if (count == constantNumber - 1)
				clk_div <= ~clk_div;
			else
				clk_div <= clk_div;
		end
	  
 
endmodule



module hexTo7Seg(
		input [3:0]x,
		output reg [6:0]z
		);
always @*
case(x)
	4'b0000 :			//Hexadecimal 0
	z = ~7'b0111111;
   4'b0001 :			//Hexadecimal 1
	z = ~7'b0000110;
   4'b0010 :			//Hexadecimal 2
	z = ~7'b1011011;
   4'b0011 : 			//Hexadecimal 3
	z = ~7'b1001111;
   4'b0100 : 			//Hexadecimal 4
	z = ~7'b1100110;
   4'b0101 : 			//Hexadecimal 5
	z = ~7'b1101101;
   4'b0110 : 			//Hexadecimal 6
	z = ~7'b1111101;
   4'b0111 :			//Hexadecimal 7
	z = ~7'b0000111;
   4'b1000 : 			//Hexadecimal 8
	z = ~7'b1111111;
   4'b1001 : 			//Hexadecimal 9
	z = ~7'b1100111;
	4'b1010 : 			//Hexadecimal A
	z = ~7'b1110111;
	4'b1011 : 			//Hexadecimal B
	z = ~7'b1111100;
	4'b1100 : 			//Hexadecimal C
	z = ~7'b1011000;
	4'b1101 : 			//Hexadecimal D
	z = ~7'b1011110;
	4'b1110 : 			//Hexadecimal E
	z = ~7'b1111001;
	4'b1111 : 			//Hexadecimal F	
	z = ~7'b1110001; 
   default :
	z = ~7'b0000000;
endcase
endmodule 