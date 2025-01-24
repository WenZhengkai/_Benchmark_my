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
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] curCredit; // @[dut.scala 24:26]
  reg [7:0] dataOut; // @[dut.scala 25:20]
  reg  validOut; // @[dut.scala 26:25]
  wire [2:0] _curCredit_T_1 = curCredit - 3'h1; // @[dut.scala 42:28]
  wire  _GEN_2 = io_enq_valid & io_enq_ready | validOut; // @[dut.scala 39:39 41:14 26:25]
  wire [2:0] _GEN_3 = io_enq_valid & io_enq_ready ? _curCredit_T_1 : curCredit; // @[dut.scala 39:39 42:15 24:26]
  wire [2:0] _curCredit_T_3 = curCredit + 3'h1; // @[dut.scala 48:30]
  assign io_enq_ready = curCredit > 3'h0; // @[dut.scala 29:29]
  assign io_deq_valid = validOut; // @[dut.scala 53:16]
  assign io_deq_bits = dataOut; // @[dut.scala 54:15]
  assign io_curCredit = curCredit; // @[dut.scala 55:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 24:26]
      curCredit <= 3'h5; // @[dut.scala 24:26]
    end else if (io_deq_credit & validOut) begin // @[dut.scala 45:36]
      if (~io_enq_valid | ~io_enq_ready) begin // @[dut.scala 47:43]
        curCredit <= _curCredit_T_3; // @[dut.scala 48:17]
      end else begin
        curCredit <= _GEN_3;
      end
    end else begin
      curCredit <= _GEN_3;
    end
    if (io_enq_valid & io_enq_ready) begin // @[dut.scala 39:39]
      dataOut <= io_enq_bits; // @[dut.scala 40:13]
    end
    if (reset) begin // @[dut.scala 26:25]
      validOut <= 1'h0; // @[dut.scala 26:25]
    end else if (io_deq_credit & validOut) begin // @[dut.scala 45:36]
      validOut <= 1'h0; // @[dut.scala 46:14]
    end else begin
      validOut <= _GEN_2;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  curCredit = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  dataOut = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  validOut = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
