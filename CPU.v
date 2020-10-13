module CPU (
	input clk,							// Clock
	input reset,						// reset (Don't know how we will use this)
	output [6:0] dsp_7seg_0,		// first hex value
	output [6:0] dsp_7seg_1,		// second hex value
	output [6:0] dsp_7seg_2,		// third hex value
	output [6:0] dsp_7seg_3,		// fourth hex value
	output [4:0] flagLEDs			// flags
	
);

	wire [15:0] addr_A, addr_B, instr, data_A, data_B, out_A, out_B, imm, regEnable, r1;
	wire [7:0] opcode;
//	wire [4:0] flags;
	wire [3:0] en_reg, s_muxA, s_muxB;
	wire PCe, s_muxImm, en_A, en_B, en_MAR, en_MDR;
	
	fsm FSM(
		.clk(clk),						// clock
		.PCe(PCe)						// program counter enable
	);
	
	pc_incr increment(
		.curr_pc(addr_A), 			// current address
		.diff(1'b1),					// amount to change address
		.decr(0),					// decrease address number
		.next_pc(next_pc)				// next address
	);
	
	program_counter PC(
		.addr_in(next_PC),			// next address
		.en(PCe),						// program counter enable
		.addr_out(addr_A)				// address out
	);
	
	dpram RAM(
		.clk(clk),						// clock
		.en_A(en_A),					// port A enable
		.en_B(en_B),					// port B enable
		.addr_A(addr_A),				// port A address
		.addr_B(addr_B),				// port B address
		.data_A(data_A),				// data into port A
		.data_B(data_B),				// data into port B
		.out_A(out_A),					// data out of port A
		.out_B(out_B)					// data out of port B
	);

	decoder instrDecoder (
		.instr(instr), 	       	// Instruction
		.opcode(opcode),      	 	// Opcode for ALU
		.en_reg(en_reg),  		 	// Regfile enables (Rdest)
		.s_muxA(s_muxA), 			 	// MUX A Select
		.s_muxB(s_muxB), 			 	// MUX B Select
		.s_muxImm(s_muxImm),     	// MUX Immediate Select
		.imm(imm), 				    	// Immediate
		.en_A(en_A),    	       	// BRAM Port A enable
		.en_B(en_B),      	    	// BRAM Port B enable
		.en_MAR(en_MAR),         	// Memory address register enable
		.en_MDR(en_MDR)          	// Memory data register enable
	);
	
	
	regFileInitializer alu(
		.regEnable(regEnable),		// Which reg to enable
		.clk(clk), 						// clock
		.reset(reset), 				// reset
		.a_select(s_muxA), 			// mux select for mux A
		.b_select(s_muxB), 			// mux select for mux B
		.use_imm(s_muxImm), 			// mux select for immediate mux
		.immediate(imm), 				// immediate
		.opCode(opCode),				// opCode
		.r1(r1),							// register 1
		.flags(flagLEDs)				// flags
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