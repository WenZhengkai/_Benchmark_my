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
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [95:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  reg  en_s0; // @[dut.scala 24:22]
  reg  en_s1; // @[dut.scala 25:22]
  reg  en_s2; // @[dut.scala 26:22]
  reg  en_s3; // @[dut.scala 27:22]
  reg [63:0] a_s0; // @[dut.scala 40:17]
  reg [63:0] b_s0; // @[dut.scala 41:17]
  reg [63:0] a_s1; // @[dut.scala 47:17]
  reg [63:0] b_s1; // @[dut.scala 48:17]
  reg [63:0] a_s2; // @[dut.scala 54:17]
  reg [63:0] b_s2; // @[dut.scala 55:17]
  reg [63:0] a_s3; // @[dut.scala 61:17]
  reg [63:0] b_s3; // @[dut.scala 62:17]
  reg [15:0] sum16_s0; // @[dut.scala 71:22]
  reg  carry_s0; // @[dut.scala 72:26]
  wire [16:0] _add0_T_2 = a_s0[15:0] + b_s0[15:0]; // @[dut.scala 75:23]
  wire [17:0] _add0_T_3 = {{1'd0}, _add0_T_2}; // @[dut.scala 75:38]
  wire [16:0] add0 = _add0_T_3[16:0]; // @[dut.scala 74:18 75:8]
  reg [31:0] sum_lo_s1; // @[dut.scala 83:22]
  reg [47:0] sum_lo_s2; // @[dut.scala 84:22]
  reg [63:0] sum_lo_s3; // @[dut.scala 85:22]
  reg  carry_s1; // @[dut.scala 86:26]
  reg  carry_s2; // @[dut.scala 87:26]
  reg  carry_s3; // @[dut.scala 88:26]
  wire [16:0] _add1_T_2 = a_s1[31:16] + b_s1[31:16]; // @[dut.scala 94:24]
  wire [16:0] _GEN_17 = {{16'd0}, carry_s0}; // @[dut.scala 94:40]
  wire [17:0] _add1_T_3 = _add1_T_2 + _GEN_17; // @[dut.scala 94:40]
  wire [16:0] add1 = _add1_T_3[16:0]; // @[dut.scala 93:18 94:8]
  wire [31:0] _sum_lo_s1_T_1 = {add1[15:0],sum16_s0}; // @[Cat.scala 33:92]
  wire [16:0] _add2_T_2 = a_s2[47:32] + b_s2[47:32]; // @[dut.scala 105:24]
  wire [16:0] _GEN_18 = {{16'd0}, carry_s1}; // @[dut.scala 105:40]
  wire [17:0] _add2_T_3 = _add2_T_2 + _GEN_18; // @[dut.scala 105:40]
  wire [16:0] add2 = _add2_T_3[16:0]; // @[dut.scala 104:18 105:8]
  wire [47:0] _sum_lo_s2_T_1 = {add2[15:0],sum_lo_s1}; // @[Cat.scala 33:92]
  wire [16:0] _add3_T_2 = a_s3[63:48] + b_s3[63:48]; // @[dut.scala 116:24]
  wire [16:0] _GEN_19 = {{16'd0}, carry_s2}; // @[dut.scala 116:40]
  wire [17:0] _add3_T_3 = _add3_T_2 + _GEN_19; // @[dut.scala 116:40]
  wire [16:0] add3 = _add3_T_3[16:0]; // @[dut.scala 115:18 116:8]
  wire [63:0] _sum_lo_s3_T_1 = {add3[15:0],sum_lo_s2}; // @[Cat.scala 33:92]
  reg [64:0] result_r; // @[dut.scala 126:25]
  wire [64:0] _result_r_T = {carry_s3,sum_lo_s3}; // @[Cat.scala 33:92]
  assign io_result = result_r; // @[dut.scala 131:13]
  assign io_o_en = en_s3; // @[dut.scala 34:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 24:22]
      en_s0 <= 1'h0; // @[dut.scala 24:22]
    end else begin
      en_s0 <= io_i_en; // @[dut.scala 29:9]
    end
    if (reset) begin // @[dut.scala 25:22]
      en_s1 <= 1'h0; // @[dut.scala 25:22]
    end else begin
      en_s1 <= en_s0; // @[dut.scala 30:9]
    end
    if (reset) begin // @[dut.scala 26:22]
      en_s2 <= 1'h0; // @[dut.scala 26:22]
    end else begin
      en_s2 <= en_s1; // @[dut.scala 31:9]
    end
    if (reset) begin // @[dut.scala 27:22]
      en_s3 <= 1'h0; // @[dut.scala 27:22]
    end else begin
      en_s3 <= en_s2; // @[dut.scala 32:9]
    end
    if (io_i_en) begin // @[dut.scala 42:17]
      a_s0 <= io_adda; // @[dut.scala 43:10]
    end
    if (io_i_en) begin // @[dut.scala 42:17]
      b_s0 <= io_addb; // @[dut.scala 44:10]
    end
    if (en_s0) begin // @[dut.scala 49:15]
      a_s1 <= a_s0; // @[dut.scala 50:10]
    end
    if (en_s0) begin // @[dut.scala 49:15]
      b_s1 <= b_s0; // @[dut.scala 51:10]
    end
    if (en_s1) begin // @[dut.scala 56:15]
      a_s2 <= a_s1; // @[dut.scala 57:10]
    end
    if (en_s1) begin // @[dut.scala 56:15]
      b_s2 <= b_s1; // @[dut.scala 58:10]
    end
    if (en_s2) begin // @[dut.scala 63:15]
      a_s3 <= a_s2; // @[dut.scala 64:10]
    end
    if (en_s2) begin // @[dut.scala 63:15]
      b_s3 <= b_s2; // @[dut.scala 65:10]
    end
    if (io_i_en) begin // @[dut.scala 77:17]
      sum16_s0 <= add0[15:0]; // @[dut.scala 78:14]
    end
    if (reset) begin // @[dut.scala 72:26]
      carry_s0 <= 1'h0; // @[dut.scala 72:26]
    end else if (io_i_en) begin // @[dut.scala 77:17]
      carry_s0 <= add0[16]; // @[dut.scala 79:14]
    end
    if (en_s0) begin // @[dut.scala 96:15]
      sum_lo_s1 <= _sum_lo_s1_T_1; // @[dut.scala 97:15]
    end
    if (en_s1) begin // @[dut.scala 107:15]
      sum_lo_s2 <= _sum_lo_s2_T_1; // @[dut.scala 108:15]
    end
    if (en_s2) begin // @[dut.scala 118:15]
      sum_lo_s3 <= _sum_lo_s3_T_1; // @[dut.scala 119:15]
    end
    if (reset) begin // @[dut.scala 86:26]
      carry_s1 <= 1'h0; // @[dut.scala 86:26]
    end else if (en_s0) begin // @[dut.scala 96:15]
      carry_s1 <= add1[16]; // @[dut.scala 98:15]
    end
    if (reset) begin // @[dut.scala 87:26]
      carry_s2 <= 1'h0; // @[dut.scala 87:26]
    end else if (en_s1) begin // @[dut.scala 107:15]
      carry_s2 <= add2[16]; // @[dut.scala 109:15]
    end
    if (reset) begin // @[dut.scala 88:26]
      carry_s3 <= 1'h0; // @[dut.scala 88:26]
    end else if (en_s2) begin // @[dut.scala 118:15]
      carry_s3 <= add3[16]; // @[dut.scala 120:15]
    end
    if (reset) begin // @[dut.scala 126:25]
      result_r <= 65'h0; // @[dut.scala 126:25]
    end else if (en_s3) begin // @[dut.scala 127:15]
      result_r <= _result_r_T; // @[dut.scala 128:14]
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
  en_s0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en_s1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en_s2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_s3 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  a_s0 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  b_s0 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  a_s1 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b_s1 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  a_s2 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b_s2 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  a_s3 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  b_s3 = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  sum16_s0 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  carry_s0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sum_lo_s1 = _RAND_14[31:0];
  _RAND_15 = {2{`RANDOM}};
  sum_lo_s2 = _RAND_15[47:0];
  _RAND_16 = {2{`RANDOM}};
  sum_lo_s3 = _RAND_16[63:0];
  _RAND_17 = {1{`RANDOM}};
  carry_s1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  carry_s2 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  carry_s3 = _RAND_19[0:0];
  _RAND_20 = {3{`RANDOM}};
  result_r = _RAND_20[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
