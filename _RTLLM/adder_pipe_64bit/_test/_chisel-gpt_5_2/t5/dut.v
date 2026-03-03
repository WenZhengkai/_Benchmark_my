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
  reg  en0; // @[dut.scala 22:20]
  reg  en1; // @[dut.scala 23:20]
  reg  en2; // @[dut.scala 24:20]
  reg  en3; // @[dut.scala 25:20]
  reg [63:0] a0; // @[dut.scala 34:15]
  reg [63:0] b0; // @[dut.scala 35:15]
  reg [63:0] a1; // @[dut.scala 36:15]
  reg [63:0] b1; // @[dut.scala 37:15]
  reg [63:0] a2; // @[dut.scala 38:15]
  reg [63:0] b2; // @[dut.scala 39:15]
  reg [63:0] a3; // @[dut.scala 40:15]
  reg [63:0] b3; // @[dut.scala 41:15]
  reg  c1; // @[dut.scala 52:19]
  reg  c2; // @[dut.scala 53:19]
  reg  c3; // @[dut.scala 54:19]
  reg  c4; // @[dut.scala 55:19]
  reg [15:0] s0; // @[dut.scala 58:15]
  reg [15:0] s1; // @[dut.scala 59:15]
  reg [15:0] s2; // @[dut.scala 60:15]
  reg [15:0] s3; // @[dut.scala 61:15]
  wire [16:0] add0 = a0[15:0] + b0[15:0]; // @[dut.scala 65:21]
  wire [16:0] _add1_T_2 = a1[31:16] + b1[31:16]; // @[dut.scala 74:22]
  wire [16:0] _GEN_17 = {{16'd0}, c1}; // @[dut.scala 74:36]
  wire [16:0] add1 = _add1_T_2 + _GEN_17; // @[dut.scala 74:36]
  wire [16:0] _add2_T_2 = a2[47:32] + b2[47:32]; // @[dut.scala 83:22]
  wire [16:0] _GEN_18 = {{16'd0}, c2}; // @[dut.scala 83:36]
  wire [16:0] add2 = _add2_T_2 + _GEN_18; // @[dut.scala 83:36]
  wire [16:0] _add3_T_2 = a3[63:48] + b3[63:48]; // @[dut.scala 92:22]
  wire [16:0] _GEN_19 = {{16'd0}, c3}; // @[dut.scala 92:36]
  wire [16:0] add3 = _add3_T_2 + _GEN_19; // @[dut.scala 92:36]
  reg [64:0] resultReg; // @[dut.scala 100:26]
  wire [64:0] _resultReg_T = {c4,s3,s2,s1,s0}; // @[Cat.scala 33:92]
  assign io_result = resultReg; // @[dut.scala 105:13]
  assign io_o_en = en3; // @[dut.scala 31:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:20]
      en0 <= 1'h0; // @[dut.scala 22:20]
    end else begin
      en0 <= io_i_en; // @[dut.scala 27:7]
    end
    if (reset) begin // @[dut.scala 23:20]
      en1 <= 1'h0; // @[dut.scala 23:20]
    end else begin
      en1 <= en0; // @[dut.scala 28:7]
    end
    if (reset) begin // @[dut.scala 24:20]
      en2 <= 1'h0; // @[dut.scala 24:20]
    end else begin
      en2 <= en1; // @[dut.scala 29:7]
    end
    if (reset) begin // @[dut.scala 25:20]
      en3 <= 1'h0; // @[dut.scala 25:20]
    end else begin
      en3 <= en2; // @[dut.scala 30:7]
    end
    if (io_i_en) begin // @[dut.scala 43:17]
      a0 <= io_adda; // @[dut.scala 44:8]
    end
    if (io_i_en) begin // @[dut.scala 43:17]
      b0 <= io_addb; // @[dut.scala 45:8]
    end
    if (en0) begin // @[dut.scala 47:13]
      a1 <= a0; // @[dut.scala 47:18]
    end
    if (en0) begin // @[dut.scala 47:13]
      b1 <= b0; // @[dut.scala 47:28]
    end
    if (en1) begin // @[dut.scala 48:13]
      a2 <= a1; // @[dut.scala 48:18]
    end
    if (en1) begin // @[dut.scala 48:13]
      b2 <= b1; // @[dut.scala 48:28]
    end
    if (en2) begin // @[dut.scala 49:13]
      a3 <= a2; // @[dut.scala 49:18]
    end
    if (en2) begin // @[dut.scala 49:13]
      b3 <= b2; // @[dut.scala 49:28]
    end
    if (reset) begin // @[dut.scala 52:19]
      c1 <= 1'h0; // @[dut.scala 52:19]
    end else if (io_i_en) begin // @[dut.scala 67:17]
      c1 <= add0[16]; // @[dut.scala 69:8]
    end
    if (reset) begin // @[dut.scala 53:19]
      c2 <= 1'h0; // @[dut.scala 53:19]
    end else if (en0) begin // @[dut.scala 76:13]
      c2 <= add1[16]; // @[dut.scala 78:8]
    end
    if (reset) begin // @[dut.scala 54:19]
      c3 <= 1'h0; // @[dut.scala 54:19]
    end else if (en1) begin // @[dut.scala 85:13]
      c3 <= add2[16]; // @[dut.scala 87:8]
    end
    if (reset) begin // @[dut.scala 55:19]
      c4 <= 1'h0; // @[dut.scala 55:19]
    end else if (en2) begin // @[dut.scala 94:13]
      c4 <= add3[16]; // @[dut.scala 96:8]
    end
    if (io_i_en) begin // @[dut.scala 67:17]
      s0 <= add0[15:0]; // @[dut.scala 68:8]
    end
    if (en0) begin // @[dut.scala 76:13]
      s1 <= add1[15:0]; // @[dut.scala 77:8]
    end
    if (en1) begin // @[dut.scala 85:13]
      s2 <= add2[15:0]; // @[dut.scala 86:8]
    end
    if (en2) begin // @[dut.scala 94:13]
      s3 <= add3[15:0]; // @[dut.scala 95:8]
    end
    if (reset) begin // @[dut.scala 100:26]
      resultReg <= 65'h0; // @[dut.scala 100:26]
    end else if (en3) begin // @[dut.scala 101:13]
      resultReg <= _resultReg_T; // @[dut.scala 102:15]
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
  _RAND_6 = {2{`RANDOM}};
  a1 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b1 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  a2 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b2 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  a3 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  b3 = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  c1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  c2 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  c3 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  c4 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  s0 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  s1 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  s2 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  s3 = _RAND_19[15:0];
  _RAND_20 = {3{`RANDOM}};
  resultReg = _RAND_20[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
