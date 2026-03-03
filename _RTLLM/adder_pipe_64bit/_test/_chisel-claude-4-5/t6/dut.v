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
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
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
  reg  carry0; // @[dut.scala 30:23]
  reg [15:0] sum0_reg; // @[dut.scala 31:25]
  wire [16:0] sum0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 33:26]
  reg  carry1; // @[dut.scala 39:23]
  reg [15:0] sum1_reg; // @[dut.scala 40:25]
  wire [16:0] _sum1_T_2 = adda_reg0[31:16] + addb_reg0[31:16]; // @[dut.scala 42:29]
  wire [16:0] _GEN_0 = {{16'd0}, carry0}; // @[dut.scala 42:50]
  wire [17:0] _sum1_T_3 = _sum1_T_2 + _GEN_0; // @[dut.scala 42:50]
  wire [16:0] sum1 = _sum1_T_3[16:0]; // @[dut.scala 38:25 42:8]
  reg  carry2; // @[dut.scala 48:23]
  reg [15:0] sum2_reg; // @[dut.scala 49:25]
  wire [16:0] _sum2_T_2 = adda_reg1[47:32] + addb_reg1[47:32]; // @[dut.scala 51:29]
  wire [16:0] _GEN_1 = {{16'd0}, carry1}; // @[dut.scala 51:50]
  wire [17:0] _sum2_T_3 = _sum2_T_2 + _GEN_1; // @[dut.scala 51:50]
  wire [16:0] sum2 = _sum2_T_3[16:0]; // @[dut.scala 47:25 51:8]
  reg  carry3; // @[dut.scala 57:23]
  reg [15:0] sum3_reg; // @[dut.scala 58:25]
  wire [16:0] _sum3_T_2 = adda_reg2[63:48] + addb_reg2[63:48]; // @[dut.scala 60:29]
  wire [16:0] _GEN_2 = {{16'd0}, carry2}; // @[dut.scala 60:50]
  wire [17:0] _sum3_T_3 = _sum3_T_2 + _GEN_2; // @[dut.scala 60:50]
  wire [16:0] sum3 = _sum3_T_3[16:0]; // @[dut.scala 56:25 60:8]
  reg [15:0] sum0_reg_stage1; // @[dut.scala 65:32]
  reg [15:0] sum0_reg_stage2; // @[dut.scala 66:32]
  reg [15:0] sum0_reg_stage3; // @[dut.scala 67:32]
  reg [15:0] sum1_reg_stage2; // @[dut.scala 69:32]
  reg [15:0] sum1_reg_stage3; // @[dut.scala 70:32]
  reg [15:0] sum2_reg_stage3; // @[dut.scala 72:32]
  wire [31:0] io_result_lo = {sum1_reg_stage3,sum0_reg_stage3}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry3,sum3_reg,sum2_reg_stage3}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = i_en_reg3; // @[dut.scala 78:11]
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
    if (reset) begin // @[dut.scala 30:23]
      carry0 <= 1'h0; // @[dut.scala 30:23]
    end else begin
      carry0 <= sum0[16]; // @[dut.scala 35:10]
    end
    if (reset) begin // @[dut.scala 31:25]
      sum0_reg <= 16'h0; // @[dut.scala 31:25]
    end else begin
      sum0_reg <= sum0[15:0]; // @[dut.scala 34:12]
    end
    if (reset) begin // @[dut.scala 39:23]
      carry1 <= 1'h0; // @[dut.scala 39:23]
    end else begin
      carry1 <= sum1[16]; // @[dut.scala 44:10]
    end
    if (reset) begin // @[dut.scala 40:25]
      sum1_reg <= 16'h0; // @[dut.scala 40:25]
    end else begin
      sum1_reg <= sum1[15:0]; // @[dut.scala 43:12]
    end
    if (reset) begin // @[dut.scala 48:23]
      carry2 <= 1'h0; // @[dut.scala 48:23]
    end else begin
      carry2 <= sum2[16]; // @[dut.scala 53:10]
    end
    if (reset) begin // @[dut.scala 49:25]
      sum2_reg <= 16'h0; // @[dut.scala 49:25]
    end else begin
      sum2_reg <= sum2[15:0]; // @[dut.scala 52:12]
    end
    if (reset) begin // @[dut.scala 57:23]
      carry3 <= 1'h0; // @[dut.scala 57:23]
    end else begin
      carry3 <= sum3[16]; // @[dut.scala 62:10]
    end
    if (reset) begin // @[dut.scala 58:25]
      sum3_reg <= 16'h0; // @[dut.scala 58:25]
    end else begin
      sum3_reg <= sum3[15:0]; // @[dut.scala 61:12]
    end
    if (reset) begin // @[dut.scala 65:32]
      sum0_reg_stage1 <= 16'h0; // @[dut.scala 65:32]
    end else begin
      sum0_reg_stage1 <= sum0_reg; // @[dut.scala 65:32]
    end
    if (reset) begin // @[dut.scala 66:32]
      sum0_reg_stage2 <= 16'h0; // @[dut.scala 66:32]
    end else begin
      sum0_reg_stage2 <= sum0_reg_stage1; // @[dut.scala 66:32]
    end
    if (reset) begin // @[dut.scala 67:32]
      sum0_reg_stage3 <= 16'h0; // @[dut.scala 67:32]
    end else begin
      sum0_reg_stage3 <= sum0_reg_stage2; // @[dut.scala 67:32]
    end
    if (reset) begin // @[dut.scala 69:32]
      sum1_reg_stage2 <= 16'h0; // @[dut.scala 69:32]
    end else begin
      sum1_reg_stage2 <= sum1_reg; // @[dut.scala 69:32]
    end
    if (reset) begin // @[dut.scala 70:32]
      sum1_reg_stage3 <= 16'h0; // @[dut.scala 70:32]
    end else begin
      sum1_reg_stage3 <= sum1_reg_stage2; // @[dut.scala 70:32]
    end
    if (reset) begin // @[dut.scala 72:32]
      sum2_reg_stage3 <= 16'h0; // @[dut.scala 72:32]
    end else begin
      sum2_reg_stage3 <= sum2_reg; // @[dut.scala 72:32]
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
  carry0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sum0_reg = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  carry1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sum1_reg = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  carry2 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sum2_reg = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  carry3 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sum3_reg = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sum0_reg_stage1 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  sum0_reg_stage2 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  sum0_reg_stage3 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  sum1_reg_stage2 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  sum1_reg_stage3 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  sum2_reg_stage3 = _RAND_23[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
