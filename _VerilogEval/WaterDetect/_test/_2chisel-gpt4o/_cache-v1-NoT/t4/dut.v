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
  reg [2:0] prev_s; // @[dut.scala 16:23]
  reg  fr3_reg; // @[dut.scala 17:24]
  reg  fr2_reg; // @[dut.scala 18:24]
  reg  fr1_reg; // @[dut.scala 19:24]
  reg  dfr_reg; // @[dut.scala 20:24]
  wire  _GEN_0 = io_s[0] ? 1'h0 : 1'h1; // @[dut.scala 48:26 50:15 55:15]
  wire  _GEN_2 = io_s[1] ? 1'h0 : _GEN_0; // @[dut.scala 43:26 45:15]
  wire  _GEN_3 = io_s[1] ? 1'h0 : 1'h1; // @[dut.scala 43:26 46:15]
  wire  _GEN_5 = io_s[2] ? 1'h0 : _GEN_2; // @[dut.scala 38:19 40:15]
  wire  _GEN_6 = io_s[2] ? 1'h0 : _GEN_3; // @[dut.scala 38:19 41:15]
  wire  _GEN_7 = io_s[2] ? 1'h0 : 1'h1; // @[dut.scala 38:19 42:15]
  wire  _T_3 = io_s > prev_s; // @[dut.scala 61:15]
  wire  _GEN_9 = io_reset | _GEN_5; // @[dut.scala 29:18 31:13]
  wire  _GEN_10 = io_reset | _GEN_6; // @[dut.scala 29:18 32:13]
  wire  _GEN_11 = io_reset | _GEN_7; // @[dut.scala 29:18 33:13]
  wire  _GEN_12 = io_reset | _T_3; // @[dut.scala 29:18 34:13]
  assign io_fr3 = fr3_reg; // @[dut.scala 23:10]
  assign io_fr2 = fr2_reg; // @[dut.scala 24:10]
  assign io_fr1 = fr1_reg; // @[dut.scala 25:10]
  assign io_dfr = dfr_reg; // @[dut.scala 26:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:23]
      prev_s <= 3'h0; // @[dut.scala 16:23]
    end else if (io_reset) begin // @[dut.scala 29:18]
      prev_s <= 3'h0; // @[dut.scala 35:12]
    end else begin
      prev_s <= io_s; // @[dut.scala 70:12]
    end
    fr3_reg <= reset | _GEN_9; // @[dut.scala 17:{24,24}]
    fr2_reg <= reset | _GEN_10; // @[dut.scala 18:{24,24}]
    fr1_reg <= reset | _GEN_11; // @[dut.scala 19:{24,24}]
    dfr_reg <= reset | _GEN_12; // @[dut.scala 20:{24,24}]
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
  prev_s = _RAND_0[2:0];
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
