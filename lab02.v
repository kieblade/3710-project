// Top-level design for Lab 2 meant to test the regfile and ALU on the FPGA board.

module lab02 (
	input clk,
	input rst,
	input [7:0] imm,
	output [6:0] dsp_7seg,
	output [4:0] flags
);
	
	wire [15:0] fsm_to_regfile;
	wire [3:0] fsm_to_muxA, fsm_to_muxB;
	wire fsm_to_muxImm;
	wire [7:0] fsm_to_ALU;
	
	fsm fib_fsm(
		.clk (clk),
		.rst (rst),
		.regEn (fsm_to_regfile),
		.muxA (fsm_to_muxA),
		.muxB (fsm_to_muxB),
		.muxBimm (fsm_to_muxImm),
		.Opcode (fsm_to_ALU)
	);
	
	// TODO: Bring in the modules—regfile, muxA, muxB, inputMux, alu, flagsReg, & hexTo7Seg.
	//       Make pin assignments.
	//       Define any continuous assign statements.
	
endmodule
