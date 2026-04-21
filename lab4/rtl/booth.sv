// ------------------------------------------
// booth.sv - Radix 4 Booth Multiplier
// Authors: David Blasco and Serik Perez
// Date: 04/2026
// ------------------------------------------
module booth(
  input           clk        , 	// global clock signal, 100 MHz frequency
  input           resetn     , 	// global reset signal, active low
  input           start      , 	// signal that activates the multiplication process by a rising edge
  output          busy       , 	// output that indicates that a multiplication process is in progress
  output          irq        , 	// IRQ signal activated when the multiplication has completed
  input           ack        , 	// Input used to deassert the IRQ and busy outputs
  input  [15:0]   data_a     , 	// First 16-bit operand
  input  [15:0]   data_b     , 	// Second 16-bit operand
  output [31:0]   result     , 	// result of the multiplication
  input  	      irq_enable    // filter the enabling of interrupt signals (optional part)
);

// definition of signals
logic [3:0]   state;        // state being declared as a counter
logic [32:0]  result_f;     // internal shift register to hold intermediate results

logic [2:0]   window;       // 3-bit window to determine the operation on the multiplicand
logic [17:0]  mux_out;      // out of multiplexer selecting the proper mutliple to add/sub
logic         sub_ctrl;     // control to determine whether add or sub
logic [17:0]  operand_b;    // final operand to be add/sub
logic [17:0]  upper_sum;    // result of the operation loaded to upper part of accomulator

logic old_ack;              // register for ack previous value, edge detection

// ACK register to detect rising edge of ack signal,
// used to return to intial state after the handshake is over
always_ff @(posedge clk) begin
  if (!resetn) begin
    old_ack <= '0; 
  end else begin
    old_ack <= ack;
  end
end

// Main FSM of the Booth Operation
// state 0: idle, waiting for start signal
// state 1-8: performing the multiplication
// state 9: final state, waiting for ack to return to idle
always_ff @(posedge clk) begin
  // on synch reset go to the INITAL state 3'h0
  if (!resetn) begin
    state <= '0;
  end else begin
    // start operation when driver requires it and has read previous results
    if (state == 4'h0) begin
      if ((!ack) && start) begin
        state <= 4'h1;
      end
    // whilst on final state, wait for ack before returning to IDLE state (3'h0)
    end else if (state == 4'h9) begin
      if ((old_ack == 1'b0) && (ack == 1'b1)) begin
        state <= '0;
      end
    // during operation, just increment the counter during operation 
    end else begin
      state <= state + 4'h1;
    end
    // hold final state when reaching 3'h9
  end
end

// window will always match lower bits of the shift accoumulator
assign window = result_f[2:0];

always_comb begin
  // multiplexer to select the multiple of multiplicand to add/subtract
  // based on the present window value (table in the slides)
  case (window)
    3'b001, 3'b010: mux_out = {data_a[15], data_a[15], data_a };  // +1 * M
    3'b011:         mux_out = {data_a[15], data_a, 1'b0 };        // +2 * M
    3'b100:         mux_out = {data_a[15], data_a, 1'b0 };        // -2 * M
    3'b101, 3'b110: mux_out = {data_a[15], data_a[15], data_a };  // -1 * M
    default:        mux_out = '0;                  								// 0
  endcase

  // make explicit that the add/sub operations to be done in a single adder
  // using the 3rd bit of the window as Cin for the first adder
  sub_ctrl  = window[2];
  operand_b = mux_out ^ {18{sub_ctrl}};
  upper_sum = {result_f[32], result_f[32], result_f[32:17]} + operand_b + {17'd0, sub_ctrl};
end


// main accomulator shift register
// it will start with the value of 2nd operand (multiplier) appended with
// a 0 for having the proper window at the 1st cycle
// then it will shift 2 bits right every cycle, overlapping the add/sub results
always_ff @(posedge clk) begin
  if (state == 4'h0) begin
    result_f <= {16'd0, data_b, 1'b0};
  end else if (state != 4'h9) begin
    result_f <= {upper_sum, result_f[16:2]};
  end
end

// output logic and control signaling
assign result = result_f[32:1];               // we may need to drop the final bit to get actual result
assign busy = (state != 4'h0);                // show busy whilst operating and waiting results to be read
assign irq = ((state == 4'h9) && irq_enable); // filtering the IRQ signal with the enable input

endmodule
