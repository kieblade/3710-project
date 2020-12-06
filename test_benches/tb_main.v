`timescale 1ns / 1ps

module tb_main();
	reg clk, reset;
	wire WE;
	wire [4:0] flags;
	wire [15:0] r1;
	wire [15:0] addr;
	wire [15:0] out_B;
	reg [15:0] addr_B;
	reg [15:0] data_out;
	wire [15:0] data_in;
	reg [4:0] music_in, controller_in;

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
		.addr_B(addr_B),
		.out_B(out_B),
		.data_out(data_out),
		.data_in(data_in),
		.music_in(music_in),
		.controller_in(controller_in)
	);
	
	integer i;
	initial begin
		for (i = 61440; i <= 61460; i = i + 1) begin
			ram[i] = 16'd0;
		end
		
		$display("Testbench begins...\n");
		clk = 0;
		reset = 1;
		#13
		reset = 0;
		#20;
		
		$readmemb("../../mem_files/main.b", ram);
		#200;
		controller_in = 5'b0;
		music_in = 5'b01100;
		#10000;
		music_in = 5'b10011;
		#20000;
		music_in = 5'b0;
		#1457767;
		controller_in = 5'b01100;
		#20000;
		controller_in = 5'b0;
		#10000000;
		$display("Testbench ends\n");
	end

	always 
		#5 clk <= ~clk;
endmodule
