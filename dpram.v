// REPRESENTS A TRUE DUAL-PORT BLOCK RAM WITH 16-BIT WORDS, 512-WORD BLOCKS, & 2 BLOCKS (2KB OF MEMORY)

module dpram (
	input clk, en_A, en_B,
	input [15:0] addr_A, addr_B, 
	input [15:0] data_A, data_B,
	output reg [15:0] out_A, out_B
);
	// RAM variable is a 2D array of 1,024 16-bit words.
	reg [15:0] ram [65535:0];
	
	initial
	begin
		$readmemb("./mem_files/vga-test.b", ram);
		// Assuming data memory starts at 16'h1000
		ram[16'hF000] = {4'h0, 12'd0};	// 1 fret
		ram[16'hF001] = {4'h1, 12'd100};	// 2 fret
		ram[16'hF002] = {4'h2, 12'd0};	// 3 fret
		ram[16'hF003] = {4'h3, 12'd100};	// 4 fret
		ram[16'hF004] = {4'h4, 12'd0};	// 5 fret
		ram[16'hF005] = {4'h0, 12'd500};	// 6 fret
		ram[16'hF006] = {4'h0, 12'd500};	// 7 fret
		ram[16'hF007] = {4'h0, 12'd500};	// 8 fret
		ram[16'hF008] = {4'h0, 12'd500};	// 9 fret
		ram[16'hF009] = {4'h0, 12'd500};	// 10 fret
		ram[16'hF00A] = {4'h0, 12'd500};	// 11 fret
		ram[16'hF00B] = {4'h0, 12'd500};	// 12 fret
		ram[16'hF00C] = {4'h0, 12'd500};	// 13 fret
		ram[16'hF00D] = {4'h0, 12'd500};	// 14 fret
		ram[16'hF00E] = {4'h0, 12'd500};	// 15 fret
		ram[16'hF00F] = {4'h0, 12'd500};	// 16 fret
		ram[16'hF010] = {4'h0, 12'd500};	// 17 fret
		ram[16'hF011] = {4'h0, 12'd500};	// 18 fret
		ram[16'hF012] = {4'h0, 12'd500};	// 19 fret
		ram[16'hF013] = {4'h0, 12'd500};	// 20 fret
	end
	
	// Port A
	always @(posedge clk) begin
		if (en_A) begin
			ram[addr_A] <= data_A;
			out_A <= data_A;
		end
		else begin
			out_A <= ram[addr_A];
		end
	end
	
	// Port B
	always @(posedge clk) begin
		if (en_B) begin
			ram[addr_B] <= data_B;
			out_B <= data_B;
		end
		else begin
			out_B <= ram[addr_B];
		end
	end
endmodule
