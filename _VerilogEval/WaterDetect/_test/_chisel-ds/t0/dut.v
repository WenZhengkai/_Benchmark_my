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
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] prevLevel; // @[dut.scala 16:26]
  reg  fr3Reg; // @[dut.scala 19:23]
  reg  fr2Reg; // @[dut.scala 20:23]
  reg  fr1Reg; // @[dut.scala 21:23]
  reg  dfrReg; // @[dut.scala 22:23]
  wire  _currentLevel_T = io_s == 3'h7; // @[dut.scala 33:11]
  wire  _currentLevel_T_1 = io_s == 3'h3; // @[dut.scala 34:11]
  wire  _currentLevel_T_2 = io_s == 3'h1; // @[dut.scala 35:11]
  wire [1:0] _currentLevel_T_6 = _currentLevel_T_1 ? 2'h2 : {{1'd0}, _currentLevel_T_2}; // @[Mux.scala 101:16]
  wire [1:0] currentLevel = _currentLevel_T ? 2'h3 : _currentLevel_T_6; // @[Mux.scala 101:16]
  wire  _dfrReg_T = prevLevel < currentLevel; // @[dut.scala 60:30]
  wire  _GEN_0 = 2'h0 == currentLevel | fr3Reg; // @[dut.scala 49:26 69:16 19:23]
  wire  _GEN_1 = 2'h0 == currentLevel | fr2Reg; // @[dut.scala 49:26 70:16 20:23]
  wire  _GEN_2 = 2'h0 == currentLevel | fr1Reg; // @[dut.scala 49:26 71:16 21:23]
  wire  _GEN_3 = 2'h0 == currentLevel | dfrReg; // @[dut.scala 49:26 72:16 22:23]
  wire  _GEN_4 = 2'h1 == currentLevel ? 1'h0 : _GEN_0; // @[dut.scala 49:26 63:16]
  wire  _GEN_5 = 2'h1 == currentLevel | _GEN_1; // @[dut.scala 49:26 64:16]
  wire  _GEN_6 = 2'h1 == currentLevel | _GEN_2; // @[dut.scala 49:26 65:16]
  wire  _GEN_7 = 2'h1 == currentLevel ? _dfrReg_T : _GEN_3; // @[dut.scala 49:26 66:16]
  wire  _GEN_8 = 2'h2 == currentLevel ? 1'h0 : _GEN_4; // @[dut.scala 49:26 57:16]
  wire  _GEN_9 = 2'h2 == currentLevel ? 1'h0 : _GEN_5; // @[dut.scala 49:26 58:16]
  wire  _GEN_10 = 2'h2 == currentLevel | _GEN_6; // @[dut.scala 49:26 59:16]
  wire  _GEN_11 = 2'h2 == currentLevel ? prevLevel < currentLevel : _GEN_7; // @[dut.scala 49:26 60:16]
  wire  _GEN_12 = 2'h3 == currentLevel ? 1'h0 : _GEN_8; // @[dut.scala 49:26 51:16]
  wire  _GEN_13 = 2'h3 == currentLevel ? 1'h0 : _GEN_9; // @[dut.scala 49:26 52:16]
  wire  _GEN_14 = 2'h3 == currentLevel ? 1'h0 : _GEN_10; // @[dut.scala 49:26 53:16]
  wire  _GEN_15 = 2'h3 == currentLevel ? 1'h0 : _GEN_11; // @[dut.scala 49:26 54:16]
  wire  _GEN_16 = io_reset | _GEN_12; // @[dut.scala 40:18 42:12]
  wire  _GEN_17 = io_reset | _GEN_13; // @[dut.scala 40:18 43:12]
  wire  _GEN_18 = io_reset | _GEN_14; // @[dut.scala 40:18 44:12]
  wire  _GEN_19 = io_reset | _GEN_15; // @[dut.scala 40:18 45:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 25:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 26:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 27:10]
  assign io_dfr = dfrReg; // @[dut.scala 28:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:26]
      prevLevel <= 2'h0; // @[dut.scala 16:26]
    end else if (io_reset) begin // @[dut.scala 40:18]
      prevLevel <= 2'h0; // @[dut.scala 46:15]
    end else if (_currentLevel_T) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h3;
    end else if (_currentLevel_T_1) begin // @[Mux.scala 101:16]
      prevLevel <= 2'h2;
    end else begin
      prevLevel <= {{1'd0}, _currentLevel_T_2};
    end
    fr3Reg <= reset | _GEN_16; // @[dut.scala 19:{23,23}]
    fr2Reg <= reset | _GEN_17; // @[dut.scala 20:{23,23}]
    fr1Reg <= reset | _GEN_18; // @[dut.scala 21:{23,23}]
    dfrReg <= reset | _GEN_19; // @[dut.scala 22:{23,23}]
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
  prevLevel = _RAND_0[1:0];
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
