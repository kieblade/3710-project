module instr_reg(en, in, out, reset);
	input en, reset;
	input [15:0] in;
	output reg [15:0] out;
	
	always @(posedge en, posedge reset)
		if (reset == 1'b1)
			out <= 16'b0;
		else 
			if (en == 1'b1)
				out <= in;
			else
				out <= out;
endmodule
