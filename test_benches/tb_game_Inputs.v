`timescale 1ns / 1ps

module tb_game_Inputs();
	parameter verbose = 1;
	
	reg clk, reset;
	reg [4:0] controller, music;
	wire [15:0] out;

	game_Inputs uut(
		.clk(clk),
		.reset(reset),
		.controller(controller),
		.music(music),
		.out(out)
	);
	
	initial begin
		// Note that most commands currently takes 3 clock cycles to execute. 
		// Load and store each take 4 clock cycles
		$display("Testbench begins...\n");
		controller = 5'b0;
		music = 5'b0;
		clk = 0;
		reset = 1;
		#13;
		reset = 0;
		#20;
		
		if (out != 0) $display("Error in initialize! Expected 0, but got %b\n", out);
		if (verbose) $display("Initialize resulted in: %b\n", out);
		
		controller = 5'b10101;
		music = 5'b01010;
		#20;
		if (out != 16'b0000000101010101) $display("Error in initialize! Expected 0000000101010101, but got %b\n", out);
		if (verbose) $display("Initialize resulted in: %b\n", out);
		
		reset = 1;
		#13;
		if (out != 0) $display("Error in initialize! Expected 0, but got %b\n", out);
		if (verbose) $display("Initialize resulted in: %b\n", out);
		
		$display("Testbench ends\n");
	end
	
	always 
		#5 clk <= ~clk;
endmodule
