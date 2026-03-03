module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_rst,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _currLevel_T_3 = io_s[1] + io_s[2]; // @[Bitwise.scala 51:90]
  wire [1:0] _GEN_20 = {{1'd0}, io_s[0]}; // @[Bitwise.scala 51:90]
  wire [2:0] _currLevel_T_5 = _GEN_20 + _currLevel_T_3; // @[Bitwise.scala 51:90]
  wire [1:0] currLevel = _currLevel_T_5[1:0]; // @[Bitwise.scala 51:90]
  reg [1:0] lastLevel; // @[dut.scala 25:34]
  reg [1:0] prevLevelAtChange; // @[dut.scala 26:34]
  wire  _effectivePrev_T = currLevel != lastLevel; // @[dut.scala 31:34]
  wire [1:0] effectivePrev = currLevel != lastLevel ? lastLevel : prevLevelAtChange; // @[dut.scala 31:23]
  wire  _io_dfr_T = effectivePrev < currLevel; // @[dut.scala 70:33]
  wire  _GEN_5 = 2'h1 == currLevel | 2'h0 == currLevel; // @[dut.scala 59:23 73:16]
  wire  _GEN_6 = 2'h1 == currLevel ? 1'h0 : 2'h0 == currLevel; // @[dut.scala 59:23 75:16]
  wire  _GEN_7 = 2'h1 == currLevel ? _io_dfr_T : 2'h0 == currLevel; // @[dut.scala 59:23 76:16]
  wire  _GEN_8 = 2'h2 == currLevel | _GEN_5; // @[dut.scala 59:23 67:16]
  wire  _GEN_9 = 2'h2 == currLevel ? 1'h0 : _GEN_5; // @[dut.scala 59:23 68:16]
  wire  _GEN_10 = 2'h2 == currLevel ? 1'h0 : _GEN_6; // @[dut.scala 59:23 69:16]
  wire  _GEN_11 = 2'h2 == currLevel ? effectivePrev < currLevel : _GEN_7; // @[dut.scala 59:23 70:16]
  wire  _GEN_12 = 2'h3 == currLevel ? 1'h0 : _GEN_8; // @[dut.scala 59:23 61:16]
  wire  _GEN_13 = 2'h3 == currLevel ? 1'h0 : _GEN_9; // @[dut.scala 59:23 62:16]
  wire  _GEN_14 = 2'h3 == currLevel ? 1'h0 : _GEN_10; // @[dut.scala 59:23 63:16]
  wire  _GEN_15 = 2'h3 == currLevel ? 1'h0 : _GEN_11; // @[dut.scala 59:23 64:16]
  assign io_fr3 = io_rst | _GEN_14; // @[dut.scala 52:16 56:12]
  assign io_fr2 = io_rst | _GEN_13; // @[dut.scala 52:16 55:12]
  assign io_fr1 = io_rst | _GEN_12; // @[dut.scala 52:16 54:12]
  assign io_dfr = io_rst | _GEN_15; // @[dut.scala 52:16 57:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 25:34]
      lastLevel <= 2'h0; // @[dut.scala 25:34]
    end else if (io_rst) begin // @[dut.scala 33:16]
      lastLevel <= 2'h0; // @[dut.scala 36:15]
    end else if (_effectivePrev_T) begin // @[dut.scala 39:35]
      lastLevel <= currLevel; // @[dut.scala 41:17]
    end
    if (reset) begin // @[dut.scala 26:34]
      prevLevelAtChange <= 2'h0; // @[dut.scala 26:34]
    end else if (io_rst) begin // @[dut.scala 33:16]
      prevLevelAtChange <= 2'h0; // @[dut.scala 37:23]
    end else if (currLevel != lastLevel) begin // @[dut.scala 31:23]
      prevLevelAtChange <= lastLevel;
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
  lastLevel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  prevLevelAtChange = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
