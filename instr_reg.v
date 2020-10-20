module instr_reg(en, in, out);
	input en;
	input [15:0] in;
	output reg [15:0] out;
	
	always @(posedge en)
		out = in;
endmodule
