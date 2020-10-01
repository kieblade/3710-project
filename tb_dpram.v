// testbench for the dpram

`timescale 1ns / 1ps

module tb_dpram();
	reg clk, en_A, en_B;
	reg [9:0] addr_A, addr_B;
	reg [15:0] data_A, data_B;
	
	wire [15:0] out_A, out_B;
	
	integer i, j;
	
	parameter verbose = 0;
		
	dpram uut(
		.clk(clk),
		.en_A(en_A),
		.en_B(en_B),
		.addr_A(addr_A),
		.addr_B(addr_B),
		.data_A(data_A),
		.data_B(data_B),
		.out_A(out_A),
		.out_B(out_B)
	);
	
	initial begin
		$display("Testbench begins...");
		clk = 0;
		en_A = 0;
		en_B = 0;
		addr_A = 10'b0;
		addr_B = 10'b0;
		data_A = 16'b0;
		data_B = 16'b0;
		#13;
		
		// random load
		$display("Testing random load");
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				data_A = $random % 65536;
				data_B = $random % 65536;
				addr_A = $random % 1024;
				addr_B = $random % 1024;
				en_A = 1;
				en_B = 1;
				if (verbose) $display("Writing %d into mem%d and %d into mem%d", data_A, addr_A, data_B, addr_B);
				
				clk = 1;
				#10
				clk = 0;
				en_A = 0;
				en_B = 0;
				#10
				
				if (addr_A != addr_B)
				begin
					if (verbose) $display("PortA output: %d\nPortB output: %d", out_A, out_B);
					if (data_A != out_A) $display("Error! Expected %d, got %d. In simple load", data_A, out_A);
					if (data_B != out_B) $display("Error! Expected %d, got %d. In simple load", data_B, out_B);
				end
				else $display("Both Ports are writing to the same adress");
				
				
			end
		end
		
		$display("Testbench ends!");
	end
	
	always 
		#5 clk <= ~clk;

endmodule 