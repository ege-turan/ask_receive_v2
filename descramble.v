/* 
Multiplicative Descrambler by Ege Turan
8/30/23, Stanford, CA

Uses a 33-bit shift-register to shift bits 10 at a time
and perform net logic operations to descramble words.
*/

module descramble(
	input rclk,
	input [9:0] scrambled,
	output [9:0] descrambled);

assign descrambled = sr_d[32:23]^sr_d[9:0]^sr_d[13:4]; // equivalent logic equation

parameter SEED = 33'b1;
reg [32:0] sr_d = SEED; 

always @ (posedge rclk) begin
	sr_d[32:10] <= sr_d[22:0];
	sr_d[9:0] <= scrambled;
	end

endmodule