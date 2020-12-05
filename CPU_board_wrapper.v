module CPU_board_wrapper(
	input clk,
	input reset,
	input clk_select,
	input [4:0] controller_in, music_in,
	// output [6:0] dsp_7seg_0,		// first hex value
	// output [6:0] dsp_7seg_1,		// second hex value
	// output [6:0] dsp_7seg_2,		// third hex value
	// output [6:0] dsp_7seg_3,		// fourth hex value
	// output [4:0] flagLEDs,			// flags
	output vga_clk, vga_blank_n, vga_vs, vga_hs,
	output [7:0] r, g, b,
	output [15:0] r1
);

	localparam SYS_DATA_WIDTH=16, SYS_ADDR_WIDTH=16;
	localparam GLYPH_DATA_WIDTH=24, GLYPH_ADDR_WIDTH=14;
	
	// wire [15:0] r1;
	wire write_en_ignored;
	wire [15:0] addr_ignored, addr_B, out_B;
	wire [15:0] data_in_ignored;
	reg [15:0] data_out_ignored;
	wire slow_clk;
	wire clk_in;
	assign clk_in = (clk_select & slow_clk) | (~clk_select & clk);
	
	clk_divider #(.slowFactor(100_000)) cd(
		.clk_50MHz(clk),
		.rst(~reset),
		.slowed_clk(slow_clk)
	);
		
	CPU #(.overrideRAM(0)) cpu(
		.clk(clk),
		.reset(~reset),
		.flagLEDs(flagLEDs),
		.r1(r1),
		.write_en(write_en_ignored),
		.addr(addr_ignored),
		.data_in(data_in_ignored),
		.data_out(data_out_ignored),
		.out_B(out_B),
		.addr_B(addr_B),
		.controller_in(controller_in),
		.music_in(music_in)
	);
	
	
	defparam vga.SYS_DATA_WIDTH = SYS_DATA_WIDTH;
	defparam vga.SYS_ADDR_WIDTH = SYS_ADDR_WIDTH;
	defparam vga.GLYPH_DATA_WIDTH = GLYPH_DATA_WIDTH;
	defparam vga.GLYPH_ADDR_WIDTH = GLYPH_ADDR_WIDTH;
	
	vga vga (
		.clk(clk), 
		.reset(~reset),
		.sys_data(out_B),
		.vga_clk(vga_clk), 
		.vga_blank_n(vga_blank_n), 
		.vga_vs(vga_vs), 
		.vga_hs(vga_hs),
		.r(r), 
		.g(g), 
		.b(b),
		.sys_addr(addr_B)
	);
	
//	hexTo7Seg hex0(
//		.x (r1[3:0]),
//		.z (dsp_7seg_0)
//	);
//	
//	
//	hexTo7Seg hex1(
//		.x (r1[7:4]),
//		.z (dsp_7seg_1)
//	);
//	
//	
//	hexTo7Seg hex2(
//		.x (r1[11:8]),
//		.z (dsp_7seg_2)
//	);
//	
//	
//	hexTo7Seg hex3(
//		.x (r1[15:12]),
//		.z (dsp_7seg_3)
//	);
endmodule
