// simple incrementer for the program counter
// expects all inputs to be unsigned
// if desired output is lower than current program counter value, set decr to high
module pc_incr(curr_pc, decr, diff, next_pc);
	input [9:0] curr_pc, diff;
	input decr;
	output [9:0] next_pc;
	
	// if decr is high, perform subtraction, otherwise do addition
	assign next_pc = (decr == 1'b1) ? (curr_pc - diff) : (curr_pc + diff);
endmodule
