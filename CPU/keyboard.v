module keyboard(clk_kb, data_kb, out_reg);

// Assining ports as in/out
input clk_kb;
input data_kb;

output reg [7:0] out_reg;

// Instantaiting and Intializing Registers
reg [4:0] counter;
reg [7:0] data_curr;
reg [7:0] data_break;
reg [7:0] data_pre;
reg flag, flag_ignore;

initial
begin
	counter = 1'b1;
	data_curr = 8'hf0;
	data_pre = 8'hf0;
	flag = 1'b0;
	out_reg = 8'hf0;
end

// FSM
always @(negedge clk_kb)
begin
	case (counter)
		1:;
		2: 	data_curr[0] <= data_kb;
		3: 	data_curr[1] <= data_kb;	
		4: 	data_curr[2] <= data_kb;
		5: 	data_curr[3] <= data_kb;	
		6: 	data_curr[4] <= data_kb;
		7: 	data_curr[5] <= data_kb;	
		8: 	data_curr[6] <= data_kb;
		9: 	data_curr[7] <= data_kb;
		10:	flag <= 1'b1;
		11: 	flag <= 1'b0;
		12:;
		13: 	data_break[0] <= data_kb;
		14: 	data_break[1] <= data_kb;	
		15: 	data_break[2] <= data_kb;
		16: 	data_break[3] <= data_kb;	
		17: 	data_break[4] <= data_kb;
		18: 	data_break[5] <= data_kb;	
		19: 	data_break[6] <= data_kb;
		20: 	data_break[7] <= data_kb;
		21:	flag_ignore <= 1'b1;
		22: 	flag_ignore <= 1'b0;
	endcase

	
	if (counter >= 22||(counter == 11 && data_curr != 8'hf0))
		counter <= 1'b1;
	else
		counter <= counter + 1'b1;

end

always @(posedge flag, posedge flag_ignore)
begin

if(flag_ignore == 1) begin

	if(data_curr == 8'hf0 && data_pre != data_break)begin
		out_reg <= data_pre;
	end

	else out_reg <= data_curr;
end

else begin

if(data_curr == 8'hf0 && data_pre != data_break)begin
		out_reg <= data_pre;
	end
	else begin
		out_reg <= data_curr;
		data_pre <= data_curr;
	end
	
end
end


endmodule 