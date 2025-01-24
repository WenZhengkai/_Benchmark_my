module dut(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_credit,
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
  reg [2:0] curCreditReg; // @[dut.scala 22:29]
  reg [7:0] dataOut; // @[dut.scala 23:20]
  reg  validOut; // @[dut.scala 24:25]
  wire [2:0] _curCreditReg_T_1 = curCreditReg + 3'h1; // @[dut.scala 29:34]
  wire [2:0] _curCreditReg_T_3 = curCreditReg - 3'h1; // @[dut.scala 31:34]
  wire  _GEN_2 = ~validOut | io_credit ? 1'h0 : validOut; // @[dut.scala 41:40 42:14 24:25]
  wire  _GEN_4 = io_enq_valid & io_enq_ready | _GEN_2; // @[dut.scala 38:39 40:14]
  assign io_enq_ready = curCreditReg > 3'h0; // @[dut.scala 35:32]
  assign io_deq_valid = validOut; // @[dut.scala 47:16]
  assign io_deq_bits = dataOut; // @[dut.scala 46:15]
  assign io_curCredit = curCreditReg; // @[dut.scala 49:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:29]
      curCreditReg <= 3'h5; // @[dut.scala 22:29]
    end else if (io_credit & ~io_deq_valid) begin // @[dut.scala 28:37]
      curCreditReg <= _curCreditReg_T_1; // @[dut.scala 29:18]
    end else if (~io_credit & io_deq_valid) begin // @[dut.scala 30:44]
      curCreditReg <= _curCreditReg_T_3; // @[dut.scala 31:18]
    end
    if (io_enq_valid & io_enq_ready) begin // @[dut.scala 38:39]
      dataOut <= io_enq_bits; // @[dut.scala 39:13]
    end
    if (reset) begin // @[dut.scala 24:25]
      validOut <= 1'h0; // @[dut.scala 24:25]
    end else begin
      validOut <= _GEN_4;
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
  curCreditReg = _RAND_0[2:0];
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
