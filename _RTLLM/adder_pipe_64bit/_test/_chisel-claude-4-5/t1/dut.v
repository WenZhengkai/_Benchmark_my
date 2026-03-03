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
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
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
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] adda_stage1; // @[dut.scala 14:28]
  reg [63:0] addb_stage1; // @[dut.scala 15:28]
  reg [63:0] adda_stage2; // @[dut.scala 17:28]
  reg [63:0] addb_stage2; // @[dut.scala 18:28]
  reg [63:0] adda_stage3; // @[dut.scala 20:28]
  reg [63:0] addb_stage3; // @[dut.scala 21:28]
  reg  en_stage1; // @[dut.scala 24:26]
  reg  en_stage2; // @[dut.scala 25:26]
  reg  en_stage3; // @[dut.scala 26:26]
  reg  en_stage4; // @[dut.scala 27:26]
  reg  carry_stage1; // @[dut.scala 31:29]
  wire [15:0] _sum_stage1_T_3 = adda_stage1[15:0] + addb_stage1[15:0]; // @[dut.scala 33:36]
  wire [16:0] sum_stage1 = {{1'd0}, _sum_stage1_T_3}; // @[dut.scala 30:24 33:14]
  reg [15:0] partial_sum1; // @[dut.scala 36:29]
  reg  carry_stage2; // @[dut.scala 40:29]
  wire [15:0] _sum_stage2_T_3 = adda_stage2[31:16] + addb_stage2[31:16]; // @[dut.scala 42:37]
  wire [15:0] _GEN_0 = {{15'd0}, carry_stage1}; // @[dut.scala 42:59]
  wire [15:0] _sum_stage2_T_5 = _sum_stage2_T_3 + _GEN_0; // @[dut.scala 42:59]
  wire [16:0] sum_stage2 = {{1'd0}, _sum_stage2_T_5}; // @[dut.scala 39:24 42:14]
  reg [15:0] partial_sum2; // @[dut.scala 45:29]
  reg  carry_stage3; // @[dut.scala 49:29]
  wire [15:0] _sum_stage3_T_3 = adda_stage3[47:32] + addb_stage3[47:32]; // @[dut.scala 51:37]
  wire [15:0] _GEN_1 = {{15'd0}, carry_stage2}; // @[dut.scala 51:59]
  wire [15:0] _sum_stage3_T_5 = _sum_stage3_T_3 + _GEN_1; // @[dut.scala 51:59]
  wire [16:0] sum_stage3 = {{1'd0}, _sum_stage3_T_5}; // @[dut.scala 48:24 51:14]
  reg [15:0] partial_sum3; // @[dut.scala 54:29]
  reg [15:0] partial_sum1_stage2; // @[dut.scala 57:36]
  reg [15:0] partial_sum1_stage3; // @[dut.scala 58:36]
  reg [15:0] partial_sum2_stage3; // @[dut.scala 60:36]
  reg [63:0] adda_stage4; // @[dut.scala 64:28]
  reg [63:0] addb_stage4; // @[dut.scala 65:28]
  wire [15:0] _sum_stage4_T_3 = adda_stage4[63:48] + addb_stage4[63:48]; // @[dut.scala 67:37]
  wire [15:0] _GEN_2 = {{15'd0}, carry_stage3}; // @[dut.scala 67:59]
  wire [15:0] _sum_stage4_T_5 = _sum_stage4_T_3 + _GEN_2; // @[dut.scala 67:59]
  wire [16:0] sum_stage4 = {{1'd0}, _sum_stage4_T_5}; // @[dut.scala 63:24 67:14]
  wire [15:0] partial_sum4 = sum_stage4[15:0]; // @[dut.scala 69:32]
  wire  final_carry = sum_stage4[16]; // @[dut.scala 70:31]
  wire [31:0] io_result_lo = {partial_sum2_stage3,partial_sum1_stage3}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {final_carry,partial_sum4,partial_sum3}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en_stage4; // @[dut.scala 76:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:28]
      adda_stage1 <= 64'h0; // @[dut.scala 14:28]
    end else begin
      adda_stage1 <= io_adda; // @[dut.scala 14:28]
    end
    if (reset) begin // @[dut.scala 15:28]
      addb_stage1 <= 64'h0; // @[dut.scala 15:28]
    end else begin
      addb_stage1 <= io_addb; // @[dut.scala 15:28]
    end
    if (reset) begin // @[dut.scala 17:28]
      adda_stage2 <= 64'h0; // @[dut.scala 17:28]
    end else begin
      adda_stage2 <= adda_stage1; // @[dut.scala 17:28]
    end
    if (reset) begin // @[dut.scala 18:28]
      addb_stage2 <= 64'h0; // @[dut.scala 18:28]
    end else begin
      addb_stage2 <= addb_stage1; // @[dut.scala 18:28]
    end
    if (reset) begin // @[dut.scala 20:28]
      adda_stage3 <= 64'h0; // @[dut.scala 20:28]
    end else begin
      adda_stage3 <= adda_stage2; // @[dut.scala 20:28]
    end
    if (reset) begin // @[dut.scala 21:28]
      addb_stage3 <= 64'h0; // @[dut.scala 21:28]
    end else begin
      addb_stage3 <= addb_stage2; // @[dut.scala 21:28]
    end
    if (reset) begin // @[dut.scala 24:26]
      en_stage1 <= 1'h0; // @[dut.scala 24:26]
    end else begin
      en_stage1 <= io_i_en; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:26]
      en_stage2 <= 1'h0; // @[dut.scala 25:26]
    end else begin
      en_stage2 <= en_stage1; // @[dut.scala 25:26]
    end
    if (reset) begin // @[dut.scala 26:26]
      en_stage3 <= 1'h0; // @[dut.scala 26:26]
    end else begin
      en_stage3 <= en_stage2; // @[dut.scala 26:26]
    end
    if (reset) begin // @[dut.scala 27:26]
      en_stage4 <= 1'h0; // @[dut.scala 27:26]
    end else begin
      en_stage4 <= en_stage3; // @[dut.scala 27:26]
    end
    if (reset) begin // @[dut.scala 31:29]
      carry_stage1 <= 1'h0; // @[dut.scala 31:29]
    end else begin
      carry_stage1 <= sum_stage1[16]; // @[dut.scala 34:16]
    end
    if (reset) begin // @[dut.scala 36:29]
      partial_sum1 <= 16'h0; // @[dut.scala 36:29]
    end else begin
      partial_sum1 <= sum_stage1[15:0]; // @[dut.scala 36:29]
    end
    if (reset) begin // @[dut.scala 40:29]
      carry_stage2 <= 1'h0; // @[dut.scala 40:29]
    end else begin
      carry_stage2 <= sum_stage2[16]; // @[dut.scala 43:16]
    end
    if (reset) begin // @[dut.scala 45:29]
      partial_sum2 <= 16'h0; // @[dut.scala 45:29]
    end else begin
      partial_sum2 <= sum_stage2[15:0]; // @[dut.scala 45:29]
    end
    if (reset) begin // @[dut.scala 49:29]
      carry_stage3 <= 1'h0; // @[dut.scala 49:29]
    end else begin
      carry_stage3 <= sum_stage3[16]; // @[dut.scala 52:16]
    end
    if (reset) begin // @[dut.scala 54:29]
      partial_sum3 <= 16'h0; // @[dut.scala 54:29]
    end else begin
      partial_sum3 <= sum_stage3[15:0]; // @[dut.scala 54:29]
    end
    if (reset) begin // @[dut.scala 57:36]
      partial_sum1_stage2 <= 16'h0; // @[dut.scala 57:36]
    end else begin
      partial_sum1_stage2 <= partial_sum1; // @[dut.scala 57:36]
    end
    if (reset) begin // @[dut.scala 58:36]
      partial_sum1_stage3 <= 16'h0; // @[dut.scala 58:36]
    end else begin
      partial_sum1_stage3 <= partial_sum1_stage2; // @[dut.scala 58:36]
    end
    if (reset) begin // @[dut.scala 60:36]
      partial_sum2_stage3 <= 16'h0; // @[dut.scala 60:36]
    end else begin
      partial_sum2_stage3 <= partial_sum2; // @[dut.scala 60:36]
    end
    if (reset) begin // @[dut.scala 64:28]
      adda_stage4 <= 64'h0; // @[dut.scala 64:28]
    end else begin
      adda_stage4 <= adda_stage3; // @[dut.scala 64:28]
    end
    if (reset) begin // @[dut.scala 65:28]
      addb_stage4 <= 64'h0; // @[dut.scala 65:28]
    end else begin
      addb_stage4 <= addb_stage3; // @[dut.scala 65:28]
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
  _RAND_0 = {2{`RANDOM}};
  adda_stage1 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addb_stage1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  adda_stage2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  addb_stage2 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  adda_stage3 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_stage3 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  en_stage1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  en_stage2 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  en_stage3 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  en_stage4 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  carry_stage1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  partial_sum1 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  carry_stage2 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  partial_sum2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  carry_stage3 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  partial_sum3 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  partial_sum1_stage2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  partial_sum1_stage3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  partial_sum2_stage3 = _RAND_18[15:0];
  _RAND_19 = {2{`RANDOM}};
  adda_stage4 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  addb_stage4 = _RAND_20[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
