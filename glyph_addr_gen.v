module glyph_addr_gen 
#(parameter GLYPH_DATA_WIDTH=24, SYS_DATA_WIDTH=18, 
				SYS_ADDR_WIDTH=16, GLYPH_ADDR_WIDTH=16,
				LOG2_DISPLAY_WIDTH=10, LOG2_DISPLAY_HEIGHT=10)
(
	input clk, reset, bright, vsync, hsync, 
	input [9:0] hcount, vcount,
	input [(SYS_DATA_WIDTH-1):0] sys_data,
	output reg [(GLYPH_ADDR_WIDTH-1):0] glyph_addr,
	output reg [(SYS_ADDR_WIDTH-1):0] sys_addr,
	output reg [23:0] bg_color,
	output reg pix_en
);


localparam BG_COLOR = 24'h505050;


// multiple fetches if multiple data needed
localparam FETCH0 = 8'h00, FETCH1 = 8'h01, FETCH2 = 8'h02, FETCH3 = 8'h03;
localparam FETCH4 = 8'h04, FETCH5 = 8'h05, FETCH6 = 8'h06, FETCH7 = 8'h07;
localparam FETCH8 = 8'h08, FETCH9 = 8'h09, FETCH10 = 8'h0A, FETCH11 = 8'h0B;
localparam FETCH12 = 8'h0C, FETCH13 = 8'h0D, FETCH14 = 8'h0E, FETCH15 = 8'h0F;
localparam FETCH16 = 8'h10, FETCH17 = 8'h11, FETCH18 = 8'h12, FETCH19 = 8'h13, FETCH20 = 8'h14;
localparam FETCH_PIXEL = 8'hFF;

reg [7:0] PS, NS;


// recall x_start = 158 = H_BACK_PORCH + H_SYNC + H_FRONT_PORCH
// 		 x_end   = 745 = H_TOTAL - H_BACK_PORCH
//        y_start = 0
//        y_end   = 480 = V_DISPLAY_INT
wire [(LOG2_DISPLAY_WIDTH-1):0] x_pos;
wire [(LOG2_DISPLAY_HEIGHT-1):0] y_pos;
assign x_pos = hcount - 10'd158;
assign y_pos = vcount;


// store values fetched to process and use through framerate
reg fret_en, fret2_en, fret3_en, fret4_en, fret5_en, fret6_en;
reg fret7_en, fret8_en, fret9_en, fret10_en, fret11_en, fret12_en;
reg fret13_en, fret14_en, fret15_en, fret16_en, fret17_en, fret18_en;
reg fret19_en, fret20_en;
reg [(SYS_DATA_WIDTH-1):0] fret_x_pos, fret2_x_pos, fret3_x_pos, fret4_x_pos, fret5_x_pos;
reg [(SYS_DATA_WIDTH-1):0] fret6_x_pos, fret7_x_pos, fret8_x_pos, fret9_x_pos, fret10_x_pos;
reg [(SYS_DATA_WIDTH-1):0] fret11_x_pos, fret12_x_pos, fret13_x_pos, fret14_x_pos, fret15_x_pos;
reg [(SYS_DATA_WIDTH-1):0] fret16_x_pos, fret17_x_pos, fret18_x_pos, fret19_x_pos, fret20_x_pos;
wire [(SYS_DATA_WIDTH-1):0] fret_addr, fret2_addr, fret3_addr, fret4_addr, fret5_addr;
wire [(SYS_DATA_WIDTH-1):0] fret6_addr, fret7_addr, fret8_addr, fret9_addr, fret10_addr;
wire [(SYS_DATA_WIDTH-1):0] fret11_addr, fret12_addr, fret13_addr, fret14_addr, fret15_addr;
wire [(SYS_DATA_WIDTH-1):0] fret16_addr, fret17_addr, fret18_addr, fret19_addr, fret20_addr;

