module CPU_board_wrapper(
	input clk,
	input reset,
	output [6:0] dsp_7seg_0,		// first hex value
	output [6:0] dsp_7seg_1,		// second hex value
	output [6:0] dsp_7seg_2,		// third hex value
	output [6:0] dsp_7seg_3,		// fourth hex value
	output [4:0] flagLEDs			// flags
);
	wire [15:0] r1;
	wire write_en_ignored;
	wire [9:0] addr_ignored;
	wire [15:0] data_in_ignored;
	reg [15:0] data_out_ignored;

	CPU #(.overrideRAM(0)) cpu(
		.clk(~clk),
		.reset(reset),
		.flagLEDs(flagLEDs),
		.r1(r1),
		.write_en(write_en_ignored),
		.addr(addr_ignored),
		.data_in(data_in_ignored),
		.data_out(data_out_ignored)
	);
	
	hexTo7Seg hex0(
		.x (r1[3:0]),
		.z (dsp_7seg_0)
	);
	
	
	hexTo7Seg hex1(
		.x (r1[7:4]),
		.z (dsp_7seg_1)
	);
	
	
	hexTo7Seg hex2(
		.x (r1[11:8]),
		.z (dsp_7seg_2)
	);
	
	
	hexTo7Seg hex3(
		.x (r1[15:12]),
		.z (dsp_7seg_3)
	);
endmodule
