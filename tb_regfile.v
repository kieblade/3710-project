// testbench for the regfile module

`timescale 1ns / 1ps

module tb_regfile();
	parameter verbose = 0;

	wire [255:0] outs;
	reg [15:0] bus, regEnable;
	reg clk, reset;
	
	integer unsigned i, temp;
	
	regfile uut(
		.clk(clk),
		.reset(reset),
		.ALUBus(bus),
		.regEnable(regEnable),
		.r0(outs[255:240]),
		.r1(outs[239:224]),
		.r2(outs[223:208]),
		.r3(outs[207:192]),
		.r4(outs[191:176]),
		.r5(outs[175:160]),
		.r6(outs[159:144]),
		.r7(outs[143:128]),
		.r8(outs[127:112]),
		.r9(outs[111:96]),
		.r10(outs[95:80]),
		.r11(outs[79:64]),
		.r12(outs[63:48]),
		.r13(outs[47:32]),
		.r14(outs[31:16]),
		.r15(outs[15:0])
	);
	
	task load;
		input [3:0] regNumber;
		input [15:0] value;
		begin
			regEnable = 16'b0000000000000001 << regNumber;
			bus = value;
			#50;
		end
	endtask
	
	initial begin
		$display("Testbench begins...");
		clk = 0;
		reset = 1;
		bus = 16'b0;
		regEnable = 16'b0;
		#13;
		reset = 0;
		#10;
		
		// sequential store/retrieve
		for (i = 0; i < 16; i = i + 1) begin
			temp = $urandom % 65536;
			if (verbose) $display("Storing %d into r%d", temp, i);
			
			load(i, temp);
			#50;
			
			if (outs[255 - (i * 16)-:16] != temp) $display("Error! Expected: %d, Got: %d", temp, outs[255 - (i * 16)-:16]);
			
			if (verbose) $display("Retrieved %d", outs[255 - (i * 16)-:16]);
		end
		
		// store and retrieve after several store operations
		for (i = 0; i < 16; i = i + 1) begin
			if (verbose) $display("Storing %d into r%d", i, i);
			
			load(i, i);
			#50;
		end
		for (i = 0; i < 16; i = i + 1) begin
			if (outs[255 - (i * 16)-:16] != i) $display("Error! Expected: %d, Got: %d", i, outs[255 - (i * 16)-:16]);
			
			if (verbose) $display("Retrieved %d", outs[255 - (i * 16)-:16]);
		end
		
		// store and retrieve in different orders
		for (i = 0; i < 16; i = i + 1) begin
			if (verbose) $display("Storing %d into r%d", i, i);
			
			load(15 - i, i);
			#50;
		end
		for (i = 0; i < 16; i = i + 1) begin
			if (outs[255 - (i * 16)-:16] != 15 - i) $display("Error! Expected: %d, Got: %d", 15 - i, outs[255 - (i * 16)-:16]);
			
			if (verbose) $display("Retrieved %d", outs[255 - (i * 16)-:16]);
		end
		
		$display("Testbench ends");
	end
	
	always
		#5 clk <= ~clk;

endmodule
