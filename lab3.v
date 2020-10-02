module lab3(
	display_addr, 
	button_code, 
	clk, 
	reset,
	dsp_7seg_0,
	dsp_7seg_1,
	dsp_7seg_2,
	dsp_7seg_3);
	
	input [9:0] display_addr;
	input [2:0] button_code;
	input clk, reset;
	
	output [6:0] dsp_7seg_0, dsp_7seg_1, dsp_7seg_2, dsp_7seg_3;
	wire [9:0] addr_a, addr_b;
	wire [15:0] din_a, din_b;
	wire wen_a, wen_b;
	wire [15:0] dout_a, dout_b, readonly_out;
		
	dpram_board_fsm fsm(
		.clk(clk),
		.reset(~reset),
		.button_code(~button_code),
		.dout_a(dout_a),
		.dout_b(dout_b),
		.addr_a(addr_a),
		.addr_b(addr_b),
		.din_a(din_a),
		.din_b(din_b),
		.wen_a(wen_a),
		.wen_b(wen_b),
		.display_addr(display_addr),
		.display_out(readonly_out)
	);
	
	dpram mem(
		.clk(clk),
		.en_A(wen_a),
		.en_B(wen_b),
		.data_A(din_a),
		.data_B(din_b),
		.out_A(dout_a),
		.out_B(dout_b),
		.addr_A(addr_a),
		.addr_B(addr_b)
	);
	
	hexTo7Seg hex0(
		.x(readonly_out[3:0]),
		.z(dsp_7seg_0)
	);
	hexTo7Seg hex1(
		.x(readonly_out[7:4]),
		.z(dsp_7seg_1)
	);
	hexTo7Seg hex2(
		.x(readonly_out[11:8]),
		.z(dsp_7seg_2)
	);
	hexTo7Seg hex3(
		.x(readonly_out[15:12]),
		.z(dsp_7seg_3)
	);
endmodule
