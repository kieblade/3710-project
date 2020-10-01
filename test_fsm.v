module test_fsm (clk, rst, data_a, data_b, addr_a, addr_b, we_a, we_b);

	input clk, rst;
	output reg [15:0] data_a, data_b;
	output reg [9:0] addr_a, addr_b;
	output reg we_a, we_b;
	
	reg [3:0] state; 
	parameter [3:0] S0 = 4'd0, S1  = 4'd1,  S2  = 4'd2,  S3  = 4'd3,  S4  = 4'd4,  S5  = 4'd5,  S6  = 4'd6,  S7  = 4'd7, S8 = 4'd8,
	                S9 = 4'd9, S10 = 4'd10, S11 = 4'd11, S12 = 4'd12, S13 = 4'd13, S14 = 4'd14, S15 = 4'd15;
	
	
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
				S15: state <= S15;
				default: state <= S0;
			endcase
	end
	
	always @(state) begin
	
		case(state)
			S0:
				begin //addr0 = 1 addr1023 = 2
					data_a = 16'd1;		// PortA writes 1
					data_b = 16'd2;		// PortB writes 2
					addr_a = 10'd0;		// PortA write to address 0
					addr_b = 10'd1023;	// PortB write to address 1023
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S1:                      
				begin //read addr0 and addr1023
					data_a = 16'dx;		// // Don't care about data to PortA
					data_b = 16'dx;		// // Don't care about data to PortB
					addr_a = 10'd0;		// PortA read from address 0
					addr_b = 10'd1023;	// PortB read from address 1023
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S2:
				begin //addr0 = 2 addr1023 = 1
					data_a = 16'd2;		// PortA writes 2
					data_b = 16'd1;		// PortB writes 1
					addr_a = 10'd0;		// PortA write to address 0
					addr_b = 10'd1023;	// PortB write to address 1023
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S3:
				begin //read addr0 and addr1023
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd0;		// PortA read from address 0
					addr_b = 10'd1023;	// PortB read from address 1023
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S4:
				begin //addr1 = 3 addr1022 = 4
					data_a = 16'd3;		// PortA writes 3
					data_b = 16'd4;		// PortB writes 4
					addr_a = 10'd1;		// PortA write to address 1
					addr_b = 10'd1022;	// PortB write to address 1022
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S5:
				begin //read addr1 and addr1022
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd1;		// PortA read from address 1
					addr_b = 10'd1022;	// PortB read from address 1022
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S6:
				begin //addr1 = 4 addr1022 = 3
					data_a = 16'd4;		// PortA writes 4
					data_b = 16'd3;		// PortB writes 3
					addr_a = 10'd1;		// PortA write to address 1
					addr_b = 10'd1022;	// PortB write to address 1022
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S7:
				begin //read addr1 and addr1022
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd1;		// PortA read from address 1
					addr_b = 10'd1022;	// PortB read from address 1022
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S8:
				begin //addr2 = 5 addr1021 = 6
					data_a = 16'd5;		// PortA writes 5
					data_b = 16'd6;		// PortB writes 6
					addr_a = 10'd2;		// PortA write to address 2
					addr_b = 10'd1021;	// PortB write to address 1021
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S9:
				begin //read addr2 and addr1021
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd2;		// PortA read from address 2
					addr_b = 10'd1021;	// PortB read from address 1021
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S10:
				begin//addr2 = 6 addr1021 = 5
					data_a = 16'd6;		// PortA writes 6
					data_b = 16'd5;		// PortB writes 5
					addr_a = 10'd2;		// PortA write to address 2
					addr_b = 10'd1021;	// PortB write to address 1021
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S11:
				begin//read addr2 and addr1021
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd2;		// PortA read from address 2
					addr_b = 10'd1021;	// PortB read from address 1021
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S12:
				begin//addr720 = 5 addr20 = 10
					data_a = 16'd5;		// PortA writes 5
					data_b = 16'd10;		// PortB writes 10
					addr_a = 10'd720;		// PortA write to address 720
					addr_b = 10'd20;		// PortB write to address 20
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S13:
				begin//read addr720 and addr20
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd720;		// PortA read from address 720
					addr_b = 10'd20;		// PortB read from address 20
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			S14:
				begin//addr720 = 20 addr20 = 5
					data_a = 16'd10;		// PortA writes 10
					data_b = 16'd5;		// PortB writes 5
					addr_a = 10'd720;		// PortA write to address 720
					addr_b = 10'd20;		// PortB write to address 20
					we_a = 1;				// Block A Write enabled
					we_b = 1;				// Block B Write enabled
				end
			S15:
				begin//read addr720 and addr20
					data_a = 16'dx;		// Don't care about data to PortA
					data_b = 16'dx;		// Don't care about data to PortB
					addr_a = 10'd720;		// PortA read from address 720
					addr_b = 10'd20;		// PortB read from address 20
					we_a = 0;				// Block A Write disabled
					we_b = 0;				// Block B Write disabled
				end
			default:
				begin // Should never reach...
					data_a = 16'dx;
					data_b = 16'dx;
					addr_a = 10'dx;
					addr_b = 10'dx;
					we_a = 1'bx;
					we_b = 1'bx;
				end
		endcase
	
	end
	

endmodule
