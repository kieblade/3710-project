// testbench for the topmodule

`timescale 1ns / 1ps

module tb_Lab3();
	reg [9:0] display_addr;
	reg [2:0] button_code;
	reg clk, reset;
	
	wire [6:0] dsp_7seg_0, dsp_7seg_1, dsp_7seg_2, dsp_7seg_3;
	
	integer i;
	
	parameter verbose = 0;
	parameter [5:0] SIDLE = 6'b111111;
	
	
	lab3 uut(
		.display_addr(display_addr),
		.button_code(button_code),
		.clk(clk),
		.reset(reset),
		.dsp_7seg_0(dsp_7seg_0),
		.dsp_7seg_1(dsp_7seg_1),
		.dsp_7seg_2(dsp_7seg_2),
		.dsp_7seg_3(dsp_7seg_3)
	);
	
	initial begin
		$display("Testbench begins...");
		display_addr = 10'd0;
		button_code = 111;
		clk = 0;
		reset = 0;
		#13
		reset = 1;
		#10
		
		// loads data
		$display("Testing load");
		button_code = 3'b110;
		#10
		button_code = 3'b111;
		#500

		for (i = 0; i < 5; i = i + 1) begin
			if (verbose) $display("display address: %d", display_addr);
			display_addr = i+1;
			#10
			if (verbose) $display("output: %d", uut.readonly_out);
			if (uut.readonly_out != i) $display("Error! Expected %d, got %d. In simple read", i, uut.readonly_out);
		end
		
		display_addr = 10'd504;
		#10
		
		for (i = 504; i < 510; i = i + 1) begin
			if (verbose) $display("display address: %d", display_addr);
			display_addr = i+1;
			#10
			if (verbose) $display("output: %d", uut.readonly_out);
			if (uut.readonly_out != i) $display("Error! Expected %d, got %d. In simple read", i, uut.readonly_out);
		end
		
		display_addr = 10'd0;
		button_code = 111;
		clk = 0;
		reset = 0;
		#13
		reset = 1;
		#10
		
		// adds one to everything 
		$display("\nTesting add one");
		button_code = 3'b101;
		#10
		button_code = 3'b111;
		#500
		
		for (i = 0; i < 5; i = i + 1) begin
			if (verbose) $display("display address: %d", display_addr);
			display_addr = i+1;
			#10
			if (verbose) $display("output: %d", uut.readonly_out);
			if (uut.readonly_out != i+1) $display("Error! Expected %d, got %d. In simple read", i+1, uut.readonly_out);
		end
		
		display_addr = 10'd504;
		#10
		
		for (i = 504; i < 511; i = i + 1) begin
			if (verbose) $display("display address: %d", display_addr);
			display_addr = i+1;
			#10
			if (verbose) $display("output: %d", uut.readonly_out);
			if (uut.readonly_out != i+1) $display("Error! Expected %d, got %d. In simple read", i+1, uut.readonly_out);
		end
		
		display_addr = 10'd0;
		button_code = 111;
		clk = 0;
		reset = 0;
		#13
		reset = 1;
		#10
		
		// fibonacci 
		$display("\nTesting fibonacci");
		button_code = 3'b011;
		#10
		button_code = 3'b111;
		#500
		
		if (verbose) $display("display address: %d", display_addr);
		display_addr = 1;
		#10
		if (verbose) $display("output: %d", uut.readonly_out);
		if (uut.readonly_out != 16'd2) $display("Error! Expected %d, got %d. In simple read", 16'd2, uut.readonly_out);
		
		if (verbose) $display("display address: %d", display_addr);
		display_addr = 2;
		#10
		if (verbose) $display("output: %d", uut.readonly_out);
		if (uut.readonly_out != 16'd3) $display("Error! Expected %d, got %d. In simple read", 16'd3, uut.readonly_out);
		
		if (verbose) $display("display address: %d", display_addr);
		display_addr = 3;
		#10
		if (verbose) $display("output: %d", uut.readonly_out);
		if (uut.readonly_out != 16'd3) $display("Error! Expected %d, got %d. In simple read", 16'd3, uut.readonly_out);
		
		$display("Testbench ends!");
	end
	
	always 
		#5 clk <= ~clk;

endmodule 