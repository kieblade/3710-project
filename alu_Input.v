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
		4'b1100: 
			begin
			a = 16'b0000000000000001;
			b = 16'b0000000000000000;
			end
		4'b1010: 
			begin
			a = 16'b0000000000000000;
			b = 16'b0000000000000001;
			end
		4'b0110: 
			begin
			a = 16'b0000000000000001;
			b = 16'b0111111111111111;
			end
		4'b1110: 
			begin
			a = 16'b1111111111111111;
			b = 16'b0000000000000000;
			end
		4'b1101: 
			begin
			a = 16'b0000000000000000;
			b = 16'b1111111111111111;
			end
		4'b1011: 
			begin
			a = 16'b1111111111111111;
			b = 16'b1111111111111111;
			end
		4'b0111: 
			begin
			a = 16'b0111111111111111;
			b = 16'b0000000000000001;
			end
		default:
			begin
			a = 16'b0000000000000000;
			b = 16'b0000000000000000;
			end
		endcase
	end

endmodule 