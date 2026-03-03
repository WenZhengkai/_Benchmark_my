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
  reg  en1; // @[dut.scala 14:20]
  reg  en2; // @[dut.scala 15:20]
  reg  en3; // @[dut.scala 16:20]
  reg  en4; // @[dut.scala 17:20]
  reg [63:0] a_r1; // @[dut.scala 25:21]
  reg [63:0] a_r2; // @[dut.scala 26:21]
  reg [63:0] a_r3; // @[dut.scala 27:21]
  reg [63:0] b_r1; // @[dut.scala 28:21]
  reg [63:0] b_r2; // @[dut.scala 29:21]
  reg [63:0] b_r3; // @[dut.scala 30:21]
  wire [16:0] s0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 40:27]
  reg [15:0] sum0_r; // @[dut.scala 41:25]
  reg  carry0_r; // @[dut.scala 42:25]
  wire [16:0] _s1_T_2 = a_r1[31:16] + b_r1[31:16]; // @[dut.scala 47:25]
  wire [16:0] _GEN_0 = {{16'd0}, carry0_r}; // @[dut.scala 47:41]
  wire [16:0] s1 = _s1_T_2 + _GEN_0; // @[dut.scala 47:41]
  reg [31:0] psum1_r; // @[dut.scala 48:25]
  reg  carry1_r; // @[dut.scala 49:25]
  wire [31:0] _psum1_r_T_1 = {s1[15:0],sum0_r}; // @[Cat.scala 33:92]
  wire [16:0] _s2_T_2 = a_r2[47:32] + b_r2[47:32]; // @[dut.scala 54:25]
  wire [16:0] _GEN_1 = {{16'd0}, carry1_r}; // @[dut.scala 54:41]
  wire [16:0] s2 = _s2_T_2 + _GEN_1; // @[dut.scala 54:41]
  reg [47:0] psum2_r; // @[dut.scala 55:25]
  reg  carry2_r; // @[dut.scala 56:25]
  wire [47:0] _psum2_r_T_1 = {s2[15:0],psum1_r}; // @[Cat.scala 33:92]
  wire [16:0] _s3_T_2 = a_r3[63:48] + b_r3[63:48]; // @[dut.scala 61:25]
  wire [16:0] _GEN_2 = {{16'd0}, carry2_r}; // @[dut.scala 61:41]
  wire [16:0] s3 = _s3_T_2 + _GEN_2; // @[dut.scala 61:41]
  reg [64:0] result_r; // @[dut.scala 62:25]
  wire [64:0] _result_r_T_2 = {s3[16],s3[15:0],psum2_r}; // @[Cat.scala 33:92]
  assign io_result = result_r; // @[dut.scala 65:13]
  assign io_o_en = en4; // @[dut.scala 66:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:20]
      en1 <= 1'h0; // @[dut.scala 14:20]
    end else begin
      en1 <= io_i_en; // @[dut.scala 19:7]
    end
    if (reset) begin // @[dut.scala 15:20]
      en2 <= 1'h0; // @[dut.scala 15:20]
    end else begin
      en2 <= en1; // @[dut.scala 20:7]
    end
    if (reset) begin // @[dut.scala 16:20]
      en3 <= 1'h0; // @[dut.scala 16:20]
    end else begin
      en3 <= en2; // @[dut.scala 21:7]
    end
    if (reset) begin // @[dut.scala 17:20]
      en4 <= 1'h0; // @[dut.scala 17:20]
    end else begin
      en4 <= en3; // @[dut.scala 22:7]
    end
    if (reset) begin // @[dut.scala 25:21]
      a_r1 <= 64'h0; // @[dut.scala 25:21]
    end else begin
      a_r1 <= io_adda; // @[dut.scala 32:8]
    end
    if (reset) begin // @[dut.scala 26:21]
      a_r2 <= 64'h0; // @[dut.scala 26:21]
    end else begin
      a_r2 <= a_r1; // @[dut.scala 33:8]
    end
    if (reset) begin // @[dut.scala 27:21]
      a_r3 <= 64'h0; // @[dut.scala 27:21]
    end else begin
      a_r3 <= a_r2; // @[dut.scala 34:8]
    end
    if (reset) begin // @[dut.scala 28:21]
      b_r1 <= 64'h0; // @[dut.scala 28:21]
    end else begin
      b_r1 <= io_addb; // @[dut.scala 35:8]
    end
    if (reset) begin // @[dut.scala 29:21]
      b_r2 <= 64'h0; // @[dut.scala 29:21]
    end else begin
      b_r2 <= b_r1; // @[dut.scala 36:8]
    end
    if (reset) begin // @[dut.scala 30:21]
      b_r3 <= 64'h0; // @[dut.scala 30:21]
    end else begin
      b_r3 <= b_r2; // @[dut.scala 37:8]
    end
    if (reset) begin // @[dut.scala 41:25]
      sum0_r <= 16'h0; // @[dut.scala 41:25]
    end else begin
      sum0_r <= s0[15:0]; // @[dut.scala 43:12]
    end
    if (reset) begin // @[dut.scala 42:25]
      carry0_r <= 1'h0; // @[dut.scala 42:25]
    end else begin
      carry0_r <= s0[16]; // @[dut.scala 44:12]
    end
    if (reset) begin // @[dut.scala 48:25]
      psum1_r <= 32'h0; // @[dut.scala 48:25]
    end else begin
      psum1_r <= _psum1_r_T_1; // @[dut.scala 50:12]
    end
    if (reset) begin // @[dut.scala 49:25]
      carry1_r <= 1'h0; // @[dut.scala 49:25]
    end else begin
      carry1_r <= s1[16]; // @[dut.scala 51:12]
    end
    if (reset) begin // @[dut.scala 55:25]
      psum2_r <= 48'h0; // @[dut.scala 55:25]
    end else begin
      psum2_r <= _psum2_r_T_1; // @[dut.scala 57:12]
    end
    if (reset) begin // @[dut.scala 56:25]
      carry2_r <= 1'h0; // @[dut.scala 56:25]
    end else begin
      carry2_r <= s2[16]; // @[dut.scala 58:12]
    end
    if (reset) begin // @[dut.scala 62:25]
      result_r <= 65'h0; // @[dut.scala 62:25]
    end else begin
      result_r <= _result_r_T_2; // @[dut.scala 63:12]
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
  a_r1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  a_r2 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  a_r3 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  b_r1 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  b_r2 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b_r3 = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  sum0_r = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry0_r = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  psum1_r = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  carry1_r = _RAND_13[0:0];
  _RAND_14 = {2{`RANDOM}};
  psum2_r = _RAND_14[47:0];
  _RAND_15 = {1{`RANDOM}};
  carry2_r = _RAND_15[0:0];
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
