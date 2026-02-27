module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_reset,
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
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevSensor; // @[dut.scala 19:27]
  reg  fr1Reg; // @[dut.scala 22:23]
  reg  fr2Reg; // @[dut.scala 23:23]
  reg  fr3Reg; // @[dut.scala 24:23]
  reg  dfrReg; // @[dut.scala 25:23]
  wire  isRising = io_s > prevSensor; // @[dut.scala 28:23]
  wire  isFalling = io_s < prevSensor; // @[dut.scala 29:24]
  wire  _GEN_1 = io_s == 3'h2 | io_s == 3'h1 ? 1'h0 : 1'h1; // @[dut.scala 54:46 57:14 61:14]
  wire  _GEN_3 = io_s == 3'h6 | io_s == 3'h3 ? 1'h0 : 1'h1; // @[dut.scala 50:46 52:14]
  wire  _GEN_4 = io_s == 3'h6 | io_s == 3'h3 ? 1'h0 : _GEN_1; // @[dut.scala 50:46 53:14]
  wire  _GEN_5 = io_s == 3'h7 ? 1'h0 : 1'h1; // @[dut.scala 46:24 47:14]
  wire  _GEN_6 = io_s == 3'h7 ? 1'h0 : _GEN_3; // @[dut.scala 46:24 48:14]
  wire  _GEN_7 = io_s == 3'h7 ? 1'h0 : _GEN_4; // @[dut.scala 46:24 49:14]
  wire  _GEN_10 = isRising | isFalling ? _GEN_5 : fr1Reg; // @[dut.scala 22:23 40:37]
  wire  _GEN_11 = isRising | isFalling ? _GEN_6 : fr2Reg; // @[dut.scala 23:23 40:37]
  wire  _GEN_12 = isRising | isFalling ? _GEN_7 : fr3Reg; // @[dut.scala 24:23 40:37]
  wire  _GEN_13 = isRising | isFalling ? isRising : dfrReg; // @[dut.scala 40:37 65:12 25:23]
  wire  _GEN_15 = io_reset | _GEN_10; // @[dut.scala 32:18 35:12]
  wire  _GEN_16 = io_reset | _GEN_11; // @[dut.scala 32:18 36:12]
  wire  _GEN_17 = io_reset | _GEN_12; // @[dut.scala 32:18 37:12]
  wire  _GEN_18 = io_reset | _GEN_13; // @[dut.scala 32:18 38:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 71:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 70:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 69:10]
  assign io_dfr = dfrReg; // @[dut.scala 72:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:27]
      prevSensor <= 3'h0; // @[dut.scala 19:27]
    end else if (io_reset) begin // @[dut.scala 32:18]
      prevSensor <= 3'h0; // @[dut.scala 39:16]
    end else if (isRising | isFalling) begin // @[dut.scala 40:37]
      prevSensor <= io_s; // @[dut.scala 43:16]
    end
    fr1Reg <= reset | _GEN_15; // @[dut.scala 22:{23,23}]
    fr2Reg <= reset | _GEN_16; // @[dut.scala 23:{23,23}]
    fr3Reg <= reset | _GEN_17; // @[dut.scala 24:{23,23}]
    dfrReg <= reset | _GEN_18; // @[dut.scala 25:{23,23}]
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
  prevSensor = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  fr1Reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2Reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr3Reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dfrReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
