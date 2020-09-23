// testbench for the 16-bit 16 input mux
`timescale 1ns / 1ps

module tb_mux();
	// input
	reg [255:0] inputs;
	reg [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	reg [3:0] select;
	
	// output
	wire [15:0] out;
	
	integer i, f;
	
	parameter verbose = 1;
	
	// instantiate unit under test
	mux uut(
		.select(select),
		.r0(inputs[255:240]),
		.r1(inputs[239:224]),
		.r2(inputs[223:208]),
		.r3(inputs[207:192]),
		.r4(inputs[191:176]),
		.r5(inputs[175:160]),
		.r6(inputs[159:144]),
		.r7(inputs[143:128]),
		.r8(inputs[127:112]),
		.r9(inputs[111:96]),
		.r10(inputs[95:80]),
		.r11(inputs[79:64]),
		.r12(inputs[63:48]),
		.r13(inputs[47:32]),
		.r14(inputs[31:16]),
		.r15(inputs[15:0]),
		.out(out)
	);
	

	task load_random;
		integer x;
		begin
			for (x = 0; x < 16; x = x + 1) begin
				inputs[((x + 1) * 16)-:16] = $random % 65536;
			end
			#10;
		end
	endtask
	
	initial begin
		$display("Begining testbench");
	
		// initialize
		inputs = 256'b0;
		select = 3'b0;
		#10;
		
		if (verbose) begin
			$display("Inputs: %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d", inputs[255:240],inputs[239:224],inputs[223:208],inputs[207:192],inputs[191:176],inputs[175:160],inputs[159:144],inputs[143:128],inputs[127:112],inputs[111:96],inputs[95:80],inputs[79:64],inputs[63:48],inputs[47:32],inputs[31:16],inputs[15:0]);
		end
		
		// run our tests
		for (f = 0; f < 10; f = f + 1) begin
			if (verbose) begin
				$display("Running trial %d", f);
			end
			
			load_random();
			
			if (verbose) begin
				$display("Inputs: %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d", inputs[255:240],inputs[239:224],inputs[223:208],inputs[207:192],inputs[191:176],inputs[175:160],inputs[159:144],inputs[143:128],inputs[127:112],inputs[111:96],inputs[95:80],inputs[79:64],inputs[63:48],inputs[47:32],inputs[31:16],inputs[15:0]);
			end
			
			for (i = 0; i < 16; i = i + 1) begin
				select = i;
				#10;
				if (verbose) begin
					$display("Select: %d, Output: %d", select, out);
				end
				if (inputs[255 - (i * 16)-:16] != out) begin
					$display("Error! Expected: %d, Got: %d", inputs[255 - (i * 16)-:16], out);
				end
			end
		end
		
		$display("End testbench");
	end

endmodule
