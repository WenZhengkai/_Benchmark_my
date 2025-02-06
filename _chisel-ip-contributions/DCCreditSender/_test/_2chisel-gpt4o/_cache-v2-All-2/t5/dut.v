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
  reg [2:0] curCredit; // @[dut.scala 25:26]
  wire [2:0] _curCredit_T_1 = curCredit + 3'h1; // @[dut.scala 29:28]
  wire [2:0] _curCredit_T_3 = curCredit - 3'h1; // @[dut.scala 34:28]
  wire  _dataOut_T = io_enq_valid & io_enq_ready; // @[dut.scala 43:53]
  reg [7:0] dataOut; // @[Reg.scala 19:16]
  wire  _validOut_T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  reg  validOut; // @[dut.scala 44:25]
  assign io_enq_ready = curCredit > 3'h0; // @[dut.scala 40:29]
  assign io_deq_valid = validOut; // @[dut.scala 48:16]
  assign io_deq_bits = dataOut; // @[dut.scala 47:15]
  assign io_curCredit = curCredit; // @[dut.scala 37:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 25:26]
      curCredit <= 3'h5; // @[dut.scala 25:26]
    end else if (io_deq_valid & ~io_deq_credit) begin // @[dut.scala 33:40]
      curCredit <= _curCredit_T_3; // @[dut.scala 34:15]
    end else if (io_deq_credit & ~io_deq_valid) begin // @[dut.scala 28:40]
      curCredit <= _curCredit_T_1; // @[dut.scala 29:15]
    end
    if (_dataOut_T) begin // @[Reg.scala 20:18]
      dataOut <= io_enq_bits; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[dut.scala 44:25]
      validOut <= 1'h0; // @[dut.scala 44:25]
    end else begin
      validOut <= _validOut_T; // @[dut.scala 44:25]
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