register #(SYS_DATA_WIDTH) fret_reg (clk, reset, fret_en, sys_data, fret_addr);
register #(SYS_DATA_WIDTH) fret2_reg (clk, reset, fret2_en, sys_data, fret2_addr);
register #(SYS_DATA_WIDTH) fret3_reg (clk, reset, fret3_en, sys_data, fret3_addr);
register #(SYS_DATA_WIDTH) fret4_reg (clk, reset, fret4_en, sys_data, fret4_addr);
register #(SYS_DATA_WIDTH) fret5_reg (clk, reset, fret5_en, sys_data, fret5_addr);
register #(SYS_DATA_WIDTH) fret6_reg (clk, reset, fret6_en, sys_data, fret6_addr);
register #(SYS_DATA_WIDTH) fret7_reg (clk, reset, fret7_en, sys_data, fret7_addr);
register #(SYS_DATA_WIDTH) fret8_reg (clk, reset, fret8_en, sys_data, fret8_addr);
register #(SYS_DATA_WIDTH) fret9_reg (clk, reset, fret9_en, sys_data, fret9_addr);
register #(SYS_DATA_WIDTH) fret10_reg (clk, reset, fret10_en, sys_data, fret10_addr);
register #(SYS_DATA_WIDTH) fret11_reg (clk, reset, fret11_en, sys_data, fret11_addr);
register #(SYS_DATA_WIDTH) fret12_reg (clk, reset, fret12_en, sys_data, fret12_addr);
register #(SYS_DATA_WIDTH) fret13_reg (clk, reset, fret13_en, sys_data, fret13_addr);
register #(SYS_DATA_WIDTH) fret14_reg (clk, reset, fret14_en, sys_data, fret14_addr);
register #(SYS_DATA_WIDTH) fret15_reg (clk, reset, fret15_en, sys_data, fret15_addr);
register #(SYS_DATA_WIDTH) fret16_reg (clk, reset, fret16_en, sys_data, fret16_addr);
register #(SYS_DATA_WIDTH) fret17_reg (clk, reset, fret17_en, sys_data, fret17_addr);
register #(SYS_DATA_WIDTH) fret18_reg (clk, reset, fret18_en, sys_data, fret18_addr);
register #(SYS_DATA_WIDTH) fret19_reg (clk, reset, fret19_en, sys_data, fret19_addr);
register #(SYS_DATA_WIDTH) fret20_reg (clk, reset, fret20_en, sys_data, fret20_addr);

wire [(LOG2_DISPLAY_WIDTH-1):0] fret_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret2_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret2_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret3_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret3_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret4_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret4_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret5_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret5_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret6_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret6_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret7_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret7_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret8_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret8_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret9_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret9_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret10_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret10_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret11_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret11_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret12_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret12_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret13_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret13_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret14_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret14_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret15_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret15_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret16_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret16_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret17_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret17_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret18_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret18_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret19_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret19_y_off;
wire [(LOG2_DISPLAY_WIDTH-1):0] fret20_x_off;
wire [(LOG2_DISPLAY_HEIGHT-1):0] fret20_y_off;

