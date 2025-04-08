module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  reg  s0_en; // @[dut.scala 18:24]
  reg  s1_en; // @[dut.scala 19:24]
  reg  s2_en; // @[dut.scala 20:24]
  reg  s3_en; // @[dut.scala 21:24]
  reg  s4_en; // @[dut.scala 22:24]
  reg [15:0] stage0_adda; // @[dut.scala 25:28]
  reg [15:0] stage0_addb; // @[dut.scala 26:28]
  reg [15:0] stage1_adda; // @[dut.scala 27:28]
  reg [15:0] stage1_addb; // @[dut.scala 28:28]
  reg [15:0] stage2_adda; // @[dut.scala 29:28]
  reg [15:0] stage2_addb; // @[dut.scala 30:28]
  reg [15:0] stage3_adda; // @[dut.scala 31:28]
  reg [15:0] stage3_addb; // @[dut.scala 32:28]
  reg  stage1_carry; // @[dut.scala 35:25]
  reg [15:0] stage1_sum; // @[dut.scala 36:25]
  reg  stage2_carry; // @[dut.scala 37:25]
  reg [15:0] stage2_sum; // @[dut.scala 38:25]
  reg  stage3_carry; // @[dut.scala 39:25]
  reg [15:0] stage3_sum; // @[dut.scala 40:25]
  reg  stage4_carry; // @[dut.scala 41:25]
  reg [15:0] stage4_sum; // @[dut.scala 42:25]
  wire [16:0] stage0_add = stage0_adda + stage0_addb; // @[dut.scala 45:32]
  wire [16:0] _stage1_add_T = stage1_adda + stage1_addb; // @[dut.scala 50:32]
  wire [16:0] _GEN_0 = {{16'd0}, stage1_carry}; // @[dut.scala 50:47]
  wire [16:0] stage1_add = _stage1_add_T + _GEN_0; // @[dut.scala 50:47]
  wire [16:0] _stage2_add_T = stage2_adda + stage2_addb; // @[dut.scala 55:32]
  wire [16:0] _GEN_1 = {{16'd0}, stage2_carry}; // @[dut.scala 55:47]
  wire [16:0] stage2_add = _stage2_add_T + _GEN_1; // @[dut.scala 55:47]
  wire [16:0] _stage3_add_T = stage3_adda + stage3_addb; // @[dut.scala 60:32]
  wire [16:0] _GEN_2 = {{16'd0}, stage3_carry}; // @[dut.scala 60:47]
  wire [16:0] stage3_add = _stage3_add_T + _GEN_2; // @[dut.scala 60:47]
  wire [31:0] io_result_lo = {stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {stage4_carry,stage4_sum,stage3_sum}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = s4_en; // @[dut.scala 66:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:24]
      s0_en <= 1'h0; // @[dut.scala 18:24]
    end else begin
      s0_en <= io_i_en; // @[dut.scala 18:24]
    end
    if (reset) begin // @[dut.scala 19:24]
      s1_en <= 1'h0; // @[dut.scala 19:24]
    end else begin
      s1_en <= s0_en; // @[dut.scala 19:24]
    end
    if (reset) begin // @[dut.scala 20:24]
      s2_en <= 1'h0; // @[dut.scala 20:24]
    end else begin
      s2_en <= s1_en; // @[dut.scala 20:24]
    end
    if (reset) begin // @[dut.scala 21:24]
      s3_en <= 1'h0; // @[dut.scala 21:24]
    end else begin
      s3_en <= s2_en; // @[dut.scala 21:24]
    end
    if (reset) begin // @[dut.scala 22:24]
      s4_en <= 1'h0; // @[dut.scala 22:24]
    end else begin
      s4_en <= s3_en; // @[dut.scala 22:24]
    end
    if (reset) begin // @[dut.scala 25:28]
      stage0_adda <= 16'h0; // @[dut.scala 25:28]
    end else begin
      stage0_adda <= io_adda[15:0]; // @[dut.scala 25:28]
    end
    if (reset) begin // @[dut.scala 26:28]
      stage0_addb <= 16'h0; // @[dut.scala 26:28]
    end else begin
      stage0_addb <= io_addb[15:0]; // @[dut.scala 26:28]
    end
    if (reset) begin // @[dut.scala 27:28]
      stage1_adda <= 16'h0; // @[dut.scala 27:28]
    end else begin
      stage1_adda <= io_adda[31:16]; // @[dut.scala 27:28]
    end
    if (reset) begin // @[dut.scala 28:28]
      stage1_addb <= 16'h0; // @[dut.scala 28:28]
    end else begin
      stage1_addb <= io_addb[31:16]; // @[dut.scala 28:28]
    end
    if (reset) begin // @[dut.scala 29:28]
      stage2_adda <= 16'h0; // @[dut.scala 29:28]
    end else begin
      stage2_adda <= io_adda[47:32]; // @[dut.scala 29:28]
    end
    if (reset) begin // @[dut.scala 30:28]
      stage2_addb <= 16'h0; // @[dut.scala 30:28]
    end else begin
      stage2_addb <= io_addb[47:32]; // @[dut.scala 30:28]
    end
    if (reset) begin // @[dut.scala 31:28]
      stage3_adda <= 16'h0; // @[dut.scala 31:28]
    end else begin
      stage3_adda <= io_adda[63:48]; // @[dut.scala 31:28]
    end
    if (reset) begin // @[dut.scala 32:28]
      stage3_addb <= 16'h0; // @[dut.scala 32:28]
    end else begin
      stage3_addb <= io_addb[63:48]; // @[dut.scala 32:28]
    end
    stage1_carry <= stage0_add[16]; // @[dut.scala 47:29]
    stage1_sum <= stage0_add[15:0]; // @[dut.scala 46:27]
    stage2_carry <= stage1_add[16]; // @[dut.scala 52:29]
    stage2_sum <= stage1_add[15:0]; // @[dut.scala 51:27]
    stage3_carry <= stage2_add[16]; // @[dut.scala 57:29]
    stage3_sum <= stage2_add[15:0]; // @[dut.scala 56:27]
    stage4_carry <= stage3_add[16]; // @[dut.scala 62:29]
    stage4_sum <= stage3_add[15:0]; // @[dut.scala 61:27]
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
  s0_en = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  s1_en = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  s2_en = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  s3_en = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  s4_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stage0_adda = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  stage0_addb = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage1_adda = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  stage1_addb = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage2_adda = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  stage2_addb = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  stage3_adda = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  stage3_addb = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  stage1_carry = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  stage1_sum = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  stage2_carry = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  stage2_sum = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  stage3_carry = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  stage3_sum = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  stage4_carry = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  stage4_sum = _RAND_20[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
