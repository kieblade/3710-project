// DECODES 16-BIT INSTRUCTIONS

module decoder (
	input [15:0] instr,        // Instruction
	output [7:0] opcode,       // Opcode for ALU
	output reg [3:0] en_reg,   // Regfile enables (Rdest)
	output reg [3:0] s_muxA,   // MUX A Select
	output reg [3:0] s_muxB,   // MUX B Select
	output reg s_muxImm,       // MUX Immediate Select
	output reg [15:0] imm,     // Immediate
	output reg en_A,           // BRAM Port A enable
	output reg en_B,           // BRAM Port B enable
	output reg en_MAR,         // Memory address register enable
	output reg en_MDR          // Memory data register enable
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
	parameter CMPI  = 8'b 1011_xxxx;
	parameter CMPU  = 8'b 0000_1000; 
	parameter CMPUI = 8'b 1100_xxxx;
	
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
	
	parameter NOP   = 8'b 0000_0000;
	
	// Concatenate opcode and opcode extension
	assign opcode[7:4] = instr[15:12];
	assign opcode[3:0] = instr[7:4];
	
	
	always @(instr) begin
		// TODO: add description
		casex(opcode)
			// 8-bit immediate operations
			ADDI, ADDUI, ADDCI, ADDCUI, SUBI,
			CMPI, CMPUI, ANDI, ORI, XORI:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = 4'bx;
				s_muxImm = 1;
				imm = $signed(instr[7:0]);
			end
			// 5-bit immediate operations
			LSHI, RSHI, ALSHI, ARSHI:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = 4'bx;
				s_muxImm = 1;
				imm = $signed(instr[4:0]);
			end
			// R-type operations
			ADD, ADDU, ADDC, ADDCU, SUB, CMP, CMPU, AND,
			OR, XOR, NOT, LSH, RSH, ALSH, ARSH, NOP:
			begin
				en_reg = instr[11:8];
				s_muxA = instr[11:8];
				s_muxB = instr[3:0];
				s_muxImm = 0;
				imm = 16'bx;
			end
			// Load, store, & invalid operations
			default:
			begin
				en_reg = 4'b0;
				s_muxA = 4'bx;
				s_muxB = 4'bx;
				s_muxImm = 1'bx;
				imm = 16'bx;
			end
		endcase
	end
	
endmodule
