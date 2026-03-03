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
  reg [95:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  reg  en1; // @[dut.scala 16:20]
  reg  en2; // @[dut.scala 17:20]
  reg  en3; // @[dut.scala 18:20]
  reg  en4; // @[dut.scala 19:20]
  reg [15:0] s0_sum; // @[dut.scala 29:24]
  reg  s0_cout; // @[dut.scala 30:24]
  reg [15:0] s0_a1; // @[dut.scala 32:22]
  reg [15:0] s0_b1; // @[dut.scala 33:22]
  reg [15:0] s0_a2; // @[dut.scala 34:22]
  reg [15:0] s0_b2; // @[dut.scala 35:22]
  reg [15:0] s0_a3; // @[dut.scala 36:22]
  reg [15:0] s0_b3; // @[dut.scala 37:22]
  wire [16:0] add0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 39:29]
  reg [15:0] s1_sum; // @[dut.scala 53:24]
  reg  s1_cout; // @[dut.scala 54:24]
  reg [15:0] s1_sum0; // @[dut.scala 56:24]
  reg [15:0] s1_a2; // @[dut.scala 57:24]
  reg [15:0] s1_b2; // @[dut.scala 58:24]
  reg [15:0] s1_a3; // @[dut.scala 59:24]
  reg [15:0] s1_b3; // @[dut.scala 60:24]
  wire [16:0] _add1_T = {1'h0,s0_a1}; // @[Cat.scala 33:92]
  wire [16:0] _add1_T_1 = {1'h0,s0_b1}; // @[Cat.scala 33:92]
  wire [17:0] _add1_T_2 = _add1_T + _add1_T_1; // @[dut.scala 62:35]
  wire [17:0] _GEN_0 = {{17'd0}, s0_cout}; // @[dut.scala 62:59]
  wire [17:0] add1 = _add1_T_2 + _GEN_0; // @[dut.scala 62:59]
  reg [15:0] s2_sum; // @[dut.scala 75:24]
  reg  s2_cout; // @[dut.scala 76:24]
  reg [15:0] s2_sum0; // @[dut.scala 78:24]
  reg [15:0] s2_sum1; // @[dut.scala 79:24]
  reg [15:0] s2_a3; // @[dut.scala 80:24]
  reg [15:0] s2_b3; // @[dut.scala 81:24]
  wire [16:0] _add2_T = {1'h0,s1_a2}; // @[Cat.scala 33:92]
  wire [16:0] _add2_T_1 = {1'h0,s1_b2}; // @[Cat.scala 33:92]
  wire [17:0] _add2_T_2 = _add2_T + _add2_T_1; // @[dut.scala 83:35]
  wire [17:0] _GEN_1 = {{17'd0}, s1_cout}; // @[dut.scala 83:59]
  wire [17:0] add2 = _add2_T_2 + _GEN_1; // @[dut.scala 83:59]
  reg [15:0] s3_sum; // @[dut.scala 95:24]
  reg  s3_cout; // @[dut.scala 96:24]
  reg [15:0] s3_sum0; // @[dut.scala 98:24]
  reg [15:0] s3_sum1; // @[dut.scala 99:24]
  reg [15:0] s3_sum2; // @[dut.scala 100:24]
  wire [16:0] _add3_T = {1'h0,s2_a3}; // @[Cat.scala 33:92]
  wire [16:0] _add3_T_1 = {1'h0,s2_b3}; // @[Cat.scala 33:92]
  wire [17:0] _add3_T_2 = _add3_T + _add3_T_1; // @[dut.scala 102:35]
  wire [17:0] _GEN_2 = {{17'd0}, s2_cout}; // @[dut.scala 102:59]
  wire [17:0] add3 = _add3_T_2 + _GEN_2; // @[dut.scala 102:59]
  reg [64:0] resultReg; // @[dut.scala 113:26]
  wire [64:0] _resultReg_T = {s3_cout,s3_sum,s3_sum2,s3_sum1,s3_sum0}; // @[Cat.scala 33:92]
  assign io_result = resultReg; // @[dut.scala 116:13]
  assign io_o_en = en4; // @[dut.scala 117:13]
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
    if (reset) begin // @[dut.scala 29:24]
      s0_sum <= 16'h0; // @[dut.scala 29:24]
    end else begin
      s0_sum <= add0[15:0]; // @[dut.scala 40:11]
    end
    if (reset) begin // @[dut.scala 30:24]
      s0_cout <= 1'h0; // @[dut.scala 30:24]
    end else begin
      s0_cout <= add0[16]; // @[dut.scala 41:11]
    end
    if (reset) begin // @[dut.scala 32:22]
      s0_a1 <= 16'h0; // @[dut.scala 32:22]
    end else begin
      s0_a1 <= io_adda[31:16]; // @[dut.scala 43:9]
    end
    if (reset) begin // @[dut.scala 33:22]
      s0_b1 <= 16'h0; // @[dut.scala 33:22]
    end else begin
      s0_b1 <= io_addb[31:16]; // @[dut.scala 44:9]
    end
    if (reset) begin // @[dut.scala 34:22]
      s0_a2 <= 16'h0; // @[dut.scala 34:22]
    end else begin
      s0_a2 <= io_adda[47:32]; // @[dut.scala 45:9]
    end
    if (reset) begin // @[dut.scala 35:22]
      s0_b2 <= 16'h0; // @[dut.scala 35:22]
    end else begin
      s0_b2 <= io_addb[47:32]; // @[dut.scala 46:9]
    end
    if (reset) begin // @[dut.scala 36:22]
      s0_a3 <= 16'h0; // @[dut.scala 36:22]
    end else begin
      s0_a3 <= io_adda[63:48]; // @[dut.scala 47:9]
    end
    if (reset) begin // @[dut.scala 37:22]
      s0_b3 <= 16'h0; // @[dut.scala 37:22]
    end else begin
      s0_b3 <= io_addb[63:48]; // @[dut.scala 48:9]
    end
    if (reset) begin // @[dut.scala 53:24]
      s1_sum <= 16'h0; // @[dut.scala 53:24]
    end else begin
      s1_sum <= add1[15:0]; // @[dut.scala 63:11]
    end
    if (reset) begin // @[dut.scala 54:24]
      s1_cout <= 1'h0; // @[dut.scala 54:24]
    end else begin
      s1_cout <= add1[16]; // @[dut.scala 64:11]
    end
    if (reset) begin // @[dut.scala 56:24]
      s1_sum0 <= 16'h0; // @[dut.scala 56:24]
    end else begin
      s1_sum0 <= s0_sum; // @[dut.scala 66:11]
    end
    if (reset) begin // @[dut.scala 57:24]
      s1_a2 <= 16'h0; // @[dut.scala 57:24]
    end else begin
      s1_a2 <= s0_a2; // @[dut.scala 67:11]
    end
    if (reset) begin // @[dut.scala 58:24]
      s1_b2 <= 16'h0; // @[dut.scala 58:24]
    end else begin
      s1_b2 <= s0_b2; // @[dut.scala 68:11]
    end
    if (reset) begin // @[dut.scala 59:24]
      s1_a3 <= 16'h0; // @[dut.scala 59:24]
    end else begin
      s1_a3 <= s0_a3; // @[dut.scala 69:11]
    end
    if (reset) begin // @[dut.scala 60:24]
      s1_b3 <= 16'h0; // @[dut.scala 60:24]
    end else begin
      s1_b3 <= s0_b3; // @[dut.scala 70:11]
    end
    if (reset) begin // @[dut.scala 75:24]
      s2_sum <= 16'h0; // @[dut.scala 75:24]
    end else begin
      s2_sum <= add2[15:0]; // @[dut.scala 84:11]
    end
    if (reset) begin // @[dut.scala 76:24]
      s2_cout <= 1'h0; // @[dut.scala 76:24]
    end else begin
      s2_cout <= add2[16]; // @[dut.scala 85:11]
    end
    if (reset) begin // @[dut.scala 78:24]
      s2_sum0 <= 16'h0; // @[dut.scala 78:24]
    end else begin
      s2_sum0 <= s1_sum0; // @[dut.scala 87:11]
    end
    if (reset) begin // @[dut.scala 79:24]
      s2_sum1 <= 16'h0; // @[dut.scala 79:24]
    end else begin
      s2_sum1 <= s1_sum; // @[dut.scala 88:11]
    end
    if (reset) begin // @[dut.scala 80:24]
      s2_a3 <= 16'h0; // @[dut.scala 80:24]
    end else begin
      s2_a3 <= s1_a3; // @[dut.scala 89:11]
    end
    if (reset) begin // @[dut.scala 81:24]
      s2_b3 <= 16'h0; // @[dut.scala 81:24]
    end else begin
      s2_b3 <= s1_b3; // @[dut.scala 90:11]
    end
    if (reset) begin // @[dut.scala 95:24]
      s3_sum <= 16'h0; // @[dut.scala 95:24]
    end else begin
      s3_sum <= add3[15:0]; // @[dut.scala 103:11]
    end
    if (reset) begin // @[dut.scala 96:24]
      s3_cout <= 1'h0; // @[dut.scala 96:24]
    end else begin
      s3_cout <= add3[16]; // @[dut.scala 104:11]
    end
    if (reset) begin // @[dut.scala 98:24]
      s3_sum0 <= 16'h0; // @[dut.scala 98:24]
    end else begin
      s3_sum0 <= s2_sum0; // @[dut.scala 106:11]
    end
    if (reset) begin // @[dut.scala 99:24]
      s3_sum1 <= 16'h0; // @[dut.scala 99:24]
    end else begin
      s3_sum1 <= s2_sum1; // @[dut.scala 107:11]
    end
    if (reset) begin // @[dut.scala 100:24]
      s3_sum2 <= 16'h0; // @[dut.scala 100:24]
    end else begin
      s3_sum2 <= s2_sum; // @[dut.scala 108:11]
    end
    if (reset) begin // @[dut.scala 113:26]
      resultReg <= 65'h0; // @[dut.scala 113:26]
    end else begin
      resultReg <= _resultReg_T; // @[dut.scala 114:13]
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
  _RAND_4 = {1{`RANDOM}};
  s0_sum = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  s0_cout = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s0_a1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  s0_b1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  s0_a2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  s0_b2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  s0_a3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  s0_b3 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  s1_sum = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  s1_cout = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  s1_sum0 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  s1_a2 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  s1_b2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  s1_a3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  s1_b3 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  s2_sum = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  s2_cout = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  s2_sum0 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  s2_sum1 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  s2_a3 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  s2_b3 = _RAND_24[15:0];
  _RAND_25 = {1{`RANDOM}};
  s3_sum = _RAND_25[15:0];
  _RAND_26 = {1{`RANDOM}};
  s3_cout = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  s3_sum0 = _RAND_27[15:0];
  _RAND_28 = {1{`RANDOM}};
  s3_sum1 = _RAND_28[15:0];
  _RAND_29 = {1{`RANDOM}};
  s3_sum2 = _RAND_29[15:0];
  _RAND_30 = {3{`RANDOM}};
  resultReg = _RAND_30[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
