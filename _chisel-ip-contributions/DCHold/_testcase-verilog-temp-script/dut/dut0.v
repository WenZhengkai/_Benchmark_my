module dut(
    input        clock,
    input        reset,
    output       io_enq_ready,
    input        io_enq_valid,
    input  [7:0] io_enq_bits,
    input        io_deq_ready,
    output       io_deq_valid,
    output [7:0] io_deq_bits
);

  // Internal register to hold valid status
  reg pValid;
  // Internal register to hold data
  reg [7:0] pData;

  // Output assignments
  assign io_deq_valid = pValid;
  assign io_deq_bits = pData;
  assign io_enq_ready = ~pValid;

  // Sequential logic for data holding
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      pValid <= 1'b0;
      pData <= 8'b0;
    end else begin
      // Loading new data when enq.valid is set and not holding valid data
      if (io_enq_valid && io_enq_ready) begin
        pData <= io_enq_bits;
        pValid <= 1'b1;
      end
      // Unloading data when deq.ready is set and valid data is being held
      else if (io_deq_ready && pValid) begin
        pValid <= 1'b0;
      end
    end
  end

endmodule
