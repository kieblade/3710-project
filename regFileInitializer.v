module regFileInitializer(
	regEnable, 
	clk, 
	reset, 
	a_select, 
	b_select, 
	use_imm, 
	immediate, 
	opCode,
	r1,
	/*r0,
	r1,
	r2,
	r3,
	r4,
	r5,
	r6,
	r7,
	r8,
	r9,
	r10,
	r11,
	r12,
	r13,
	r14,
	r15,*/
	flags
	);
	
	input clk, reset, use_imm;
	input [7:0] opCode;
	input [15:0] regEnable, immediate;
	input [3:0] a_select, b_select;
	wire [15:0] aluBus, mux_a_out, mux_b_out, inputMux_out;
	wire [15:0] r0, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [4:0] flagsIn;
	output [15:0] r1;
	output [4:0] flags;
	
	regfile regArray(
		.ALUBus(aluBus),
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
		.regEnable(regEnable),
		.clk(clk),
		.reset(reset)
	);
	mux muxA(
		.select(a_select),
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
		.out(mux_a_out)
	);
	mux muxB(
		.select(b_select),
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
		.out(mux_b_out)
	);
	inputMux inputMux(
		.select(use_imm),
		.b(mux_b_out),
		.immd(immediate),
		.out(inputMux_out)
	);
	flagsReg flagsReg(
		.D(flagsIn),
		.reset(reset),
		.clk(clk),
		.r(flags)
	);
	alu alu(
		.A(mux_a_out),
		.B(inputMux_out),
		.carryIn(flags[3]),
		.C(aluBus),
		.Opcode(opCode),
		.Flags(flagsIn)
	);
	
endmodule
