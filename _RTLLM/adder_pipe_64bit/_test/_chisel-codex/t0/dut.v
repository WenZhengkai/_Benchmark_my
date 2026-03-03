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
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [95:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  reg  en0; // @[dut.scala 16:20]
  reg  en1; // @[dut.scala 17:20]
  reg  en2; // @[dut.scala 18:20]
  reg  en3; // @[dut.scala 19:20]
  reg [63:0] a_r1; // @[dut.scala 31:21]
  reg [63:0] b_r1; // @[dut.scala 32:21]
  reg [63:0] a_r2; // @[dut.scala 33:21]
  reg [63:0] b_r2; // @[dut.scala 34:21]
  reg [63:0] a_r3; // @[dut.scala 35:21]
  reg [63:0] b_r3; // @[dut.scala 36:21]
  wire [16:0] sum0_w = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 48:31]
  reg [15:0] sum0_r; // @[dut.scala 49:23]
  reg  c0_r; // @[dut.scala 50:23]
  wire [16:0] _sum1_w_T_2 = a_r1[31:16] + b_r1[31:16]; // @[dut.scala 58:29]
  wire [16:0] _GEN_0 = {{16'd0}, c0_r}; // @[dut.scala 58:45]
  wire [17:0] sum1_w = _sum1_w_T_2 + _GEN_0; // @[dut.scala 58:45]
  reg [31:0] sum01_r; // @[dut.scala 59:24]
  reg  c1_r; // @[dut.scala 60:24]
  wire [31:0] _sum01_r_T_1 = {sum1_w[15:0],sum0_r}; // @[Cat.scala 33:92]
  wire [16:0] _sum2_w_T_2 = a_r2[47:32] + b_r2[47:32]; // @[dut.scala 68:29]
  wire [16:0] _GEN_1 = {{16'd0}, c1_r}; // @[dut.scala 68:45]
  wire [17:0] sum2_w = _sum2_w_T_2 + _GEN_1; // @[dut.scala 68:45]
  reg [47:0] sum012_r; // @[dut.scala 69:25]
  reg  c2_r; // @[dut.scala 70:25]
  wire [47:0] _sum012_r_T_1 = {sum2_w[15:0],sum01_r}; // @[Cat.scala 33:92]
  wire [16:0] _sum3_w_T_2 = a_r3[63:48] + b_r3[63:48]; // @[dut.scala 78:29]
  wire [16:0] _GEN_2 = {{16'd0}, c2_r}; // @[dut.scala 78:45]
  wire [17:0] sum3_w = _sum3_w_T_2 + _GEN_2; // @[dut.scala 78:45]
  reg [64:0] result_r; // @[dut.scala 79:25]
  wire [64:0] _result_r_T_2 = {sum3_w[16],sum3_w[15:0],sum012_r}; // @[Cat.scala 33:92]
  assign io_result = result_r; // @[dut.scala 84:13]
  assign io_o_en = en3; // @[dut.scala 26:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:20]
      en0 <= 1'h0; // @[dut.scala 16:20]
    end else begin
      en0 <= io_i_en; // @[dut.scala 21:7]
    end
    if (reset) begin // @[dut.scala 17:20]
      en1 <= 1'h0; // @[dut.scala 17:20]
    end else begin
      en1 <= en0; // @[dut.scala 22:7]
    end
    if (reset) begin // @[dut.scala 18:20]
      en2 <= 1'h0; // @[dut.scala 18:20]
    end else begin
      en2 <= en1; // @[dut.scala 23:7]
    end
    if (reset) begin // @[dut.scala 19:20]
      en3 <= 1'h0; // @[dut.scala 19:20]
    end else begin
      en3 <= en2; // @[dut.scala 24:7]
    end
    if (reset) begin // @[dut.scala 31:21]
      a_r1 <= 64'h0; // @[dut.scala 31:21]
    end else begin
      a_r1 <= io_adda; // @[dut.scala 38:8]
    end
    if (reset) begin // @[dut.scala 32:21]
      b_r1 <= 64'h0; // @[dut.scala 32:21]
    end else begin
      b_r1 <= io_addb; // @[dut.scala 39:8]
    end
    if (reset) begin // @[dut.scala 33:21]
      a_r2 <= 64'h0; // @[dut.scala 33:21]
    end else begin
      a_r2 <= a_r1; // @[dut.scala 40:8]
    end
    if (reset) begin // @[dut.scala 34:21]
      b_r2 <= 64'h0; // @[dut.scala 34:21]
    end else begin
      b_r2 <= b_r1; // @[dut.scala 41:8]
    end
    if (reset) begin // @[dut.scala 35:21]
      a_r3 <= 64'h0; // @[dut.scala 35:21]
    end else begin
      a_r3 <= a_r2; // @[dut.scala 42:8]
    end
    if (reset) begin // @[dut.scala 36:21]
      b_r3 <= 64'h0; // @[dut.scala 36:21]
    end else begin
      b_r3 <= b_r2; // @[dut.scala 43:8]
    end
    if (reset) begin // @[dut.scala 49:23]
      sum0_r <= 16'h0; // @[dut.scala 49:23]
    end else begin
      sum0_r <= sum0_w[15:0]; // @[dut.scala 52:10]
    end
    if (reset) begin // @[dut.scala 50:23]
      c0_r <= 1'h0; // @[dut.scala 50:23]
    end else begin
      c0_r <= sum0_w[16]; // @[dut.scala 53:10]
    end
    if (reset) begin // @[dut.scala 59:24]
      sum01_r <= 32'h0; // @[dut.scala 59:24]
    end else begin
      sum01_r <= _sum01_r_T_1; // @[dut.scala 62:11]
    end
    if (reset) begin // @[dut.scala 60:24]
      c1_r <= 1'h0; // @[dut.scala 60:24]
    end else begin
      c1_r <= sum1_w[16]; // @[dut.scala 63:11]
    end
    if (reset) begin // @[dut.scala 69:25]
      sum012_r <= 48'h0; // @[dut.scala 69:25]
    end else begin
      sum012_r <= _sum012_r_T_1; // @[dut.scala 72:12]
    end
    if (reset) begin // @[dut.scala 70:25]
      c2_r <= 1'h0; // @[dut.scala 70:25]
    end else begin
      c2_r <= sum2_w[16]; // @[dut.scala 73:12]
    end
    if (reset) begin // @[dut.scala 79:25]
      result_r <= 65'h0; // @[dut.scala 79:25]
    end else begin
      result_r <= _result_r_T_2; // @[dut.scala 82:12]
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
  en0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en3 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  a_r1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  b_r1 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  a_r2 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b_r2 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  a_r3 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b_r3 = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  sum0_r = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  c0_r = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sum01_r = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  c1_r = _RAND_13[0:0];
  _RAND_14 = {2{`RANDOM}};
  sum012_r = _RAND_14[47:0];
  _RAND_15 = {1{`RANDOM}};
  c2_r = _RAND_15[0:0];
  _RAND_16 = {3{`RANDOM}};
  result_r = _RAND_16[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
