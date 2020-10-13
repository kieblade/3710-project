// DECODES THE 4-BIT 'Rdest' TO THE 16-BIT 'regEnable'

module rdest_decoder(
	input [3:0] reg_en,
	output reg [15:0] regEnable
);
	
	always @(reg_en) begin
		case(reg_en)
			4'b0000: regEnable = 16'b1;
			4'b0001: regEnable = 16'b10;
			4'b0010: regEnable = 16'b100;
			4'b0011:	regEnable = 16'b1000;
			4'b0100:	regEnable = 16'b10000;
			4'b0101: regEnable = 16'b100000;
			4'b0110: regEnable = 16'b1000000;
			4'b0111: regEnable = 16'b10000000;
			4'b1000: regEnable = 16'b100000000;
			4'b1001: regEnable = 16'b1000000000;
			4'b1010: regEnable = 16'b10000000000;
			4'b1011: regEnable = 16'b100000000000;
			4'b1100: regEnable = 16'b1000000000000;
			4'b1101: regEnable = 16'b10000000000000;
			4'b1110: regEnable = 16'b100000000000000;
			4'b1111: regEnable = 16'b1000000000000000;
		endcase
	end
	
endmodule
