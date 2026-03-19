`timescale 1ns / 1 ps

module count28(clk, resetn, enable, count28_out);

// This module implements the functionality of a 28-bit binary
// counter with synchronous reset (active low) and enable.
// The reset signal comes from button KEY0 and the enable signal 
// from switch SW0. The clock signal has a frequency of 50 MHz.
// The 10 most significant bits of the counter drive the LEDs of 
// the board.


input clk;			// global clock signal, with a frequency of 50 MHz
input resetn;			// synchronous reset input, active low
input enable;			// enable input, active high
output [9:0] count28_out;	// 10 most significant bits of the counter that drive the LEDs


reg [1:0] resetn_sync;	// registers used to implement the synchronizer for the reset signal
reg [1:0] enable_sync;	// registers used to implement the synchronizer for the reset signal
reg [27:0] count;	// 28-bit counter


assign count28_out = count[27:18]; // output assignment


// synchronizer for the reset signal

always @(posedge clk)
begin
	resetn_sync <= {resetn_sync[0],resetn};
end

// synchronizer for the enable signal

always @(posedge clk)
begin
	enable_sync <= {enable_sync[0],enable};
end

// 28-bit counter functionality

always @(posedge clk)
begin
	if(!resetn_sync[1]) // reset detection
		 count <= 0;
	else
		if (enable_sync[1]) // counter enabled
			count <= count + 1;
end

endmodule
