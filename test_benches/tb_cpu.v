`timescale 1ns / 1ps

module tb_cpu();
	parameter verbose = 0;

	reg clk, reset;
	wire WE;
	wire [4:0] flags;
	wire [15:0] r1;
	wire [15:0] addr;
	reg [15:0] data_out;
	wire [15:0] data_in;

	reg [15:0] ram [65535:0];
	
	always @(posedge clk)
		if (WE) begin
			ram[addr] <= data_in;
			data_out <= data_in;
		end else
			data_out <= ram[addr];

	CPU #(.overrideRAM(1)) uut(
		.clk(clk),
		.reset(reset),
		.flagLEDs(flags),
		.r1(r1),
		.write_en(WE),
		.addr(addr),
		.data_out(data_out),
		.data_in(data_in)
	);
	
	task cycle_reset;
		begin
			reset = 1;
			#10;
			reset = 0;
			#20;
		end
	endtask
	
	initial begin
		ram[16'hF000] = {4'h0, 12'd100};	// 1 fret
		ram[16'hF001] = {4'h4, 12'd500};	// 2 fret
		ram[16'hF002] = {4'h4, 12'd500};	// 3 fret
		ram[16'hF003] = {4'h4, 12'd500};	// 4 fret
		ram[16'hF004] = {4'h0, 12'd500};	// 5 fret
		ram[16'hF005] = {4'h1, 12'd500};	// 6 fret
		ram[16'hF006] = {4'h2, 12'd500};	// 7 fret
		ram[16'hF007] = {4'h3, 12'd500};	// 8 fret
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
		// Note that most commands currently takes 3 clock cycles to execute. 
		// Load and store each take 4 clock cycles
		$display("Testbench begins...\n");
		clk = 0;
		reset = 1;
		#13
		reset = 0;
		#20;
		
//		$readmemb("../../mem_files/rshi-test.b", ram);
//		#1000;

//		if (verbose) $display("loading initialize.b");
//		$readmemb("../../mem_files/initialize.b", ram);
//		#510;
//		if (r1 != 0) $display("Error in initialize! Expected 0, but got %d\n", r1);
//		if (verbose) $display("Initialize resulted in: %d\n", r1);
//		
//		if (verbose) $display("loading fibonacci.b");
//		$readmemb("../../mem_files/fibonacci.b", ram);
//		cycle_reset();
//		#460;
//		
//		if (r1 != 233) $display("Error executing Fibonacci! Expected 233, but got %d\n", r1);
//		if (verbose) $display("Fibonacci resulted in: %d\n", r1);
//		
//		if (verbose) $display("loading comparisons.b");
//		$readmemb("../../mem_files/comparisons.b", ram);
//		cycle_reset();
//		#160;
//		
//		if (flags != 5'b10000) $display("Error in comparison! Expected flags to be 10000 but got %b\n", flags);
//		if (verbose) $display("First comparison resulted in flags: %b\n", flags);
//		
//		#60;
//		
//		if (flags != 5'b00000) $display("Error in comparison! Expected flags to be 00000 but got %b\n", flags);
//		if (verbose) $display("Second comparison resulted in flags: %b\n", flags);
//		
//		#60;
//		
//		if (r1 != 16'd8) $display("Error in comparison! Expected r1 to be 8 but got %d\n", r1);
//		if (verbose) $display("Left shift resulted in %d\n", r1);
//		
//		#60;
//		
//		if (flags != 5'b00011) $display("Error in comparison! Expected flags to be 00011 but got %b\n", flags);
//		if (verbose) $display("Third comparison resulted in flags: %b\n", flags);
//		
//		#60;
//		
//		if (r1 != 16'd2) $display("Error in comparison! Expected r1 to be 2 but got %d\n", r1);
//		if (verbose) $display("Right shift resulted in %d\n", r1);
//		
		if (verbose) $display("loading load-store.b\n");
		$readmemb("../../mem_files/load-store.b", ram);
		cycle_reset();
		#540;
		
		if (r1 != 100) $display("Error executing load-store! Expected 100, but got %d\n", r1);
		if (verbose) $display("load-store resulted in %d\n", r1);
		
//		if (verbose) $display("loading basic-jump.b\n");
//		$readmemb("../../mem_files/basic-jump.b", ram);
//		cycle_reset();
//		#460;
//				
//		if (r1 != 60) $display("Error in basic jump! Expected 60 but got %d\n", r1);
//		if (verbose) $display("basic-jump resulted in %d\n", r1);
//		
//		if (verbose) $display("loading jump-cond.b\n");
//		$readmemb("../../mem_files/jump-cond.b", ram);
//		cycle_reset();
//		#5000;
//		
//		if (r1 != 987) $display("Error in conditional jump! Expected 987 but got %d\n", r1);
//		if (verbose) $display("Jump conditional resulted in %d\n", r1);
//		
//		if (verbose) $display("loading gameInput.b\n");
//		$readmemb("../../mem_files/gameInput.b", ram);
//		cycle_reset();
//		#570;
//		
//		if (r1 != 16'b0000000101010101) $display("Error in game input! Expected 0000000101010101 but got %b\n", r1);
//		if (verbose) $display("Game input resulted in %b\n", r1);

		
		$display("Testbench ends\n");
	end
	
	always 
		#5 clk <= ~clk;
endmodule
