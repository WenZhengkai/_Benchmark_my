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
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [95:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  reg  en_s0; // @[dut.scala 26:22]
  reg  en_s1; // @[dut.scala 27:22]
  reg  en_s2; // @[dut.scala 28:22]
  reg  en_s3; // @[dut.scala 29:22]
  reg [63:0] a_s0; // @[dut.scala 38:17]
  reg [63:0] b_s0; // @[dut.scala 39:17]
  reg [63:0] a_s1; // @[dut.scala 41:17]
  reg [63:0] b_s1; // @[dut.scala 42:17]
  reg [63:0] a_s2; // @[dut.scala 44:17]
  reg [63:0] b_s2; // @[dut.scala 45:17]
  reg [63:0] a_s3; // @[dut.scala 47:17]
  reg [63:0] b_s3; // @[dut.scala 48:17]
  reg [15:0] sum0_r; // @[dut.scala 61:25]
  reg [15:0] sum1_r; // @[dut.scala 62:25]
  reg [15:0] sum2_r; // @[dut.scala 63:25]
  reg [15:0] sum3_r; // @[dut.scala 64:25]
  reg  carry0_r; // @[dut.scala 65:25]
  reg  carry1_r; // @[dut.scala 66:25]
  reg  carry2_r; // @[dut.scala 67:25]
  reg  carry3_r; // @[dut.scala 68:25]
  wire [15:0] a0 = a_s0[15:0]; // @[dut.scala 71:16]
  wire [15:0] b0 = b_s0[15:0]; // @[dut.scala 72:16]
  wire [16:0] s0 = a0 + b0; // @[dut.scala 73:15]
  wire [15:0] a1 = a_s1[31:16]; // @[dut.scala 78:16]
  wire [15:0] b1 = b_s1[31:16]; // @[dut.scala 79:16]
  wire [16:0] _s1_T = a1 + b1; // @[dut.scala 80:15]
  wire [16:0] _GEN_0 = {{16'd0}, carry0_r}; // @[dut.scala 80:21]
  wire [17:0] s1 = _s1_T + _GEN_0; // @[dut.scala 80:21]
  wire [15:0] a2 = a_s2[47:32]; // @[dut.scala 85:16]
  wire [15:0] b2 = b_s2[47:32]; // @[dut.scala 86:16]
  wire [16:0] _s2_T = a2 + b2; // @[dut.scala 87:15]
  wire [16:0] _GEN_1 = {{16'd0}, carry1_r}; // @[dut.scala 87:21]
  wire [17:0] s2 = _s2_T + _GEN_1; // @[dut.scala 87:21]
  wire [15:0] a3 = a_s3[63:48]; // @[dut.scala 92:16]
  wire [15:0] b3 = b_s3[63:48]; // @[dut.scala 93:16]
  wire [16:0] _s3_T = a3 + b3; // @[dut.scala 94:15]
  wire [16:0] _GEN_2 = {{16'd0}, carry2_r}; // @[dut.scala 94:21]
  wire [17:0] s3 = _s3_T + _GEN_2; // @[dut.scala 94:21]
  reg [64:0] result_r; // @[dut.scala 99:25]
  wire [64:0] _result_r_T = {carry3_r,sum3_r,sum2_r,sum1_r,sum0_r}; // @[Cat.scala 33:92]
  assign io_result = result_r; // @[dut.scala 101:13]
  assign io_o_en = en_s3; // @[dut.scala 35:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 26:22]
      en_s0 <= 1'h0; // @[dut.scala 26:22]
    end else begin
      en_s0 <= io_i_en; // @[dut.scala 31:9]
    end
    if (reset) begin // @[dut.scala 27:22]
      en_s1 <= 1'h0; // @[dut.scala 27:22]
    end else begin
      en_s1 <= en_s0; // @[dut.scala 32:9]
    end
    if (reset) begin // @[dut.scala 28:22]
      en_s2 <= 1'h0; // @[dut.scala 28:22]
    end else begin
      en_s2 <= en_s1; // @[dut.scala 33:9]
    end
    if (reset) begin // @[dut.scala 29:22]
      en_s3 <= 1'h0; // @[dut.scala 29:22]
    end else begin
      en_s3 <= en_s2; // @[dut.scala 34:9]
    end
    a_s0 <= io_adda; // @[dut.scala 51:8]
    b_s0 <= io_addb; // @[dut.scala 52:8]
    a_s1 <= a_s0; // @[dut.scala 53:8]
    b_s1 <= b_s0; // @[dut.scala 54:8]
    a_s2 <= a_s1; // @[dut.scala 55:8]
    b_s2 <= b_s1; // @[dut.scala 56:8]
    a_s3 <= a_s2; // @[dut.scala 57:8]
    b_s3 <= b_s2; // @[dut.scala 58:8]
    if (reset) begin // @[dut.scala 61:25]
      sum0_r <= 16'h0; // @[dut.scala 61:25]
    end else begin
      sum0_r <= s0[15:0]; // @[dut.scala 74:12]
    end
    if (reset) begin // @[dut.scala 62:25]
      sum1_r <= 16'h0; // @[dut.scala 62:25]
    end else begin
      sum1_r <= s1[15:0]; // @[dut.scala 81:12]
    end
    if (reset) begin // @[dut.scala 63:25]
      sum2_r <= 16'h0; // @[dut.scala 63:25]
    end else begin
      sum2_r <= s2[15:0]; // @[dut.scala 88:12]
    end
    if (reset) begin // @[dut.scala 64:25]
      sum3_r <= 16'h0; // @[dut.scala 64:25]
    end else begin
      sum3_r <= s3[15:0]; // @[dut.scala 95:12]
    end
    if (reset) begin // @[dut.scala 65:25]
      carry0_r <= 1'h0; // @[dut.scala 65:25]
    end else begin
      carry0_r <= s0[16]; // @[dut.scala 75:12]
    end
    if (reset) begin // @[dut.scala 66:25]
      carry1_r <= 1'h0; // @[dut.scala 66:25]
    end else begin
      carry1_r <= s1[16]; // @[dut.scala 82:12]
    end
    if (reset) begin // @[dut.scala 67:25]
      carry2_r <= 1'h0; // @[dut.scala 67:25]
    end else begin
      carry2_r <= s2[16]; // @[dut.scala 89:12]
    end
    if (reset) begin // @[dut.scala 68:25]
      carry3_r <= 1'h0; // @[dut.scala 68:25]
    end else begin
      carry3_r <= s3[16]; // @[dut.scala 96:12]
    end
    if (reset) begin // @[dut.scala 99:25]
      result_r <= 65'h0; // @[dut.scala 99:25]
    end else begin
      result_r <= _result_r_T; // @[dut.scala 100:12]
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
  sum0_r = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum1_r = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  sum2_r = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  sum3_r = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  carry0_r = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  carry1_r = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  carry2_r = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  carry3_r = _RAND_19[0:0];
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
