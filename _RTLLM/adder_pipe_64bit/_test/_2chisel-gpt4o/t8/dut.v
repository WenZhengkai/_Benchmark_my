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
`endif // RANDOMIZE_REG_INIT
  reg [15:0] stage1_a; // @[dut.scala 15:25]
  reg [15:0] stage1_b; // @[dut.scala 16:25]
  reg [15:0] stage2_a; // @[dut.scala 19:25]
  reg [15:0] stage2_b; // @[dut.scala 20:25]
  reg  stage2_carry; // @[dut.scala 21:29]
  reg [15:0] stage3_a; // @[dut.scala 23:25]
  reg [15:0] stage3_b; // @[dut.scala 24:25]
  reg  stage3_carry; // @[dut.scala 25:29]
  reg [15:0] stage4_a; // @[dut.scala 27:25]
  reg [15:0] stage4_b; // @[dut.scala 28:25]
  reg  stage4_carry; // @[dut.scala 29:29]
  reg  en_r1; // @[dut.scala 37:22]
  reg  en_r2; // @[dut.scala 38:22]
  reg  en_r3; // @[dut.scala 39:22]
  reg  en_r4; // @[dut.scala 40:22]
  wire [15:0] _stage1_sum_T_1 = stage1_a + stage1_b; // @[dut.scala 49:26]
  wire [16:0] _stage1_sum_T_2 = {{1'd0}, _stage1_sum_T_1}; // @[dut.scala 49:37]
  wire [16:0] stage1_sum = {{1'd0}, _stage1_sum_T_2[15:0]}; // @[dut.scala 31:24 49:14]
  wire [15:0] _stage2_sum_T_1 = stage2_a + stage2_b; // @[dut.scala 58:26]
  wire [15:0] _GEN_12 = {{15'd0}, stage2_carry}; // @[dut.scala 58:37]
  wire [15:0] _stage2_sum_T_3 = _stage2_sum_T_1 + _GEN_12; // @[dut.scala 58:37]
  wire [16:0] stage2_sum = {{1'd0}, _stage2_sum_T_3}; // @[dut.scala 32:24 58:14]
  wire [15:0] _stage3_sum_T_1 = stage3_a + stage3_b; // @[dut.scala 67:26]
  wire [15:0] _GEN_13 = {{15'd0}, stage3_carry}; // @[dut.scala 67:37]
  wire [15:0] _stage3_sum_T_3 = _stage3_sum_T_1 + _GEN_13; // @[dut.scala 67:37]
  wire [16:0] stage3_sum = {{1'd0}, _stage3_sum_T_3}; // @[dut.scala 33:24 67:14]
  wire [15:0] _stage4_sum_T_1 = stage4_a + stage4_b; // @[dut.scala 76:26]
  wire [15:0] _GEN_14 = {{15'd0}, stage4_carry}; // @[dut.scala 76:37]
  wire [15:0] _stage4_sum_T_3 = _stage4_sum_T_1 + _GEN_14; // @[dut.scala 76:37]
  wire [16:0] stage4_sum = {{1'd0}, _stage4_sum_T_3}; // @[dut.scala 34:24 76:14]
  wire [31:0] io_result_lo = {stage2_sum[15:0],stage1_sum[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {stage4_sum[16],stage4_sum[15:0],stage3_sum[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en_r4; // @[dut.scala 80:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:25]
      stage1_a <= 16'h0; // @[dut.scala 15:25]
    end else if (io_i_en) begin // @[dut.scala 43:17]
      stage1_a <= io_adda[15:0]; // @[dut.scala 44:14]
    end
    if (reset) begin // @[dut.scala 16:25]
      stage1_b <= 16'h0; // @[dut.scala 16:25]
    end else if (io_i_en) begin // @[dut.scala 43:17]
      stage1_b <= io_addb[15:0]; // @[dut.scala 45:14]
    end
    if (reset) begin // @[dut.scala 19:25]
      stage2_a <= 16'h0; // @[dut.scala 19:25]
    end else if (en_r1) begin // @[dut.scala 52:15]
      stage2_a <= io_adda[31:16]; // @[dut.scala 53:14]
    end
    if (reset) begin // @[dut.scala 20:25]
      stage2_b <= 16'h0; // @[dut.scala 20:25]
    end else if (en_r1) begin // @[dut.scala 52:15]
      stage2_b <= io_addb[31:16]; // @[dut.scala 54:14]
    end
    if (reset) begin // @[dut.scala 21:29]
      stage2_carry <= 1'h0; // @[dut.scala 21:29]
    end else if (en_r1) begin // @[dut.scala 52:15]
      stage2_carry <= stage1_sum[16]; // @[dut.scala 55:18]
    end
    if (reset) begin // @[dut.scala 23:25]
      stage3_a <= 16'h0; // @[dut.scala 23:25]
    end else if (en_r2) begin // @[dut.scala 61:15]
      stage3_a <= io_adda[47:32]; // @[dut.scala 62:14]
    end
    if (reset) begin // @[dut.scala 24:25]
      stage3_b <= 16'h0; // @[dut.scala 24:25]
    end else if (en_r2) begin // @[dut.scala 61:15]
      stage3_b <= io_addb[47:32]; // @[dut.scala 63:14]
    end
    if (reset) begin // @[dut.scala 25:29]
      stage3_carry <= 1'h0; // @[dut.scala 25:29]
    end else if (en_r2) begin // @[dut.scala 61:15]
      stage3_carry <= stage2_sum[16]; // @[dut.scala 64:18]
    end
    if (reset) begin // @[dut.scala 27:25]
      stage4_a <= 16'h0; // @[dut.scala 27:25]
    end else if (en_r3) begin // @[dut.scala 70:15]
      stage4_a <= io_adda[63:48]; // @[dut.scala 71:14]
    end
    if (reset) begin // @[dut.scala 28:25]
      stage4_b <= 16'h0; // @[dut.scala 28:25]
    end else if (en_r3) begin // @[dut.scala 70:15]
      stage4_b <= io_addb[63:48]; // @[dut.scala 72:14]
    end
    if (reset) begin // @[dut.scala 29:29]
      stage4_carry <= 1'h0; // @[dut.scala 29:29]
    end else if (en_r3) begin // @[dut.scala 70:15]
      stage4_carry <= stage3_sum[16]; // @[dut.scala 73:18]
    end
    en_r1 <= io_i_en; // @[dut.scala 37:22]
    en_r2 <= en_r1; // @[dut.scala 38:22]
    en_r3 <= en_r2; // @[dut.scala 39:22]
    en_r4 <= en_r3; // @[dut.scala 40:22]
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
  stage1_a = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  stage1_b = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  stage2_a = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  stage2_b = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  stage2_carry = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stage3_a = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  stage3_b = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage3_carry = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage4_a = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage4_b = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  stage4_carry = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  en_r1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  en_r2 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  en_r3 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  en_r4 = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
