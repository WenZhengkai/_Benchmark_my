module dut(
    input        clock,
    input        reset,
    output       io_enq_ready,
    input        io_enq_valid,
    input [7:0]  io_enq_bits,
    output       io_deq_valid,
    input        io_deq_credit,
    output [7:0] io_deq_bits,
    output [2:0] io_curCredit
);

  reg [2:0] curCredit;
  reg [7:0] dataOut;
  reg validOut;
  reg icredit;

  // Initial block for resetting or initializing values
  initial begin
    curCredit <= 3'd0;
    dataOut <= 8'b0;
    validOut <= 1'b0;
    icredit <= 1'b0;
  end

  // Logic for credit register
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      icredit <= 1'b0;
    end else begin
      icredit <= io_deq_credit;
    end
  end

  // Logic for credit counter
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      curCredit <= 3'd7; // Assuming maxCredit is 7
    end else begin
      if (icredit && !io_enq_valid) begin
        // Increment credit when a credit is received and not enqueueing data
        curCredit <= curCredit + 3'd1;
      end else if (!icredit && io_enq_ready && io_enq_valid) begin
        // Decrement credit when data is sent
        curCredit <= curCredit - 3'd1;
      end
    end
  end

  // Logic for the enqueue ready signal
  assign io_enq_ready = (curCredit > 3'd0);

  // Logic for data storage and valid flag
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      dataOut <= 8'b0;
      validOut <= 1'b0;
    end else begin
      if (io_enq_ready && io_enq_valid) begin
        dataOut <= io_enq_bits;
        validOut <= 1'b1;
      end else if (validOut && io_deq_credit) begin
        validOut <= 1'b0;
      end
    end
  end

  // Assign outputs
  assign io_deq_valid = validOut;
  assign io_deq_bits = dataOut;
  assign io_curCredit = curCredit;

endmodule
