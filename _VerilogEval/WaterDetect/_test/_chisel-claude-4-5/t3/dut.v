module dut(
  input        clock,
  input        reset,
  input  [3:0] io_s,
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
  wire  s1 = io_s[1]; // @[dut.scala 14:16]
  wire  s2 = io_s[2]; // @[dut.scala 15:16]
  wire  s3 = io_s[3]; // @[dut.scala 16:16]
  wire [2:0] currentLevel = {s3,s2,s1}; // @[Cat.scala 33:92]
  reg [2:0] prevLevel; // @[dut.scala 22:26]
  reg  fr3Reg; // @[dut.scala 25:23]
  reg  fr2Reg; // @[dut.scala 26:23]
  reg  fr1Reg; // @[dut.scala 27:23]
  reg  dfrReg; // @[dut.scala 28:23]
  wire  isRising = currentLevel > prevLevel; // @[dut.scala 35:31]
  wire  _GEN_0 = currentLevel == 3'h0 | fr3Reg; // @[dut.scala 56:41 58:12 25:23]
  wire  _GEN_1 = currentLevel == 3'h0 | fr2Reg; // @[dut.scala 56:41 59:12 26:23]
  wire  _GEN_2 = currentLevel == 3'h0 | fr1Reg; // @[dut.scala 56:41 60:12 27:23]
  wire  _GEN_3 = currentLevel == 3'h0 | dfrReg; // @[dut.scala 56:41 61:12 28:23]
  wire  _GEN_4 = currentLevel == 3'h1 ? 1'h0 : _GEN_0; // @[dut.scala 50:41 52:12]
  wire  _GEN_5 = currentLevel == 3'h1 | _GEN_1; // @[dut.scala 50:41 53:12]
  wire  _GEN_6 = currentLevel == 3'h1 | _GEN_2; // @[dut.scala 50:41 54:12]
  wire  _GEN_7 = currentLevel == 3'h1 ? isRising : _GEN_3; // @[dut.scala 50:41 55:12]
  wire  _GEN_8 = currentLevel == 3'h3 ? 1'h0 : _GEN_4; // @[dut.scala 44:41 46:12]
  wire  _GEN_9 = currentLevel == 3'h3 ? 1'h0 : _GEN_5; // @[dut.scala 44:41 47:12]
  wire  _GEN_10 = currentLevel == 3'h3 | _GEN_6; // @[dut.scala 44:41 48:12]
  wire  _GEN_11 = currentLevel == 3'h3 ? isRising : _GEN_7; // @[dut.scala 44:41 49:12]
  wire  _GEN_12 = currentLevel == 3'h7 ? 1'h0 : _GEN_8; // @[dut.scala 38:35 40:12]
  wire  _GEN_13 = currentLevel == 3'h7 ? 1'h0 : _GEN_9; // @[dut.scala 38:35 41:12]
  wire  _GEN_14 = currentLevel == 3'h7 ? 1'h0 : _GEN_10; // @[dut.scala 38:35 42:12]
  wire  _GEN_15 = currentLevel == 3'h7 ? 1'h0 : _GEN_11; // @[dut.scala 38:35 43:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 69:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 70:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 71:10]
  assign io_dfr = dfrReg; // @[dut.scala 72:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:26]
      prevLevel <= 3'h0; // @[dut.scala 22:26]
    end else begin
      prevLevel <= currentLevel; // @[dut.scala 31:13]
    end
    fr3Reg <= reset | _GEN_12; // @[dut.scala 25:{23,23}]
    fr2Reg <= reset | _GEN_13; // @[dut.scala 26:{23,23}]
    fr1Reg <= reset | _GEN_14; // @[dut.scala 27:{23,23}]
    dfrReg <= reset | _GEN_15; // @[dut.scala 28:{23,23}]
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
  prevLevel = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  fr3Reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2Reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr1Reg = _RAND_3[0:0];
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
