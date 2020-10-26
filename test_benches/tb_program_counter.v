module tb_program_counter();
	reg [15:0] addr_in;
	reg en;
	wire [15:0] addr_out;
	
	integer i;
	reg [15:0] tmp;
	
	parameter verbose = 0;
	
	program_counter uut(
		.addr_in(addr_in),
		.addr_out(addr_out),
		.en(en)
	);
	
	initial
	begin
		$display("Simulation begins...");
		
		addr_in = 16'b0;
		en = 1'b0;
		#10;
		en = 1'b1;
		#10;
		en = 1'b0;
		#10;
		
		for (i = 0 ; i < 2**10; i = i + 1)
		begin
			tmp = $random() % 65536;
			addr_in = tmp;
			en = 1'b1;
			#10;
			en = 1'b0;
			#10;
			
			if (verbose)
				$display("Loading %d", tmp);
			
			if (addr_out != tmp)
				$display("Error: expected %d, but got %d", tmp, addr_out);
			
			en = 1'b0;
			addr_in = $random();
			#10;
			
			if (verbose)
				$display("Making sure value doesn't change from %d to %d", tmp, addr_in);
			
			if (addr_out != tmp)
				$display("Error: value shouldn't have changed from %d, but got %d", tmp, addr_out);
		end
		
		$display("Simulation ends");
	end
endmodule
