// FSM for processor and program counter.

module CPU_FSM (clk, PCe);

	input clk;
	output reg PCe;
	
	reg [3:0] state; 
	parameter [4:0] S0 = 5'd0, S1  = 5'd1,  S2  = 5'd2,  S3  = 5'd3,  S4  = 5'd4,  S5  = 5'd5,  S6  = 5'd6,  S7  = 5'd7, S8 = 5'd8;
	
	
	always @(posedge clk) begin
		case(state)
			S0:  state <= S1;
			S1:  state <= S2;
			S2:  state <= S0;
			default: state <= S0;
		endcase	
	end
	
	
	always @(state) begin
	
		case(state)
			S0:
				begin 
					PCe = 0;
				end
			S1:                      
				begin 
					PCe = 0;
				end
			S2:
				begin 
					PCe = 1;
				end
			default:
				begin 
					PCe = 0;
				end
		endcase
	
	end
	

endmodule
