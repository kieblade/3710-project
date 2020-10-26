`timescale 1ns / 1ps

module tb_pc_incr();
	wire [15:0] pc_out;
	reg [15:0] pc_in, diff;
	reg decr;
	
	integer i, j, k;
	reg [15:0] tmp;
	parameter verbose = 0;
	
	pc_incr uut(
		.curr_pc(pc_in),
		.decr(decr),
		.diff(diff),
		.next_pc(pc_out)
	);
	
	initial begin
		$display("Simulation begins...");
		
		// sequential test
		for (i = 0; i < 2 ** 8; i = i + 1)
		begin
			pc_in = i;
			for (j = 0; j < 2 ** 8; j = j + 1)
			begin
				diff = j;
				for (k = 0; k < 2; k = k + 1)
				begin
					decr = k;
					#10;
					
					if (verbose)
						$display("Executing %d %s %d", i, ((k == 1'b1) ? "-" : "+"), j);
					
					if (verbose)
						$display("Result: %d", pc_out);
					
					if (k == 1'b1)
						tmp = i - j;
					else
						tmp = i + j;
						
					if (pc_out != tmp)
						$display("Error: expected %d but got %d", tmp, pc_out);
				end
			end
		end
		
		// random test
		for (i = 0; i < 2 ** 8; i = i + 1)
		begin
			j = $urandom() % 65536;
			k = $urandom() % 65536;
			pc_in = j;
			diff = k;
			decr = $urandom() % 2;
			#10;
			
			if (verbose)
				$display("Executing %d %s %d", j, ((decr == 1'b1) ? "-" : "+"), k);
			
			if (verbose)
				$display("Result: %d", pc_out);
			
			if (decr == 1'b1)
				tmp = j - k;
			else
				tmp = j + k;
				
			if (pc_out != tmp)
				$display("Error: expected %d but got %d", tmp, pc_out);
		end
		
		$display("Simulation ends");
	end
endmodule
