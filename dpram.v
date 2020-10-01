// REPRESENTS A TRUE DUAL-PORT BLOCK RAM WITH 16-BIT WORDS, 512-WORD BLOCKS, & 2 BLOCKS (2KB OF MEMORY)

module dpram (
	input clk, en_A, en_B,
	input  [9:0] addr_A, addr_B,
	input [15:0] data_A, data_B,
	output reg [15:0] out_A, out_B
	// RAM variable is a 2D array of 1024 16-bit words.
	input reg [15:0] ram [1023:0];
);
	
	// Port A
	always @(posedge clk) begin
		if (en_A) begin
			ram[addr_A] <= data_A;
			out_A <= data_A;
		end
		else begin
			out_A <= ram[addr_A];
		end
	end
	
	// Port B
	always @(posedge clk) begin
		if (en_B) begin
			ram[addr_B] <= data_B;
			out_B <= data_B;
		end
		else begin
			out_B <= ram[addr_B];
		end
	end
	
	
endmodule
