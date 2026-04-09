
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
		##4;
		$display("starting task");
		wait(!busy);
		data_a = a;
		data_b = b;
		##5;
		start = 1'b1;
		wait(irq);
		##5;
		ack = 1'b1;
		##2;
		wait(!busy);
		ack = '0;
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
                setoperands(16'sd3, 16'sd5);
                $display("Result: %0d, Expected: %0d\n", $signed(result), 16'sd3 * 16'sd5);
                assert ($signed(result) == (16'sd3 * 16'sd5)) else $error("not equal case pos x pos");

                // Negative x Positive
                $display("[TEST] Negative x Positive\n");
                setoperands(-16'sd10, 16'sd6);
                $display("Result: %0d, Expected: %0d\n", $signed(result), -16'sd10 * 16'sd6);
                assert ($signed(result) == (-16'sd10 * 16'sd6)) else $error("not equal case neg x pos");

                // Positive x Negative
                $display("[TEST] Positive x Negative\n");
                setoperands(16'sd16, -16'sd3);
                $display("Result: %0d, Expected: %0d\n", $signed(result), 16'sd16 * -16'sd3);
                assert ($signed(result) == (16'sd16 * -16'sd3)) else $error("not equal case pos x neg");

                // Negative x Negative
                $display("[TEST] Negative x Negative\n");
                setoperands(-16'sd10, -16'sd4);
                $display("Result: %0d, Expected: %0d\n", $signed(result), -16'sd10 * -16'sd4);
                assert ($signed(result) == (-16'sd10 * -16'sd4)) else $error("not equal case neg x neg");

                // Positive x Zero
                $display("[TEST] Positive x Zero\n");
                setoperands(16'sd30, 16'sd0);
                $display("Result: %0d, Expected: %0d\n", $signed(result), 16'sd30 * 16'sd0);
                assert ($signed(result) == (16'sd30 * 16'sd0)) else $error("not equal case pos x zero");

                // Negative x Zero
                $display("[TEST] Negative x Zero\n");
                setoperands(-16'sd20, 16'sd0);
                $display("Result: %0d, Expected: %0d\n", $signed(result), -16'sd20 * 16'sd0);
                assert ($signed(result) == (-16'sd20 * 16'sd0)) else $error("not equal case neg x zero");

                $display("[TEST] ----------\n");
                setoperands(16'sd28, 16'sd2);
                $display("Result: %0d, Expected: %0d\n", $signed(result), 16'sd28 * 16'sd2);
                assert ($signed(result) == (16'sd28 * 16'sd2)) else $error("not equal case 28 x 2");

                $display("[TEST] ----------\n");
                setoperands(16'sd20, 16'sd5);
                $display("Result: %0d, Expected: %0d\n", $signed(result), 16'sd20 * 16'sd5);
                assert ($signed(result) == (16'sd20 * 16'sd5)) else $error("not equal case 20 x 5");

                $display("All tests finished\n");

		##10;
	end
endmodule
