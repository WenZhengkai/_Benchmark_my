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
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  icredit; // @[dut.scala 20:24]
  reg [2:0] curCredit; // @[dut.scala 21:26]
  reg  validOut; // @[dut.scala 22:25]
  reg [7:0] dataOut; // @[dut.scala 23:20]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _curCredit_T_2 = curCredit + 3'h1; // @[dut.scala 32:57]
  wire [2:0] _curCredit_T_6 = curCredit - 3'h1; // @[dut.scala 35:49]
  reg  validOut_REG; // @[dut.scala 50:22]
  assign io_enq_ready = curCredit > 3'h0; // @[dut.scala 43:29]
  assign io_deq_valid = validOut; // @[dut.scala 53:16]
  assign io_deq_bits = dataOut; // @[dut.scala 54:15]
  assign io_curCredit = curCredit; // @[dut.scala 39:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:24]
      icredit <= 1'h0; // @[dut.scala 20:24]
    end else begin
      icredit <= io_deq_credit; // @[dut.scala 27:11]
    end
    if (reset) begin // @[dut.scala 21:26]
      curCredit <= 3'h5; // @[dut.scala 21:26]
    end else if (icredit & ~_T) begin // @[dut.scala 30:35]
      if (curCredit < 3'h5) begin // @[dut.scala 32:21]
        curCredit <= _curCredit_T_2;
      end
    end else if (_T & ~icredit) begin // @[dut.scala 33:41]
      if (curCredit > 3'h0) begin // @[dut.scala 35:21]
        curCredit <= _curCredit_T_6;
      end
    end
    if (reset) begin // @[dut.scala 22:25]
      validOut <= 1'h0; // @[dut.scala 22:25]
    end else begin
      validOut <= validOut_REG; // @[dut.scala 50:12]
    end
    if (_T) begin // @[dut.scala 47:23]
      dataOut <= io_enq_bits; // @[dut.scala 48:13]
    end
    if (reset) begin // @[dut.scala 50:22]
      validOut_REG <= 1'h0; // @[dut.scala 50:22]
    end else begin
      validOut_REG <= _T; // @[dut.scala 50:22]
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
  icredit = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  curCredit = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  validOut = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  dataOut = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  validOut_REG = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
