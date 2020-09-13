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
module alu_Input( B, a, b);
input [3:0] B;
output reg [15:0] a, b;

	always @(B)
	begin
		case (B)
		4'b1110:
			begin
			a = -768;
			b = 32000;
			end
		4'b1101:
			begin
			a = 32767;
			b = -1;
			end
		4'b1011:
			begin
			a = -32768;
			b = 1;
			end
		4'b0111: 
			begin
			a = 32000;
			b = -768;
			end
		4'b1100: 
			begin
			a = 0;
			b = 1;
			end
		4'b1010: 
			begin
			a = 1;
			b = 32767;
			end
		4'b0110: 
			begin
			a = -1;
			b = 0;
			end
		4'b1001: 
			begin
			a = 0;
			b = -1;
			end
		4'b0101: 
			begin
			a = -1;
			b = -1;
			end
		4'b0011: 
			begin
			a = 32767;
			b = 1;
			end
		default:
			begin
			a = 0;
			b = 0;
			end
		endcase
	end

endmodule 