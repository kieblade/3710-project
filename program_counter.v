module program_counter(addr_in, addr_out, en);
	input [9:0] addr_in;
	input en;
	output reg [9:0] addr_out;
	
	always @(posedge en)
	begin
		if (en == 1'b1)
			addr_out = addr_in;
		else
			addr_out = addr_out;
	end

endmodule
