`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Universtiy of Utah
// Engineer: Scott Crowley, Sam Hirsch, Seth Jackson
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
module alu( A, B, carryIn, C, Opcode, Flags);
input [15:0] A, B;
input carryIn;
input [7:0] Opcode;
output reg [15:0] C;
output reg [4:0] Flags;

//Flags[0] negative bit
//Flags[1] low flag
//Flags[2] flag bit (overflow)
//Flags[3] carry bit
//Flags[4] z bit

// Opcode List
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

always @(A, B, carryIn, Opcode)
begin
	casex (Opcode)
	ADDU, ADDUI:
		begin
		{Flags[3], C} = A + B;
		// perhaps if ({Flags[3], C} == 5'b00000) ....
		if (C == 16'b0000000000000000) Flags[4] = 1'b1; 
		else Flags[4] = 1'b0;
		Flags[2:0] = 3'b000;
		end
	ADDCU, ADDCUI:
		begin
		{Flags[3], C} = A + B + carryIn;
		if (C == 16'b0000000000000000) Flags[4] = 1'b1; 
		else Flags[4] = 1'b0;
		Flags[2:0] = 3'b000;
		end
	ADD, ADDI:
		begin
		C = A + B;
		if (C == 16'b0000000000000000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		Flags[1:0] = 2'b00; Flags[3] = 1'b0;
		end
	ADDC, ADDCI:
		begin
		C = A + B + carryIn;
		if (C == 16'b0000000000000000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		Flags[1:0] = 2'b00; Flags[3] = 1'b0;
		end
	SUB, SUBI:
		begin
		C = A - B;
		if (C == 16'b0000000000000000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[15] & B[15] & C[15]) | (A[15] & ~B[15] & ~C[15]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		Flags[1:0] = 2'b00; Flags[3] = 1'b0;
		end
	CMP, CMPI:
		begin
		if( $signed(A) < $signed(B) ) Flags[4:0] = 5'b00011;
		else if (A == B) Flags[4:0] = 5'b10000;
		else Flags[4:0] = 5'b00000;
		C = 16'b0000000000000000;
		end
	CMPU, CMPUI:
		begin
		if( A < B ) Flags[4:0] = 5'b00011;
		else if (A == B) Flags[4:0] = 5'b10000;
		else Flags[4:0] = 2'b00000;
		C = 16'b0000000000000000;
		end
	AND, ANDI:
		begin
		C = A & B;
		if( C == 16'b0000000000000000 ) Flags[4] = 1'b1; 
		else Flags[4] = 1'b0;
		Flags[3:0] = 4'b0000;
		end
	OR, ORI:
		begin
		C = A | B;
		if( C == 16'b0000000000000000 ) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		Flags[3:0] = 4'b0000;
		end
	XOR, XORI:
		begin
		C = A ^ B;
		if( C == 16'b0000000000000000 ) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		Flags[3:0] = 4'b0000;
		end
	NOT:
		begin
		C = ~A;
		if( C == 16'b0000000000000000 ) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		Flags[3:0] = 4'b0000;
		end
	ALSH, ALSHI:
		begin
		C = $signed(A) <<< $signed(B);
		Flags[4:0] = 5'b00000;
		end
	LSH, LSHI:
		begin
		C = A<<B;
		Flags[4:0] = 5'b00000;
		end
	RSH, RSHI:
		begin
		C = A>>B;
		Flags[4:0] = 5'b00000;
		end
	ARSH, ARSHI:
		begin
		C = $signed(A) >>> $signed(B);
		Flags[4:0] = 5'b00000;
		end
	NOP:
	   begin
		C = 16'bxxxxxxxxxxxxxxxx;
		Flags = 5'bxxxxx;
		end
	default:
		begin
		C = 16'bxxxxxxxxxxxxxxxx;
		Flags = 5'b00000;
		end
	endcase
end

endmodule