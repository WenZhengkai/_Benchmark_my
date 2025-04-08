module dut (
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  output       io_deq_valid,
  input        io_deq_credit,
  output [7:0] io_deq_bits,
  output [2:0] io_curCredit
);

  // Internal credit register to track the latched credit signal.
  reg icredit;
  // Current credit counter register.
  reg [2:0] curCredit;
  // Data output register for holding the data to be dequeued.
  reg [7:0] dataOut;
  // Valid output register indicates if dataOut holds valid data.
  reg validOut;

  // Maximum credit value we can handle (set based on requirement, here assumed 3-bit max).
  parameter maxCredit = 3'b111;

  // Wire declarations for signals.
  wire enq_fire;
  wire deq_fire;

  // enq_fire is true when both enqueue valid and ready are high; data is transferred.
  assign enq_fire = io_enq_ready && io_enq_valid;

  // deq_fire is true when valid output data and credit are present for dequeue.
  assign deq_fire = validOut && io_deq_credit;

  // Ready signal is high if there is at least one credit available.
  assign io_enq_ready = curCredit > 0;

  // If valid, the output is driven by dataOut and the valid status.
  assign io_deq_valid = validOut;
  assign io_deq_bits = dataOut;

  // Expose current credit count.
  assign io_curCredit = curCredit;

  // Sequential logic
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      curCredit <= maxCredit;
      icredit <= 1'b0;
      validOut <= 1'b0;
    end else begin
      // Latch the credit signal (simplifying to single-cycle handling here).
      icredit <= io_deq_credit;
      
      // Handle credit increments or decrements.
      if (deq_fire) begin
        // Decrement available credits following a successful dequeue.
        curCredit <= curCredit - 1;
        validOut <= 1'b0;  // Reset validOut after successful dequeue
      end else if (icredit && !enq_fire) begin
        // Increment credits if new credit received and enqueue not firing.
        curCredit <= curCredit + 1;
      end

      if (enq_fire) begin
        // Capture incoming data upon enqueue fire and become ready for dequeue.
        dataOut <= io_enq_bits;
        validOut <= 1'b1;
        curCredit <= curCredit - 1; // decrement credit as data is being enqueued
      end
    end
  end
endmodule
