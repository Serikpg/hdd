
`timescale 1ns/10ps

module tb_booth;
	// define the simulation signals
	logic [15:0] data_a, data_b;
	logic [31:0] result;
	logic clk, resetn, start, busy, irq, ack;

	task setoperands;
		input 	logic [15:0] 	a;
		input 	logic [15:0] 	b;
	begin
		$display("starting task");
		wait(!busy);
		data_a = a;
		data_b = b;
		##5;
		start = 1'b1;
		wait(irq);
		##4;
		ack = 1'b1;
		wait(!busy);
		start = 0;
	end;
	endtask


	// instantiation of the DUT radix-4 booth multiplier module
	booth dut_booth_multiplier ( .* );

	always #5 clk = !clk; // default 100MHz clock

	// use clocking statement for leting SystemVerilog know which is the
	// default clockig event to respond to ##
	clocking main_cb @(posedge clk);
	endclocking
	default clocking main_cb;

	initial begin
		resetn = '0;
		clk = '0;
		ack = '0;
		data_a = '0;
		data_b = '0;
		start = '0;

		##5; // after 5 cycles
		resetn = 1;
		##20;
		
		// Positive x Positive
		$display("[TEST] Positive x Positive\n");
		setoperands(15'sd3, 15'sd5);
		$display("Result: %0d, Expected: %0d\n", result, 15'sd3 * 15'sd5);

		// Negative x Positive
		$display("[TEST] Negative x Positive\n");
		setoperands(-15'sd10, 15'sd6);
		$display("Result: %0d, Expected: %0d\n", result, -15'sd10 * 15'sd6);

		// Positive x Negative
		$display("[TEST] Positive x Negative\n");
		setoperands(15'sd16, -15'sd3);
		$display("Result: %0d, Expected: %0d\n", result, 15'sd16 * -15'sd3);

		// Negative x Negative
		$display("[TEST] Negative x Negative\n");
		setoperands(-15'sd10, -15'sd4);
		$display("Result: %0d, Expected: %0d\n", result, -15'sd10 * -15'sd4);

		// Zero x Positive
		$display("[TEST] Positive x Zero\n");
		setoperands(15'sd30, 15'sd0);
		$display("Result: %0d, Expected: %0d\n", result, 15'sd30 * 15'sd0);

		// Zero x Negative
		$display("[TEST] Negative x Zero\n");
		setoperands(-15'sd20, 15'sd0);
		$display("Result: %0d, Expected: %0d\n", result, -15'sd20 * 15'sd0);

		$display("[TEST] ----------\n");
		setoperands(15'sd28, 15'sd2);
		$display("Result: %0d, Expected: %0d\n", result, 15'sd28 * 15'sd2);

		$display("[TEST] ----------\n");
		setoperands(15'sd20, 15'sd5);
		$display("Result: %0d, Expected: %0d\n", result, 15'sd20 * 15'sd5);

		$display("All tests finished\n");

		##10;
	end
endmodule
