module dpram_board_fsm(clk, reset, button_code, display_addr, display_out, dout_a, dout_b, addr_a, addr_b, din_a, din_b, wen_a, wen_b);
	input clk, reset;
	input [2:0] button_code;
	input [15:0] dout_a, dout_b;
	input [9:0] display_addr;
	
	output reg [9:0] addr_a, addr_b;
	output reg [15:0] din_a, din_b, display_out;
	output reg wen_a, wen_b;
	
	reg [5:0] cs, ns;
	
	parameter [5:0] SIDLE = 6'b11111, S0 = 6'd0, S1 = 6'd1, S2 = 6'd2, S3 = 6'd3, S4 = 6'd4, S5 = 6'd5, S6 = 6'd6,
				 S7 = 6'd7, S8 = 6'd8, S9 = 6'd9, S10 = 6'd10, S11 = 6'd11, S12 = 6'd12, S13 = 6'd13,
				 S14 = 6'd14, S15 = 6'd15, S16 = 6'd16, S17 = 6'd17, S18 = 6'd18, S19 = 6'd19, S20 = 6'd20,
				 S21 = 6'd21, S22 = 6'd22, S23 = 6'd23, S24 = 6'd24, S25 = 6'd25, S26 = 6'd26, S27 = 6'd27,
				 S28 = 6'd28, S29 = 6'd29, S30 = 6'd30, S31 = 6'd31, S32 = 6'd32, S33 = 6'd33, S34 = 6'd34,
				 S35 = 6'd35, S36 = 6'd36, S37 = 6'd37;
	

	// inner state controller
	always @(cs, display_addr, button_code) begin
		case (cs)
		SIDLE: begin
			addr_a <= display_addr;
			addr_b <= 10'dx;
			din_a <= 16'dx;
			din_b <= 16'dx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= dout_a;
			
			if (button_code[0] == 1'b1)
				ns <= S0;
			else if (button_code[1] == 1'b1)
				ns <= S7;
			else if (button_code[2] == 1'b1)
				ns <= S32;
			else
				ns <= SIDLE;
		end
		
		// loads data
		S0: begin
			addr_a <= 10'dx;
			addr_b <= 10'dx;
			din_a <= 16'dx;
			din_b <= 16'dx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'd0;
			if (button_code[0] == 1'b1)
				ns <= S0;
			else
				ns <= S1;
		end
		S1: begin
			addr_a <= 10'd0;
			addr_b <= 10'd1;
			din_a <= 16'd0;
			din_b <= 16'd1;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= S2;
		end
		S2: begin
			addr_a <= 10'd2;
			addr_b <= 10'd3;
			din_a <= 16'd2;
			din_b <= 16'd3;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= S3;
		end
		S3: begin
			addr_a <= 10'd4;
			addr_b <= 10'd5;
			din_a <= 16'd4;
			din_b <= 16'd5;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= S4;
		end
		S4: begin
			addr_a <= 10'd504;
			addr_b <= 10'd505;
			din_a <= 16'd504;
			din_b <= 16'd505;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= S5;
		end
		S5: begin
			addr_a <= 10'd506;
			addr_b <= 10'd507;
			din_a <= 16'd506;
			din_b <= 16'd507;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= S6;
		end
		S6: begin
			addr_a <= 10'd508;
			addr_b <= 10'd509;
			din_a <= 16'd508;
			din_b <= 16'd509;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= SIDLE;
		end
		
		
		// adds one to everything 
		S7: begin
			addr_a <= 10'dx;
			addr_b <= 10'dx;
			din_a <= 16'dx;
			din_b <= 16'dx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'd0;
			if (button_code[1] == 1'b1)
				ns <= S7;
			else
				ns <= S8;
		end
		S8: begin
			addr_a <= 10'd0;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S9;
		end
		S9: begin
			addr_a <= 10'd0;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S10;
		end
		S10: begin
			addr_a <= 10'd1;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S11;
		end
		S11: begin
			addr_a <= 10'd1;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S12;
		end
		S12: begin
			addr_a <= 10'd2;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S13;
		end
		S13: begin
			addr_a <= 10'd2;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S14;
		end
		S14: begin
			addr_a <= 10'd3;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S15;
		end
		S15: begin
			addr_a <= 10'd3;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S16;
		end
		S16: begin
			addr_a <= 10'd4;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S17;
		end
		S17: begin
			addr_a <= 10'd4;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S18;
		end
		S18: begin
			addr_a <= 10'd5;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S19;
		end
		S19: begin
			addr_a <= 10'd5;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S20;
		end
		S20: begin
			addr_a <= 10'd504;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S21;
		end
		S21: begin
			addr_a <= 10'd504;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S22;
		end
		S22: begin
			addr_a <= 10'd505;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S23;
		end
		S23: begin
			addr_a <= 10'd505;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S24;
		end
		S24: begin
			addr_a <= 10'd506;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S25;
		end
		S25: begin
			addr_a <= 10'd506;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S26;
		end
		S26: begin
			addr_a <= 10'd507;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S27;
		end
		S27: begin
			addr_a <= 10'd507;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S28;
		end
		S28: begin
			addr_a <= 10'd508;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S29;
		end
		S29: begin
			addr_a <= 10'd508;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S30;
		end
		S30: begin
			addr_a <= 10'd509;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S31;
		end
		S31: begin
			addr_a <= 10'd509;
			addr_b <= 10'bx;
			din_a <= dout_a + 1;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= SIDLE;
		end
		
		
		// fibonacci
		S32: begin
			addr_a <= 10'dx;
			addr_b <= 10'dx;
			din_a <= 16'dx;
			din_b <= 16'dx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'd0;
			if (button_code[2] == 1'b1)
				ns <= S32;
			else
				ns <= S33;
		end
		S33: begin
			addr_a <= 10'd0;
			addr_b <= 10'd1;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S34;
		end
		S34: begin
			addr_a <= 10'd2;
			addr_b <= 10'bx;
			din_a <= dout_a + dout_b;
			din_b <= 16'bx;
			wen_a <= 1'b1;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S35;
		end
		S35: begin
			addr_a <= 10'd1;
			addr_b <= 10'd2;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= S36;
		end
		S36: begin
			addr_a <= 10'd0;
			addr_b <= 10'd1;
			din_a <= dout_a;
			din_b <= dout_b;
			wen_a <= 1'b1;
			wen_b <= 1'b1;
			display_out <= 16'b0;
			ns <= S37;
		end
		S37: begin
			addr_a <= 10'dx;
			addr_b <= 10'dx;
			din_a <= 16'dx;
			din_b <= 16'dx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= SIDLE;
		end
		
		
		default: begin
			addr_a <= 10'bx;
			addr_b <= 10'bx;
			din_a <= 16'bx;
			din_b <= 16'bx;
			wen_a <= 1'b0;
			wen_b <= 1'b0;
			display_out <= 16'b0;
			ns <= SIDLE;
		end				
		endcase
	end
	
	
	// update current state
	always @(posedge clk, posedge reset)
		if (reset == 1'b1)
			cs <= SIDLE;
		else
			cs <= ns;	
endmodule
