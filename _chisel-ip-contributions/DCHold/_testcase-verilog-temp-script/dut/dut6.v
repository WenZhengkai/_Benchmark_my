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

  // Internal registers
  reg          pValid;
  reg  [7:0]   pData;
  
  // Sequential logic
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      // Initialize registers on reset
      pValid <= 1'b0;
      pData  <= 8'b0;
    end else begin
      // Hold data if enq valid and we have no current valid data
      if (io_enq_valid && !pValid) begin
        pData  <= io_enq_bits;
        pValid <= 1'b1;
      end

      // Clear hold if dequeued successfully
      if (io_deq_ready && pValid) begin
        pValid <= 1'b0;
      end
    end
  end
  
  // Combinational logic
  assign io_deq_valid = pValid;
  assign io_deq_bits  = pData;
  
  // enq_ready is high when the dut is not holding any data
  assign io_enq_ready = !pValid;

endmodule
