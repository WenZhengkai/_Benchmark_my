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
`endif // RANDOMIZE_REG_INIT
  reg [63:0] adda_reg0; // @[dut.scala 14:26]
  reg [63:0] adda_reg1; // @[dut.scala 15:26]
  reg [63:0] adda_reg2; // @[dut.scala 16:26]
  reg [63:0] addb_reg0; // @[dut.scala 18:26]
  reg [63:0] addb_reg1; // @[dut.scala 19:26]
  reg [63:0] addb_reg2; // @[dut.scala 20:26]
  reg  i_en_reg0; // @[dut.scala 23:26]
  reg  i_en_reg1; // @[dut.scala 24:26]
  reg  i_en_reg2; // @[dut.scala 25:26]
  reg  i_en_reg3; // @[dut.scala 26:26]
  reg [15:0] sum_stage0; // @[dut.scala 29:27]
  reg [15:0] sum_stage1; // @[dut.scala 30:27]
  reg [15:0] sum_stage2; // @[dut.scala 31:27]
  reg [15:0] sum_stage3; // @[dut.scala 32:27]
  reg  carry_stage0; // @[dut.scala 34:29]
  reg  carry_stage1; // @[dut.scala 35:29]
  reg  carry_stage2; // @[dut.scala 36:29]
  reg  carry_stage3; // @[dut.scala 37:29]
  wire [15:0] stage0_a = io_adda[15:0]; // @[dut.scala 40:25]
  wire [15:0] stage0_b = io_addb[15:0]; // @[dut.scala 41:25]
  wire [16:0] stage0_sum = stage0_a + stage0_b; // @[dut.scala 42:29]
  wire [15:0] stage1_a = adda_reg0[31:16]; // @[dut.scala 47:27]
  wire [15:0] stage1_b = addb_reg0[31:16]; // @[dut.scala 48:27]
  wire [16:0] _stage1_sum_T = stage1_a + stage1_b; // @[dut.scala 49:29]
  wire [16:0] _GEN_0 = {{16'd0}, carry_stage0}; // @[dut.scala 49:41]
  wire [17:0] stage1_sum = _stage1_sum_T + _GEN_0; // @[dut.scala 49:41]
  wire [15:0] stage2_a = adda_reg1[47:32]; // @[dut.scala 54:27]
  wire [15:0] stage2_b = addb_reg1[47:32]; // @[dut.scala 55:27]
  wire [16:0] _stage2_sum_T = stage2_a + stage2_b; // @[dut.scala 56:29]
  wire [16:0] _GEN_1 = {{16'd0}, carry_stage1}; // @[dut.scala 56:41]
  wire [17:0] stage2_sum = _stage2_sum_T + _GEN_1; // @[dut.scala 56:41]
  wire [15:0] stage3_a = adda_reg2[63:48]; // @[dut.scala 61:27]
  wire [15:0] stage3_b = addb_reg2[63:48]; // @[dut.scala 62:27]
  wire [16:0] _stage3_sum_T = stage3_a + stage3_b; // @[dut.scala 63:29]
  wire [16:0] _GEN_2 = {{16'd0}, carry_stage2}; // @[dut.scala 63:41]
  wire [17:0] stage3_sum = _stage3_sum_T + _GEN_2; // @[dut.scala 63:41]
  wire [31:0] io_result_lo = {sum_stage1,sum_stage0}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry_stage3,sum_stage3,sum_stage2}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = i_en_reg3; // @[dut.scala 71:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      adda_reg0 <= 64'h0; // @[dut.scala 14:26]
    end else begin
      adda_reg0 <= io_adda; // @[dut.scala 14:26]
    end
    if (reset) begin // @[dut.scala 15:26]
      adda_reg1 <= 64'h0; // @[dut.scala 15:26]
    end else begin
      adda_reg1 <= adda_reg0; // @[dut.scala 15:26]
    end
    if (reset) begin // @[dut.scala 16:26]
      adda_reg2 <= 64'h0; // @[dut.scala 16:26]
    end else begin
      adda_reg2 <= adda_reg1; // @[dut.scala 16:26]
    end
    if (reset) begin // @[dut.scala 18:26]
      addb_reg0 <= 64'h0; // @[dut.scala 18:26]
    end else begin
      addb_reg0 <= io_addb; // @[dut.scala 18:26]
    end
    if (reset) begin // @[dut.scala 19:26]
      addb_reg1 <= 64'h0; // @[dut.scala 19:26]
    end else begin
      addb_reg1 <= addb_reg0; // @[dut.scala 19:26]
    end
    if (reset) begin // @[dut.scala 20:26]
      addb_reg2 <= 64'h0; // @[dut.scala 20:26]
    end else begin
      addb_reg2 <= addb_reg1; // @[dut.scala 20:26]
    end
    if (reset) begin // @[dut.scala 23:26]
      i_en_reg0 <= 1'h0; // @[dut.scala 23:26]
    end else begin
      i_en_reg0 <= io_i_en; // @[dut.scala 23:26]
    end
    if (reset) begin // @[dut.scala 24:26]
      i_en_reg1 <= 1'h0; // @[dut.scala 24:26]
    end else begin
      i_en_reg1 <= i_en_reg0; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:26]
      i_en_reg2 <= 1'h0; // @[dut.scala 25:26]
    end else begin
      i_en_reg2 <= i_en_reg1; // @[dut.scala 25:26]
    end
    if (reset) begin // @[dut.scala 26:26]
      i_en_reg3 <= 1'h0; // @[dut.scala 26:26]
    end else begin
      i_en_reg3 <= i_en_reg2; // @[dut.scala 26:26]
    end
    if (reset) begin // @[dut.scala 29:27]
      sum_stage0 <= 16'h0; // @[dut.scala 29:27]
    end else begin
      sum_stage0 <= stage0_sum[15:0]; // @[dut.scala 43:14]
    end
    if (reset) begin // @[dut.scala 30:27]
      sum_stage1 <= 16'h0; // @[dut.scala 30:27]
    end else begin
      sum_stage1 <= stage1_sum[15:0]; // @[dut.scala 50:14]
    end
    if (reset) begin // @[dut.scala 31:27]
      sum_stage2 <= 16'h0; // @[dut.scala 31:27]
    end else begin
      sum_stage2 <= stage2_sum[15:0]; // @[dut.scala 57:14]
    end
    if (reset) begin // @[dut.scala 32:27]
      sum_stage3 <= 16'h0; // @[dut.scala 32:27]
    end else begin
      sum_stage3 <= stage3_sum[15:0]; // @[dut.scala 64:14]
    end
    if (reset) begin // @[dut.scala 34:29]
      carry_stage0 <= 1'h0; // @[dut.scala 34:29]
    end else begin
      carry_stage0 <= stage0_sum[16]; // @[dut.scala 44:16]
    end
    if (reset) begin // @[dut.scala 35:29]
      carry_stage1 <= 1'h0; // @[dut.scala 35:29]
    end else begin
      carry_stage1 <= stage1_sum[16]; // @[dut.scala 51:16]
    end
    if (reset) begin // @[dut.scala 36:29]
      carry_stage2 <= 1'h0; // @[dut.scala 36:29]
    end else begin
      carry_stage2 <= stage2_sum[16]; // @[dut.scala 58:16]
    end
    if (reset) begin // @[dut.scala 37:29]
      carry_stage3 <= 1'h0; // @[dut.scala 37:29]
    end else begin
      carry_stage3 <= stage3_sum[16]; // @[dut.scala 65:16]
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
  adda_reg0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  adda_reg1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  adda_reg2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  addb_reg0 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  addb_reg1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg2 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  i_en_reg0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  i_en_reg1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  i_en_reg2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  i_en_reg3 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum_stage0 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum_stage1 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum_stage2 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum_stage3 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  carry_stage0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  carry_stage1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  carry_stage2 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  carry_stage3 = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
