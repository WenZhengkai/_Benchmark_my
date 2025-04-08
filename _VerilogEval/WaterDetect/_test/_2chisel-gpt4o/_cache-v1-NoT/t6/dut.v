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
  reg  fr3; // @[dut.scala 14:20]
  reg  fr2; // @[dut.scala 15:20]
  reg  fr1; // @[dut.scala 16:20]
  reg  dfr; // @[dut.scala 17:20]
  reg [2:0] prev_s; // @[dut.scala 18:23]
  wire  _GEN_0 = io_s[0] ? 1'h0 : 1'h1; // @[dut.scala 45:25 46:11 50:11]
  wire  _GEN_2 = io_s[1] ? 1'h0 : _GEN_0; // @[dut.scala 41:25 42:11]
  wire  _GEN_3 = io_s[1] ? 1'h0 : 1'h1; // @[dut.scala 41:25 43:11]
  wire  _GEN_5 = io_s[2] ? 1'h0 : _GEN_2; // @[dut.scala 37:19 38:11]
  wire  _GEN_6 = io_s[2] ? 1'h0 : _GEN_3; // @[dut.scala 37:19 39:11]
  wire  _GEN_7 = io_s[2] ? 1'h0 : 1'h1; // @[dut.scala 37:19 40:11]
  wire  _GEN_8 = reset | _GEN_5; // @[dut.scala 27:22 29:9]
  wire  _GEN_9 = reset | _GEN_6; // @[dut.scala 27:22 30:9]
  wire  _GEN_10 = reset | _GEN_7; // @[dut.scala 27:22 31:9]
  wire  _GEN_11 = reset | io_s > prev_s; // @[dut.scala 27:22 32:9 57:9]
  assign io_fr3 = fr3; // @[dut.scala 21:10]
  assign io_fr2 = fr2; // @[dut.scala 22:10]
  assign io_fr1 = fr1; // @[dut.scala 23:10]
  assign io_dfr = dfr; // @[dut.scala 24:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:20]
      fr3 <= 1'h0; // @[dut.scala 14:20]
    end else begin
      fr3 <= _GEN_8;
    end
    if (reset) begin // @[dut.scala 15:20]
      fr2 <= 1'h0; // @[dut.scala 15:20]
    end else begin
      fr2 <= _GEN_9;
    end
    if (reset) begin // @[dut.scala 16:20]
      fr1 <= 1'h0; // @[dut.scala 16:20]
    end else begin
      fr1 <= _GEN_10;
    end
    if (reset) begin // @[dut.scala 17:20]
      dfr <= 1'h0; // @[dut.scala 17:20]
    end else begin
      dfr <= _GEN_11;
    end
    if (reset) begin // @[dut.scala 18:23]
      prev_s <= 3'h0; // @[dut.scala 18:23]
    end else if (reset) begin // @[dut.scala 27:22]
      prev_s <= 3'h0; // @[dut.scala 33:12]
    end else begin
      prev_s <= io_s; // @[dut.scala 60:12]
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
  fr3 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  fr2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  dfr = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  prev_s = _RAND_4[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
