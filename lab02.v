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
	
	wire [15:0] r0_to_mux, r1_to_mux, r2_to_mux,  r3_to_mux,  r4_to_mux,  r5_to_mux,  r6_to_mux,  r7_to_mux,
	            r8_to_mux, r9_to_mux, r10_to_mux, r11_to_mux, r12_to_mux, r13_to_mux, r14_to_mux, r15_to_mux;
					// ^Is there a cleaner way to do this?
					
	wire [15:0] muxA_to_aluA, muxB_to_muxImm, muxImm_to_aluB, bus;
	wire [4:0] ALU_to_flagsReg;
	
	
	fsm fib_fsm (
		.clk (clk),
		.rst (rst),
		.regEn (fsm_to_regfile),
		.muxA (fsm_to_muxA),
		.muxB (fsm_to_muxB),
		.muxBimm (fsm_to_muxImm),
		.Opcode (fsm_to_ALU)
	);
	
	
	regfile regArr (
		.clk (clk),
		.reset (rst),
		.regEnable (fsm_to_regfile),
		.ALUBus (bus),
		.r0 (r0_to_mux),
		.r1 (r1_to_mux),
		.r2 (r2_to_mux),
		.r3 (r3_to_mux),
		.r4 (r4_to_mux),
		.r5 (r5_to_mux),
		.r6 (r6_to_mux),
		.r7 (r7_to_mux),
		.r8 (r8_to_mux),
		.r9 (r9_to_mux),
		.r10(r10_to_mux),
		.r11(r11_to_mux),
		.r12(r12_to_mux),
		.r13(r13_to_mux),
		.r14(r14_to_mux),
		.r15(r15_to_mux)
	);
	
	
	mux muxA (
		.select (fsm_to_muxA),
		.r0 (r0_to_mux),
		.r1 (r1_to_mux),
		.r2 (r2_to_mux),
		.r3 (r3_to_mux),
		.r4 (r4_to_mux),
		.r5 (r5_to_mux),
		.r6 (r6_to_mux),
		.r7 (r7_to_mux),
		.r8 (r8_to_mux),
		.r9 (r9_to_mux),
		.r10(r10_to_mux),
		.r11(r11_to_mux),
		.r12(r12_to_mux),
		.r13(r13_to_mux),
		.r14(r14_to_mux),
		.r15(r15_to_mux),
		.out (muxA_to_aluA)
	);
	
	
	mux muxB (
		.select (fsm_to_muxB),
		.r0 (r0_to_mux),
		.r1 (r1_to_mux),
		.r2 (r2_to_mux),
		.r3 (r3_to_mux),
		.r4 (r4_to_mux),
		.r5 (r5_to_mux),
		.r6 (r6_to_mux),
		.r7 (r7_to_mux),
		.r8 (r8_to_mux),
		.r9 (r9_to_mux),
		.r10(r10_to_mux),
		.r11(r11_to_mux),
		.r12(r12_to_mux),
		.r13(r13_to_mux),
		.r14(r14_to_mux),
		.r15(r15_to_mux),
		.out (muxB_to_muxImm)
	);
	
	
	inputMux muxImm (
		.select (fsm_to_muxImm),
		.b (muxB_to_muxImm),
		.immd (imm16),
		.out (muxImm_to_aluB)
	);
	
	
	alu ALU (
		.A (muxA_to_aluA),
		.B (muxImm_to_aluB),
		.carryIn (), // Not using carryIn for now.
		.Opcode (fsm_to_ALU),
		.C (bus),
		.Flags (ALU_to_flagsReg)
	);
	
	
	flagsReg FlagReg(
		.clk (clk),
		.reset (rst),
		.D (ALU_to_flagsReg),
		.r (flagLEDs)
	);
	
	
	hexTo7Seg hex0(
		.x (r15_to_mux[3:0]),
		.z (dsp_7seg_0)
	);
	
	
	hexTo7Seg hex1(
		.x (r15_to_mux[7:4]),
		.z (dsp_7seg_1)
	);
	
	
	hexTo7Seg hex2(
		.x (r15_to_mux[11:8]),
		.z (dsp_7seg_2)
	);
	
	
	hexTo7Seg hex3(
		.x (r15_to_mux[15:12]),
		.z (dsp_7seg_3)
	);
	
	
	assign imm16 = $signed(imm8);
	
	// TODO: Make pin assignments.
	
endmodule
