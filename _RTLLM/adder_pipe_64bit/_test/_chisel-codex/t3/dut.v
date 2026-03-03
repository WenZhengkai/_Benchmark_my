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
  reg  en1; // @[dut.scala 16:20]
  reg  en2; // @[dut.scala 17:20]
  reg  en3; // @[dut.scala 18:20]
  reg  en4; // @[dut.scala 19:20]
  reg [63:0] a_d1; // @[dut.scala 29:17]
  reg [63:0] a_d2; // @[dut.scala 30:17]
  reg [63:0] a_d3; // @[dut.scala 31:17]
  reg [63:0] b_d1; // @[dut.scala 32:17]
  reg [63:0] b_d2; // @[dut.scala 33:17]
  reg [63:0] b_d3; // @[dut.scala 34:17]
  reg [15:0] sum0; // @[dut.scala 47:21]
  reg [15:0] sum1; // @[dut.scala 48:21]
  reg [15:0] sum2; // @[dut.scala 49:21]
  reg [15:0] sum3; // @[dut.scala 50:21]
  reg  c0; // @[dut.scala 52:19]
  reg  c1; // @[dut.scala 53:19]
  reg  c2; // @[dut.scala 54:19]
  reg  c3; // @[dut.scala 55:19]
  reg [15:0] sum0_d1; // @[dut.scala 58:24]
  reg [15:0] sum0_d2; // @[dut.scala 59:24]
  reg [15:0] sum0_d3; // @[dut.scala 60:24]
  reg [15:0] sum1_d1; // @[dut.scala 62:24]
  reg [15:0] sum1_d2; // @[dut.scala 63:24]
  reg [15:0] sum2_d1; // @[dut.scala 65:24]
  wire [16:0] t0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 71:29]
  wire [16:0] _t1_T_2 = a_d1[31:16] + b_d1[31:16]; // @[dut.scala 80:27]
  wire [16:0] _GEN_14 = {{16'd0}, c0}; // @[dut.scala 80:43]
  wire [17:0] t1 = _t1_T_2 + _GEN_14; // @[dut.scala 80:43]
  wire [16:0] _t2_T_2 = a_d2[47:32] + b_d2[47:32]; // @[dut.scala 91:27]
  wire [16:0] _GEN_15 = {{16'd0}, c1}; // @[dut.scala 91:43]
  wire [17:0] t2 = _t2_T_2 + _GEN_15; // @[dut.scala 91:43]
  wire [16:0] _t3_T_2 = a_d3[63:48] + b_d3[63:48]; // @[dut.scala 103:27]
  wire [16:0] _GEN_16 = {{16'd0}, c2}; // @[dut.scala 103:43]
  wire [17:0] t3 = _t3_T_2 + _GEN_16; // @[dut.scala 103:43]
  wire [31:0] io_result_lo = {sum1_d2,sum0_d3}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {c3,sum3,sum2_d1}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en4; // @[dut.scala 116:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:20]
      en1 <= 1'h0; // @[dut.scala 16:20]
    end else begin
      en1 <= io_i_en; // @[dut.scala 21:7]
    end
    if (reset) begin // @[dut.scala 17:20]
      en2 <= 1'h0; // @[dut.scala 17:20]
    end else begin
      en2 <= en1; // @[dut.scala 22:7]
    end
    if (reset) begin // @[dut.scala 18:20]
      en3 <= 1'h0; // @[dut.scala 18:20]
    end else begin
      en3 <= en2; // @[dut.scala 23:7]
    end
    if (reset) begin // @[dut.scala 19:20]
      en4 <= 1'h0; // @[dut.scala 19:20]
    end else begin
      en4 <= en3; // @[dut.scala 24:7]
    end
    a_d1 <= io_adda; // @[dut.scala 36:8]
    a_d2 <= a_d1; // @[dut.scala 37:8]
    a_d3 <= a_d2; // @[dut.scala 38:8]
    b_d1 <= io_addb; // @[dut.scala 40:8]
    b_d2 <= b_d1; // @[dut.scala 41:8]
    b_d3 <= b_d2; // @[dut.scala 42:8]
    if (reset) begin // @[dut.scala 47:21]
      sum0 <= 16'h0; // @[dut.scala 47:21]
    end else if (io_i_en) begin // @[dut.scala 70:17]
      sum0 <= t0[15:0]; // @[dut.scala 72:10]
    end
    if (reset) begin // @[dut.scala 48:21]
      sum1 <= 16'h0; // @[dut.scala 48:21]
    end else if (en1) begin // @[dut.scala 79:13]
      sum1 <= t1[15:0]; // @[dut.scala 81:10]
    end
    if (reset) begin // @[dut.scala 49:21]
      sum2 <= 16'h0; // @[dut.scala 49:21]
    end else if (en2) begin // @[dut.scala 90:13]
      sum2 <= t2[15:0]; // @[dut.scala 92:10]
    end
    if (reset) begin // @[dut.scala 50:21]
      sum3 <= 16'h0; // @[dut.scala 50:21]
    end else if (en3) begin // @[dut.scala 102:13]
      sum3 <= t3[15:0]; // @[dut.scala 104:10]
    end
    if (reset) begin // @[dut.scala 52:19]
      c0 <= 1'h0; // @[dut.scala 52:19]
    end else if (io_i_en) begin // @[dut.scala 70:17]
      c0 <= t0[16]; // @[dut.scala 73:8]
    end
    if (reset) begin // @[dut.scala 53:19]
      c1 <= 1'h0; // @[dut.scala 53:19]
    end else if (en1) begin // @[dut.scala 79:13]
      c1 <= t1[16]; // @[dut.scala 82:8]
    end
    if (reset) begin // @[dut.scala 54:19]
      c2 <= 1'h0; // @[dut.scala 54:19]
    end else if (en2) begin // @[dut.scala 90:13]
      c2 <= t2[16]; // @[dut.scala 93:8]
    end
    if (reset) begin // @[dut.scala 55:19]
      c3 <= 1'h0; // @[dut.scala 55:19]
    end else if (en3) begin // @[dut.scala 102:13]
      c3 <= t3[16]; // @[dut.scala 105:8]
    end
    if (reset) begin // @[dut.scala 58:24]
      sum0_d1 <= 16'h0; // @[dut.scala 58:24]
    end else if (en1) begin // @[dut.scala 79:13]
      sum0_d1 <= sum0; // @[dut.scala 84:13]
    end
    if (reset) begin // @[dut.scala 59:24]
      sum0_d2 <= 16'h0; // @[dut.scala 59:24]
    end else if (en2) begin // @[dut.scala 90:13]
      sum0_d2 <= sum0_d1; // @[dut.scala 95:13]
    end
    if (reset) begin // @[dut.scala 60:24]
      sum0_d3 <= 16'h0; // @[dut.scala 60:24]
    end else if (en3) begin // @[dut.scala 102:13]
      sum0_d3 <= sum0_d2; // @[dut.scala 107:13]
    end
    if (reset) begin // @[dut.scala 62:24]
      sum1_d1 <= 16'h0; // @[dut.scala 62:24]
    end else if (en2) begin // @[dut.scala 90:13]
      sum1_d1 <= sum1; // @[dut.scala 96:13]
    end
    if (reset) begin // @[dut.scala 63:24]
      sum1_d2 <= 16'h0; // @[dut.scala 63:24]
    end else if (en3) begin // @[dut.scala 102:13]
      sum1_d2 <= sum1_d1; // @[dut.scala 108:13]
    end
    if (reset) begin // @[dut.scala 65:24]
      sum2_d1 <= 16'h0; // @[dut.scala 65:24]
    end else if (en3) begin // @[dut.scala 102:13]
      sum2_d1 <= sum2; // @[dut.scala 109:13]
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
  en1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en4 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  a_d1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  a_d2 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  a_d3 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b_d1 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  b_d2 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b_d3 = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  sum0 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum1 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum2 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum3 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  c0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  c1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  c2 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  c3 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sum0_d1 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  sum0_d2 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  sum0_d3 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  sum1_d1 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  sum1_d2 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  sum2_d1 = _RAND_23[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
