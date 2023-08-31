// Ege Turan
// 8/22/23, Stanford, CA
// transmit side commented out, just the receive side active

module top_invert (
	input MAX10_CLK1_50, RCLK, // rst, load,
	input sw0,
	input R0, R1, R2, R3, R4, R5, R6, R7, R8, R9,
	//output demodulated, new_word //neg_demodulated,
	output [6:0] HEX0, HEX1, HEX2, HEX3,
	output refclk
	);
	
//wire result_out, xor_result, clk;
reg [9:0] d_in;
wire [9:0] r_in;
reg [9:0] invert = 10'b0; // use to invert bits every other new pulse

//assign r_in = {R9, R8, R7, R6, R5, R4, R3, R2, R1, R0};
assign r_in = {R0, R1, R2, R3, R4, R5, R6, R7, R8, R9};

always @ (posedge RCLK) begin
	d_in <= r_in;
	invert <= ~invert;
end

// 10 bits given from deserializer must be routed to LEDs
wire [15:0] decoded_word = {{6{1'b0}}, d_in^invert^{10{sw0}}};

//fastpll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk));
//ege_pll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk));
slow_pll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk));
//modulator mod(clk, rst, load, result_out, new_word, xor_result);
//assign demodulated = xor_result;
x7segbAc disp(.x(decoded_word), .HX3(HEX3), .HX2(HEX2), .HX1(HEX1), .HX0(HEX0));

// LVDS requires negated output
//assign demodulated = ~neg_demodulated;

endmodule