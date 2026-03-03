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
`endif // RANDOMIZE_REG_INIT
  reg  en1; // @[dut.scala 20:20]
  reg  en2; // @[dut.scala 21:20]
  reg  en3; // @[dut.scala 22:20]
  reg  en4; // @[dut.scala 23:20]
  reg [63:0] a1; // @[dut.scala 31:15]
  reg [63:0] b1; // @[dut.scala 32:15]
  reg [63:0] a2; // @[dut.scala 33:15]
  reg [63:0] b2; // @[dut.scala 34:15]
  reg [63:0] a3; // @[dut.scala 35:15]
  reg [63:0] b3; // @[dut.scala 36:15]
  reg [63:0] a4; // @[dut.scala 37:15]
  reg [63:0] b4; // @[dut.scala 38:15]
  reg [15:0] sum0; // @[dut.scala 47:21]
  reg [15:0] sum1; // @[dut.scala 48:21]
  reg [15:0] sum2; // @[dut.scala 49:21]
  reg [15:0] sum3; // @[dut.scala 50:21]
  reg  c1; // @[dut.scala 53:19]
  reg  c2; // @[dut.scala 54:19]
  reg  c3; // @[dut.scala 55:19]
  reg  c4; // @[dut.scala 56:19]
  wire [16:0] _s1_T_2 = a1[15:0] + b1[15:0]; // @[dut.scala 60:19]
  wire [17:0] _s1_T_3 = {{1'd0}, _s1_T_2}; // @[dut.scala 60:32]
  wire [16:0] s1 = _s1_T_3[16:0]; // @[dut.scala 59:16 60:6]
  wire [16:0] _s2_T_2 = a2[31:16] + b2[31:16]; // @[dut.scala 66:20]
  wire [16:0] _GEN_0 = {{16'd0}, c1}; // @[dut.scala 66:34]
  wire [17:0] _s2_T_3 = _s2_T_2 + _GEN_0; // @[dut.scala 66:34]
  wire [16:0] s2 = _s2_T_3[16:0]; // @[dut.scala 65:16 66:6]
  wire [16:0] _s3_T_2 = a3[47:32] + b3[47:32]; // @[dut.scala 72:20]
  wire [16:0] _GEN_1 = {{16'd0}, c2}; // @[dut.scala 72:34]
  wire [17:0] _s3_T_3 = _s3_T_2 + _GEN_1; // @[dut.scala 72:34]
  wire [16:0] s3 = _s3_T_3[16:0]; // @[dut.scala 71:16 72:6]
  wire [16:0] _s4_T_2 = a4[63:48] + b4[63:48]; // @[dut.scala 78:20]
  wire [16:0] _GEN_2 = {{16'd0}, c3}; // @[dut.scala 78:34]
  wire [17:0] _s4_T_3 = _s4_T_2 + _GEN_2; // @[dut.scala 78:34]
  wire [16:0] s4 = _s4_T_3[16:0]; // @[dut.scala 77:16 78:6]
  wire [31:0] io_result_lo = {sum1,sum0}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {c4,sum3,sum2}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en4; // @[dut.scala 28:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:20]
      en1 <= 1'h0; // @[dut.scala 20:20]
    end else begin
      en1 <= io_i_en; // @[dut.scala 24:7]
    end
    if (reset) begin // @[dut.scala 21:20]
      en2 <= 1'h0; // @[dut.scala 21:20]
    end else begin
      en2 <= en1; // @[dut.scala 25:7]
    end
    if (reset) begin // @[dut.scala 22:20]
      en3 <= 1'h0; // @[dut.scala 22:20]
    end else begin
      en3 <= en2; // @[dut.scala 26:7]
    end
    if (reset) begin // @[dut.scala 23:20]
      en4 <= 1'h0; // @[dut.scala 23:20]
    end else begin
      en4 <= en3; // @[dut.scala 27:7]
    end
    a1 <= io_adda; // @[dut.scala 41:6]
    b1 <= io_addb; // @[dut.scala 41:21]
    a2 <= a1; // @[dut.scala 42:6]
    b2 <= b1; // @[dut.scala 42:20]
    a3 <= a2; // @[dut.scala 43:6]
    b3 <= b2; // @[dut.scala 43:20]
    a4 <= a3; // @[dut.scala 44:6]
    b4 <= b3; // @[dut.scala 44:20]
    if (reset) begin // @[dut.scala 47:21]
      sum0 <= 16'h0; // @[dut.scala 47:21]
    end else begin
      sum0 <= s1[15:0]; // @[dut.scala 61:8]
    end
    if (reset) begin // @[dut.scala 48:21]
      sum1 <= 16'h0; // @[dut.scala 48:21]
    end else begin
      sum1 <= s2[15:0]; // @[dut.scala 67:8]
    end
    if (reset) begin // @[dut.scala 49:21]
      sum2 <= 16'h0; // @[dut.scala 49:21]
    end else begin
      sum2 <= s3[15:0]; // @[dut.scala 73:8]
    end
    if (reset) begin // @[dut.scala 50:21]
      sum3 <= 16'h0; // @[dut.scala 50:21]
    end else begin
      sum3 <= s4[15:0]; // @[dut.scala 79:8]
    end
    if (reset) begin // @[dut.scala 53:19]
      c1 <= 1'h0; // @[dut.scala 53:19]
    end else begin
      c1 <= s1[16]; // @[dut.scala 62:8]
    end
    if (reset) begin // @[dut.scala 54:19]
      c2 <= 1'h0; // @[dut.scala 54:19]
    end else begin
      c2 <= s2[16]; // @[dut.scala 68:8]
    end
    if (reset) begin // @[dut.scala 55:19]
      c3 <= 1'h0; // @[dut.scala 55:19]
    end else begin
      c3 <= s3[16]; // @[dut.scala 74:8]
    end
    if (reset) begin // @[dut.scala 56:19]
      c4 <= 1'h0; // @[dut.scala 56:19]
    end else begin
      c4 <= s4[16]; // @[dut.scala 80:8]
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
  a1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  b1 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  a2 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b2 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  a3 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b3 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  a4 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  b4 = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  sum0 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum1 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  sum2 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  sum3 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  c1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  c2 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  c3 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  c4 = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
