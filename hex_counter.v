// From https://my.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
// Modified by Team 10 
// 	Dalton Clift
//		Sam Hirsch
// 	Seth Jackson
module hex_counter (
	input reset,
	input [15:0] h_number,
	output reg [3:0] D_one, D_two, D_three, D_four, D_five,
	output sign
);

assign sign = ~h_number[15];
integer i;
reg [15:0] num;
always @(h_number)
begin
	D_one = 4'd0;
	D_two = 4'd0;
	D_three = 4'd0;
	D_four = 4'd0;
	D_five = 4'd0;
	
	if (h_number[15] == 1)
		num = ~h_number + 1;
	else
		num = h_number;
	
	for (i = 15; i>=0; i=i-1)
	begin
		if (D_five >= 5)
			D_five = D_five + 3;
		if (D_four >= 5)
			D_four = D_four + 3;
		if (D_three >= 5)
			D_three = D_three + 3;
		if (D_two >= 5)
			D_two = D_two + 3;
		if (D_one >= 5)
			D_one = D_one + 3;
			
		D_five = D_five << 1;
		D_five[0] = D_four[3];
		D_four = D_four << 1;
		D_four[0] = D_three[3];
		D_three = D_three << 1;
		D_three[0] = D_two[3];
		D_two = D_two << 1;
		D_two[0] = D_one[3];
		D_one = D_one << 1;
		D_one[0] = num[i];
	end
end
	
endmodule 