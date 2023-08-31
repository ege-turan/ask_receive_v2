// Ege Turan
// 8/30/23, Stanford, CA
// Microwave Link Receive System

module top (
	input MAX10_CLK1_50, RCLK, // rst, load,
	input R0, R1, R2, R3, R4, R5, R6, R7, R8, R9,
	output [6:0] HEX0, HEX1, HEX2, HEX3,
	output refclk
	);
	
//wire result_out, xor_result, clk;
wire [9:0] r_in;
wire [9:0] d_in;

//assign r_in = {R9, R8, R7, R6, R5, R4, R3, R2, R1, R0};
assign r_in = {R0, R1, R2, R3, R4, R5, R6, R7, R8, R9};


// DESCRAMBLER Control

descramble sd(.rclk(RCLK), .scrambled(r_in), .descrambled(d_in)); //activate descramble
//assign d_in = r_in; //deactive descramble



// 10 bits given from deserializer must be routed to LEDs
wire [15:0] decoded_word = {{6{1'b0}}, d_in};

// Clock (speed) control:

fast_pll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk));		// activate for 240 Mbps (actual 200 Mbps data transfer)
//slow_pll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk)); 	// activate for 120 Mbps (actual 100 Mbps data transfer)

//fastpll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk));		// For random words (previous work)
//ege_pll pll_inst(.inclk0(MAX10_CLK1_50), .c1(refclk));		// For testing


x7segbAc disp(.x(decoded_word), .HX3(HEX3), .HX2(HEX2), .HX1(HEX1), .HX0(HEX0));

endmodule