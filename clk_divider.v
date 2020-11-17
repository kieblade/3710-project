module clk_divider #( parameter slowFactor = 50000) (clk_50MHz, rst, slowed_clk);

	input clk_50MHz, rst;
	
	output reg slowed_clk;
	
	reg [24:0] count;
	
	always@(posedge clk_50MHz)
	begin
		if (rst == 1)
		begin
			count <= 25'd0;
			slowed_clk <= 0;
		end
		else if (count >= slowFactor / 2)
		begin
			count <= 25'd0;
			slowed_clk <= ~slowed_clk;
		end
		else
		begin
			slowed_clk <= slowed_clk;
			count <= count + 25'd1;
		end
		
	end

endmodule 