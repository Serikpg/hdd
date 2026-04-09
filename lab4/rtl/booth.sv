module booth(
  input           clk    , // global clock signal, 100 MHz frequency
  input           resetn , // global reset signal, active low
  input           start  , // signal that activates the multiplication process by a rising edge
  output          busy   , // output that indicates that a multiplication process is in progress
  output          irq    , // IRQ signal activated when the multiplication has completed
  input           ack    , // Input used to deassert the IRQ and busy outputs
  input  [15:0]   data_a , // First 16-bit operand
  input  [15:0]   data_b , // Second 16-bit operand
  output [31:0]   result   // result of the multiplication
);

logic [3:0]   state;
logic [32:0]  result_f;

logic [2:0]   window;
logic [17:0]  mux_out;
logic         sub_ctrl;
logic [17:0]  operand_b;
logic [17:0]  upper_sum;

logic old_ack; 

always_ff @(posedge clk) begin
  if (!resetn) begin
    old_ack <= '0; 
  end else begin
    old_ack <= ack;
  end
end

// state will serve as counter indexing combinational shifters
always_ff @(posedge clk) begin
  // on synch reset or on ack return to the INITAL state 3'h0
  if (!resetn) begin
    state <= '0;
  end else begin
    if (state == 4'h0) begin
      if ((!ack) && start) begin
        state <= 4'h1;
      end
    end else if (state == 4'h9) begin
      if ((old_ack == 1'b0) && (ack == 1'b1)) begin
        state <= '0;
      end
    end else begin
      state <= state + 4'h1;
    end
    // hold final state when reaching 3'h9
  end
end

assign window = result_f[2:0];

always_comb begin
    case (window)
        3'b001, 3'b010: mux_out = {data_a[15], data_a[15], data_a };  // +1 * M
        3'b011:         mux_out = {data_a[15], data_a, 1'b0 };        // +2 * M
        3'b100:         mux_out = {data_a[15], data_a, 1'b0 };        // -2 * M
        3'b101, 3'b110: mux_out = {data_a[15], data_a[15], data_a };  // -1 * M
        default:        mux_out = '0;                  								// 0
    endcase

		sub_ctrl  = window[2];
    operand_b = mux_out ^ {18{sub_ctrl}};
    upper_sum = {result_f[32], result_f[32], result_f[32:17]} + operand_b + {17'd0, sub_ctrl};
end


// result will be a shift register
always_ff @(posedge clk) begin
  if (state == 4'h0) begin
    result_f <= {16'd0, data_b, 1'b0};
  end else if (state != 4'h9) begin
    result_f <= {upper_sum, result_f[16:2]};
  end
end

assign result = result_f[32:1]; // we may need to drop the final bit to get actual result
assign busy = (state != 4'h0);
assign irq = (state == 4'h9);
// assign irq = irq_enabled ? (state == 4'h9) : '0);

endmodule
