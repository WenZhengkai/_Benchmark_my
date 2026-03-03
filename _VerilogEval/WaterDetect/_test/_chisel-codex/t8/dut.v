module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _GEN_0 = 3'h7 == io_s ? 2'h3 : 2'h0; // @[dut.scala 19:12 20:16 24:29]
  wire [1:0] _GEN_1 = 3'h3 == io_s ? 2'h2 : _GEN_0; // @[dut.scala 20:16 23:29]
  wire [1:0] _GEN_2 = 3'h1 == io_s ? 2'h1 : _GEN_1; // @[dut.scala 20:16 22:29]
  wire [1:0] curLevel = 3'h0 == io_s ? 2'h0 : _GEN_2; // @[dut.scala 20:16 21:29]
  reg [1:0] lastLevel; // @[dut.scala 28:30]
  reg  lastChangeUp; // @[dut.scala 29:30]
  reg  fr1Reg; // @[dut.scala 32:23]
  reg  fr2Reg; // @[dut.scala 33:23]
  reg  fr3Reg; // @[dut.scala 34:23]
  reg  dfrReg; // @[dut.scala 35:23]
  wire  levelChanged = curLevel != lastLevel; // @[dut.scala 42:31]
  wire  changeIsUp = curLevel > lastLevel; // @[dut.scala 43:31]
  wire  midDfr = levelChanged ? changeIsUp : lastChangeUp; // @[dut.scala 44:25]
  wire  _GEN_6 = 2'h0 == curLevel | fr1Reg; // @[dut.scala 62:22 82:16 32:23]
  wire  _GEN_7 = 2'h0 == curLevel | fr2Reg; // @[dut.scala 62:22 83:16 33:23]
  wire  _GEN_8 = 2'h0 == curLevel | fr3Reg; // @[dut.scala 62:22 84:16 34:23]
  wire  _GEN_9 = 2'h0 == curLevel | dfrReg; // @[dut.scala 62:22 85:16 35:23]
  wire  _GEN_10 = 2'h1 == curLevel | _GEN_6; // @[dut.scala 62:22 76:16]
  wire  _GEN_11 = 2'h1 == curLevel | _GEN_7; // @[dut.scala 62:22 77:16]
  wire  _GEN_12 = 2'h1 == curLevel ? 1'h0 : _GEN_8; // @[dut.scala 62:22 78:16]
  wire  _GEN_13 = 2'h1 == curLevel ? midDfr : _GEN_9; // @[dut.scala 62:22 79:16]
  wire  _GEN_14 = 2'h2 == curLevel | _GEN_10; // @[dut.scala 62:22 70:16]
  wire  _GEN_15 = 2'h2 == curLevel ? 1'h0 : _GEN_11; // @[dut.scala 62:22 71:16]
  wire  _GEN_16 = 2'h2 == curLevel ? 1'h0 : _GEN_12; // @[dut.scala 62:22 72:16]
  wire  _GEN_17 = 2'h2 == curLevel ? midDfr : _GEN_13; // @[dut.scala 62:22 73:16]
  wire  _GEN_18 = 2'h3 == curLevel ? 1'h0 : _GEN_14; // @[dut.scala 62:22 64:16]
  wire  _GEN_19 = 2'h3 == curLevel ? 1'h0 : _GEN_15; // @[dut.scala 62:22 65:16]
  wire  _GEN_20 = 2'h3 == curLevel ? 1'h0 : _GEN_16; // @[dut.scala 62:22 66:16]
  wire  _GEN_21 = 2'h3 == curLevel ? 1'h0 : _GEN_17; // @[dut.scala 62:22 67:16]
  wire  _GEN_23 = reset | midDfr; // @[dut.scala 46:22 50:18]
  wire  _GEN_24 = reset | _GEN_18; // @[dut.scala 46:22 52:12]
  wire  _GEN_25 = reset | _GEN_19; // @[dut.scala 46:22 53:12]
  wire  _GEN_26 = reset | _GEN_20; // @[dut.scala 46:22 54:12]
  wire  _GEN_27 = reset | _GEN_21; // @[dut.scala 46:22 55:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 39:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 38:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 37:10]
  assign io_dfr = dfrReg; // @[dut.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 28:30]
      lastLevel <= 2'h0; // @[dut.scala 28:30]
    end else if (reset) begin // @[dut.scala 46:22]
      lastLevel <= 2'h0; // @[dut.scala 49:18]
    end else if (levelChanged) begin // @[dut.scala 57:24]
      if (3'h0 == io_s) begin // @[dut.scala 20:16]
        lastLevel <= 2'h0; // @[dut.scala 21:29]
      end else begin
        lastLevel <= _GEN_2;
      end
    end
    lastChangeUp <= reset | _GEN_23; // @[dut.scala 29:{30,30}]
    fr1Reg <= reset | _GEN_24; // @[dut.scala 32:{23,23}]
    fr2Reg <= reset | _GEN_25; // @[dut.scala 33:{23,23}]
    fr3Reg <= reset | _GEN_26; // @[dut.scala 34:{23,23}]
    dfrReg <= reset | _GEN_27; // @[dut.scala 35:{23,23}]
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
  lastChangeUp = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr1Reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr2Reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  fr3Reg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dfrReg = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
