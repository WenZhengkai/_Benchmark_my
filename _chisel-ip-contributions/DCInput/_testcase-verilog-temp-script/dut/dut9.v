module dut(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input   [7:0]  io_enq_bits,
  input          io_deq_ready,
  output         io_deq_valid,
  output  [7:0]  io_deq_bits
);

  // Internal registers and wires
  reg            ready_r;
  reg            occupied;
  reg     [7:0]  hold;
  wire           load;
  wire           drain;

  // Combinational logic for load and drain
  assign drain = occupied && io_deq_ready;
  assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);

  // Combinational logic for output data (deq.bits) and validity (deq.valid)
  assign io_deq_bits = occupied ? hold : io_enq_bits;
  assign io_deq_valid = io_enq_valid || occupied;

  // Combinational logic for enq.ready
  assign io_enq_ready = ready_r;

  // Sequential logic for state updates
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ready_r <= 1'b1;
      occupied <= 1'b0;
    end else begin
      if (load) begin
        hold <= io_enq_bits; // Store incoming data
        occupied <= 1'b1;
      end
      if (drain) begin
        occupied <= 1'b0;
      end

      // Determine ready_r based on current states
      ready_r <= !occupied || drain || load;
    end
  end

endmodule
