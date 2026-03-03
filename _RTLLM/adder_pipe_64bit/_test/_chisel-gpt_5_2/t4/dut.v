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
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [95:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg  en0; // @[dut.scala 21:22]
  reg [63:0] a0; // @[dut.scala 22:18]
  reg [63:0] b0; // @[dut.scala 23:18]
  reg [15:0] sum0; // @[dut.scala 24:22]
  reg  c0; // @[dut.scala 25:22]
  reg  en1; // @[dut.scala 28:22]
  reg [63:0] a1; // @[dut.scala 29:18]
  reg [63:0] b1; // @[dut.scala 30:18]
  reg [15:0] sum1; // @[dut.scala 31:22]
  reg  c1; // @[dut.scala 32:22]
  reg  en2; // @[dut.scala 35:22]
  reg [63:0] a2; // @[dut.scala 36:18]
  reg [63:0] b2; // @[dut.scala 37:18]
  reg [15:0] sum2; // @[dut.scala 38:22]
  reg  c2; // @[dut.scala 39:22]
  reg  en3; // @[dut.scala 42:22]
  reg [15:0] sum3; // @[dut.scala 43:22]
  reg  c3; // @[dut.scala 44:22]
  reg  en4; // @[dut.scala 47:22]
  reg [64:0] resR; // @[dut.scala 48:22]
  wire [16:0] _full_T = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 57:15]
  wire [17:0] _full_T_1 = {{1'd0}, _full_T}; // @[dut.scala 57:20]
  wire [16:0] full = _full_T_1[16:0]; // @[dut.scala 56:20 57:10]
  wire [15:0] s0 = full[15:0]; // @[dut.scala 58:10]
  wire  co0 = full[16]; // @[dut.scala 58:23]
  wire [16:0] _full_T_2 = a0[31:16] + b0[31:16]; // @[dut.scala 57:15]
  wire [16:0] _GEN_15 = {{16'd0}, c0}; // @[dut.scala 57:20]
  wire [17:0] _full_T_3 = _full_T_2 + _GEN_15; // @[dut.scala 57:20]
  wire [16:0] full_1 = _full_T_3[16:0]; // @[dut.scala 56:20 57:10]
  wire [15:0] s1 = full_1[15:0]; // @[dut.scala 58:10]
  wire  co1 = full_1[16]; // @[dut.scala 58:23]
  wire [16:0] _full_T_4 = a1[47:32] + b1[47:32]; // @[dut.scala 57:15]
  wire [16:0] _GEN_16 = {{16'd0}, c1}; // @[dut.scala 57:20]
  wire [17:0] _full_T_5 = _full_T_4 + _GEN_16; // @[dut.scala 57:20]
  wire [16:0] full_2 = _full_T_5[16:0]; // @[dut.scala 56:20 57:10]
  wire [15:0] s2 = full_2[15:0]; // @[dut.scala 58:10]
  wire  co2 = full_2[16]; // @[dut.scala 58:23]
  wire [16:0] _full_T_6 = a2[63:48] + b2[63:48]; // @[dut.scala 57:15]
  wire [16:0] _GEN_17 = {{16'd0}, c2}; // @[dut.scala 57:20]
  wire [17:0] _full_T_7 = _full_T_6 + _GEN_17; // @[dut.scala 57:20]
  wire [16:0] full_3 = _full_T_7[16:0]; // @[dut.scala 56:20 57:10]
  wire [15:0] s3 = full_3[15:0]; // @[dut.scala 58:10]
  wire  co3 = full_3[16]; // @[dut.scala 58:23]
  wire [64:0] _resR_T = {c3,sum3,sum2,sum1,sum0}; // @[Cat.scala 33:92]
  assign io_result = resR; // @[dut.scala 51:13]
  assign io_o_en = en4; // @[dut.scala 52:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:22]
      en0 <= 1'h0; // @[dut.scala 21:22]
    end else begin
      en0 <= io_i_en; // @[dut.scala 72:7]
    end
    if (io_i_en) begin // @[dut.scala 66:17]
      a0 <= io_adda; // @[dut.scala 67:10]
    end
    if (io_i_en) begin // @[dut.scala 66:17]
      b0 <= io_addb; // @[dut.scala 68:10]
    end
    if (reset) begin // @[dut.scala 24:22]
      sum0 <= 16'h0; // @[dut.scala 24:22]
    end else if (io_i_en) begin // @[dut.scala 66:17]
      sum0 <= s0; // @[dut.scala 69:10]
    end
    if (reset) begin // @[dut.scala 25:22]
      c0 <= 1'h0; // @[dut.scala 25:22]
    end else if (io_i_en) begin // @[dut.scala 66:17]
      c0 <= co0; // @[dut.scala 70:10]
    end
    if (reset) begin // @[dut.scala 28:22]
      en1 <= 1'h0; // @[dut.scala 28:22]
    end else begin
      en1 <= en0; // @[dut.scala 85:7]
    end
    if (en0) begin // @[dut.scala 79:13]
      a1 <= a0; // @[dut.scala 80:10]
    end
    if (en0) begin // @[dut.scala 79:13]
      b1 <= b0; // @[dut.scala 81:10]
    end
    if (reset) begin // @[dut.scala 31:22]
      sum1 <= 16'h0; // @[dut.scala 31:22]
    end else if (en0) begin // @[dut.scala 79:13]
      sum1 <= s1; // @[dut.scala 82:10]
    end
    if (reset) begin // @[dut.scala 32:22]
      c1 <= 1'h0; // @[dut.scala 32:22]
    end else if (en0) begin // @[dut.scala 79:13]
      c1 <= co1; // @[dut.scala 83:10]
    end
    if (reset) begin // @[dut.scala 35:22]
      en2 <= 1'h0; // @[dut.scala 35:22]
    end else begin
      en2 <= en1; // @[dut.scala 98:7]
    end
    if (en1) begin // @[dut.scala 92:13]
      a2 <= a1; // @[dut.scala 93:10]
    end
    if (en1) begin // @[dut.scala 92:13]
      b2 <= b1; // @[dut.scala 94:10]
    end
    if (reset) begin // @[dut.scala 38:22]
      sum2 <= 16'h0; // @[dut.scala 38:22]
    end else if (en1) begin // @[dut.scala 92:13]
      sum2 <= s2; // @[dut.scala 95:10]
    end
    if (reset) begin // @[dut.scala 39:22]
      c2 <= 1'h0; // @[dut.scala 39:22]
    end else if (en1) begin // @[dut.scala 92:13]
      c2 <= co2; // @[dut.scala 96:10]
    end
    if (reset) begin // @[dut.scala 42:22]
      en3 <= 1'h0; // @[dut.scala 42:22]
    end else begin
      en3 <= en2; // @[dut.scala 109:7]
    end
    if (reset) begin // @[dut.scala 43:22]
      sum3 <= 16'h0; // @[dut.scala 43:22]
    end else if (en2) begin // @[dut.scala 105:13]
      sum3 <= s3; // @[dut.scala 106:10]
    end
    if (reset) begin // @[dut.scala 44:22]
      c3 <= 1'h0; // @[dut.scala 44:22]
    end else if (en2) begin // @[dut.scala 105:13]
      c3 <= co3; // @[dut.scala 107:10]
    end
    if (reset) begin // @[dut.scala 47:22]
      en4 <= 1'h0; // @[dut.scala 47:22]
    end else begin
      en4 <= en3; // @[dut.scala 117:7]
    end
    if (reset) begin // @[dut.scala 48:22]
      resR <= 65'h0; // @[dut.scala 48:22]
    end else if (en3) begin // @[dut.scala 114:13]
      resR <= _resR_T; // @[dut.scala 115:10]
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
  _RAND_1 = {2{`RANDOM}};
  a0 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  b0 = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  sum0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  c0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  en1 = _RAND_5[0:0];
  _RAND_6 = {2{`RANDOM}};
  a1 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b1 = _RAND_7[63:0];
  _RAND_8 = {1{`RANDOM}};
  sum1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  c1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  en2 = _RAND_10[0:0];
  _RAND_11 = {2{`RANDOM}};
  a2 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  b2 = _RAND_12[63:0];
  _RAND_13 = {1{`RANDOM}};
  sum2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  c2 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  en3 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sum3 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  c3 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  en4 = _RAND_18[0:0];
  _RAND_19 = {3{`RANDOM}};
  resR = _RAND_19[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
