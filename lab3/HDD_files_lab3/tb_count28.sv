`timescale 1 ns / 1 ps

module tb_count28;

// Testbench for the 28-bit counter module 
// described in the count28.sv file

	// internal signals used to apply stimuli

	reg clk, resetn, enable;
	wire [9:0] count28_out;

	// instantiation of the counter

	count28 count28_instance(.clk(clk), .resetn(resetn), .enable(enable), .count28_out(count28_out));

	// generation of the clock signal

	always
		#10 clk = ~clk;

	// definition of the stimuli

	initial
	begin
		// initial conditions

		clk = 0; resetn = 1; enable = 0;
		#5 resetn = 0;		// reset for the system
		#40 resetn =1;
		#20 enable = 1;	// counter enabled

	end

	// monitoring of results

	initial
		$monitor($time,,,"clk=%b resetn=%b enable=%b count_out=%d",clk,resetn,enable,count28_out);

endmodule
