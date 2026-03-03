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
  wire  _level_above_s3_T = s1 & s2; // @[dut.scala 19:27]
  wire  level_above_s3 = s1 & s2 & s3; // @[dut.scala 19:33]
  wire  level_between_s3_s2 = _level_above_s3_T & ~s3; // @[dut.scala 20:38]
  wire  level_between_s2_s1 = s1 & ~s2; // @[dut.scala 21:32]
  reg [1:0] prev_level; // @[dut.scala 25:27]
  wire [1:0] _curr_level_T_2 = level_between_s3_s2 ? 2'h2 : {{1'd0}, level_between_s2_s1}; // @[Mux.scala 101:16]
  wire [1:0] curr_level = level_above_s3 ? 2'h3 : _curr_level_T_2; // @[Mux.scala 101:16]
  wire  level_rising = curr_level > prev_level; // @[dut.scala 41:33]
  reg  fr3_reg; // @[dut.scala 47:24]
  reg  fr2_reg; // @[dut.scala 48:24]
  reg  fr1_reg; // @[dut.scala 49:24]
  reg  dfr_reg; // @[dut.scala 50:24]
  wire  _GEN_0 = level_between_s2_s1 ? 1'h0 : 1'h1; // @[dut.scala 66:35 68:13 75:13]
  wire  _GEN_3 = level_between_s3_s2 ? 1'h0 : _GEN_0; // @[dut.scala 59:35 61:13]
  wire  _GEN_4 = level_between_s3_s2 ? 1'h0 : 1'h1; // @[dut.scala 59:35 62:13]
  wire  _GEN_7 = level_above_s3 ? 1'h0 : _GEN_3; // @[dut.scala 53:24 55:13]
  wire  _GEN_8 = level_above_s3 ? 1'h0 : _GEN_4; // @[dut.scala 53:24 56:13]
  wire  _GEN_9 = level_above_s3 ? 1'h0 : 1'h1; // @[dut.scala 53:24 57:13]
  wire  _GEN_10 = level_above_s3 ? 1'h0 : level_rising; // @[dut.scala 53:24 58:13]
  assign io_fr3 = fr3_reg; // @[dut.scala 83:10]
  assign io_fr2 = fr2_reg; // @[dut.scala 84:10]
  assign io_fr1 = fr1_reg; // @[dut.scala 85:10]
  assign io_dfr = dfr_reg; // @[dut.scala 86:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 25:27]
      prev_level <= 2'h0; // @[dut.scala 25:27]
    end else if (level_above_s3) begin // @[Mux.scala 101:16]
      prev_level <= 2'h3;
    end else if (level_between_s3_s2) begin // @[Mux.scala 101:16]
      prev_level <= 2'h2;
    end else begin
      prev_level <= {{1'd0}, level_between_s2_s1};
    end
    fr3_reg <= reset | _GEN_7; // @[dut.scala 47:{24,24}]
    fr2_reg <= reset | _GEN_8; // @[dut.scala 48:{24,24}]
    fr1_reg <= reset | _GEN_9; // @[dut.scala 49:{24,24}]
    dfr_reg <= reset | _GEN_10; // @[dut.scala 50:{24,24}]
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
  prev_level = _RAND_0[1:0];
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
