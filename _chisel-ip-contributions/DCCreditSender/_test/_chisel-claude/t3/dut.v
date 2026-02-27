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
`endif // RANDOMIZE_REG_INIT
  reg [2:0] creditCounter; // @[dut.scala 23:30]
  reg  icredit; // @[dut.scala 26:24]
  reg  validOut; // @[dut.scala 29:25]
  wire  _dataOut_T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  reg [7:0] dataOut; // @[Reg.scala 19:16]
  wire [2:0] _creditCounter_T_1 = creditCounter + 3'h1; // @[dut.scala 37:36]
  wire [2:0] _creditCounter_T_3 = creditCounter - 3'h1; // @[dut.scala 39:36]
  wire  _validOut_T_1 = icredit ? 1'h0 : validOut; // @[dut.scala 52:22]
  assign io_enq_ready = creditCounter > 3'h0; // @[dut.scala 48:33]
  assign io_deq_valid = validOut; // @[dut.scala 55:16]
  assign io_deq_bits = dataOut; // @[dut.scala 56:15]
  assign io_curCredit = creditCounter; // @[dut.scala 57:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 23:30]
      creditCounter <= 3'h5; // @[dut.scala 23:30]
    end else if (creditCounter > 3'h5) begin // @[dut.scala 43:37]
      creditCounter <= 3'h5; // @[dut.scala 44:19]
    end else if (icredit & ~_dataOut_T) begin // @[dut.scala 36:35]
      creditCounter <= _creditCounter_T_1; // @[dut.scala 37:19]
    end else if (~icredit & _dataOut_T) begin // @[dut.scala 38:41]
      creditCounter <= _creditCounter_T_3; // @[dut.scala 39:19]
    end
    if (reset) begin // @[dut.scala 26:24]
      icredit <= 1'h0; // @[dut.scala 26:24]
    end else begin
      icredit <= io_deq_credit; // @[dut.scala 26:24]
    end
    if (reset) begin // @[dut.scala 29:25]
      validOut <= 1'h0; // @[dut.scala 29:25]
    end else begin
      validOut <= _dataOut_T | _validOut_T_1; // @[dut.scala 51:12]
    end
    if (_dataOut_T) begin // @[Reg.scala 20:18]
      dataOut <= io_enq_bits; // @[Reg.scala 20:22]
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
  creditCounter = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  icredit = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  validOut = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  dataOut = _RAND_3[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
