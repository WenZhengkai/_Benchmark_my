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
  reg [7:0] dataOut; // @[dut.scala 27:20]
  reg  validOut; // @[dut.scala 28:25]
  wire [2:0] _curCredit_T_1 = curCredit + 3'h1; // @[dut.scala 40:30]
  wire  _T_3 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _curCredit_T_3 = curCredit - 3'h1; // @[dut.scala 44:30]
  wire  _GEN_5 = io_deq_credit ? 1'h0 : validOut; // @[dut.scala 55:30 56:14 28:25]
  wire  _GEN_7 = _T_3 | _GEN_5; // @[dut.scala 52:23 54:14]
  assign io_enq_ready = curCredit != 3'h0; // @[dut.scala 49:30]
  assign io_deq_valid = validOut; // @[dut.scala 60:16]
  assign io_deq_bits = dataOut; // @[dut.scala 61:15]
  assign io_curCredit = curCredit; // @[dut.scala 64:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 24:26]
      curCredit <= 3'h5; // @[dut.scala 24:26]
    end else if (io_deq_credit & ~io_enq_valid) begin // @[dut.scala 38:40]
      if (curCredit != 3'h5) begin // @[dut.scala 39:37]
        curCredit <= _curCredit_T_1; // @[dut.scala 40:17]
      end
    end else if (_T_3) begin // @[dut.scala 42:30]
      if (curCredit != 3'h0) begin // @[dut.scala 43:29]
        curCredit <= _curCredit_T_3; // @[dut.scala 44:17]
      end
    end
    if (_T_3) begin // @[dut.scala 52:23]
      dataOut <= io_enq_bits; // @[dut.scala 53:13]
    end
    if (reset) begin // @[dut.scala 28:25]
      validOut <= 1'h0; // @[dut.scala 28:25]
    end else begin
      validOut <= _GEN_7;
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
