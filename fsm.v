// IMPLEMENTS A 5-BIT FINITE STATE MACHINE (MOORE MACHINE) THAT TESTS THE ALU & REGFILE W/ A FIBONACCI SEQUENCE.

module fsm (clk, rst, regEn, muxA, muxB, muxBimm, Opcode);

	input clk, rst;
	output reg [15:0] regEn;
	output reg [3:0] muxA, muxB;
	output reg muxBimm;
	output reg [7:0] Opcode;
	
	reg [4:0] state; 
	parameter [4:0] S0 = 5'd0, S1  = 5'd1,  S2  = 5'd2,  S3  = 5'd3,  S4  = 5'd4,  S5  = 5'd5,  S6  = 5'd6,  S7  = 5'd7, S8 = 5'd8,
	                S9 = 5'd9, S10 = 5'd10, S11 = 5'd11, S12 = 5'd12, S13 = 5'd13, S14 = 5'd14, S15 = 5'd15, S16 = 5'd16;
	parameter ADD = 8'b00000101, ADDI = 8'b01010000, NOP = 8'b00000000;
	
	
	always @(posedge clk) begin
	
		if(rst == 1) state <= S0;
		else
			case(state)
				S0:  state <= S1;
				S1:  state <= S2;
				S2:  state <= S3;
				S3:  state <= S4;
				S4:  state <= S5;
				S5:  state <= S6;
				S6:  state <= S7;
				S7:  state <= S8;
				S8:  state <= S9;
				S9:  state <= S10;
				S10: state <= S11;
				S11: state <= S12;
				S12: state <= S13;
				S13: state <= S14;
				S14: state <= S15;
				S15: state <= S16;
				S16: state <= S16;
				default: state <= S0;
			endcase
	end
	
	
	always @(state) begin
	
		case(state)
			S0:
				begin //r0 = imm + 0
					regEn   = 16'd1;    // Only enable r0
					muxA    = 4'b0000;  // MUX A passes r0 to ALU
					muxB    = 4'bx;     // Don't care about MUX B
					muxBimm = 1;        // Pass imm to ALU
					Opcode  = ADDI;     // r0 + imm
				end
			S1:                      
				begin //r1 = r0 + 0
					regEn   = 16'd2;    // Only enable r1
					muxA    = 4'b0000;  // MUX A passes r0 to ALU
					muxB    = 4'b0001;  // MUX B passes r1 to ALU
					muxBimm = 0;        // Pass B(r1) to ALU
					Opcode  = ADD;      // r0 + r1
				end
			S2:
				begin //r2 = r0 + r1
					regEn   = 16'd4;    // Only enable r2
					muxA    = 4'b0000;  // MUX A passes r0 to ALU
					muxB    = 4'b0001;  // MUX B passes r1 to ALU
					muxBimm = 0;        // Pass B(r1) to ALU
					Opcode  = ADD;      // r0 + r1
				end
			S3:
				begin //r3 = r1 + r2
					regEn   = 16'd8;    // Only enable r3
					muxA    = 4'b0001;  // MUX A passes r1 to ALU
					muxB    = 4'b0010;  // MUX B passes r2 to ALU
					muxBimm = 0;        // Pass B(r2) to ALU
					Opcode  = ADD;      // r1 + r2
				end
			S4:
				begin //r4 = r2 + r3
					regEn   = 16'd16;   // Only enable r4
					muxA    = 4'b0010;  // MUX A passes r2 to ALU
					muxB    = 4'b0011;  // MUX B passes r3 to ALU
					muxBimm = 0;        // Pass B(r3) to ALU
					Opcode  = ADD;      // r2 + r3
				end
			S5:
				begin //r5 = r3 + r4
					regEn   = 16'd32;   // Only enable r5
					muxA    = 4'b0011;  // MUX A passes r3 to ALU
					muxB    = 4'b0100;  // MUX B passes r4 to ALU
					muxBimm = 0;        // Pass B(r4) to ALU
					Opcode  = ADD;      // r3 + r4
				end
			S6:
				begin //r6 = r4 + r5
					regEn   = 16'd64;   // Only enable r6
					muxA    = 4'b0100;  // MUX A passes r4 to ALU
					muxB    = 4'b0101;  // MUX B passes r5 to ALU
					muxBimm = 0;        // Pass B(r5) to ALU
					Opcode  = ADD;      // r4 + r5
				end
			S7:
				begin //r7 = r5 + r6
					regEn   = 16'd128;  // Only enable r7
					muxA    = 4'b0101;  // MUX A passes r5 to ALU
					muxB    = 4'b0110;  // MUX B passes r6 to ALU
					muxBimm = 0;        // Pass B(r6) to ALU
					Opcode  = ADD;      // r5 + r6
				end
			S8:
				begin //r8 = r6 + r7
					regEn   = 16'd256;  // Only enable r8
					muxA    = 4'b0110;  // MUX A passes r6 to ALU
					muxB    = 4'b0111;  // MUX B passes r7 to ALU
					muxBimm = 0;        // Pass B(r7) to ALU
					Opcode  = ADD;      // r6 + r7
				end
			S9:
				begin //r9 = r7 + r8
					regEn   = 16'd512;  // Only enable r9
					muxA    = 4'b0111;  // MUX A passes r7 to ALU
					muxB    = 4'b1000;  // MUX B passes r8 to ALU
					muxBimm = 0;        // Pass B(r8) to ALU
					Opcode  = ADD;      // r7 + r8
				end
			S10:
				begin//r10 = r8 + r9
					regEn   = 16'd1024; // Only enable r10
					muxA    = 4'b1000;  // MUX A passes r8 to ALU
					muxB    = 4'b1001;  // MUX B passes r9 to ALU
					muxBimm = 0;        // Pass B(r9) to ALU
					Opcode  = ADD;      // r8 + r9
				end
			S11:
				begin//r11 = r9 + r10
					regEn   = 16'd2048; // Only enable r11
					muxA    = 4'b1001;  // MUX A passes r9 to ALU
					muxB    = 4'b1010;  // MUX B passes r10 to ALU
					muxBimm = 0;        // Pass B(r10) to ALU
					Opcode  = ADD;      // r9 + r10
				end
			S12:
				begin//r12 = r10 + r11
					regEn   = 16'd4096; // Only enable r12
					muxA    = 4'b1010;  // MUX A passes r10 to ALU
					muxB    = 4'b1011;  // MUX B passes r11 to ALU
					muxBimm = 0;        // Pass B(r11) to ALU
					Opcode  = ADD;      // r10 + r11
				end
			S13:
				begin//r13 = r11 + r12
					regEn   = 16'd8192; // Only enable r13
					muxA    = 4'b1011;  // MUX A passes r11 to ALU
					muxB    = 4'b1100;  // MUX B passes r12 to ALU
					muxBimm = 0;        // Pass B(r12) to ALU
					Opcode  = ADD;      // r11 + r12
				end
			S14:
				begin//r14 = r12 + r13
					regEn   = 16'd16384;// Only enable r14
					muxA    = 4'b1100;  // MUX A passes r12 to ALU
					muxB    = 4'b1101;  // MUX B passes r13 to ALU
					muxBimm = 0;        // Pass B(r13) to ALU
					Opcode  = ADD;      // r12 + r13
				end
			S15:
				begin//r15 = r13 + r14
					regEn   = 16'd32768;// Only enable r15
					muxA    = 4'b1101;  // MUX A passes r13 to ALU
					muxB    = 4'b1110;  // MUX B passes r14 to ALU
					muxBimm = 0;        // Pass B(r14) to ALU
					Opcode  = ADD;      // r13 + r14
				end
			S16:
				begin // Wait for reset
					regEn   = 16'd0;    // Block all registers
					muxA    = 4'bx;     // Don't care about MUX A
					muxB    = 4'bx;     // Don't care about MUX B
					muxBimm = 1'bx;     // Don't care about imm
					Opcode  = NOP;      // No operation
				end
			default:
				begin // Should never reach...
					regEn   = 16'bx;
					muxA    = 4'bx;
					muxB    = 4'bx;
					muxBimm = 1'bx;
					Opcode  = 8'bx;
				end
		endcase
	
	end
	

endmodule
