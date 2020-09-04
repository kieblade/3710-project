`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Universtiy of Utah
// Engineer: Seth Jackson
// 
// Create Date:    12:54:08 08/30/2011 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu( A, B, C, Opcode, Flags);
input [15:0] A, B;
input [7:0] Opcode;
output reg [15:0] C;
output reg [4:0] Flags;

//Flags[0] negative bit
//Flags[1] low flag
//Flags[2] flag bit (overflow)
//Flags[3] carry bit
//Flags[4] z bit

parameter NORMAL = 4'b0000;
parameter SHIFT = 4'b1000;

parameter ADD = 4'b0101;
parameter ADDU = 4'b0110;
parameter ADDC = 4'b0111;
parameter ADDCU = 4'b0100;
parameter SUB = 4'b1001;
parameter CMP = 4'b1011;
parameter AND = 4'b0001;
parameter OR = 4'b0010;
parameter XOR = 4'b0011;

// shifts
parameter LSH = 4'b0100;
parameter RSH = 4'b1100;

parameter LSHI = 4'b0000;
parameter RSHI = 4'b0001;

parameter ALSH = 4'b0110;
parameter ARSH = 4'b1110;

always @(A, B, Opcode)
begin
	case (Opcode[7:4])
	NORMAL:
		begin
		case (Opcode[3:0])
		ADDU:
			begin
			{Flags[3], C} = A + B;
			// perhaps if ({Flags[3], C} == 5'b00000) ....
			if (C == 16'b0000000000000000) Flags[4] = 1'b1; 
			else Flags[4] = 1'b0;
			Flags[2:0] = 3'b000;
			end
		ADDCU:
			begin
			{Flags[3], C} = A + B + Flags[3];
			if (C == 16'b0000000000000000) Flags[4] = 1'b1; 
			else Flags[4] = 1'b0;
			Flags[2:0] = 3'b000;
			end
		ADD:
			begin
			C = A + B;
			if (C == 16'b0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			Flags[1:0] = 2'b00; Flags[3] = 1'b0;
			end
		ADDC:
			begin
			C = A + B + Flags[3];
			if (C == 16b'0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			Flags[1:0] = 2'b00; Flags[3] = 1'b0;
		SUB:
			begin
			C = A - B;
			if (C == 16'b0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			Flags[1:0] = 2'b00; Flags[3] = 1'b0;
			end
		CMP:
			begin
			if( $signed(A) < $signed(B) ) Flags[1:0] = 2'b11;
			else Flags[1:0] = 2'b00;
			C = 16'b0000000000000000;
			Flags[4:2] = 3'b000;
			end
		AND:
			begin
			C = A & B;
			if( C == 16'b0000000000000000 ) Flags[4] = 1'b1; 
			else Flags[4] = 1'b0;
			Flags[3:0] = 4'b0000;
			end
		OR:
			begin
			C = A | B;
			if( C == 16'b0000000000000000 ) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			Flags[3:0] = 4'b0000;
			end
		XOR:
			begin
			C = A ^ B;
			if( C == 16'b0000000000000000 ) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			Flags[3:0] = 4'b0000;
			end
		default: 
			begin
				C = 16'bxxxxxxxxxxxxxxxx;
				Flags = 5'b00000;
			end
		endcase
		end
	SHIFT:
		// all shift operations set the flags to zeros
		Flags[4:0] = 5'b00000;
		case (Opcode[3:0])
		// arithmetic and logical left shift are the same
		ALSH, LSH:
			begin
			C = A<<B;
			end
		RSH:
			begin
			C = A>>B;
			end
		ARSH:
			begin
			C = A>>>B;
			end
		// I'm not certain these are the expected operations.
		LSHI:
			begin
			C = B<<1;
			end
		RSHI:
			begin
			C = B>>1;
			end
		default: 
			begin
				C = 16'bxxxxxxxxxxxxxxxx;
			end
		endcase
		end
	// otherwise, it has an immediate value
	default:
		begin
		// the opcode with an immediate matches the op code ext without an immediate
		case (Opcode[7:4])
		ADDU:
			begin
			{Flags[3], C} = A + $signed({8'b00000000, Opcode[3:0], B[3:0]});
			if (C == 16'b0000000000000000) Flags[4] = 1'b1; 
			else Flags[4] = 1'b0;
			Flags[2:0] = 3'b000;
			end
		ADDCU
			begin
			{Flags[3], C} = A + $signed({8'b00000000, Opcode[3:0], B[3:0]}) + Flags[3];
			if (C == 16'b0000000000000000) Flags[4] = 1'b1; 
			else Flags[4] = 1'b0;
			Flags[2:0] = 3'b000;
			end
		ADD:
			begin
			// perform sign extension on immediate value
			if (Opcode[3])
				c = A + $signed(8'b11111111, Opcode[3:0], B[3:0]);
			else
				c = A + $signed(8'b00000000, Opcode[3:0], B[3:0]);
			if (C == 16'b0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			Flags[1:0] = 2'b00; Flags[3] = 1'b0;
			end
		ADDC:
			begin
			// perform sign extension on immediate value
			if (Opcode[3])
				c = (A + $signed(8'b11111111, Opcode[3:0], B[3:0])) + Flags[3];
			else
				c = (A + $signed(8'b00000000, Opcode[3:0], B[3:0])) + Flags[3];
			if (C == 16'b0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			Flags[1:0] = 2'b00; Flags[3] = 1'b0;
			end
		SUB:
			begin
			if (Opcode[3])
				C = A - $signed({8'b11111111, Opcode[3:0], B[3:0]});
			else
				C = A - $signed({8'b00000000, Opcode[3:0], B[3:0]});
			if (C == 16'b0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			Flags[1:0] = 2'b00; Flags[3] = 1'b0;
			end
		CMP:
			begin
			if (Opcode[3])
				if( $signed(A) < $signed({8'b11111111, Opcode[3:0], B[3:0]}) ) Flags[1:0] = 2'b11;
				else Flags[1:0] = 2'b00;
			else
				if( $signed(A) < $signed({8'b00000000, Opcode[3:0], B[3:0]}) ) Flags[1:0] = 2'b11;
				else Flags[1:0] = 2'b00;
			C = 16'b0000000000000000;
			Flags[4:2] = 3'b000;
			end
		// logical operations with immediate zero extend
		AND:
			begin
			C = A & {8'b00000000, Opcode[3:0], B[3:0]};
			if( C == 16'b0000000000000000 ) Flags[4] = 1'b1; 
			else Flags[4] = 1'b0;
			Flags[3:0] = 4'b0000;
			end
		OR:
			begin
			C = A | {8'b00000000, Opcode[3:0], B[3:0]};
			if (C == 16'b0000000000000000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			Flags[3:0] = 4'b0000;
			end
		XOR:
			begin
			C = A ^ {8'b00000000, Opcode[3:0], B[3:0]};
			if( C == 16'b0000000000000000 ) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			Flags[3:0] = 4'b0000;
			end
		default: 
			begin
				C = 16'bxxxxxxxxxxxxxxxx;
				Flags = 5'b00000;
			end
		endcase
		end
	endcase
end

endmodule