module VGA (
	input clk,
	input [15:0] in1, in2, 			//first 10 bits of in1 are x coord [9:0]
													//first 10 bits of in2 are y coord [9:0]
													//10th bit of in2 is dead or alive [10] 0 is ship is not dead
													//11th bit of in2 is win or not [11] 0 is game is not won
													//12th bit of in2 is has game started? [12] 1 is game not yet started
	output reg [7:0] red, green, blue,
	output hsync, vsync,
	output reg blankN, vgaClk
);

	localparam H_SYNC         		= 10'd96;  // 3.8us  -- 25.175M * 3.8u  = 95.665
	localparam H_FRONT_PORCH  		= 10'd16;  // 0.6us  -- 25.175M * 0.6u  = 15.105
	localparam H_DISPLAY_INT  		= 10'd640; // 25.4us -- 25.175M * 25.4u = 639.445
	localparam H_BACK_PORCH   		= 10'd48;  // 1.9us  -- 25.175M * 1.9u  = 47.8325
	localparam H_TOTAL        		= 10'd800; // total width -- 96 + 16 + 640 + 48 = 800

	localparam V_SYNC         		= 10'd2;   // 2 lines
	localparam V_BACK_PORCH   		= 10'd33;  // 33 lines
	localparam V_DISPLAY_INT  		= 10'd480; // 480 lines
	localparam V_FRONT_PORCH  		= 10'd10;  // 10 lines
	localparam V_TOTAL        		= 10'd525; // total width -- 2 + 33 + 480 + 10 = 525
	
	//0,0 is top left IFF all coords add 160 to X and 12 to Y
	localparam platform1X     		= 10'd170; //X coord = 10 + 160 offset
	localparam platform1Y     		= 10'd412; //Y coord = 400 + 12 offset
	localparam platform1Width 		= 10'd75;
	
	localparam platform2X     		= 10'd360; //X coord = 200 + 160 offset
	localparam platform2Y     		= 10'd312; //Y coord = 300 + 12 offset
	localparam platform2Width 		= 10'd50;
	
	localparam platform3X     		= 10'd430; //X coord = 270 + 160 offset
	localparam platform3Y     		= 10'd462; //Y coord = 450 + 12 offset
	localparam platform3Width 		= 10'd125;
	
	localparam platform4X     		= 10'd600; //X coord = 440 + 160 offset
	localparam platform4Y     		= 10'd332; //Y coord = 320 + 12 offset
	localparam platform4Width 		= 10'd40;
	
	localparam platform5X     		= 10'd700; //X coord = 540 + 160 offset
	localparam platform5Y     		= 10'd437; //Y coord = 425 + 12 offset
	localparam platform5Width 		= 10'd30;
	
	localparam platformThick  		= 10'd5;
	
	localparam outOfBounds1X  		= 10'd160; //X coord = 0 + 160 offset
	localparam outOfBounds1Y  		= 10'd412; //Y coord = 400 + 12 offset
	localparam outOfBounds1Width  = 10'd160;
	
	localparam outOfBounds2X  		= 10'd320; //X coord = 160 + 160 offset
	localparam outOfBounds2Y  		= 10'd312; //Y coord = 300 + 12 offset
	localparam outOfBounds2Width  = 10'd100;
	
	localparam outOfBounds3X  		= 10'd420; //X coord = 260 + 160 offset
	localparam outOfBounds3Y  		= 10'd462; //Y coord = 450 + 12 offset
	localparam outOfBounds3Width  = 10'd150;
	
	localparam outOfBounds4X  		= 10'd570; //X coord = 410 + 160 offset
	localparam outOfBounds4Y  		= 10'd332; //Y coord = 320 + 12 offset
	localparam outOfBounds4Width  = 10'd115;
	
	localparam outOfBounds5X  		= 10'd685; //X coord = 525 + 160 offset
	localparam outOfBounds5Y  		= 10'd437; //Y coord = 425 + 12 offset
	localparam outOfBounds5Width  = 10'd115;
	
	reg [9:0] hcount, vcount;
	
	wire [15:0] data1, data2;
	
	
	vgaRegister ramData1 (
		.in(in1),
		.clk(vgaClk),
		.en(hcount == H_TOTAL && vcount == V_TOTAL),
		.out(data1)
	);
	
	vgaRegister ramData2 (
		.in(in2),
		.clk(vgaClk),
		.en(hcount == H_TOTAL && vcount == V_TOTAL),
		.out(data2)
	);
	
	vgaClkDivider divider (
		.refclk(clk),
		.rst(0),
		.outclk_0(vgaClk)
	);
	
	
	initial begin
		red = 8'b0;
		green = 8'b0;
		blue = 8'b0;
		blankN = 1'b0;
		vgaClk = 1'b0;
		hcount = 10'b0;
		vcount = 10'b0;
	end

	assign hsync = ~((hcount >= H_FRONT_PORCH) & (hcount < H_FRONT_PORCH + H_SYNC));
	assign vsync = ~((vcount >= V_DISPLAY_INT + V_BACK_PORCH) & (vcount < V_DISPLAY_INT + V_BACK_PORCH + V_SYNC));
	
	always @(posedge vgaClk) begin
		if (hcount < H_TOTAL) begin
			hcount = hcount + 1;
			vcount = vcount;
		end
		else if (vcount < V_TOTAL) begin
			hcount = 0;
			vcount = vcount + 1;
		end
		else begin
			hcount = 0;
			vcount = 0;
		end
	end
	
	always @(hcount, vcount) begin
			if ((hcount >= (data1[9:0] + 160)) && (hcount <= (data1[9:0] + 160 + 15)) && (vcount >= (data2[9:0] + 12)) && (vcount <= (data2[9:0] + 12 + 15))) begin
				if (data2[12] == 1) begin
					red = 8'd84;
					green = 8'd101;
					blue = 8'd255;
				end
				
				if (data2[11] == 1) begin //won
					red = 8'd0;
					green = 8'd255;
					blue = 8'd0;
				end
				
				else if (data2[10] == 1) begin // died
					red = 8'd255;
					green = 8'd0;
					blue = 8'd0;
				end
				
				else begin
					red = 8'd84;
					green = 8'd101;
					blue = 8'd255;
				end
			end
			
			else if (
				((hcount >= platform1X) && (hcount <= (platform1X + platform1Width)) && (vcount >= platform1Y) && (vcount <= (platform1Y + platformThick))) || 
				((hcount >= platform2X) && (hcount <= (platform2X + platform2Width)) && (vcount >= platform2Y) && (vcount <= (platform2Y + platformThick))) ||
				((hcount >= platform3X) && (hcount <= (platform3X + platform3Width)) && (vcount >= platform3Y) && (vcount <= (platform3Y + platformThick))) ||
				((hcount >= platform4X) && (hcount <= (platform4X + platform4Width)) && (vcount >= platform4Y) && (vcount <= (platform4Y + platformThick))) ||
				((hcount >= platform5X) && (hcount <= (platform5X + platform5Width)) && (vcount >= platform5Y) && (vcount <= (platform5Y + platformThick)))
					) begin
				red = 8'd7;
				green = 8'd7;
				blue = 8'd7;
			end
			
			else if (
				((hcount >= outOfBounds1X) && (hcount <= (outOfBounds1X + outOfBounds1Width)) && (vcount >= outOfBounds1Y)) || 
				((hcount >= outOfBounds2X) && (hcount <= (outOfBounds2X + outOfBounds2Width)) && (vcount >= outOfBounds2Y)) || 
				((hcount >= outOfBounds3X) && (hcount <= (outOfBounds3X + outOfBounds3Width)) && (vcount >= outOfBounds3Y)) || 
				((hcount >= outOfBounds4X) && (hcount <= (outOfBounds4X + outOfBounds4Width)) && (vcount >= outOfBounds4Y)) || 
				((hcount >= outOfBounds5X) && (hcount <= (outOfBounds5X + outOfBounds5Width)) && (vcount >= outOfBounds5Y))
				) begin
				red = 8'd75;
				green = 8'd100;
				blue = 8'd74;
			end
			
			else begin
				red = 8'd92;
				green = 8'd200;
				blue = 8'd255;
			end
//		end
	end
	
	always @(hcount,vcount) begin
    
    // bright
    if ((hcount >= H_FRONT_PORCH + H_SYNC + H_BACK_PORCH) &&
         (hcount < H_TOTAL - H_FRONT_PORCH) &&
         (vcount < V_DISPLAY_INT))
         blankN = 1'b1;
     
     else 
        blankN = 1'b0;
        
	end
	
endmodule

module vgaRegister(in, clk, en, out);
	input [15:0] in;
	input clk, en;
	
	output reg [15:0] out;
	
	always @(negedge clk) begin
		if (en)
			out <= in;
		else
			out <= out;
	end
endmodule 