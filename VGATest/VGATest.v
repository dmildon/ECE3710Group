module VGATest (
	input clk,
	output reg [7:0] red, 
	output reg [7:0] green, 
	output reg [7:0] blue,
	output hsync, 
	output vsync,
	output reg blankN,
	output reg vgaClk
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
	
	localparam platform3X     		= 10'd430; //X coord = 200 + 160 offset
	localparam platform3Y     		= 10'd462; //Y coord = 300 + 12 offset
	localparam platform3Width 		= 10'd125;
	
	localparam platform4X     		= 10'd600; //X coord = 200 + 160 offset
	localparam platform4Y     		= 10'd332; //Y coord = 300 + 12 offset
	localparam platform4Width 		= 10'd40;
	
	localparam platform5X     		= 10'd700; //X coord = 200 + 160 offset
	localparam platform5Y     		= 10'd437; //Y coord = 300 + 12 offset
	localparam platform5Width 		= 10'd30;
	
	localparam platformThick  		= 10'd5;
	
	localparam outOfBounds1X  		= 10'd0;
	localparam outOfBounds1Y  		= 10'd412;
	localparam outOfBounds1Width  = 10'd320;
	
	localparam outOfBounds2X  		= 10'd320;
	localparam outOfBounds2Y  		= 10'd312;
	localparam outOfBounds2Width  = 10'd100;
	
	localparam outOfBounds3X  		= 10'd420;
	localparam outOfBounds3Y  		= 10'd462;
	localparam outOfBounds3Width  = 10'd150;
	
	localparam outOfBounds4X  		= 10'd570;
	localparam outOfBounds4Y  		= 10'd332;
	localparam outOfBounds4Width  = 10'd115;
	
	localparam outOfBounds5X  		= 10'd685;
	localparam outOfBounds5Y  		= 10'd437;
	localparam outOfBounds5Width  = 10'd115;
	
	reg [9:0] hcount, vcount;
	
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
	
//	assign red = 8'b00101101;
//	assign green = 8'b10011010;
//	assign blue = 8'b01111001;
	
	always @(posedge clk) begin
		vgaClk = ~vgaClk;
	end
	
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
		if (
			((hcount >= platform1X) && (hcount <= (platform1X + platform1Width)) && (vcount >= platform1Y) && (vcount <= (platform1Y + platformThick))) || 
			((hcount >= platform2X) && (hcount <= (platform2X + platform2Width)) && (vcount >= platform2Y) && (vcount <= (platform2Y + platformThick))) ||
			((hcount >= platform3X) && (hcount <= (platform3X + platform3Width)) && (vcount >= platform3Y) && (vcount <= (platform3Y + platformThick))) ||
			((hcount >= platform4X) && (hcount <= (platform4X + platform4Width)) && (vcount >= platform4Y) && (vcount <= (platform4Y + platformThick))) ||
			((hcount >= platform5X) && (hcount <= (platform5X + platform5Width)) && (vcount >= platform5Y) && (vcount <= (platform5Y + platformThick)))
				) begin
			red = 8'd220;
			green = 8'd240;
			blue = 8'd20;
		end
		
		else if (
			((hcount >= outOfBounds1X) && (hcount <= (outOfBounds1X + outOfBounds1Width)) && (vcount >= outOfBounds1Y)) || 
			((hcount >= outOfBounds2X) && (hcount <= (outOfBounds2X + outOfBounds2Width)) && (vcount >= outOfBounds2Y)) || 
			((hcount >= outOfBounds3X) && (hcount <= (outOfBounds3X + outOfBounds3Width)) && (vcount >= outOfBounds3Y)) || 
			((hcount >= outOfBounds4X) && (hcount <= (outOfBounds4X + outOfBounds4Width)) && (vcount >= outOfBounds4Y)) || 
			((hcount >= outOfBounds5X) && (hcount <= (outOfBounds5X + outOfBounds5Width)) && (vcount >= outOfBounds5Y))
			) begin
			red = 8'd130;
			green = 8'd0;
			blue = 8'd0;
		end
		
		else begin
			red = 8'd12;
			green = 8'd10;
			blue = 8'd181;
		end
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
