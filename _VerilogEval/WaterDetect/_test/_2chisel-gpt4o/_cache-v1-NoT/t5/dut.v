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
  reg  fr3; // @[dut.scala 17:20]
  reg  fr2; // @[dut.scala 18:20]
  reg  fr1; // @[dut.scala 19:20]
  reg  dfr; // @[dut.scala 20:20]
  wire  _GEN_0 = 3'h0 == io_s | fr3; // @[dut.scala 38:18 55:13 17:20]
  wire  _GEN_1 = 3'h0 == io_s | fr2; // @[dut.scala 38:18 56:13 18:20]
  wire  _GEN_2 = 3'h0 == io_s | fr1; // @[dut.scala 38:18 57:13 19:20]
  wire  _GEN_3 = 3'h1 == io_s ? 1'h0 : _GEN_0; // @[dut.scala 38:18 50:13]
  wire  _GEN_4 = 3'h1 == io_s | _GEN_1; // @[dut.scala 38:18 51:13]
  wire  _GEN_5 = 3'h1 == io_s | _GEN_2; // @[dut.scala 38:18 52:13]
  wire  _GEN_6 = 3'h3 == io_s ? 1'h0 : _GEN_3; // @[dut.scala 38:18 45:13]
  wire  _GEN_7 = 3'h3 == io_s ? 1'h0 : _GEN_4; // @[dut.scala 38:18 46:13]
  wire  _GEN_8 = 3'h3 == io_s | _GEN_5; // @[dut.scala 38:18 47:13]
  wire  _GEN_9 = 3'h7 == io_s ? 1'h0 : _GEN_6; // @[dut.scala 38:18 40:13]
  wire  _GEN_10 = 3'h7 == io_s ? 1'h0 : _GEN_7; // @[dut.scala 38:18 41:13]
  wire  _GEN_11 = 3'h7 == io_s ? 1'h0 : _GEN_8; // @[dut.scala 38:18 42:13]
  wire  _T_5 = io_s > prevS; // @[dut.scala 62:15]
  wire  _GEN_13 = reset | _GEN_9; // @[dut.scala 29:25 31:9]
  wire  _GEN_14 = reset | _GEN_10; // @[dut.scala 29:25 32:9]
  wire  _GEN_15 = reset | _GEN_11; // @[dut.scala 29:25 33:9]
  wire  _GEN_16 = reset | _T_5; // @[dut.scala 29:25 34:9]
  assign io_fr3 = fr3; // @[dut.scala 23:10]
  assign io_fr2 = fr2; // @[dut.scala 24:10]
  assign io_fr1 = fr1; // @[dut.scala 25:10]
  assign io_dfr = dfr; // @[dut.scala 26:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      prevS <= 3'h0; // @[dut.scala 14:22]
    end else if (reset) begin // @[dut.scala 29:25]
      prevS <= 3'h0; // @[dut.scala 35:11]
    end else begin
      prevS <= io_s; // @[dut.scala 69:11]
    end
    fr3 <= reset | _GEN_13; // @[dut.scala 17:{20,20}]
    fr2 <= reset | _GEN_14; // @[dut.scala 18:{20,20}]
    fr1 <= reset | _GEN_15; // @[dut.scala 19:{20,20}]
    dfr <= reset | _GEN_16; // @[dut.scala 20:{20,20}]
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
  fr3 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  fr1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dfr = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
