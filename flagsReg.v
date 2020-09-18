`timescale 1ns / 1ps

module flagsReg(D, reset, clk, r);
	 input [4:0] D;
	 input reset, clk;
	 output reg [4:0] r;
	 
 always @( posedge clk )
	begin
	if (reset) r <= 5'b00000;
	else
		begin			
			r <= D;
		end
	end
endmodule

