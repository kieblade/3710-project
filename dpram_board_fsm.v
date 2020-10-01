module dpram_board_fsm(clk, reset, button_code, dout_a, dout_b, addr_a, addr_b, din_a, din_b, wen_a, wen_b);
	input clk, reset;
	input [3:0] button_code;
	input [15:0] dout_a, dout_b;
	
	output reg [9:0] addr_a, addr_b;
	output reg [15:0] din_a, din_b;
	output reg wen_a, wen_b;
	
	reg [2:0] outer_state;
	reg [4:0] cs, ns;
	reg done = 1'b0;
	
	parameter [2:0] SIDLE = 3'b000, S1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;
	parameter IS0 = 5'd0, IS1 = 5'd1, IS2 = 5'd2, IS3 = 5'd3, IS4 = 5'd4, IS5 = 5'd5, IS6 = 5'd6,
				 IS7 = 5'd7, IS8 = 5'd8, IS9 = 5'd9, IS10 = 5'd10, IS11 = 5'd11, IS12 = 5'd12, IS13 = 5'd13,
				 IS14 = 5'd14, IS15 = 5'd15, IS16 = 5'd16, IS17 = 5'd17, IS18 = 5'd18, IS19 = 5'd19, IS20 = 5'd20,
				 IS21 = 5'd21;
	
	// outer state controller
	always @(posedge done, button_code) begin
		if (done == 1'b1) begin
			done <= 1'b0;
			outer_state = SIDLE;
		end else begin
			// just limits it to only valid codes
			case (button_code)
				SIDLE, S1, S2, S3, S4:
					outer_state <= button_code;
				default:
					outer_state <= SIDLE;
			endcase
		end
	end
	
	// inner state controller
	always @(cs) begin
		case (outer_state):
			SIDLE:
				
			S1:
				// iterate and add, single port
				// sequence of read and write back
				case (cs):
				IS0:
					addr_a = 10'd0;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS1;
				IS1:
					addr_a = 10'd0;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'bx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS2;
				IS2:
					addr_a = 10'd1;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS3;
				IS3:
					addr_a = 10'd1;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_out = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS4;
				IS4:
					addr_a = 10'd2;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS5;
				IS5:
					addr_a = 10'd2;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS6;
				IS6:
					addr_a = 10'd3;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS7;
				IS7:
					addr_a = 10'd3;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS8;
				IS8:
					addr_a = 10'd4;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS9;
				IS9:
					addr_a = 10'd4;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS10;
				IS10:
					addr_a = 10'd5;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS11;
				IS11:
					addr_a = 10'd5;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS12;
				IS12:
					addr_a = 10'd6;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS13;
				IS13:
					addr_a = 10'd6;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS14;
				IS14:
					addr_a = 10'd7;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS15;
				IS15:
					addr_a = 10'd7;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS16;
				IS16:
					addr_a = 10'd8;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS17;
				IS17:
					addr_a = 10'd8;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS18;
				IS18:
					addr_a = 10'd9;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS19;
				IS19:
					addr_a = 10'd9;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'dx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS20;
				IS20:
					addr_a = 10'd10;
					addr_b = 10'dx;
					din_a = 16'dx;
					din_b = 16'dx;
					wen_a = 1'b0;
					wen_b = 1'b0;
					done = 1'b0;
					ns = IS21;
				IS21;
					addr_a = 10'd10;
					addr_b = 10'dx;
					din_a = dout_a + 1;
					din_b = 16'bx;
					wen_a = 1'b1;
					wen_b = 1'b0;
					done = 1'b1;
					ns = IS0;
				endcase
			S2:
			S3:
			S4:
			default:
		endcase
	end
	
	
	// update current state
	always @(posedge clk, reset)
		if (reset == 1'b1)
			outer_stater <= SIDLE;
		else
			cs <= ns;
endmodule
