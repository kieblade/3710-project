module program_counter(clk, reset, addr_in, addr_out, en);
	input [15:0] addr_in;
	input en, clk, reset;
	output reg [15:0] addr_out;
	
	initial addr_out = 16'd0;
	
	always @(posedge clk)
	begin
		if (reset == 1'b1) addr_out <= 16'd0;
		else
			if (en == 1'b1)
				addr_out <= addr_in;
			else
				addr_out <= addr_out;
	end

endmodule
