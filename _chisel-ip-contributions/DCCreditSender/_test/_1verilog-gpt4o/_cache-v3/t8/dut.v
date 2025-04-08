module dut(
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

  // Parameter for the maximum credits
  localparam MAX_CREDIT = 3'd7;

  // Internal registers
  reg [2:0] curCredit;
  reg [7:0] dataOut;
  reg       validOut;
  reg       icredit;

  // Assigning the output current credit
  assign io_curCredit = curCredit;

  // Initialize or reset logic for the internal registers
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      curCredit <= MAX_CREDIT;
      dataOut   <= 8'b0;
      validOut  <= 1'b0;
      icredit   <= 1'b0;
    end else begin
      icredit <= io_deq_credit;
      
      // Logic for updating current credit based on icredit and enq.fire
      if (icredit && !io_enq_valid) begin
        if (curCredit < MAX_CREDIT) begin
          curCredit <= curCredit + 1;
        end
      end else if (!icredit && io_enq_valid && io_enq_ready) begin
        curCredit <= curCredit - 1;
      end

      // Data and valid registers update
      if (io_enq_valid && io_enq_ready) begin
        dataOut <= io_enq_bits;
        validOut <= 1'b1;
      end else if (io_deq_valid && io_deq_credit) begin
        validOut <= 1'b0;
      end
    end
  end

  // Enqueue ready logic
  assign io_enq_ready = (curCredit > 0);

  // Dequeue logic
  assign io_deq_valid = validOut;
  assign io_deq_bits = dataOut;

endmodule
