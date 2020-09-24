module inputMux(select, b, immd, out);
	input select;
	input [15:0] b, immd;
	
	output reg [15:0] out;
	
	always@( select, b, immd )
	begin
	case(select)
	0 : out <= b;
	1 : out <= immd;
	endcase
	end

endmodule 