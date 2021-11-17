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

	localparam H_SYNC        = 10'd96;  // 3.8us  -- 25.175M * 3.8u  = 95.665
	localparam H_FRONT_PORCH = 10'd16;  // 0.6us  -- 25.175M * 0.6u  = 15.105
	localparam H_DISPLAY_INT = 10'd640; // 25.4us -- 25.175M * 25.4u = 639.445
	localparam H_BACK_PORCH  = 10'd48;  // 1.9us  -- 25.175M * 1.9u  = 47.8325
	localparam H_TOTAL       = 10'd800; // total width -- 96 + 16 + 640 + 48 = 800

	localparam V_SYNC        = 10'd2;   // 2 lines
	localparam V_BACK_PORCH  = 10'd33;  // 33 lines
	localparam V_DISPLAY_INT = 10'd480; // 480 lines
	localparam V_FRONT_PORCH = 10'd10;  // 10 lines
	localparam V_TOTAL       = 10'd525; // total width -- 2 + 33 + 480 + 10 = 525
	
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

	assign hsync = ~((hcount >= H_BACK_PORCH) & (hcount < H_BACK_PORCH + H_SYNC));
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
		if ((hcount >= 160 && hcount < 320) || (hcount >= 480 && hcount < 640)) begin
			if ((vcount >= 12 && vcount < 132) || (vcount >= 252 && vcount < 372)) begin
				red = 8'b11011110; //red
				green = 8'b00000111;
				blue = 8'b00000111;
			end
			
			else begin
				red = 8'b11111111; //white
				green = 8'b11111111;
				blue = 8'b11111111;
			end
		end
		
		else begin
			if ((vcount >= 12 && vcount < 132) || (vcount >= 252 && vcount < 372)) begin
				red = 8'b11111111; //white
				green = 8'b11111111;
				blue = 8'b11111111;
			end
			
			else begin
				red = 8'b11011110; //red
				green = 8'b00000111;
				blue = 8'b00000111;
			end
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