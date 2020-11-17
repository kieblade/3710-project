module game_Inputs(clk, reset, controller, music, out);
	input clk, reset;
	input [4:0] controller, music;
	output reg [15:0] out;
	
	always @(posedge clk, posedge reset)
		if (reset == 1'b1)
			out <= 16'b0;
		else 
			out <= {6'b0, music, controller};
endmodule
