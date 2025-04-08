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
  reg  fr3_reg; // @[dut.scala 15:24]
  reg  fr2_reg; // @[dut.scala 16:24]
  reg  fr1_reg; // @[dut.scala 17:24]
  reg  dfr_reg; // @[dut.scala 18:24]
  wire  _GEN_0 = io_s[0] ? 1'h0 : 1'h1; // @[dut.scala 44:27 45:15 49:15]
  wire  _GEN_2 = io_s[1] ? 1'h0 : _GEN_0; // @[dut.scala 40:27 41:15]
  wire  _GEN_3 = io_s[1] ? 1'h0 : 1'h1; // @[dut.scala 40:27 42:15]
  wire  _GEN_5 = io_s[2] ? 1'h0 : _GEN_2; // @[dut.scala 36:20 37:15]
  wire  _GEN_6 = io_s[2] ? 1'h0 : _GEN_3; // @[dut.scala 36:20 38:15]
  wire  _GEN_7 = io_s[2] ? 1'h0 : 1'h1; // @[dut.scala 36:20 39:15]
  wire  _T_4 = io_s > prevS; // @[dut.scala 55:16]
  wire  _GEN_9 = reset | _GEN_5; // @[dut.scala 27:25 29:13]
  wire  _GEN_10 = reset | _GEN_6; // @[dut.scala 27:25 30:13]
  wire  _GEN_11 = reset | _GEN_7; // @[dut.scala 27:25 31:13]
  wire  _GEN_12 = reset | _T_4; // @[dut.scala 27:25 32:13]
  assign io_fr3 = fr3_reg; // @[dut.scala 21:10]
  assign io_fr2 = fr2_reg; // @[dut.scala 22:10]
  assign io_fr1 = fr1_reg; // @[dut.scala 23:10]
  assign io_dfr = dfr_reg; // @[dut.scala 24:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      prevS <= 3'h0; // @[dut.scala 14:22]
    end else if (reset) begin // @[dut.scala 27:25]
      prevS <= 3'h0; // @[dut.scala 33:11]
    end else begin
      prevS <= io_s; // @[dut.scala 62:11]
    end
    fr3_reg <= reset | _GEN_9; // @[dut.scala 15:{24,24}]
    fr2_reg <= reset | _GEN_10; // @[dut.scala 16:{24,24}]
    fr1_reg <= reset | _GEN_11; // @[dut.scala 17:{24,24}]
    dfr_reg <= reset | _GEN_12; // @[dut.scala 18:{24,24}]
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
  fr3_reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2_reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr1_reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dfr_reg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
