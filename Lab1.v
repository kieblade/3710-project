`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Universtiy of Utah
// Engineer: Scott Crowley, Sam Hirsch, Seth Jackson
// 
// Create Date:    12:54:08 09/07/2020 
// Design Name: 	
// Module Name:    Lab1.v 
// Project Name: 	 Lab1
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Lab1( B, carryIn, Opcode, z, Flags);
input [3:0] B;
input carryIn;
input [7:0] Opcode;
output [27:0] z;
output [4:0] Flags;
wire [15:0] a, b, c;

	alu_Input buttons(B, a, b);
	alu theALU(a, b, carryIn, c, Opcode, Flags);
	hexTo7Seg hex0(c[3:0], z[6:0]);
	hexTo7Seg hex1(c[7:4], z[13:7]);
	hexTo7Seg hex2(c[11:8], z[20:14]);
	hexTo7Seg hex3(c[15:12], z[27:21]);

endmodule 