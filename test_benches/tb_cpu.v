`timescale 1ns / 1ps

module tb_cpu();
	parameter verbose = 1;

	reg clk, reset;
	wire WE;
	wire [4:0] flags;
	wire [15:0] r1;
	wire [9:0] addr;
	reg [15:0] data_out;
	wire [15:0] data_in;
	
	reg [15:0] ram [1023:0];
	
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
		// Note that each command currently takes 3 clock cycles to execute. 
		// In order to get appropriate wait time take (lines in .b file) * 30
		// to calculate the minimum time to wait.
		$display("Testbench begins...\n");
		clk = 0;
		reset = 1;
		#13
		reset = 0;
		#20;
		if (verbose) $display("loading initialize.b");
		$readmemb("../../mem_files/initialize.b", ram);
		#510;
		if (r1 != 0) $display("Error in initialize! Expected 0, but got %d\n", r1);
		if (verbose) $display("Initialize resulted in: %d\n", r1);
		
		if (verbose) $display("loading fibonacci.b");
		$readmemb("../../mem_files/fibonacci.b", ram);
		cycle_reset();
		#450;
		
		if (r1 != 233) $display("Error executing Fibonacci! Expected 233, but got %d\n", r1);
		if (verbose) $display("Fibonacci resulted in: %d\n", r1);
		
		if (verbose) $display("loading comparisons.b");
		$readmemb("../../mem_files/comparisons.b", ram);
		cycle_reset();
		#150;
		
		if (flags != 5'b10000) $display("Error in comparison! Expected flags to be 10000 but got %b\n", flags);
		if (verbose) $display("First comparison resulted in flags: %b\n", flags);
		
		#150;
		
		if (flags != 5'b00000) $display("Error in comparison! Expected flags to be 00000 but got %b\n", flags);
		if (verbose) $display("Second comparison resulted in flags: %b\n", flags);
		
		#150;
		
		if (r1 != 16'd8) $display("Error in comparison! Expected r1 to be 8 but got %d\n", r1);
		if (verbose) $display("Left shift resulted in %d\n", r1);
		
		#150;
		
		if (flags != 5'b00011) $display("Error in comparison! Expected flags to be 00011 but got %b\n", flags);
		if (verbose) $display("Third comparison resulted in flags: %b\n", flags);
		
		#150;
		
		if (r1 != 16'd2) $display("Error in comparison! Expected r1 to be 2 but got %d\n", r1);
		if (verbose) $display("Right shift resulted in %d\n", r1);
		
		$display("Testbench ends\n");
	end
	
	always 
		#5 clk <= ~clk;
endmodule
