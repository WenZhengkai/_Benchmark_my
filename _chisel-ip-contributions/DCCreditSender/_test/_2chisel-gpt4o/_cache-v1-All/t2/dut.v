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
  reg [7:0] dataOut; // @[dut.scala 26:20]
  reg  validOut; // @[dut.scala 27:25]
  wire [2:0] _curCreditReg_T_1 = curCreditReg + 3'h1; // @[dut.scala 35:34]
  wire [2:0] _curCreditReg_T_3 = curCreditReg - 3'h1; // @[dut.scala 37:34]
  wire  _T_4 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  assign io_enq_ready = curCreditReg > 3'h0; // @[dut.scala 42:32]
  assign io_deq_valid = validOut; // @[dut.scala 60:16]
  assign io_deq_bits = dataOut; // @[dut.scala 59:15]
  assign io_curCredit = curCreditReg; // @[dut.scala 61:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:29]
      curCreditReg <= 3'h5; // @[dut.scala 22:29]
    end else if (io_credit & ~io_deq_valid) begin // @[dut.scala 34:36]
      curCreditReg <= _curCreditReg_T_1; // @[dut.scala 35:18]
    end else if (io_deq_valid & ~io_credit) begin // @[dut.scala 36:42]
      curCreditReg <= _curCreditReg_T_3; // @[dut.scala 37:18]
    end
    if (_T_4) begin // @[dut.scala 47:23]
      dataOut <= io_enq_bits; // @[dut.scala 48:13]
    end
    if (reset) begin // @[dut.scala 27:25]
      validOut <= 1'h0; // @[dut.scala 27:25]
    end else begin
      validOut <= _T_4;
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
