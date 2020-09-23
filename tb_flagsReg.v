// testbench for the flagsReg module

`timescale 1ns / 1ps

module tb_flagsReg();
	// set to 1 for more verbose logging
	parameter verbose = 0;

	reg [4:0] flags;
	reg reset, clk;
	wire [4:0] out;
	
	reg [4:0] x;
	integer i;
	
	flagsReg uut(
		.D(flags),
		.clk(clk),
		.reset(reset),
		.r(out)
	);
	
	initial begin
		$display("Testbench begins...");
		clk = 0;
		reset = 1;
		flags = 5'b0;
		#13;
		reset = 0;
		#10;
		
		// test store and retrieve
		$display("--- Testing store and retrieve ---");
		for (i = 0; i < 32; i = i + 1) begin
			if (verbose) begin
				x = i;
				$display("Storing: %b", x);
			end
			
			flags = i;
			#50;
			
			if (verbose) $display("Read: %b", out);
			
			if (out != i) $display("Error! Expected %b, but got %b", i, out); 
			
			#100;
			if (out != i) $display("Error after delay! Expected %b, but got %b", i, out); 
		end
		
		// test reset
		$display("--- Testing reset ---");
		for (i = 0; i < 10; i = i + 1) begin
			x = $random % 32;
			if (verbose) $display("Storing: %b", x);
			
			flags = x;
			reset = 1;
			#50;
			
			if (verbose) $display("Read: %b", out);
			if (out != 5'b0) $display("Error! Expected 0, but got %b", out);
			
			reset = 0;
			#50;
		end
		
		$display("Testbench ends.");
	end
	
	always
		#5 clk <= ~clk;
endmodule
