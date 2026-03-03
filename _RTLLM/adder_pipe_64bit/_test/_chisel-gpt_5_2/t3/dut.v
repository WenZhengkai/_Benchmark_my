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
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg  en0; // @[dut.scala 26:20]
  reg  en1; // @[dut.scala 27:20]
  reg  en2; // @[dut.scala 28:20]
  reg  en3; // @[dut.scala 29:20]
  reg [63:0] a0; // @[dut.scala 32:19]
  reg [63:0] b0; // @[dut.scala 33:19]
  reg [15:0] sum0_reg; // @[dut.scala 46:27]
  reg  carry0_reg; // @[dut.scala 47:27]
  wire [16:0] s0 = a0[15:0] + b0[15:0]; // @[dut.scala 49:22]
  reg [63:0] a1; // @[dut.scala 56:19]
  reg [63:0] b1; // @[dut.scala 57:19]
  reg [15:0] sum1_reg; // @[dut.scala 63:27]
  reg  carry1_reg; // @[dut.scala 64:27]
  wire [16:0] _s1_T_2 = a1[31:16] + b1[31:16]; // @[dut.scala 66:23]
  wire [16:0] _GEN_16 = {{16'd0}, carry0_reg}; // @[dut.scala 66:37]
  wire [16:0] s1 = _s1_T_2 + _GEN_16; // @[dut.scala 66:37]
  reg [63:0] a2; // @[dut.scala 73:19]
  reg [63:0] b2; // @[dut.scala 74:19]
  reg [15:0] sum2_reg; // @[dut.scala 80:27]
  reg  carry2_reg; // @[dut.scala 81:27]
  wire [16:0] _s2_T_2 = a2[47:32] + b2[47:32]; // @[dut.scala 83:23]
  wire [16:0] _GEN_17 = {{16'd0}, carry1_reg}; // @[dut.scala 83:37]
  wire [16:0] s2 = _s2_T_2 + _GEN_17; // @[dut.scala 83:37]
  reg [63:0] a3; // @[dut.scala 90:19]
  reg [63:0] b3; // @[dut.scala 91:19]
  reg [15:0] sum3_reg; // @[dut.scala 97:31]
  reg  finalCarry_reg; // @[dut.scala 98:31]
  wire [16:0] _s3_T_2 = a3[63:48] + b3[63:48]; // @[dut.scala 100:23]
  wire [16:0] _GEN_18 = {{16'd0}, carry2_reg}; // @[dut.scala 100:37]
  wire [16:0] s3 = _s3_T_2 + _GEN_18; // @[dut.scala 100:37]
  wire [31:0] io_result_lo = {sum1_reg,sum0_reg}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {finalCarry_reg,sum3_reg,sum2_reg}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en3; // @[dut.scala 108:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 26:20]
      en0 <= 1'h0; // @[dut.scala 26:20]
    end else begin
      en0 <= io_i_en; // @[dut.scala 40:7]
    end
    if (reset) begin // @[dut.scala 27:20]
      en1 <= 1'h0; // @[dut.scala 27:20]
    end else begin
      en1 <= en0; // @[dut.scala 41:7]
    end
    if (reset) begin // @[dut.scala 28:20]
      en2 <= 1'h0; // @[dut.scala 28:20]
    end else begin
      en2 <= en1; // @[dut.scala 42:7]
    end
    if (reset) begin // @[dut.scala 29:20]
      en3 <= 1'h0; // @[dut.scala 29:20]
    end else begin
      en3 <= en2; // @[dut.scala 43:7]
    end
    if (reset) begin // @[dut.scala 32:19]
      a0 <= 64'h0; // @[dut.scala 32:19]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      a0 <= io_adda; // @[dut.scala 36:8]
    end
    if (reset) begin // @[dut.scala 33:19]
      b0 <= 64'h0; // @[dut.scala 33:19]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      b0 <= io_addb; // @[dut.scala 37:8]
    end
    if (reset) begin // @[dut.scala 46:27]
      sum0_reg <= 16'h0; // @[dut.scala 46:27]
    end else if (en0) begin // @[dut.scala 50:13]
      sum0_reg <= s0[15:0]; // @[dut.scala 51:16]
    end
    if (reset) begin // @[dut.scala 47:27]
      carry0_reg <= 1'h0; // @[dut.scala 47:27]
    end else if (en0) begin // @[dut.scala 50:13]
      carry0_reg <= s0[16]; // @[dut.scala 52:16]
    end
    if (reset) begin // @[dut.scala 56:19]
      a1 <= 64'h0; // @[dut.scala 56:19]
    end else if (en0) begin // @[dut.scala 58:13]
      a1 <= a0; // @[dut.scala 59:8]
    end
    if (reset) begin // @[dut.scala 57:19]
      b1 <= 64'h0; // @[dut.scala 57:19]
    end else if (en0) begin // @[dut.scala 58:13]
      b1 <= b0; // @[dut.scala 60:8]
    end
    if (reset) begin // @[dut.scala 63:27]
      sum1_reg <= 16'h0; // @[dut.scala 63:27]
    end else if (en1) begin // @[dut.scala 67:13]
      sum1_reg <= s1[15:0]; // @[dut.scala 68:16]
    end
    if (reset) begin // @[dut.scala 64:27]
      carry1_reg <= 1'h0; // @[dut.scala 64:27]
    end else if (en1) begin // @[dut.scala 67:13]
      carry1_reg <= s1[16]; // @[dut.scala 69:16]
    end
    if (reset) begin // @[dut.scala 73:19]
      a2 <= 64'h0; // @[dut.scala 73:19]
    end else if (en1) begin // @[dut.scala 75:13]
      a2 <= a1; // @[dut.scala 76:8]
    end
    if (reset) begin // @[dut.scala 74:19]
      b2 <= 64'h0; // @[dut.scala 74:19]
    end else if (en1) begin // @[dut.scala 75:13]
      b2 <= b1; // @[dut.scala 77:8]
    end
    if (reset) begin // @[dut.scala 80:27]
      sum2_reg <= 16'h0; // @[dut.scala 80:27]
    end else if (en2) begin // @[dut.scala 84:13]
      sum2_reg <= s2[15:0]; // @[dut.scala 85:16]
    end
    if (reset) begin // @[dut.scala 81:27]
      carry2_reg <= 1'h0; // @[dut.scala 81:27]
    end else if (en2) begin // @[dut.scala 84:13]
      carry2_reg <= s2[16]; // @[dut.scala 86:16]
    end
    if (reset) begin // @[dut.scala 90:19]
      a3 <= 64'h0; // @[dut.scala 90:19]
    end else if (en2) begin // @[dut.scala 92:13]
      a3 <= a2; // @[dut.scala 93:8]
    end
    if (reset) begin // @[dut.scala 91:19]
      b3 <= 64'h0; // @[dut.scala 91:19]
    end else if (en2) begin // @[dut.scala 92:13]
      b3 <= b2; // @[dut.scala 94:8]
    end
    if (reset) begin // @[dut.scala 97:31]
      sum3_reg <= 16'h0; // @[dut.scala 97:31]
    end else if (en3) begin // @[dut.scala 101:13]
      sum3_reg <= s3[15:0]; // @[dut.scala 102:20]
    end
    if (reset) begin // @[dut.scala 98:31]
      finalCarry_reg <= 1'h0; // @[dut.scala 98:31]
    end else if (en3) begin // @[dut.scala 101:13]
      finalCarry_reg <= s3[16]; // @[dut.scala 103:20]
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
  a0 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  b0 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  sum0_reg = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  carry0_reg = _RAND_7[0:0];
  _RAND_8 = {2{`RANDOM}};
  a1 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b1 = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  sum1_reg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry1_reg = _RAND_11[0:0];
  _RAND_12 = {2{`RANDOM}};
  a2 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  b2 = _RAND_13[63:0];
  _RAND_14 = {1{`RANDOM}};
  sum2_reg = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  carry2_reg = _RAND_15[0:0];
  _RAND_16 = {2{`RANDOM}};
  a3 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  b3 = _RAND_17[63:0];
  _RAND_18 = {1{`RANDOM}};
  sum3_reg = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  finalCarry_reg = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
