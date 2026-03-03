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
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg  en0; // @[dut.scala 16:20]
  reg  en1; // @[dut.scala 17:20]
  reg  en2; // @[dut.scala 18:20]
  reg  en3; // @[dut.scala 19:20]
  reg [15:0] s0; // @[dut.scala 29:19]
  reg  c0; // @[dut.scala 30:19]
  reg [15:0] a1_0; // @[dut.scala 32:21]
  reg [15:0] b1_0; // @[dut.scala 33:21]
  reg [15:0] a2_0; // @[dut.scala 34:21]
  reg [15:0] b2_0; // @[dut.scala 35:21]
  reg [15:0] a3_0; // @[dut.scala 36:21]
  reg [15:0] b3_0; // @[dut.scala 37:21]
  wire [16:0] add0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 40:31]
  reg [15:0] s1; // @[dut.scala 55:19]
  reg  c1; // @[dut.scala 56:19]
  reg [15:0] a2_1; // @[dut.scala 58:21]
  reg [15:0] b2_1; // @[dut.scala 59:21]
  reg [15:0] a3_1; // @[dut.scala 60:21]
  reg [15:0] b3_1; // @[dut.scala 61:21]
  reg [15:0] s0_d1; // @[dut.scala 63:22]
  wire [16:0] _add1_T = a1_0 + b1_0; // @[dut.scala 66:21]
  wire [16:0] _GEN_27 = {{16'd0}, c0}; // @[dut.scala 66:29]
  wire [16:0] add1 = _add1_T + _GEN_27; // @[dut.scala 66:29]
  reg [15:0] s2; // @[dut.scala 81:19]
  reg  c2; // @[dut.scala 82:19]
  reg [15:0] a3_2; // @[dut.scala 84:21]
  reg [15:0] b3_2; // @[dut.scala 85:21]
  reg [15:0] s0_d2; // @[dut.scala 87:22]
  reg [15:0] s1_d1; // @[dut.scala 88:22]
  wire [16:0] _add2_T = a2_1 + b2_1; // @[dut.scala 91:21]
  wire [16:0] _GEN_28 = {{16'd0}, c1}; // @[dut.scala 91:29]
  wire [16:0] add2 = _add2_T + _GEN_28; // @[dut.scala 91:29]
  reg [15:0] s3; // @[dut.scala 105:19]
  reg  c3; // @[dut.scala 106:19]
  reg [15:0] s0_d3; // @[dut.scala 108:22]
  reg [15:0] s1_d2; // @[dut.scala 109:22]
  reg [15:0] s2_d1; // @[dut.scala 110:22]
  wire [16:0] _add3_T = a3_2 + b3_2; // @[dut.scala 113:21]
  wire [16:0] _GEN_29 = {{16'd0}, c2}; // @[dut.scala 113:29]
  wire [16:0] add3 = _add3_T + _GEN_29; // @[dut.scala 113:29]
  reg [64:0] resultReg; // @[dut.scala 125:26]
  reg  oEnReg; // @[dut.scala 126:26]
  wire [64:0] _resultReg_T = {c3,s3,s2_d1,s1_d2,s0_d3}; // @[Cat.scala 33:92]
  assign io_result = resultReg; // @[dut.scala 133:13]
  assign io_o_en = oEnReg; // @[dut.scala 134:13]
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
    if (reset) begin // @[dut.scala 29:19]
      s0 <= 16'h0; // @[dut.scala 29:19]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      s0 <= add0[15:0]; // @[dut.scala 41:8]
    end
    if (reset) begin // @[dut.scala 30:19]
      c0 <= 1'h0; // @[dut.scala 30:19]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      c0 <= add0[16]; // @[dut.scala 42:8]
    end
    if (reset) begin // @[dut.scala 32:21]
      a1_0 <= 16'h0; // @[dut.scala 32:21]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      a1_0 <= io_adda[31:16]; // @[dut.scala 44:10]
    end
    if (reset) begin // @[dut.scala 33:21]
      b1_0 <= 16'h0; // @[dut.scala 33:21]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      b1_0 <= io_addb[31:16]; // @[dut.scala 45:10]
    end
    if (reset) begin // @[dut.scala 34:21]
      a2_0 <= 16'h0; // @[dut.scala 34:21]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      a2_0 <= io_adda[47:32]; // @[dut.scala 46:10]
    end
    if (reset) begin // @[dut.scala 35:21]
      b2_0 <= 16'h0; // @[dut.scala 35:21]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      b2_0 <= io_addb[47:32]; // @[dut.scala 47:10]
    end
    if (reset) begin // @[dut.scala 36:21]
      a3_0 <= 16'h0; // @[dut.scala 36:21]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      a3_0 <= io_adda[63:48]; // @[dut.scala 48:10]
    end
    if (reset) begin // @[dut.scala 37:21]
      b3_0 <= 16'h0; // @[dut.scala 37:21]
    end else if (io_i_en) begin // @[dut.scala 39:17]
      b3_0 <= io_addb[63:48]; // @[dut.scala 49:10]
    end
    if (reset) begin // @[dut.scala 55:19]
      s1 <= 16'h0; // @[dut.scala 55:19]
    end else if (en0) begin // @[dut.scala 65:13]
      s1 <= add1[15:0]; // @[dut.scala 67:8]
    end
    if (reset) begin // @[dut.scala 56:19]
      c1 <= 1'h0; // @[dut.scala 56:19]
    end else if (en0) begin // @[dut.scala 65:13]
      c1 <= add1[16]; // @[dut.scala 68:8]
    end
    if (reset) begin // @[dut.scala 58:21]
      a2_1 <= 16'h0; // @[dut.scala 58:21]
    end else if (en0) begin // @[dut.scala 65:13]
      a2_1 <= a2_0; // @[dut.scala 70:10]
    end
    if (reset) begin // @[dut.scala 59:21]
      b2_1 <= 16'h0; // @[dut.scala 59:21]
    end else if (en0) begin // @[dut.scala 65:13]
      b2_1 <= b2_0; // @[dut.scala 71:10]
    end
    if (reset) begin // @[dut.scala 60:21]
      a3_1 <= 16'h0; // @[dut.scala 60:21]
    end else if (en0) begin // @[dut.scala 65:13]
      a3_1 <= a3_0; // @[dut.scala 72:10]
    end
    if (reset) begin // @[dut.scala 61:21]
      b3_1 <= 16'h0; // @[dut.scala 61:21]
    end else if (en0) begin // @[dut.scala 65:13]
      b3_1 <= b3_0; // @[dut.scala 73:10]
    end
    if (reset) begin // @[dut.scala 63:22]
      s0_d1 <= 16'h0; // @[dut.scala 63:22]
    end else if (en0) begin // @[dut.scala 65:13]
      s0_d1 <= s0; // @[dut.scala 75:11]
    end
    if (reset) begin // @[dut.scala 81:19]
      s2 <= 16'h0; // @[dut.scala 81:19]
    end else if (en1) begin // @[dut.scala 90:13]
      s2 <= add2[15:0]; // @[dut.scala 92:8]
    end
    if (reset) begin // @[dut.scala 82:19]
      c2 <= 1'h0; // @[dut.scala 82:19]
    end else if (en1) begin // @[dut.scala 90:13]
      c2 <= add2[16]; // @[dut.scala 93:8]
    end
    if (reset) begin // @[dut.scala 84:21]
      a3_2 <= 16'h0; // @[dut.scala 84:21]
    end else if (en1) begin // @[dut.scala 90:13]
      a3_2 <= a3_1; // @[dut.scala 95:10]
    end
    if (reset) begin // @[dut.scala 85:21]
      b3_2 <= 16'h0; // @[dut.scala 85:21]
    end else if (en1) begin // @[dut.scala 90:13]
      b3_2 <= b3_1; // @[dut.scala 96:10]
    end
    if (reset) begin // @[dut.scala 87:22]
      s0_d2 <= 16'h0; // @[dut.scala 87:22]
    end else if (en1) begin // @[dut.scala 90:13]
      s0_d2 <= s0_d1; // @[dut.scala 98:11]
    end
    if (reset) begin // @[dut.scala 88:22]
      s1_d1 <= 16'h0; // @[dut.scala 88:22]
    end else if (en1) begin // @[dut.scala 90:13]
      s1_d1 <= s1; // @[dut.scala 99:11]
    end
    if (reset) begin // @[dut.scala 105:19]
      s3 <= 16'h0; // @[dut.scala 105:19]
    end else if (en2) begin // @[dut.scala 112:13]
      s3 <= add3[15:0]; // @[dut.scala 114:8]
    end
    if (reset) begin // @[dut.scala 106:19]
      c3 <= 1'h0; // @[dut.scala 106:19]
    end else if (en2) begin // @[dut.scala 112:13]
      c3 <= add3[16]; // @[dut.scala 115:8]
    end
    if (reset) begin // @[dut.scala 108:22]
      s0_d3 <= 16'h0; // @[dut.scala 108:22]
    end else if (en2) begin // @[dut.scala 112:13]
      s0_d3 <= s0_d2; // @[dut.scala 117:11]
    end
    if (reset) begin // @[dut.scala 109:22]
      s1_d2 <= 16'h0; // @[dut.scala 109:22]
    end else if (en2) begin // @[dut.scala 112:13]
      s1_d2 <= s1_d1; // @[dut.scala 118:11]
    end
    if (reset) begin // @[dut.scala 110:22]
      s2_d1 <= 16'h0; // @[dut.scala 110:22]
    end else if (en2) begin // @[dut.scala 112:13]
      s2_d1 <= s2; // @[dut.scala 119:11]
    end
    if (reset) begin // @[dut.scala 125:26]
      resultReg <= 65'h0; // @[dut.scala 125:26]
    end else if (en3) begin // @[dut.scala 129:13]
      resultReg <= _resultReg_T; // @[dut.scala 130:15]
    end
    if (reset) begin // @[dut.scala 126:26]
      oEnReg <= 1'h0; // @[dut.scala 126:26]
    end else begin
      oEnReg <= en3; // @[dut.scala 128:10]
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
  _RAND_4 = {1{`RANDOM}};
  s0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  c0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  a1_0 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  b1_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  a2_0 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  b2_0 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  a3_0 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  b3_0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  s1 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  c1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  a2_1 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  b2_1 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  a3_1 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  b3_1 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  s0_d1 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  s2 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  c2 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  a3_2 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  b3_2 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  s0_d2 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  s1_d1 = _RAND_24[15:0];
  _RAND_25 = {1{`RANDOM}};
  s3 = _RAND_25[15:0];
  _RAND_26 = {1{`RANDOM}};
  c3 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  s0_d3 = _RAND_27[15:0];
  _RAND_28 = {1{`RANDOM}};
  s1_d2 = _RAND_28[15:0];
  _RAND_29 = {1{`RANDOM}};
  s2_d1 = _RAND_29[15:0];
  _RAND_30 = {3{`RANDOM}};
  resultReg = _RAND_30[64:0];
  _RAND_31 = {1{`RANDOM}};
  oEnReg = _RAND_31[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
