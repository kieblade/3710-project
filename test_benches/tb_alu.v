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
		
		
		//Random SUB Simulation
		Opcode = 8'b00001001; #50
		$display("\n ********* SUB *********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random SUBI Simulation
		Opcode = 8'b10010000; #50
		$display("\n ********* SUBI ********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		end
		
		
		//Random CMP Simulation
		Opcode = 8'b00001011; #50
		$display("\n ********* CMP *********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d < %d            %b", A, B, Flags[4:0]);
		end
		
		
		//Random CMPI Simulation
		Opcode = 8'b10110000; #50
		$display("\n ********* CMPI ********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d < %d            %b", A, B, Flags[4:0]);
		end
		
		
		//Random CMPU Simulation
		Opcode = 8'b00001000; #50
		$display("\n ********* CMPU ********   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d < %d              %b", $unsigned(A), $unsigned(B), Flags[4:0]);
		end
		
		
		//Random CMPUI Simulation
		Opcode = 8'b00001100; #50
		$display("\n ********* CMPUI *******   FLAGS:");
		$display("                           ZCOLN");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("%d < %d              %b", $unsigned(A), $unsigned(B), Flags[4:0]);
		end
		
		
		//Random AND Simulation
		Opcode = 8'b00000001; #50
		$display("\n ********* AND *********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("  %b", A);
			$display("* %b", B);
			$display("------------------");
			$display("  %b\n", C);
		end
		
		
		//Random OR Simulation
		Opcode = 8'b00000010; #50
		$display("\n ********* OR  *********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("  %b", A);
			$display("+ %b", B);
			$display("------------------");
			$display("  %b\n", C);
		end
		
		
		//Random XOR Simulation
		Opcode = 8'b00000011; #50
		$display("\n ********* XOR *********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("  %b", A);
			$display("^ %b", B);
			$display("------------------");
			$display("  %b\n", C);
		end
		
		
		//Random NOT Simulation
		Opcode = 8'b00001111; #50
		$display("\n ********* NOT *********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 65536; #50
			$display("! %b", A);
			$display("= %b\n", C);
		end
		
		
		//Random LSH Simulation
		Opcode = 8'b10000100; #50
		$display("\n ********* LSH *********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 16; #50
			$display("  %b << %0d", A, B);
			$display("= %b\n", C);
		end
		
		
		//Random LSHI Simulation
		Opcode = 8'b10000000; #50
		$display("\n ********* LSHI ********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 16; #50
			$display("  %b << %0d", A, B);
			$display("= %b\n", C);
		end
		
		
		//Random RSH Simulation
		Opcode = 8'b10000101; #50
		$display("\n ********* RSH *********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 16; #50
			$display("  %b >> %0d", A, B);
			$display("= %b\n", C);
		end
		
		
		//Random RSHI Simulation
		Opcode = 8'b10000001; #50
		$display("\n ********* RSHI ********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 16; #50
			$display("  %b >> %0d", A, B);
			$display("= %b\n", C);
		end
		
		
		//Random ALSH Simulation
		Opcode = 8'b10000110; #50
		$display("\n ********* ALSH ********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 16; #50
			$display("  %b <<< %0d", A, B);
			$display("= %b\n", C);
		end
		
		
		//Random ARSH Simulation
		Opcode = 8'b10000111; #50
		$display("\n ********* ARSH ********");
		for( i = 0; i < 10; i = i + 1) begin
			A = $random % 65536;
			B = $random % 16; #50
			$display("  %b >>> %0d", A, B);
			$display("= %b\n", C);
		end
		
		
		// ADD Simulation w/ Corner Cases
		Opcode = 8'b00000101;
		$display(" ********* ADD *********   FLAGS:");
		$display("                           ZCOLN");
		A = 0;
		B = 0; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = 32000;
		B = 767; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = -768;
		B = -32000; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = 32767;
		B = 1; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = -1;
		B = -32768; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = 10;
		B = -10; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		
		
		// ADDU Simulation w/ Corner Cases
		Opcode = 8'b00000110;
		$display("\n ********* ADDU ********   FLAGS:");
		$display("                           ZCOLN");
		A = 0;
		B = 0; #50
		$display("%d + %d = %d      %b", $unsigned(A), $unsigned(B), $unsigned(C), Flags[4:0]);
		A = 65000;
		B = 535; #50
		$display("%d + %d = %d      %b", $unsigned(A), $unsigned(B), $unsigned(C), Flags[4:0]);
		A = 1;
		B = 65535; #50
		$display("%d + %d = %d      %b", $unsigned(A), $unsigned(B), $unsigned(C), Flags[4:0]);
		
		
		// ADDC Simulation w/ Corner Cases
		Opcode = 8'b00000111;
		$display("\n ********* ADDC ********   FLAGS:");
		$display("                           ZCOLN");
		A = 0;
		B = 0; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = 0;
		B = -1; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = 32000;
		B = 766; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = -769;
		B = -32000; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = 32767;
		B = 0; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		A = -2;
		B = -32768; #50
		$display("%d + %d = %d   %b", A, B, C, Flags[4:0]);
		
		
		// SUB Simulation w/ Corner Cases
		Opcode = 8'b00001001;
		$display("\n ********* SUB *********   FLAGS:");
		$display("                           ZCOLN");
		A = 0;
		B = 0; #50
		$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		A = 32000;
		B = -767; #50
		$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		A = -768;
		B = 32000; #50
		$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		A = 32767;
		B = -1; #50
		$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		A = -32768;
		B = 1; #50
		$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		A = -5;
		B = -5; #50
		$display("%d - %d = %d   %b", A, B, C, Flags[4:0]);
		
		
	end
      
endmodule
