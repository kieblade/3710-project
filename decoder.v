// DECODES 16-BIT INSTRUCTIONS

module decoder (
	input [15:0] instr,        // Instruction
	output [7:0] opcode,       // Opcode for ALU
	output reg [3:0] en_reg,   // Regfile enables (Rdest)
	output reg [3:0] s_muxA,   // MUX A Select
	output reg [3:0] s_muxB,   // MUX B Select
	output reg [15:0] imm,     // Immediate
	output reg [1:0] type,		// Instruction type
	output reg wb
);
	
	// Opcode list
	parameter ADD   = 8'b 0000_0101;
	parameter ADDI  = 8'b 0101_xxxx;
	parameter ADDU  = 8'b 0000_0110;
	parameter ADDUI = 8'b 0110_xxxx;
	parameter ADDC  = 8'b 0000_0111;
	parameter ADDCI = 8'b 0111_xxxx;
	parameter ADDCU = 8'b 0000_0100;
	parameter ADDCUI= 8'b 1010_xxxx;
	parameter SUB   = 8'b 0000_1001;
	parameter SUBI  = 8'b 1001_xxxx;
	parameter CMP   = 8'b 0000_1011;
	parameter CMPI  = 8'b 1011_0000;
	parameter CMPU  = 8'b 0000_1000; 
	parameter CMPUI = 8'b 1100_0000;
	
	parameter AND   = 8'b 0000_0001;
	parameter ANDI  = 8'b 0001_xxxx;
	parameter OR    = 8'b 0000_0010;
	parameter ORI   = 8'b 0010_xxxx;
	parameter XOR   = 8'b 0000_0011;
	parameter XORI  = 8'b 0011_xxxx;
	parameter NOT   = 8'b 0000_1111;	
	
	parameter LSH   = 8'b 1000_0100;
	parameter LSHI  = 8'b 1000_000x;
	parameter RSH   = 8'b 1000_0101;
	parameter RSHI  = 8'b 1000_001x;
	parameter ALSH  = 8'b 1000_0110;
	parameter ALSHI = 8'b 1000_100x;
	parameter ARSH  = 8'b 1000_0111;
	parameter ARSHI = 8'b 1000_101x;
	
	parameter LOAD  = 8'b 0100_0000;
	parameter STOR  = 8'b 0100_0100;
	parameter JALR  = 8'b 0100_1000;
	parameter Jcond = 8'b 0100_1100;
	//parameter Bcond = 8'b ????
	
	parameter NOP   = 8'b 0000_0000;
	
	// Instruction types       // Examples:
	parameter rType = 2'b 00;  // ADD  r1, r2 (r1 = r1 + r2)
	parameter iType = 2'b 01;  // ADDI r1, 16 (r0 = r1 + 16)
	parameter pType = 2'b 10;  // LOAD r1, r0 (r1 = mem[r0])
	parameter jType = 2'b 11;  // JALR r0, r1 (r0 = PC + 1; PC = r1)
	
	// Concatenate opcode and opcode extension
	assign opcode[7:4] = instr[15:12];
	assign opcode[3:0] = instr[7:4];
	
	
	always @(instr) begin
		// TODO: add description
		casex(opcode)
			// 8-bit immediate operations (I-type)
			ADDI, ADDUI, ADDCI, ADDCUI, SUBI,
			CMPI, CMPUI, ANDI, ORI, XORI:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = 4'bx;
				imm = $signed(instr[7:0]);
				type = iType;
				// don't writeback on cmp instructions
				if (opcode == CMPI || opcode == CMPUI)
					wb = 1'b0;
				else
					wb = 1'b1;
			end
			// 5-bit immediate operations
			LSHI, RSHI, ALSHI, ARSHI:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = 4'bx;
				imm = $signed(instr[4:0]);
				type = iType;
				wb = 1'b1;
			end
			// R-type operations
			ADD, ADDU, ADDC, ADDCU, SUB, CMP, CMPU, AND,
			OR, XOR, NOT, LSH, RSH, ALSH, ARSH, NOP:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = instr[3:0];
				imm = 16'bx;
				type = rType;
				// no writeback on cmp and nops
				if (opcode == CMP || opcode == CMPU || opcode == NOP)
					wb = 1'b0;
				else
					wb = 1'b1;
			end
			// Load, store, & pointer-type operations
			LOAD, STOR:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = instr[3:0];
				imm = 16'bx;
				type = pType;
				// may need to be corrected but only writeback on stores.
				if (opcode == LOAD)
					wb = 1'b0;
				else
					wb = 1'b1;
			end
			// Jump/branch operations
			JALR, Jcond:
			begin
				// TODO: Update to handle conditionals
				en_reg = instr[11:8];
				s_muxA = 4'bx;
				s_muxB = instr[3:0];
				imm = 16'bx;
				type = jType;
				// no writeback
				wb = 1'b0;
			end
			// Invalid operations
			default:
			begin
				en_reg = 4'b0;
				s_muxA = 4'bx;
				s_muxB = 4'bx;
				imm = 16'bx;
				type = 2'bx;
				wb = 1'b0;
			end
		endcase
	end
	
endmodule
