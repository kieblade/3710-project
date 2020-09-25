// testbench for the regFileInitializer which combines all components of the regFiles and alu

`timescale 1ns / 1ps

module tb_regFileInitializer();
	reg [15:0] regEnable, immediate, temp, temp1;
	reg clk, reset, useImm;
	reg [7:0] opCode;
	reg [3:0] a_select, b_select;
	
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [4:0] flags;
	
	integer i, j;
	
	parameter verbose = 0;
	
	parameter ADD = 8'b00000101;
	parameter ADDI = 8'b01010000;
	parameter ADDU = 8'b00000110;
	parameter ADDUI = 8'b01100000;
	parameter ADDC = 8'b00000111;
	parameter ADDCI = 8'b01110000;
	parameter ADDCU = 8'b00000100;
	parameter ADDCUI = 8'b01000000;
	parameter SUB = 8'b00001001;
	parameter SUBI = 8'b10010000;
	parameter CMP = 8'b00001011;
	parameter CMPI = 8'b10110000;
	parameter CMPU = 8'b00001000; 
	parameter CMPUI = 8'b00001100;

	parameter AND = 8'b00000001;
	parameter ANDI = 8'b00010000;

	parameter OR = 8'b00000010;
	parameter ORI = 8'b00100000;
	parameter XOR = 8'b00000011;
	parameter XORI = 8'b00110000;
	parameter NOT = 8'b00001111;

	// shifts
	parameter LSH = 8'b10000100;
	parameter LSHI = 8'b10000000;
	parameter RSH = 8'b10000101;
	parameter RSHI = 8'b10000001;

	parameter ALSH = 8'b10000110;
	parameter ALSHI = 8'b10000010;
	parameter ARSH = 8'b10000111;
	parameter ARSHI = 8'b10000011;

	parameter NOP = 8'b00000000;
		
	regFileInitializer uut(
		.regEnable(regEnable),
		.immediate(immediate),
		.clk(clk),
		.reset(reset),
		.use_imm(useImm),
		.opCode(opCode),
		.a_select(a_select),
		.b_select(b_select), 
		.r0(r0),
		.r1(r1),
		.r2(r2),
		.r3(r3),
		.r4(r4),
		.r5(r5),
		.r6(r6),
		.r7(r7),
		.r8(r8),
		.r9(r9),
		.r10(r10),
		.r11(r11),
		.r12(r12),
		.r13(r13),
		.r14(r14),
		.r15(r15),
		.flags(flags)
	);
	
	// loading a value into a register does an ori with anything, followed by and andi with itself
	task load;
		input [3:0] regNumber;
		input [15:0] value;
		begin
			opCode = ORI;
			regEnable = 16'b0000000000000001 << regNumber;
			immediate = value;
			useImm = 1'b1;
			a_select = 4'bx;
			b_select = 4'bx;
			#10;
			
			opCode = ANDI;
			regEnable = 16'b0000000000000001 << regNumber;
			immediate = value;
			useImm = 1'b1;
			a_select = regNumber;
			b_select = 4'bx;
		end
	endtask
	
	function [15:0] valFromReg(input [3:0] regNumber);
		case(regNumber)
			4'b0000: valFromReg = r0;
			4'b0001: valFromReg = r1;
			4'b0010: valFromReg = r2;
			4'b0011: valFromReg = r3;
			4'b0100: valFromReg = r4;
			4'b0101: valFromReg = r5;
			4'b0110: valFromReg = r6;
			4'b0111: valFromReg = r7;
			4'b1000: valFromReg = r8;
			4'b1001: valFromReg = r9;
			4'b1010: valFromReg = r10;
			4'b1011: valFromReg = r11;
			4'b1100: valFromReg = r12;
			4'b1101: valFromReg = r13;
			4'b1110: valFromReg = r14;
			4'b1111: valFromReg = r15;
		endcase
	endfunction
	
	initial begin
		$display("Testbench begins...");
		reset = 1;
		clk = 0;
		useImm = 0;
		regEnable = 16'b0;
		immediate = 16'b0;
		opCode = 8'b0;
		a_select = 4'b0;
		b_select = 4'b0;
		#13;
		reset = 0;
		#10;
		
		// random load
		$display("Testing random load");
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 16;
				if (verbose) $display("Loading %d into r%d", temp, temp1);
				
				load(temp1, temp);
				#10
				
				if (verbose) $display("Loaded %d from r%d", valFromReg(i), temp1);
				if (valFromReg(temp1) != temp) $display("Error! Expected %d, got %d. In simple load", temp, valFromReg(i));
			end
		end
		
		// random add
		$display("Testing random add");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 65536;
				
				load(i, temp);
				#10;
				load(i + 1, temp1);
				#10;
				
				if (verbose) $display("Executing %d + %d", $signed(temp), $signed(temp1));
				useImm = 0;
				regEnable = 16'b0000000000000001 << i;
				opCode = ADD;
				a_select = i;
				b_select = i + 1;
				#10;
				
				temp = $signed(temp) + $signed(temp1);
				if (verbose) $display("Resulted in %d", $signed(valFromReg(i)));
				if ($signed(valFromReg(i)) != $signed(temp)) $display("Error! Expected %d, but got %d. In random add", $signed(temp), $signed(valFromReg(i)));
			end
		end
		
		// random addi
		$display("Testing random addi");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 65536;
				
				load(i, temp);
				#10;
				
				if (verbose) $display("Executing %d + %d", $signed(temp), $signed(temp1));
				useImm = 1;
				regEnable = 16'b0000000000000001 << i;
				opCode = ADDI;
				a_select = i;
				immediate = temp1;
				#10;
				
				temp = $signed(temp) + $signed(temp1);
				if (verbose) $display("Resulted in %d", $signed(valFromReg(i)));
				if ($signed(valFromReg(i)) != $signed(temp)) $display("Error! Expected %d, but got %d. In random addi", $signed(temp), $signed(valFromReg(i)));
			end
		end
		
		// random addc
		$display("Testing random addcu");
		for (i = 1; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 65536;
				
				load(i, temp);
				#10;
				load(i + 1, temp1);
				#10; 
				
				load(0, 65535);
				#10;
				useImm = 1;
				regEnable = 16'd1;
				opCode = ADDUI;
				a_select = 0;
				immediate = 2;
				#10;
				
				if (verbose) $display("Executing %d + %d + %b", temp, temp1, flags[3]);
				temp = temp + temp1 + flags[3];
				
				useImm = 0;
				regEnable = 16'b0000000000000001 << i;
				opCode = ADDCU;
				a_select = i;
				b_select = i + 1;
				#10;
				
				if (verbose) $display("Resulted in %d", valFromReg(i));
				if (valFromReg(i) != temp) $display("Error! Expected %d, but got %d. In random addcu", temp, valFromReg(i));
			end
		end
		
		// random sub
		$display("Testing random sub");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 65536;
				
				load(i, temp);
				#10;
				load(i + 1, temp1);
				#10;
				
				if (verbose) $display("Executing %d - %d", $signed(temp), $signed(temp1));
				useImm = 0;
				regEnable = 16'b0000000000000001 << i;
				opCode = SUB;
				a_select = i;
				b_select = i + 1;
				#10;
				
				temp = $signed(temp) - $signed(temp1);
				if (verbose) $display("Resulted in %d", $signed(valFromReg(i)));
				if ($signed(valFromReg(i)) != $signed(temp)) $display("Error! Expected %d, but got %d. In random sub", $signed(temp), $signed(valFromReg(i)));
			end
		end
		
		// random subi
		$display("Testing random subi");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 65536;
				
				load(i, temp);
				#10;
				
				if (verbose) $display("Executing %d - %d", $signed(temp), $signed(temp1));
				useImm = 1;
				regEnable = 16'b0000000000000001 << i;
				opCode = SUBI;
				a_select = i;
				immediate = temp1;
				#10;
				
				temp = $signed(temp) - $signed(temp1);
				if (verbose) $display("Resulted in %d", $signed(valFromReg(i)));
				if ($signed(valFromReg(i)) != $signed(temp)) $display("Error! Expected %d, but got %d. In random subi", $signed(temp), $signed(valFromReg(i)));
			end
		end
		
		// random cmp
		$display("Testing random cmp");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 65536;
				
				load(i, temp);
				#10;
				load(i + 1, temp1);
				#10;
				
				if (verbose) $display("Executing %d < %d", $signed(temp), $signed(temp1));
				useImm = 0;
				regEnable = 16'b0000000000000001 << i;
				opCode = CMP;
				a_select = i;
				b_select = i + 1;
				#10;
				
				if (verbose) $display("Resulted in %b", flags);
				if ($signed(temp) < $signed(temp1) && ~flags[1]) $display("Expected low flag but got %b", flags);
				if ($signed(temp) > $signed(temp1) && flags[1]) $display("Expected no low flag but got %b", flags);
				if (temp == temp1 && ~flags[4]) $display("Expected zero flag but got %b", flags);
			end
		end
		
		// random cmpi
		$display("Testing random cmpi all equal");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				
				load(i, temp);
				#10;
				
				if (verbose) $display("Executing %d == %d", $signed(temp), $signed(temp));
				useImm = 1;
				regEnable = 16'b0000000000000001 << i;
				opCode = CMPI;
				a_select = i;
				immediate = temp;
				#10;
				
				if (verbose) $display("Resulted in %b", flags);
				if (~flags[4]) $display("Error! Expected zero flag but got %b", flags);
			end
		end
		
		// random lsh
		$display("Testing random cmp");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				temp1 = $random % 16;
				
				load(i, temp);
				#10;
				load(i + 1, temp1);
				#10;
				
				if (verbose) $display("Executing %d << %d", $signed(temp), $signed(temp1));
				useImm = 0;
				regEnable = 16'b0000000000000001 << i;
				opCode = LSH;
				a_select = i;
				b_select = i + 1;
				#10;
				
				if (verbose) $display("Resulted in %d", $signed(valFromReg(i)));
				if (valFromReg(i) != temp << temp1) $display("Error! Expected %d but got %d", temp << temp1, valFromReg(i));
			end
		end
		
		// random rshi all neg
		$display("Testing random arshi all neg");
		for (i = 0; i < 15; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				if ($signed(temp) > 0) temp = temp * -1;
				temp1 = $random % 16;
				if ($signed(temp1) < 0) temp1 = temp1 * -1;
				
				load(i, temp);
				#10;

				
				if (verbose) $display("Executing %d >>> %d", $signed(temp), $signed(temp1));
				useImm = 1;
				regEnable = 16'b0000000000000001 << i;
				opCode = ARSHI;
				a_select = i;
				immediate = temp1;
				#10;
				
				if (verbose) $display("Resulted in %d", $signed(valFromReg(i)));
				if ($signed(valFromReg(i)) != $signed(temp) >>> $signed(temp1)) $display("Error! Expected %d but got %d", temp << temp1, valFromReg(i));
			end
		end
		
		// random not
		$display("Testing random not");
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 10; j = j + 1) begin
				temp = $random % 65536;
				
				load (i, temp);
				#10;
				
				if (verbose) $display("Executing ~%b", temp);
				useImm = 0;
				regEnable = 16'b0000000000000001 << i;
				opCode = NOT;
				a_select = i;
				#10;
				
				if (verbose) $display("Resulted in %b", $signed(valFromReg(i)));
				if (valFromReg(i) != ~temp) $display("Error! Expected %b, but got %b", ~temp, valFromReg(i));
			end
		end
		
		// fibonnacci sequence
		$display("Running fibonnacci sequence");
		load(0, 0);
		#10;
		load(1, 1);
		#10;
		for (i = 0; i < 23; i = i + 1) begin
			useImm = 0;
			regEnable = 16'b0000000000000001 << ((i + 2) % 16);
			opCode = ADDU;
			a_select = i % 16;
			b_select = (i + 1) % 16;
			#10;
			
			$display("%d", valFromReg((i + 2) % 16));
		end
		
		// squaring numbers
		$display("Square number sequence");
		for (i = 0; i < 10; i = i + 1) begin
			load(i % 16, i);
			#10;
			
			for (j = 1; j < i; j = j + 1) begin
				useImm = 0; 
				regEnable = 16'b0000000000000001 << (i % 16);
				opCode = ADDU;
				a_select = i % 16;
				b_select = i % 16;
				#10;
			end
			$display("%d", valFromReg(i % 16));
		end
		
		$display("Testbench ends!");
	end
	
	always 
		#5 clk <= ~clk;

endmodule
