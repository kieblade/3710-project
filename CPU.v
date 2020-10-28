module CPU 
#( parameter overrideRAM = 0)
(
	input clk,							// Clock
	input reset,						// reset (resets the whole CPU and script sequence)
	output [4:0] flagLEDs,			// flags
	output [15:0] r1,
	output write_en,
	output [9:0] addr,
	output [15:0] data_in,
	input [15:0] data_out
);	
	wire [15:0] mux_a_out, mux_b_out, instr, data_B, instr_out, out_A, out_B, imm, regEnable;
	wire [15:0] r0, /*r1 is and output to display output,*/ r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [9:0] addr_A, addr_B, next_pc, address;
	wire [7:0] opcode;
	wire [3:0] en_reg, s_muxA, s_muxB;
	wire [1:0] type;
	wire Lscntl, s_muxImm, WE, en_B, en_MAR, en_MDR, i_en, flagsEn, PCe, wb, s_mem_to_bus, reg_Wen;
	
	generate
		if (overrideRAM == 1) begin
			assign write_en = WE;
			assign addr = addr_A;
			assign data_in = mux_a_out;
		end else
		begin
			// these values are passed out when we override RAM
			assign write_en = 1'b0;
			assign addr = 10'b0;
			assign data_in = 15'b0;
		end
	endgenerate
	
	CPU_FSM FSM(
		.type(type),					// instruction type
		.clk(clk),						// clock
		.PCe(PCe),						// program counter enable
		.Lscntl(Lscntl),				// address mux select
		.WE(WE),							// Write enable
		.i_en(i_en),					// Enable for instruction register
		.s_muxImm(s_muxImm),			// select for immediate mux
		.reg_Wen(reg_Wen),			// write enable for regFile (It's needed just trust me - Seth)
		.flagsEn(flagsEn),			// write enable for flags register (it overwrites the flags if you don't have this)
		.wb(wb),
		.s_mem_to_bus(s_mem_to_bus)
	);
	
	pc_incr increment(
		.curr_pc(addr_A), 			// current address
		.diff(10'b1),					// amount to change address
		.decr(1'b0),						// decrease address number
		.next_pc(next_pc)				// next address
	);
	
	program_counter PC(
		.clk(clk),
		.reset(reset),
		.addr_in(next_pc),			// next address
		.en(PCe),						// program counter enable
		.addr_out(address)			// address out
	);
	
	inputMux addressMux(
		.select(Lscntl), 				// address mux select
		.b(mux_b_out),					// address from program counter
		.immd({6'b0, address}), 				// address from register
		.out(addr_A)					// adress to ram
	);
	
	generate
		if (overrideRAM == 0) begin
			dpram RAM(
				.clk(clk),						// clock
				.en_A(WE),						// port A enable
				.en_B(en_B),					// port B enable
				.addr_A(addr_A),				// port A address
				.addr_B(addr_B),				// port B address
				.data_A(mux_a_out),				// data into port A
				.data_B(data_B),				// data into port B
				.out_A(out_A),					// data out of port A
				.out_B(out_B)					// data out of port B
			);
			instr_reg instruction_register(
				.en(i_en),						// instruction register enable
				.in(out_A),						// input address
				.out(instr_out)				// output address
			);
		end
		else
		begin
			instr_reg instruction_register(
				.en(i_en),						// instruction register enable
				.in(data_out),						// input address
				.out(instr_out)				// output address
			);
		end
	endgenerate

	decoder instrDecoder (
		.instr(instr_out), 	       	// Instruction
		.opcode(opcode),      	 	// Opcode for ALU
		.en_reg(en_reg),  		 	// Regfile enables (Rdest)
		.s_muxA(s_muxA), 			 	// MUX A Select
		.s_muxB(s_muxB), 			 	// MUX B Select
		.imm(imm), 				    	// Immediate
		.type(type),						// instuction type
		.wb(wb)
	);
	
	rdest_decoder reg_decoder(
		.reg_en(en_reg),				// reg enable from instruction
		.reg_Wen(reg_Wen),			// enable to prevent regEnable until ready
		.regEnable(regEnable)		// reg enable for regFile
	);
	
	generate
	if (overrideRAM == 0) begin
		regFileInitializer alu(
			.regEnable(regEnable),		// Which reg to enable
			.clk(clk),		 				// clock
			.reset(reset), 				// reset
			.a_select(s_muxA), 			// mux select for mux A
			.b_select(s_muxB), 			// mux select for mux B
			.bus_select(s_mem_to_bus),
			.bus_data(out_A),
			.use_imm(s_muxImm), 			// mux select for immediate mux
			.immediate(imm), 				// immediate
			.opCode(opcode),				// opCode
			.mux_a_out(mux_a_out),		// output from mux b
			.mux_b_out(mux_b_out),
			.r0(r0),							// register 1 output
			.r1(r1),							// register 2 output
			.r2(r2),							// register 3 output
			.r3(r3),							// register 4 output
			.r4(r4),							// register 5 output
			.r5(r5),							// register 6 output
			.r6(r6),							// register 7 output
			.r7(r7),							// register 8 output
			.r8(r8),							// register 9 output
			.r9(r9),							// register 10 output
			.r10(r10),						// register 11 output
			.r11(r11),						// register 12 output
			.r12(r12),						// register 13 output
			.r13(r13),						// register 14 output
			.r14(r14),						// register 15 output
			.r15(r15),						// register 16 output
			.flags(flagLEDs),				// flags
			.flagsEn(flagsEn)          // write enable for flags register (it overwrites the flags if you don't have this)
		);
	end
	else begin
		regFileInitializer alu(
			.regEnable(regEnable),		// Which reg to enable
			.clk(clk),		 				// clock
			.reset(reset), 				// reset
			.a_select(s_muxA), 			// mux select for mux A
			.b_select(s_muxB), 			// mux select for mux B
			.bus_select(s_mem_to_bus),
			.bus_data(data_out),  		// WHEN OVERRIDING RAM this signal should be fed by data_out
			.use_imm(s_muxImm), 			// mux select for immediate mux
			.immediate(imm), 				// immediate
			.opCode(opcode),				// opCode
			.mux_a_out(mux_a_out),		// output from mux b
			.mux_b_out(mux_b_out),
			.r0(r0),							// register 1 output
			.r1(r1),							// register 2 output
			.r2(r2),							// register 3 output
			.r3(r3),							// register 4 output
			.r4(r4),							// register 5 output
			.r5(r5),							// register 6 output
			.r6(r6),							// register 7 output
			.r7(r7),							// register 8 output
			.r8(r8),							// register 9 output
			.r9(r9),							// register 10 output
			.r10(r10),						// register 11 output
			.r11(r11),						// register 12 output
			.r12(r12),						// register 13 output
			.r13(r13),						// register 14 output
			.r14(r14),						// register 15 output
			.r15(r15),						// register 16 output
			.flags(flagLEDs),				// flags
			.flagsEn(flagsEn)          // write enable for flags register (it overwrites the flags if you don't have this)
		);

	end
	endgenerate
endmodule 