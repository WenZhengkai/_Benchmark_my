module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_reset
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevS; // @[dut.scala 15:22]
  wire  _io_dfr_T = prevS < io_s; // @[dut.scala 43:23]
  wire  _T_3 = io_s == 3'h0; // @[dut.scala 51:21]
  wire  _GEN_1 = io_s == 3'h1 ? 1'h0 : _T_3; // @[dut.scala 44:35 46:14]
  wire  _GEN_2 = io_s == 3'h1 | _T_3; // @[dut.scala 44:35 47:14]
  wire  _GEN_3 = io_s == 3'h1 ? _io_dfr_T : _T_3; // @[dut.scala 44:35 50:14]
  wire  _GEN_4 = io_s == 3'h3 ? 1'h0 : _GEN_1; // @[dut.scala 37:35 39:14]
  wire  _GEN_5 = io_s == 3'h3 ? 1'h0 : _GEN_2; // @[dut.scala 37:35 40:14]
  wire  _GEN_6 = io_s == 3'h3 | _GEN_2; // @[dut.scala 37:35 41:14]
  wire  _GEN_7 = io_s == 3'h3 ? prevS < io_s : _GEN_3; // @[dut.scala 37:35 43:14]
  wire  _GEN_8 = io_s == 3'h7 ? 1'h0 : _GEN_4; // @[dut.scala 31:29 33:14]
  wire  _GEN_9 = io_s == 3'h7 ? 1'h0 : _GEN_5; // @[dut.scala 31:29 34:14]
  wire  _GEN_10 = io_s == 3'h7 ? 1'h0 : _GEN_6; // @[dut.scala 31:29 35:14]
  wire  _GEN_11 = io_s == 3'h7 ? 1'h0 : _GEN_7; // @[dut.scala 31:29 36:14]
  assign io_fr3 = io_reset | _GEN_8; // @[dut.scala 24:18 25:12]
  assign io_fr2 = io_reset | _GEN_9; // @[dut.scala 24:18 26:12]
  assign io_fr1 = io_reset | _GEN_10; // @[dut.scala 24:18 27:12]
  assign io_dfr = io_reset | _GEN_11; // @[dut.scala 24:18 28:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:22]
      prevS <= 3'h0; // @[dut.scala 15:22]
    end else begin
      prevS <= io_s; // @[dut.scala 62:9]
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
  prevS = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
