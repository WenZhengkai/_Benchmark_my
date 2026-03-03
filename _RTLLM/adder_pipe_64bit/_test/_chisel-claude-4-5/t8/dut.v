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
  reg  en_reg0; // @[dut.scala 23:24]
  reg  en_reg1; // @[dut.scala 24:24]
  reg  en_reg2; // @[dut.scala 25:24]
  reg  en_reg3; // @[dut.scala 26:24]
  reg  carry0; // @[dut.scala 29:23]
  reg  carry1; // @[dut.scala 30:23]
  reg  carry2; // @[dut.scala 31:23]
  reg  carry3; // @[dut.scala 32:23]
  reg [15:0] sum0; // @[dut.scala 35:21]
  reg [15:0] sum1; // @[dut.scala 36:21]
  reg [15:0] sum2; // @[dut.scala 37:21]
  reg [15:0] sum3; // @[dut.scala 38:21]
  wire [16:0] stage0_sum = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 41:35]
  wire  _GEN_1 = io_i_en & stage0_sum[16]; // @[dut.scala 42:17 44:12 47:12]
  wire [16:0] _stage1_sum_T_2 = adda_reg0[31:16] + addb_reg0[31:16]; // @[dut.scala 51:38]
  wire [16:0] _GEN_8 = {{16'd0}, carry0}; // @[dut.scala 51:59]
  wire [17:0] stage1_sum = _stage1_sum_T_2 + _GEN_8; // @[dut.scala 51:59]
  wire  _GEN_3 = en_reg0 & stage1_sum[16]; // @[dut.scala 52:17 54:12 57:12]
  wire [16:0] _stage2_sum_T_2 = adda_reg1[47:32] + addb_reg1[47:32]; // @[dut.scala 61:38]
  wire [16:0] _GEN_9 = {{16'd0}, carry1}; // @[dut.scala 61:59]
  wire [17:0] stage2_sum = _stage2_sum_T_2 + _GEN_9; // @[dut.scala 61:59]
  wire  _GEN_5 = en_reg1 & stage2_sum[16]; // @[dut.scala 62:17 64:12 67:12]
  wire [16:0] _stage3_sum_T_2 = adda_reg2[63:48] + addb_reg2[63:48]; // @[dut.scala 71:38]
  wire [16:0] _GEN_10 = {{16'd0}, carry2}; // @[dut.scala 71:59]
  wire [17:0] stage3_sum = _stage3_sum_T_2 + _GEN_10; // @[dut.scala 71:59]
  wire  _GEN_7 = en_reg2 & stage3_sum[16]; // @[dut.scala 72:17 74:12 77:12]
  wire [31:0] io_result_lo = {sum1,sum0}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry3,sum3,sum2}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en_reg3; // @[dut.scala 84:11]
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
    if (reset) begin // @[dut.scala 23:24]
      en_reg0 <= 1'h0; // @[dut.scala 23:24]
    end else begin
      en_reg0 <= io_i_en; // @[dut.scala 23:24]
    end
    if (reset) begin // @[dut.scala 24:24]
      en_reg1 <= 1'h0; // @[dut.scala 24:24]
    end else begin
      en_reg1 <= en_reg0; // @[dut.scala 24:24]
    end
    if (reset) begin // @[dut.scala 25:24]
      en_reg2 <= 1'h0; // @[dut.scala 25:24]
    end else begin
      en_reg2 <= en_reg1; // @[dut.scala 25:24]
    end
    if (reset) begin // @[dut.scala 26:24]
      en_reg3 <= 1'h0; // @[dut.scala 26:24]
    end else begin
      en_reg3 <= en_reg2; // @[dut.scala 26:24]
    end
    if (reset) begin // @[dut.scala 29:23]
      carry0 <= 1'h0; // @[dut.scala 29:23]
    end else begin
      carry0 <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 30:23]
      carry1 <= 1'h0; // @[dut.scala 30:23]
    end else begin
      carry1 <= _GEN_3;
    end
    if (reset) begin // @[dut.scala 31:23]
      carry2 <= 1'h0; // @[dut.scala 31:23]
    end else begin
      carry2 <= _GEN_5;
    end
    if (reset) begin // @[dut.scala 32:23]
      carry3 <= 1'h0; // @[dut.scala 32:23]
    end else begin
      carry3 <= _GEN_7;
    end
    if (reset) begin // @[dut.scala 35:21]
      sum0 <= 16'h0; // @[dut.scala 35:21]
    end else if (io_i_en) begin // @[dut.scala 42:17]
      sum0 <= stage0_sum[15:0]; // @[dut.scala 43:12]
    end else begin
      sum0 <= 16'h0; // @[dut.scala 46:12]
    end
    if (reset) begin // @[dut.scala 36:21]
      sum1 <= 16'h0; // @[dut.scala 36:21]
    end else if (en_reg0) begin // @[dut.scala 52:17]
      sum1 <= stage1_sum[15:0]; // @[dut.scala 53:12]
    end else begin
      sum1 <= 16'h0; // @[dut.scala 56:12]
    end
    if (reset) begin // @[dut.scala 37:21]
      sum2 <= 16'h0; // @[dut.scala 37:21]
    end else if (en_reg1) begin // @[dut.scala 62:17]
      sum2 <= stage2_sum[15:0]; // @[dut.scala 63:12]
    end else begin
      sum2 <= 16'h0; // @[dut.scala 66:12]
    end
    if (reset) begin // @[dut.scala 38:21]
      sum3 <= 16'h0; // @[dut.scala 38:21]
    end else if (en_reg2) begin // @[dut.scala 72:17]
      sum3 <= stage3_sum[15:0]; // @[dut.scala 73:12]
    end else begin
      sum3 <= 16'h0; // @[dut.scala 76:12]
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
  en_reg0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  en_reg1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  en_reg2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  en_reg3 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  carry0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  carry1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  carry2 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  carry3 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sum0 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  sum1 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  sum2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  sum3 = _RAND_17[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
