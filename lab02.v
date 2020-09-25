// Top-level design for Lab 2 meant to test the regfile and ALU on the FPGA board.

module lab02 (
	input clk,
	input rst,
	input [7:0] imm8,
	output [6:0] dsp_7seg_0,
	output [6:0] dsp_7seg_1,
	output [6:0] dsp_7seg_2,
	output [6:0] dsp_7seg_3,
	output [4:0] flagLEDs
);
	
	wire [15:0] imm16;
	
	wire [15:0] fsm_to_regfile;
	wire [3:0] fsm_to_muxA, fsm_to_muxB;
	wire fsm_to_muxImm;
	wire [7:0] fsm_to_ALU;
	
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	
	fsm fib_fsm (
		.clk (clk),
		.rst (rst),
		.regEn (fsm_to_regfile),
		.muxA (fsm_to_muxA),
		.muxB (fsm_to_muxB),
		.muxBimm (fsm_to_muxImm),
		.Opcode (fsm_to_ALU)
	);
	
	regFileInitializer regFileAlu(
		.clk(clk),
		.regEnable(fsm_to_regfile),
		.reset(rst),
		.a_select(fsm_to_muxA),
		.b_select(fsm_to_muxB),
		.use_imm(fsm_to_muxImm),
		.immediate(imm16),
		.opCode(fsm_to_ALU),
		.r0(r0),
		.r1(r1),
		.r2(r2),
		.r3(r3),
		.r4(r4),
		.r5(r5),
		.r6(r6),
		.r7(r7),
		.r8(r8),
		.r9(r9),
		.r10(r10),
		.r11(r11),
		.r12(r12),
		.r13(r13),
		.r14(r14),
		.r15(r15),
		.flags(flagLEDs)
	);
	
	hexTo7Seg hex0(
		.x (r15[3:0]),
		.z (dsp_7seg_0)
	);
	
	
	hexTo7Seg hex1(
		.x (r15[7:4]),
		.z (dsp_7seg_1)
	);
	
	
	hexTo7Seg hex2(
		.x (r15[11:8]),
		.z (dsp_7seg_2)
	);
	
	
	hexTo7Seg hex3(
		.x (r15[15:12]),
		.z (dsp_7seg_3)
	);
	
	
	assign imm16 = $signed(imm8);
	
	// TODO: Make pin assignments.
	
endmodule