task mPos;
input [3:0] M_POS;
output [(SYS_DATA_WIDTH-1):0] X_POS;
begin
   if (M_POS == 4'h0)
		X_POS = 200;
		
	else if (M_POS == 4'h1)
		X_POS = 250;
		
	else if (M_POS == 4'h2)
		X_POS = 300;
		
	else if (M_POS == 4'h3)
		X_POS = 350;
		
	else if (M_POS == 4'h4)
		X_POS = 400;
		
	else
		X_POS = 200;
end
endtask

assign fret_x_off = x_pos - fret_x_pos;
assign fret_y_off = y_pos - fret_addr[11:0];
assign fret2_x_off = x_pos - fret2_x_pos;
assign fret2_y_off = y_pos - fret2_addr[11:0];
assign fret3_x_off = x_pos - fret3_x_pos;
assign fret3_y_off = y_pos - fret3_addr[11:0];
assign fret4_x_off = x_pos - fret4_x_pos;
assign fret4_y_off = y_pos - fret4_addr[11:0];
assign fret5_x_off = x_pos - fret5_x_pos;
assign fret5_y_off = y_pos - fret5_addr[11:0];
assign fret6_x_off = x_pos - fret6_x_pos;
assign fret6_y_off = y_pos - fret6_addr[11:0];
assign fret7_x_off = x_pos - fret7_x_pos;
assign fret7_y_off = y_pos - fret7_addr[11:0];
assign fret8_x_off = x_pos - fret8_x_pos;
assign fret8_y_off = y_pos - fret8_addr[11:0];
assign fret9_x_off = x_pos - fret9_x_pos;
assign fret9_y_off = y_pos - fret9_addr[11:0];
assign fret10_x_off = x_pos - fret10_x_pos;
assign fret10_y_off = y_pos - fret10_addr[11:0];
assign fret11_x_off = x_pos - fret11_x_pos;
assign fret11_y_off = y_pos - fret11_addr[11:0];
assign fret12_x_off = x_pos - fret12_x_pos;
assign fret12_y_off = y_pos - fret12_addr[11:0];
assign fret13_x_off = x_pos - fret13_x_pos;
assign fret13_y_off = y_pos - fret13_addr[11:0];
assign fret14_x_off = x_pos - fret14_x_pos;
assign fret14_y_off = y_pos - fret14_addr[11:0];
assign fret15_x_off = x_pos - fret15_x_pos;
assign fret15_y_off = y_pos - fret15_addr[11:0];
assign fret16_x_off = x_pos - fret16_x_pos;
assign fret16_y_off = y_pos - fret16_addr[11:0];
assign fret17_x_off = x_pos - fret17_x_pos;
assign fret17_y_off = y_pos - fret17_addr[11:0];
assign fret18_x_off = x_pos - fret18_x_pos;
assign fret18_y_off = y_pos - fret18_addr[11:0];
assign fret19_x_off = x_pos - fret19_x_pos;
assign fret19_y_off = y_pos - fret19_addr[11:0];
assign fret20_x_off = x_pos - fret20_x_pos;
assign fret20_y_off = y_pos - fret20_addr[11:0];

localparam FRET_GLYPH_WIDTH = 50;
localparam FRET_GLYPH_HEIGHT = 28;
localparam FRET_GLYPH_SIZE = 1400;	// MARIO_GLYPH_WIDTH * MARIO_GLYPH_HEIGHT


always @(posedge clk) begin
	if (reset) PS <= FETCH0;
	else if (!vsync) PS <= FETCH0;
	else PS <= NS;
end


always @* begin
	
	sys_addr = 'hx;
	glyph_addr = 'hx;
	fret_en = 0;
	fret2_en = 0;
	fret3_en = 0;
	fret4_en = 0;
	fret5_en = 0;
	fret6_en = 0;
	fret7_en = 0;
	fret8_en = 0;
	fret9_en = 0;
	fret10_en = 0;
	fret11_en = 0;
	fret12_en = 0;
	fret13_en = 0;
	fret14_en = 0;
	fret15_en = 0;
	fret16_en = 0;
	fret17_en = 0;
	fret18_en = 0;
	fret19_en = 0;
	fret20_en = 0;
	pix_en = 0;
	bg_color = BG_COLOR;
	
	mPos (fret_addr[15:12], fret_x_pos);
	mPos (fret2_addr[15:12], fret2_x_pos);
	mPos (fret3_addr[15:12], fret3_x_pos);
	mPos (fret4_addr[15:12], fret4_x_pos);
	mPos (fret5_addr[15:12], fret5_x_pos);
	mPos (fret6_addr[15:12], fret6_x_pos);
	mPos (fret7_addr[15:12], fret7_x_pos);
	mPos (fret8_addr[15:12], fret8_x_pos);
	mPos (fret9_addr[15:12], fret9_x_pos);
	mPos (fret10_addr[15:12], fret10_x_pos);
	mPos (fret11_addr[15:12], fret11_x_pos);
	mPos (fret12_addr[15:12], fret12_x_pos);
	mPos (fret13_addr[15:12], fret13_x_pos);
	mPos (fret14_addr[15:12], fret14_x_pos);
	mPos (fret15_addr[15:12], fret15_x_pos);
	mPos (fret16_addr[15:12], fret16_x_pos);
	mPos (fret17_addr[15:12], fret17_x_pos);
	mPos (fret18_addr[15:12], fret18_x_pos);
	mPos (fret19_addr[15:12], fret19_x_pos);
	mPos (fret20_addr[15:12], fret20_x_pos);
	
	case (PS)
	
		// fetch memory needed ( try and store in as few memory locations possible )
		
		// save stage happens in next FETCH because it you send address and takes
		// 1 cycle for RAM to output value
		
		// fetch mario x-position
		FETCH0: begin
			sys_addr = 'hF000;
			NS = FETCH1;
		end
		
		FETCH1: begin
			fret_en = 1'b1;
			sys_addr = 'hF001;
			NS = FETCH2;
		end
		
		FETCH2: begin
			fret2_en = 1'b1;
			sys_addr = 'hF002;
			NS = FETCH3;
		end
		
		FETCH3: begin
			fret3_en = 1'b1;
			sys_addr = 'hF003;
			NS = FETCH4;
		end
		
		FETCH4: begin
			fret4_en = 1'b1;
			sys_addr = 'hF004;
			NS = FETCH5;
		end
		
		FETCH5: begin
			fret5_en = 1'b1;
			sys_addr = 'hF005;
			NS = FETCH6;
		end
		
		FETCH6: begin
			fret6_en = 1'b1;
			sys_addr = 'hF006;
			NS = FETCH7;
		end
		
		FETCH7: begin
			fret7_en = 1'b1;
			sys_addr = 'hF007;
			NS = FETCH8;
		end
		
		FETCH8: begin
			fret8_en = 1'b1;
			sys_addr = 'hF008;
			NS = FETCH9;
		end
		
		FETCH9: begin
			fret9_en = 1'b1;
			sys_addr = 'hF009;
			NS = FETCH10;
		end
		
		FETCH10: begin
			fret10_en = 1'b1;
			sys_addr = 'hF00A;
			NS = FETCH11;
		end
		
		FETCH11: begin
			fret11_en = 1'b1;
			sys_addr = 'hF00B;
			NS = FETCH12;
		end
		
		FETCH12: begin
			fret12_en = 1'b1;
			sys_addr = 'hF00C;
			NS = FETCH13;
		end
		
		FETCH13: begin
			fret13_en = 1'b1;
			sys_addr = 'hF00D;
			NS = FETCH14;
		end
		
		FETCH14: begin
			fret14_en = 1'b1;
			sys_addr = 'hF00E;
			NS = FETCH15;
		end
		
		FETCH15: begin
			fret15_en = 1'b1;
			sys_addr = 'hF00F;
			NS = FETCH16;
		end
		
		FETCH16: begin
			fret16_en = 1'b1;
			sys_addr = 'hF010;
			NS = FETCH17;
		end
		
		FETCH17: begin
			fret17_en = 1'b1;
			sys_addr = 'hF011;
			NS = FETCH18;
		end
		
		FETCH18: begin
			fret18_en = 1'b1;
			sys_addr = 'hF012;
			NS = FETCH19;
		end
		
		FETCH19: begin
			fret19_en = 1'b1;
			sys_addr = 'hF013;
			NS = FETCH20;
		end
		
		FETCH20: begin
			fret20_en = 1'b1;
			NS = FETCH_PIXEL;
		end
		
		
		// fetch specific pixel based on position
		FETCH_PIXEL: begin
			
			if (x_pos >= fret_x_pos &&
				 x_pos < (fret_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret_addr[11:0] && 
				 y_pos < (fret_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret2_x_pos &&
				 x_pos < (fret2_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret2_addr[11:0] && 
				 y_pos < (fret2_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret2_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret2_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret2_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret3_x_pos &&
				 x_pos < (fret3_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret3_addr[11:0] && 
				 y_pos < (fret3_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret3_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret3_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret3_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret4_x_pos &&
				 x_pos < (fret4_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret4_addr[11:0] && 
				 y_pos < (fret4_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret4_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret4_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret4_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret5_x_pos &&
				 x_pos < (fret5_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret5_addr[11:0] && 
				 y_pos < (fret5_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret5_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret5_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret5_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret6_x_pos &&
				 x_pos < (fret6_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret6_addr[11:0] && 
				 y_pos < (fret6_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret6_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret6_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret6_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret7_x_pos &&
				 x_pos < (fret7_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret7_addr[11:0] && 
				 y_pos < (fret7_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret7_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret7_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret7_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret8_x_pos &&
				 x_pos < (fret8_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret8_addr[11:0] && 
				 y_pos < (fret8_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret8_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret8_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret8_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret9_x_pos &&
				 x_pos < (fret9_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret9_addr[11:0] && 
				 y_pos < (fret9_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret9_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret9_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret9_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret10_x_pos &&
				 x_pos < (fret10_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret10_addr[11:0] && 
				 y_pos < (fret10_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret10_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret10_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret10_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret11_x_pos &&
				 x_pos < (fret11_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret11_addr[11:0] && 
				 y_pos < (fret11_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret11_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret11_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret11_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret12_x_pos &&
				 x_pos < (fret12_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret12_addr[11:0] && 
				 y_pos < (fret12_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret12_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret12_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret12_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret13_x_pos &&
				 x_pos < (fret13_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret13_addr[11:0] && 
				 y_pos < (fret13_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret13_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret13_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret13_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret14_x_pos &&
				 x_pos < (fret14_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret14_addr[11:0] && 
				 y_pos < (fret14_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret14_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret14_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret14_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret15_x_pos &&
				 x_pos < (fret15_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret15_addr[11:0] && 
				 y_pos < (fret15_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret15_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret15_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret15_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret16_x_pos &&
				 x_pos < (fret16_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret16_addr[11:0] && 
				 y_pos < (fret16_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret16_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret16_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret16_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret17_x_pos &&
				 x_pos < (fret17_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret17_addr[11:0] && 
				 y_pos < (fret17_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret17_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret17_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret17_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret18_x_pos &&
				 x_pos < (fret18_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret18_addr[11:0] && 
				 y_pos < (fret18_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret18_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret18_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret18_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret19_x_pos &&
				 x_pos < (fret19_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret19_addr[11:0] && 
				 y_pos < (fret19_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret19_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret19_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret19_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= fret20_x_pos &&
				 x_pos < (fret20_x_pos + FRET_GLYPH_WIDTH) &&
				 y_pos >= fret20_addr[11:0] && 
				 y_pos < (fret20_addr[11:0] + FRET_GLYPH_HEIGHT)) begin
				glyph_addr = (fret20_addr[15:12] * FRET_GLYPH_SIZE) + 	// base address
								 (fret20_y_off * FRET_GLYPH_WIDTH) +	// y-offset
								  fret20_x_off;									// x-offset
				pix_en = 1'b1;
			end
			
			else if (x_pos >= 200 &&
						x_pos < 250 &&
						y_pos >= 400 && 
						y_pos < 428) begin
						glyph_addr = (0 * FRET_GLYPH_SIZE) + 	// base address
										 ((y_pos - 400) * FRET_GLYPH_WIDTH) +	// y-offset
										  (x_pos - 200);	
				pix_en = 1'b1;
			end
			
			else if (x_pos >= 250 &&
						x_pos < 300 &&
						y_pos >= 400 && 
						y_pos < 428) begin
						glyph_addr = (1 * FRET_GLYPH_SIZE) + 	// base address
										 ((y_pos - 400) * FRET_GLYPH_WIDTH) +	// y-offset
										  (x_pos - 250);	
				pix_en = 1'b1;
			end
			
			else if (x_pos >= 300 &&
						x_pos < 350 &&
						y_pos >= 400 && 
						y_pos < 428) begin
						glyph_addr = (2 * FRET_GLYPH_SIZE) + 	// base address
										 ((y_pos - 400) * FRET_GLYPH_WIDTH) +	// y-offset
										  (x_pos - 300);	
				pix_en = 1'b1;
			end
			
			else if (x_pos >= 350 &&
						x_pos < 400 &&
						y_pos >= 400 && 
						y_pos < 428) begin
						glyph_addr = (3 * FRET_GLYPH_SIZE) + 	// base address
										 ((y_pos - 400) * FRET_GLYPH_WIDTH) +	// y-offset
										  (x_pos - 350);	
				pix_en = 1'b1;
			end
			
			else if (x_pos >= 400 &&
						x_pos < 450 &&
						y_pos >= 400 && 
						y_pos < 428) begin
						glyph_addr = (4 * FRET_GLYPH_SIZE) + 	// base address
										 ((y_pos - 400) * FRET_GLYPH_WIDTH) +	// y-offset
										  (x_pos - 400);	
				pix_en = 1'b1;
			end

			else if (x_pos >= 200 &&
						x_pos < 450 &&
						y_pos >= 0 && 
						y_pos < 480) begin
						glyph_addr = (5 * FRET_GLYPH_SIZE);
				pix_en = 1'b1;
			end
	
			NS = FETCH_PIXEL;
		end
	
	endcase 
	
end

endmodule
