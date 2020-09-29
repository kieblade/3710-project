// REPRESENTS A TRUE DUAL-PORT BLOCK RAM WITH 16-BIT WORDS, 512-WORD BLOCKS, & 2 BLOCKS (2KB OF MEMORY)

module dpram (
	input rst, clk, en_A,   en_B,
	input  [9:0] addr_A, addr_B,
	input [15:0] data_A, data_B,
	output reg [15:0] out_A, out_B
);


endmodule
