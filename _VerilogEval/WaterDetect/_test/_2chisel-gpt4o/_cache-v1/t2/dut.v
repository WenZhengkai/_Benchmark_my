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
  reg  fr3_reg; // @[dut.scala 15:24]
  reg  fr2_reg; // @[dut.scala 16:24]
  reg  fr1_reg; // @[dut.scala 17:24]
  reg  dfr_reg; // @[dut.scala 18:24]
  reg [2:0] prev_s; // @[dut.scala 21:23]
  wire  _dfr_reg_T = io_s > prev_s; // @[dut.scala 48:26]
  wire  _GEN_0 = 3'h0 == io_s | fr3_reg; // @[dut.scala 37:18 57:17 15:24]
  wire  _GEN_1 = 3'h0 == io_s | fr2_reg; // @[dut.scala 37:18 58:17 16:24]
  wire  _GEN_2 = 3'h0 == io_s | fr1_reg; // @[dut.scala 37:18 59:17 17:24]
  wire  _GEN_3 = 3'h0 == io_s | dfr_reg; // @[dut.scala 37:18 60:17 18:24]
  wire  _GEN_4 = 3'h1 == io_s ? 1'h0 : _GEN_0; // @[dut.scala 37:18 51:17]
  wire  _GEN_5 = 3'h1 == io_s | _GEN_1; // @[dut.scala 37:18 52:17]
  wire  _GEN_6 = 3'h1 == io_s | _GEN_2; // @[dut.scala 37:18 53:17]
  wire  _GEN_7 = 3'h1 == io_s ? _dfr_reg_T : _GEN_3; // @[dut.scala 37:18 54:17]
  wire  _GEN_8 = 3'h3 == io_s ? 1'h0 : _GEN_4; // @[dut.scala 37:18 45:17]
  wire  _GEN_9 = 3'h3 == io_s ? 1'h0 : _GEN_5; // @[dut.scala 37:18 46:17]
  wire  _GEN_10 = 3'h3 == io_s | _GEN_6; // @[dut.scala 37:18 47:17]
  wire  _GEN_11 = 3'h3 == io_s ? io_s > prev_s : _GEN_7; // @[dut.scala 37:18 48:17]
  wire  _GEN_12 = 3'h7 == io_s ? 1'h0 : _GEN_8; // @[dut.scala 37:18 39:17]
  wire  _GEN_13 = 3'h7 == io_s ? 1'h0 : _GEN_9; // @[dut.scala 37:18 40:17]
  wire  _GEN_14 = 3'h7 == io_s ? 1'h0 : _GEN_10; // @[dut.scala 37:18 41:17]
  wire  _GEN_15 = 3'h7 == io_s ? 1'h0 : _GEN_11; // @[dut.scala 37:18 42:17]
  wire  _GEN_16 = io_reset | _GEN_12; // @[dut.scala 30:18 31:13]
  wire  _GEN_17 = io_reset | _GEN_13; // @[dut.scala 30:18 32:13]
  wire  _GEN_18 = io_reset | _GEN_14; // @[dut.scala 30:18 33:13]
  wire  _GEN_19 = io_reset | _GEN_15; // @[dut.scala 30:18 34:13]
  assign io_fr3 = fr3_reg; // @[dut.scala 66:10]
  assign io_fr2 = fr2_reg; // @[dut.scala 67:10]
  assign io_fr1 = fr1_reg; // @[dut.scala 68:10]
  assign io_dfr = dfr_reg; // @[dut.scala 69:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:24]
      fr3_reg <= 1'h0; // @[dut.scala 15:24]
    end else begin
      fr3_reg <= _GEN_16;
    end
    if (reset) begin // @[dut.scala 16:24]
      fr2_reg <= 1'h0; // @[dut.scala 16:24]
    end else begin
      fr2_reg <= _GEN_17;
    end
    if (reset) begin // @[dut.scala 17:24]
      fr1_reg <= 1'h0; // @[dut.scala 17:24]
    end else begin
      fr1_reg <= _GEN_18;
    end
    if (reset) begin // @[dut.scala 18:24]
      dfr_reg <= 1'h0; // @[dut.scala 18:24]
    end else begin
      dfr_reg <= _GEN_19;
    end
    prev_s <= io_s; // @[dut.scala 21:23]
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
  fr3_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  fr2_reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  fr1_reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  dfr_reg = _RAND_3[0:0];
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
