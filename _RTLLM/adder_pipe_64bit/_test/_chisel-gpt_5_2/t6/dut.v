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
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
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
`endif // RANDOMIZE_REG_INIT
  reg  s0_en; // @[dut.scala 22:24]
  reg [63:0] s0_adda; // @[dut.scala 23:20]
  reg [63:0] s0_addb; // @[dut.scala 24:20]
  reg  s1_en; // @[dut.scala 40:25]
  reg [63:0] s1_adda; // @[dut.scala 41:21]
  reg [63:0] s1_addb; // @[dut.scala 42:21]
  reg [15:0] s1_sum0; // @[dut.scala 43:21]
  reg  s1_carry; // @[dut.scala 44:25]
  wire [16:0] _tmp_T = s0_adda[15:0] + s0_addb[15:0]; // @[dut.scala 33:14]
  wire [17:0] _tmp_T_1 = {{1'd0}, _tmp_T}; // @[dut.scala 33:19]
  wire [16:0] tmp = _tmp_T_1[16:0]; // @[dut.scala 33:19]
  wire  c1_w = tmp[16]; // @[dut.scala 34:21]
  reg  s2_en; // @[dut.scala 57:26]
  reg [63:0] s2_adda; // @[dut.scala 58:22]
  reg [63:0] s2_addb; // @[dut.scala 59:22]
  reg [15:0] s2_sum0; // @[dut.scala 60:22]
  reg [15:0] s2_sum1; // @[dut.scala 61:22]
  reg  s2_carry; // @[dut.scala 62:26]
  wire [16:0] _tmp_T_3 = s1_adda[31:16] + s1_addb[31:16]; // @[dut.scala 33:14]
  wire [16:0] _GEN_0 = {{16'd0}, s1_carry}; // @[dut.scala 33:19]
  wire [16:0] tmp_1 = _tmp_T_3 + _GEN_0; // @[dut.scala 33:19]
  wire  c2_w = tmp_1[16]; // @[dut.scala 34:21]
  reg  s3_en; // @[dut.scala 76:26]
  reg [63:0] s3_adda; // @[dut.scala 77:22]
  reg [63:0] s3_addb; // @[dut.scala 78:22]
  reg [15:0] s3_sum0; // @[dut.scala 79:22]
  reg [15:0] s3_sum1; // @[dut.scala 80:22]
  reg [15:0] s3_sum2; // @[dut.scala 81:22]
  reg  s3_carry; // @[dut.scala 82:26]
  wire [16:0] _tmp_T_6 = s2_adda[47:32] + s2_addb[47:32]; // @[dut.scala 33:14]
  wire [16:0] _GEN_1 = {{16'd0}, s2_carry}; // @[dut.scala 33:19]
  wire [16:0] tmp_2 = _tmp_T_6 + _GEN_1; // @[dut.scala 33:19]
  wire  c3_w = tmp_2[16]; // @[dut.scala 34:21]
  reg  s4_en; // @[dut.scala 97:26]
  reg [15:0] s4_sum0; // @[dut.scala 98:22]
  reg [15:0] s4_sum1; // @[dut.scala 99:22]
  reg [15:0] s4_sum2; // @[dut.scala 100:22]
  reg [15:0] s4_sum3; // @[dut.scala 101:22]
  reg  s4_carry; // @[dut.scala 102:26]
  wire [16:0] _tmp_T_9 = s3_adda[63:48] + s3_addb[63:48]; // @[dut.scala 33:14]
  wire [16:0] _GEN_2 = {{16'd0}, s3_carry}; // @[dut.scala 33:19]
  wire [16:0] tmp_3 = _tmp_T_9 + _GEN_2; // @[dut.scala 33:19]
  wire  c4_w = tmp_3[16]; // @[dut.scala 34:21]
  wire [31:0] io_result_lo = {s4_sum1,s4_sum0}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {s4_carry,s4_sum3,s4_sum2}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = s4_en; // @[dut.scala 114:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:24]
      s0_en <= 1'h0; // @[dut.scala 22:24]
    end else begin
      s0_en <= io_i_en; // @[dut.scala 26:11]
    end
    s0_adda <= io_adda; // @[dut.scala 27:11]
    s0_addb <= io_addb; // @[dut.scala 28:11]
    if (reset) begin // @[dut.scala 40:25]
      s1_en <= 1'h0; // @[dut.scala 40:25]
    end else begin
      s1_en <= s0_en; // @[dut.scala 48:12]
    end
    s1_adda <= s0_adda; // @[dut.scala 49:12]
    s1_addb <= s0_addb; // @[dut.scala 50:12]
    s1_sum0 <= tmp[15:0]; // @[dut.scala 34:9]
    if (reset) begin // @[dut.scala 44:25]
      s1_carry <= 1'h0; // @[dut.scala 44:25]
    end else begin
      s1_carry <= c1_w; // @[dut.scala 52:12]
    end
    if (reset) begin // @[dut.scala 57:26]
      s2_en <= 1'h0; // @[dut.scala 57:26]
    end else begin
      s2_en <= s1_en; // @[dut.scala 66:12]
    end
    s2_adda <= s1_adda; // @[dut.scala 67:12]
    s2_addb <= s1_addb; // @[dut.scala 68:12]
    s2_sum0 <= s1_sum0; // @[dut.scala 69:12]
    s2_sum1 <= tmp_1[15:0]; // @[dut.scala 34:9]
    if (reset) begin // @[dut.scala 62:26]
      s2_carry <= 1'h0; // @[dut.scala 62:26]
    end else begin
      s2_carry <= c2_w; // @[dut.scala 71:12]
    end
    if (reset) begin // @[dut.scala 76:26]
      s3_en <= 1'h0; // @[dut.scala 76:26]
    end else begin
      s3_en <= s2_en; // @[dut.scala 86:12]
    end
    s3_adda <= s2_adda; // @[dut.scala 87:12]
    s3_addb <= s2_addb; // @[dut.scala 88:12]
    s3_sum0 <= s2_sum0; // @[dut.scala 89:12]
    s3_sum1 <= s2_sum1; // @[dut.scala 90:12]
    s3_sum2 <= tmp_2[15:0]; // @[dut.scala 34:9]
    if (reset) begin // @[dut.scala 82:26]
      s3_carry <= 1'h0; // @[dut.scala 82:26]
    end else begin
      s3_carry <= c3_w; // @[dut.scala 92:12]
    end
    if (reset) begin // @[dut.scala 97:26]
      s4_en <= 1'h0; // @[dut.scala 97:26]
    end else begin
      s4_en <= s3_en; // @[dut.scala 106:12]
    end
    s4_sum0 <= s3_sum0; // @[dut.scala 107:12]
    s4_sum1 <= s3_sum1; // @[dut.scala 108:12]
    s4_sum2 <= s3_sum2; // @[dut.scala 109:12]
    s4_sum3 <= tmp_3[15:0]; // @[dut.scala 34:9]
    if (reset) begin // @[dut.scala 102:26]
      s4_carry <= 1'h0; // @[dut.scala 102:26]
    end else begin
      s4_carry <= c4_w; // @[dut.scala 111:12]
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
  s0_en = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  s0_adda = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  s0_addb = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  s1_en = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  s1_adda = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  s1_addb = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  s1_sum0 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  s1_carry = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  s2_en = _RAND_8[0:0];
  _RAND_9 = {2{`RANDOM}};
  s2_adda = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  s2_addb = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  s2_sum0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  s2_sum1 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  s2_carry = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  s3_en = _RAND_14[0:0];
  _RAND_15 = {2{`RANDOM}};
  s3_adda = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  s3_addb = _RAND_16[63:0];
  _RAND_17 = {1{`RANDOM}};
  s3_sum0 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  s3_sum1 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  s3_sum2 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  s3_carry = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  s4_en = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  s4_sum0 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  s4_sum1 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  s4_sum2 = _RAND_24[15:0];
  _RAND_25 = {1{`RANDOM}};
  s4_sum3 = _RAND_25[15:0];
  _RAND_26 = {1{`RANDOM}};
  s4_carry = _RAND_26[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
