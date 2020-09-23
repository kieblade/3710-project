// Given below is a 2D-memory array implementation 
// For simplicity, I'm designing a 4-bitX4  memory
module regfile(ALUBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regEnable, clk, reset);
	input clk, reset;
	input [15:0] ALUBus;
	input [15:0] regEnable;
	// 4 instances (r0 to r3) of 4-bit registers
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15; 
	reg [15:0] r [0:15]; // 2-dimensional memory

        // The syntax for the above 2D-array is:
        // reg [DATA_WIDTH - 1: 0] r [0: NUM_WORDS-1]

   
	/********
	Unfortunately, verilog does not allow  the following
	declaration where the 2D memory cannot be  declared as 
	an IO port
	// output reg [3:0] r [0:3];
	*********/
	genvar i;
	
	generate
	for(i=0; i<=15;i=i+1) 
	begin:regfile
		always @(posedge clk)
		begin
			if (reset == 1'b1)
				r[i]<= 4'd0;
			else
				if(regEnable[i]==1'b1)
					r[i] <= ALUBus;
				//else
				//r[i] <= r[i];
		end
	end
	endgenerate
	// assign outputs explicitly
	assign r0 = r[0];
	assign r1 = r[1];
	assign r2 = r[2];
	assign r3 = r[3];
	assign r4 = r[4];
	assign r5 = r[5];
	assign r6 = r[6];
	assign r7 = r[7];
	assign r8 = r[8];
	assign r9 = r[9];
	assign r10 = r[10];
	assign r11 = r[11];
	assign r12 = r[12];
	assign r13 = r[13];
	assign r14 = r[14];
	assign r15 = r[15];
endmodule
