`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:25:01 08/30/2011
// Design Name:   alu
// Module Name:   C:/Documents and Settings/Administrator/ALU/alutest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alutest;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [7:0] Opcode;

	// Outputs
	wire [15:0] C;
	wire [4:0] Flags;

	integer i;
	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.Opcode(Opcode), 
		.Flags(Flags)
	);

	initial begin
//			$monitor("A: %0d, B: %0d, C: %0d, Flags[1:0]:%b, time:%0d", A, B, C, Flags[1:0], $time );
//Instead of the $display stmt in the loop, you could use just this
//monitor statement which is executed everytime there is an event on any
//signal in the argument list.

		// Initialize Inputs
		A = 0;
		B = 0;
		Opcode = 8'b00000101;

		// Wait 100 ns for global reset to finish
/*****
		// One vector-by-vector case simulation
		#10;
	        Opcode = 8'b00000001;
		//A = 16'b1111111111111111; B = 16'b1111111111111111;
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		#10
		//$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time:%d", A, B, C, Flags[4:0], $time);
		//immediate 
		$display("A: %b, Imm: %b, C: %b, Flags[4:0]: %b, time:%d", A, $signed({1'b0, Opcode[3:0], B[3:0]}), C, Flags[4:0], $time );
****/
		//Random simulation

		for( i = 0; i< 10; i = i+ 1)
		begin
			#10
			A = $random % 16;
			B = $random % 16;
			#10
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			
			//immediate 
			//$display("A: %0d, Imm: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, $signed({1'b0, Opcode[3:0], B[3:0]}), C, Flags[4:0], $time );
		end
		
		$display("testing AND ...");
		#10
		Opcode = 8'b00000001;
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		
		for( i = 0; i< 10; i = i+ 1)
		begin
			#10
			A = $random % 16;
			B = $random % 16;
			#10
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		end
		
		#10
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b1111111111111111; B = 16'b1111111111111111;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b0000000000000000; B = 16'b1111111111111111;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b1111111111111111; B = 16'b0000000000000000;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		$display("testing OR ...");
		#10
		Opcode = 8'b00000010;
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		
		for( i = 0; i< 10; i = i+ 1)
		begin
			#10
			A = $random % 16;
			B = $random % 16;
			#10
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		end
		
		#10
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b1111111111111111; B = 16'b1111111111111111;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b0000000000000000; B = 16'b1111111111111111;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b1111111111111111; B = 16'b0000000000000000;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		$display("testing XOR ...");
		#10
		Opcode = 8'b00000011;
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		
		for( i = 0; i< 10; i = i+ 1)
		begin
			#10
			A = $random % 16;
			B = $random % 16;
			#10
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		end
		
		#10
		A = 16'b0000000000000000; B = 16'b0000000000000000;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b1111111111111111; B = 16'b1111111111111111;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b0000000000000000; B = 16'b1111111111111111;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		
		#10
		A = 16'b1111111111111111; B = 16'b0000000000000000;
		#10
		$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		

		//$finish(2);
		
		// Add stimulus here
	end
      
endmodule