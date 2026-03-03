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
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] prevLevel; // @[dut.scala 18:26]
  reg  trendUp; // @[dut.scala 19:26]
  reg  fr1Reg; // @[dut.scala 22:23]
  reg  fr2Reg; // @[dut.scala 23:23]
  reg  fr3Reg; // @[dut.scala 24:23]
  reg  dfrReg; // @[dut.scala 25:23]
  wire [1:0] _level_T_4 = io_s[1] ? 2'h2 : {{1'd0}, io_s[0]}; // @[dut.scala 31:15]
  wire [1:0] level = io_s[2] ? 2'h3 : _level_T_4; // @[dut.scala 30:15]
  wire  levelChanged = level != prevLevel; // @[dut.scala 34:28]
  wire  trendNow = levelChanged ? level > prevLevel : trendUp; // @[dut.scala 35:25]
  wire  fr1Next = level != 2'h3; // @[dut.scala 38:23]
  wire  _fr2Next_T_1 = level == 2'h0; // @[dut.scala 39:43]
  wire  fr2Next = level == 2'h1 | level == 2'h0; // @[dut.scala 39:33]
  wire  _dfrNext_T_2 = level == 2'h3 ? 1'h0 : trendNow; // @[dut.scala 47:20]
  wire  dfrNext = _fr2Next_T_1 | _dfrNext_T_2; // @[dut.scala 46:20]
  wire  _GEN_3 = io_rst | trendNow; // @[dut.scala 49:16 52:15]
  wire  _GEN_4 = io_rst | fr1Next; // @[dut.scala 49:16 53:15 63:12]
  wire  _GEN_5 = io_rst | fr2Next; // @[dut.scala 49:16 54:15 64:12]
  wire  _GEN_6 = io_rst | _fr2Next_T_1; // @[dut.scala 49:16 55:15 65:12]
  wire  _GEN_7 = io_rst | dfrNext; // @[dut.scala 49:16 56:15 66:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 71:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 70:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 69:10]
  assign io_dfr = dfrReg; // @[dut.scala 72:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:26]
      prevLevel <= 2'h0; // @[dut.scala 18:26]
    end else if (io_rst) begin // @[dut.scala 49:16]
      prevLevel <= 2'h0; // @[dut.scala 51:15]
    end else if (levelChanged) begin // @[dut.scala 58:24]
      if (io_s[2]) begin // @[dut.scala 30:15]
        prevLevel <= 2'h3;
      end else begin
        prevLevel <= _level_T_4;
      end
    end
    trendUp <= reset | _GEN_3; // @[dut.scala 19:{26,26}]
    fr1Reg <= reset | _GEN_4; // @[dut.scala 22:{23,23}]
    fr2Reg <= reset | _GEN_5; // @[dut.scala 23:{23,23}]
    fr3Reg <= reset | _GEN_6; // @[dut.scala 24:{23,23}]
    dfrReg <= reset | _GEN_7; // @[dut.scala 25:{23,23}]
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
  trendUp = _RAND_1[0:0];
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
