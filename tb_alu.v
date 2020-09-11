// TESTBENCH FOR 16-BIT ALU

`timescale 1ns / 1ps

module tb_alu();

	// Inputs
	reg signed [15:0] A, B;
	reg [7:0] Opcode;
	reg carryIn;

	// Outputs
	wire signed [15:0] C;
	wire [4:0] Flags;
	
	// Iterator
	integer i;
	
	alu uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.Opcode(Opcode), 
		.Flags(Flags),
		.carryIn(carryIn)
	);

	//Flags[0] Negative / Sign
	//Flags[1] Low
	//Flags[2] Overflow
	//Flags[3] Carry
	//Flags[4] Zero
	
	initial begin

		// Initialize Inputs
		A = 0;
		B = 0;
		Opcode = 8'b00000101;
		carryIn = 1; #50
		
		
		//Random ADD Simulation
		$display(" ********* ADD *********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDI Simulation
		Opcode = 8'b01010000; #50
		$display("\n ********* ADDI ********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDU Simulation
		Opcode = 8'b00000110; #50
		$display("\n ********* ADDU ********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDUI Simulation
		Opcode = 8'b01100000; #50
		$display("\n ********* ADDUI *******   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDC Simulation
		Opcode = 8'b00000111; #50
		$display("\n ********* ADDC ********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDCI Simulation
		Opcode = 8'b01110000; #50
		$display("\n ********* ADDCI *******   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDCU Simulation
		Opcode = 8'b00000100; #50
		$display("\n ********* ADDCU *******   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random ADDCUI Simulation
		Opcode = 8'b01000000; #50
		$display("\n ********* ADDCUI ******   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		// Cont...

	end
      
endmodule
