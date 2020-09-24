// Top-level design for Lab 2 meant to test the regfile and ALU on the FPGA board.

module lab02 (
	input clk,
	input rst,
	input [7:0] imm8,
	output [6:0] dsp_7seg,
	output [4:0] flags
);
	
	reg [15:0] imm16;
	
	wire [15:0] fsm_to_regfile;
	wire [3:0] fsm_to_muxA, fsm_to_muxB;
	wire fsm_to_muxImm;
	wire [7:0] fsm_to_ALU;
	
	wire [15:0] r0_to_mux, r1_to_mux, r2_to_mux,  r3_to_mux,  r4_to_mux,  r5_to_mux,  r6_to_mux,  r7_to_mux,
	            r8_to_mux, r9_to_mux, r10_to_mux, r11_to_mux, r12_to_mux, r13_to_mux, r14_to_mux, r15_to_mux;
					// ^Is there a cleaner way to do this?
					
	wire [15:0] muxA_to_aluA, muxB_to_muxImm, muxImm_to_aluB, bus;
	
	
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
	
	
	// TODO: Bring in the modules—alu, flagsReg, & hexTo7Seg.
	//       Make pin assignments.
	//       Define any continuous assign statements (such as imm8-to-imm16).
	
endmodule
