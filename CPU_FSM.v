// FSM for processor and program counter.

module CPU_FSM (opcode, clk, PCe, Lscntl, WE);

	input [7:0] opcode;
	input clk;
	output reg PCe, Lscntl, WE;
	
	reg [3:0] state; 
	parameter [4:0] S0 = 5'd0, S1  = 5'd1,  S2  = 5'd2,  S3  = 5'd3,  S4  = 5'd4,  S5  = 5'd5,  S6  = 5'd6,  S7  = 5'd7, S8 = 5'd8;
	
	parameter LOAD  = 8'b 0100_0000;
	parameter STOR  = 8'b 0100_0100;
	
	parameter NOP   = 8'b 0000_0000;
	
	
	always @(posedge clk) begin
		case(state)
			S0:  state <= S1;
			S1:
				begin
					casex(opcode)
						// store operations
						STOR:
						begin
							state <= S3;
						end
						// Load, r-type, & invalid operations
						default:
						begin
							state <= S2;
						end
					endcase
				end
			S2:  state <= S0;
			S3:  state <= S0;
			default: state <= S0;
		endcase	
	end
	
	
	always @(state) begin
	
		case(state)
			S0:
				begin 
					PCe = 0;
					Lscntl = 1;
					WE = 0;
				end
			S1:                      
				begin 
					PCe = 0;
					Lscntl = 1;
					WE = 0;
				end
			S2:
				begin 
					PCe = 1;
					Lscntl = 1;
					WE = 0;
				end
			S3:
				begin
					PCe = 1;
					Lscntl = 0;
					WE = 1;
				end
			default:
				begin 
					PCe = 0;
				end
		endcase
	
	end
	

endmodule
