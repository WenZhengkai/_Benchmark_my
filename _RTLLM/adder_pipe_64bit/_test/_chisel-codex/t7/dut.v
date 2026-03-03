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
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
`endif // RANDOMIZE_REG_INIT
  reg  v0; // @[dut.scala 16:19]
  reg  v1; // @[dut.scala 17:19]
  reg  v2; // @[dut.scala 18:19]
  reg  v3; // @[dut.scala 19:19]
  reg [15:0] a1_d1; // @[dut.scala 31:18]
  reg [15:0] b1_d1; // @[dut.scala 32:18]
  reg [15:0] a2_d1; // @[dut.scala 34:18]
  reg [15:0] b2_d1; // @[dut.scala 35:18]
  reg [15:0] a2_d2; // @[dut.scala 36:18]
  reg [15:0] b2_d2; // @[dut.scala 37:18]
  reg [15:0] a3_d1; // @[dut.scala 39:18]
  reg [15:0] b3_d1; // @[dut.scala 40:18]
  reg [15:0] a3_d2; // @[dut.scala 41:18]
  reg [15:0] b3_d2; // @[dut.scala 42:18]
  reg [15:0] a3_d3; // @[dut.scala 43:18]
  reg [15:0] b3_d3; // @[dut.scala 44:18]
  wire [16:0] s0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 64:27]
  reg [15:0] sum0_r; // @[dut.scala 65:21]
  reg  carry0_r; // @[dut.scala 66:21]
  wire [16:0] _s1_T = a1_d1 + b1_d1; // @[dut.scala 73:18]
  wire [16:0] _GEN_0 = {{16'd0}, carry0_r}; // @[dut.scala 73:27]
  wire [17:0] s1 = _s1_T + _GEN_0; // @[dut.scala 73:27]
  reg [15:0] sum1_r; // @[dut.scala 74:21]
  reg  carry1_r; // @[dut.scala 75:21]
  wire [16:0] _s2_T = a2_d2 + b2_d2; // @[dut.scala 82:18]
  wire [16:0] _GEN_1 = {{16'd0}, carry1_r}; // @[dut.scala 82:27]
  wire [17:0] s2 = _s2_T + _GEN_1; // @[dut.scala 82:27]
  reg [15:0] sum2_r; // @[dut.scala 83:21]
  reg  carry2_r; // @[dut.scala 84:21]
  wire [16:0] _s3_T = a3_d3 + b3_d3; // @[dut.scala 91:18]
  wire [16:0] _GEN_2 = {{16'd0}, carry2_r}; // @[dut.scala 91:27]
  wire [17:0] s3 = _s3_T + _GEN_2; // @[dut.scala 91:27]
  reg [15:0] sum3_r; // @[dut.scala 92:21]
  reg  carry3_r; // @[dut.scala 93:21]
  reg [15:0] sum0_d1; // @[dut.scala 100:20]
  reg [15:0] sum0_d2; // @[dut.scala 101:20]
  reg [15:0] sum0_d3; // @[dut.scala 102:20]
  reg [15:0] sum1_d1; // @[dut.scala 104:20]
  reg [15:0] sum1_d2; // @[dut.scala 105:20]
  reg [15:0] sum2_d1; // @[dut.scala 107:20]
  wire [31:0] io_result_lo = {sum1_d2,sum0_d3}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry3_r,sum3_r,sum2_d1}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = v3; // @[dut.scala 26:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:19]
      v0 <= 1'h0; // @[dut.scala 16:19]
    end else begin
      v0 <= io_i_en; // @[dut.scala 21:6]
    end
    if (reset) begin // @[dut.scala 17:19]
      v1 <= 1'h0; // @[dut.scala 17:19]
    end else begin
      v1 <= v0; // @[dut.scala 22:6]
    end
    if (reset) begin // @[dut.scala 18:19]
      v2 <= 1'h0; // @[dut.scala 18:19]
    end else begin
      v2 <= v1; // @[dut.scala 23:6]
    end
    if (reset) begin // @[dut.scala 19:19]
      v3 <= 1'h0; // @[dut.scala 19:19]
    end else begin
      v3 <= v2; // @[dut.scala 24:6]
    end
    a1_d1 <= io_adda[31:16]; // @[dut.scala 46:19]
    b1_d1 <= io_addb[31:16]; // @[dut.scala 47:19]
    a2_d1 <= io_adda[47:32]; // @[dut.scala 49:19]
    b2_d1 <= io_addb[47:32]; // @[dut.scala 50:19]
    a2_d2 <= a2_d1; // @[dut.scala 51:9]
    b2_d2 <= b2_d1; // @[dut.scala 52:9]
    a3_d1 <= io_adda[63:48]; // @[dut.scala 54:19]
    b3_d1 <= io_addb[63:48]; // @[dut.scala 55:19]
    a3_d2 <= a3_d1; // @[dut.scala 56:9]
    b3_d2 <= b3_d1; // @[dut.scala 57:9]
    a3_d3 <= a3_d2; // @[dut.scala 58:9]
    b3_d3 <= b3_d2; // @[dut.scala 59:9]
    sum0_r <= s0[15:0]; // @[dut.scala 67:17]
    carry0_r <= s0[16]; // @[dut.scala 68:17]
    sum1_r <= s1[15:0]; // @[dut.scala 76:17]
    carry1_r <= s1[16]; // @[dut.scala 77:17]
    sum2_r <= s2[15:0]; // @[dut.scala 85:17]
    carry2_r <= s2[16]; // @[dut.scala 86:17]
    sum3_r <= s3[15:0]; // @[dut.scala 94:17]
    carry3_r <= s3[16]; // @[dut.scala 95:17]
    sum0_d1 <= sum0_r; // @[dut.scala 109:11]
    sum0_d2 <= sum0_d1; // @[dut.scala 110:11]
    sum0_d3 <= sum0_d2; // @[dut.scala 111:11]
    sum1_d1 <= sum1_r; // @[dut.scala 113:11]
    sum1_d2 <= sum1_d1; // @[dut.scala 114:11]
    sum2_d1 <= sum2_r; // @[dut.scala 116:11]
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
  v0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  v1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  v2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  v3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  a1_d1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  b1_d1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  a2_d1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  b2_d1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  a2_d2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  b2_d2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  a3_d1 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  b3_d1 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  a3_d2 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  b3_d2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  a3_d3 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  b3_d3 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  sum0_r = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  carry0_r = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sum1_r = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  carry1_r = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sum2_r = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  carry2_r = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sum3_r = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  carry3_r = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  sum0_d1 = _RAND_24[15:0];
  _RAND_25 = {1{`RANDOM}};
  sum0_d2 = _RAND_25[15:0];
  _RAND_26 = {1{`RANDOM}};
  sum0_d3 = _RAND_26[15:0];
  _RAND_27 = {1{`RANDOM}};
  sum1_d1 = _RAND_27[15:0];
  _RAND_28 = {1{`RANDOM}};
  sum1_d2 = _RAND_28[15:0];
  _RAND_29 = {1{`RANDOM}};
  sum2_d1 = _RAND_29[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
