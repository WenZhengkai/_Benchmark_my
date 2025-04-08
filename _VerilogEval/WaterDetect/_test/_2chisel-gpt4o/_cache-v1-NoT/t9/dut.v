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
`endif // RANDOMIZE_REG_INIT
  reg [2:0] prevS; // @[dut.scala 14:22]
  reg  fr3Reg; // @[dut.scala 17:23]
  reg  fr2Reg; // @[dut.scala 18:23]
  reg  fr1Reg; // @[dut.scala 19:23]
  reg  dfrReg; // @[dut.scala 20:23]
  wire  _GEN_0 = io_s[0] ? 1'h0 : 1'h1; // @[dut.scala 46:25 47:14 51:14]
  wire  _GEN_2 = io_s[1] ? 1'h0 : _GEN_0; // @[dut.scala 42:25 43:14]
  wire  _GEN_3 = io_s[1] ? 1'h0 : 1'h1; // @[dut.scala 42:25 44:14]
  wire  _GEN_5 = io_s[2] ? 1'h0 : _GEN_2; // @[dut.scala 38:19 39:14]
  wire  _GEN_6 = io_s[2] ? 1'h0 : _GEN_3; // @[dut.scala 38:19 40:14]
  wire  _GEN_7 = io_s[2] ? 1'h0 : 1'h1; // @[dut.scala 38:19 41:14]
  wire  _T_4 = io_s > prevS; // @[dut.scala 57:15]
  wire  _GEN_9 = reset | _GEN_5; // @[dut.scala 29:24 31:12]
  wire  _GEN_10 = reset | _GEN_6; // @[dut.scala 29:24 32:12]
  wire  _GEN_11 = reset | _GEN_7; // @[dut.scala 29:24 33:12]
  wire  _GEN_12 = reset | _T_4; // @[dut.scala 29:24 34:12]
  assign io_fr3 = fr3Reg; // @[dut.scala 23:10]
  assign io_fr2 = fr2Reg; // @[dut.scala 24:10]
  assign io_fr1 = fr1Reg; // @[dut.scala 25:10]
  assign io_dfr = dfrReg; // @[dut.scala 26:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      prevS <= 3'h0; // @[dut.scala 14:22]
    end else if (reset) begin // @[dut.scala 29:24]
      prevS <= 3'h0; // @[dut.scala 35:11]
    end else begin
      prevS <= io_s; // @[dut.scala 64:11]
    end
    fr3Reg <= reset | _GEN_9; // @[dut.scala 17:{23,23}]
    fr2Reg <= reset | _GEN_10; // @[dut.scala 18:{23,23}]
    fr1Reg <= reset | _GEN_11; // @[dut.scala 19:{23,23}]
    dfrReg <= reset | _GEN_12; // @[dut.scala 20:{23,23}]
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
