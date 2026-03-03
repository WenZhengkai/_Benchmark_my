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
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [95:0] _RAND_22;
`endif // RANDOMIZE_REG_INIT
  reg  en_s0; // @[dut.scala 22:22]
  reg [63:0] a_s0; // @[dut.scala 23:18]
  reg [63:0] b_s0; // @[dut.scala 24:18]
  reg  en_s1; // @[dut.scala 35:24]
  reg [63:0] a_s1; // @[dut.scala 36:20]
  reg [63:0] b_s1; // @[dut.scala 37:20]
  reg [15:0] sum0_s1; // @[dut.scala 38:20]
  reg  c1_s1; // @[dut.scala 39:24]
  wire [16:0] _add0_T_2 = a_s0[15:0] + b_s0[15:0]; // @[dut.scala 41:26]
  wire [17:0] add0 = {{1'd0}, _add0_T_2}; // @[dut.scala 41:41]
  reg  en_s2; // @[dut.scala 54:25]
  reg [63:0] a_s2; // @[dut.scala 55:21]
  reg [63:0] b_s2; // @[dut.scala 56:21]
  reg [15:0] sum0_s2; // @[dut.scala 57:21]
  reg [15:0] sum1_s2; // @[dut.scala 58:21]
  reg  c2_s2; // @[dut.scala 59:25]
  wire [16:0] _add1_T_2 = a_s1[31:16] + b_s1[31:16]; // @[dut.scala 61:27]
  wire [16:0] _GEN_18 = {{16'd0}, c1_s1}; // @[dut.scala 61:43]
  wire [17:0] add1 = _add1_T_2 + _GEN_18; // @[dut.scala 61:43]
  reg  en_s3; // @[dut.scala 75:25]
  reg [63:0] a_s3; // @[dut.scala 76:21]
  reg [63:0] b_s3; // @[dut.scala 77:21]
  reg [15:0] sum0_s3; // @[dut.scala 78:21]
  reg [15:0] sum1_s3; // @[dut.scala 79:21]
  reg [15:0] sum2_s3; // @[dut.scala 80:21]
  reg  c3_s3; // @[dut.scala 81:25]
  wire [16:0] _add2_T_2 = a_s2[47:32] + b_s2[47:32]; // @[dut.scala 83:27]
  wire [16:0] _GEN_19 = {{16'd0}, c2_s2}; // @[dut.scala 83:43]
  wire [17:0] add2 = _add2_T_2 + _GEN_19; // @[dut.scala 83:43]
  reg  en_s4; // @[dut.scala 98:24]
  reg [64:0] res_s4; // @[dut.scala 99:24]
  wire [16:0] _add3_T_2 = a_s3[63:48] + b_s3[63:48]; // @[dut.scala 101:27]
  wire [16:0] _GEN_20 = {{16'd0}, c3_s3}; // @[dut.scala 101:43]
  wire [17:0] add3 = _add3_T_2 + _GEN_20; // @[dut.scala 101:43]
  wire [15:0] sum3 = add3[15:0]; // @[dut.scala 102:18]
  wire  c4 = add3[16]; // @[dut.scala 103:18]
  wire [64:0] _res_s4_T = {c4,sum3,sum2_s3,sum1_s3,sum0_s3}; // @[Cat.scala 33:92]
  assign io_result = res_s4; // @[dut.scala 110:13]
  assign io_o_en = en_s4; // @[dut.scala 111:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:22]
      en_s0 <= 1'h0; // @[dut.scala 22:22]
    end else begin
      en_s0 <= io_i_en; // @[dut.scala 30:9]
    end
    if (io_i_en) begin // @[dut.scala 26:17]
      a_s0 <= io_adda; // @[dut.scala 27:10]
    end
    if (io_i_en) begin // @[dut.scala 26:17]
      b_s0 <= io_addb; // @[dut.scala 28:10]
    end
    if (reset) begin // @[dut.scala 35:24]
      en_s1 <= 1'h0; // @[dut.scala 35:24]
    end else begin
      en_s1 <= en_s0; // @[dut.scala 49:9]
    end
    if (en_s0) begin // @[dut.scala 43:15]
      a_s1 <= a_s0; // @[dut.scala 44:13]
    end
    if (en_s0) begin // @[dut.scala 43:15]
      b_s1 <= b_s0; // @[dut.scala 45:13]
    end
    if (en_s0) begin // @[dut.scala 43:15]
      sum0_s1 <= add0[15:0]; // @[dut.scala 46:13]
    end
    if (reset) begin // @[dut.scala 39:24]
      c1_s1 <= 1'h0; // @[dut.scala 39:24]
    end else if (en_s0) begin // @[dut.scala 43:15]
      c1_s1 <= add0[16]; // @[dut.scala 47:13]
    end
    if (reset) begin // @[dut.scala 54:25]
      en_s2 <= 1'h0; // @[dut.scala 54:25]
    end else begin
      en_s2 <= en_s1; // @[dut.scala 70:9]
    end
    if (en_s1) begin // @[dut.scala 63:15]
      a_s2 <= a_s1; // @[dut.scala 64:13]
    end
    if (en_s1) begin // @[dut.scala 63:15]
      b_s2 <= b_s1; // @[dut.scala 65:13]
    end
    if (en_s1) begin // @[dut.scala 63:15]
      sum0_s2 <= sum0_s1; // @[dut.scala 66:13]
    end
    if (en_s1) begin // @[dut.scala 63:15]
      sum1_s2 <= add1[15:0]; // @[dut.scala 67:13]
    end
    if (reset) begin // @[dut.scala 59:25]
      c2_s2 <= 1'h0; // @[dut.scala 59:25]
    end else if (en_s1) begin // @[dut.scala 63:15]
      c2_s2 <= add1[16]; // @[dut.scala 68:13]
    end
    if (reset) begin // @[dut.scala 75:25]
      en_s3 <= 1'h0; // @[dut.scala 75:25]
    end else begin
      en_s3 <= en_s2; // @[dut.scala 93:9]
    end
    if (en_s2) begin // @[dut.scala 85:15]
      a_s3 <= a_s2; // @[dut.scala 86:13]
    end
    if (en_s2) begin // @[dut.scala 85:15]
      b_s3 <= b_s2; // @[dut.scala 87:13]
    end
    if (en_s2) begin // @[dut.scala 85:15]
      sum0_s3 <= sum0_s2; // @[dut.scala 88:13]
    end
    if (en_s2) begin // @[dut.scala 85:15]
      sum1_s3 <= sum1_s2; // @[dut.scala 89:13]
    end
    if (en_s2) begin // @[dut.scala 85:15]
      sum2_s3 <= add2[15:0]; // @[dut.scala 90:13]
    end
    if (reset) begin // @[dut.scala 81:25]
      c3_s3 <= 1'h0; // @[dut.scala 81:25]
    end else if (en_s2) begin // @[dut.scala 85:15]
      c3_s3 <= add2[16]; // @[dut.scala 91:13]
    end
    if (reset) begin // @[dut.scala 98:24]
      en_s4 <= 1'h0; // @[dut.scala 98:24]
    end else begin
      en_s4 <= en_s3; // @[dut.scala 108:9]
    end
    if (reset) begin // @[dut.scala 99:24]
      res_s4 <= 65'h0; // @[dut.scala 99:24]
    end else if (en_s3) begin // @[dut.scala 105:15]
      res_s4 <= _res_s4_T; // @[dut.scala 106:12]
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
  _RAND_1 = {2{`RANDOM}};
  a_s0 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  b_s0 = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  en_s1 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  a_s1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  b_s1 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  sum0_s1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  c1_s1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  en_s2 = _RAND_8[0:0];
  _RAND_9 = {2{`RANDOM}};
  a_s2 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  b_s2 = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  sum0_s2 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum1_s2 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  c2_s2 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  en_s3 = _RAND_14[0:0];
  _RAND_15 = {2{`RANDOM}};
  a_s3 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  b_s3 = _RAND_16[63:0];
  _RAND_17 = {1{`RANDOM}};
  sum0_s3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sum1_s3 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  sum2_s3 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  c3_s3 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  en_s4 = _RAND_21[0:0];
  _RAND_22 = {3{`RANDOM}};
  res_s4 = _RAND_22[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
