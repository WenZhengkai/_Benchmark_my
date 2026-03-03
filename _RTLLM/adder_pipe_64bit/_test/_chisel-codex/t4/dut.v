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
  reg [95:0] _RAND_25;
`endif // RANDOMIZE_REG_INIT
  reg  v0; // @[dut.scala 16:19]
  reg  v1; // @[dut.scala 17:19]
  reg  v2; // @[dut.scala 18:19]
  reg  v3; // @[dut.scala 19:19]
  reg [15:0] s0_sum0; // @[dut.scala 29:25]
  reg  s0_carry; // @[dut.scala 30:25]
  reg [15:0] s0_a1; // @[dut.scala 31:25]
  reg [15:0] s0_b1; // @[dut.scala 32:25]
  reg [15:0] s0_a2; // @[dut.scala 33:25]
  reg [15:0] s0_b2; // @[dut.scala 34:25]
  reg [15:0] s0_a3; // @[dut.scala 35:25]
  reg [15:0] s0_b3; // @[dut.scala 36:25]
  wire [16:0] add0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 39:31]
  reg [15:0] s1_sum0; // @[dut.scala 54:25]
  reg [15:0] s1_sum1; // @[dut.scala 55:25]
  reg  s1_carry; // @[dut.scala 56:25]
  reg [15:0] s1_a2; // @[dut.scala 57:25]
  reg [15:0] s1_b2; // @[dut.scala 58:25]
  reg [15:0] s1_a3; // @[dut.scala 59:25]
  reg [15:0] s1_b3; // @[dut.scala 60:25]
  wire [16:0] _add1_T = s0_a1 + s0_b1; // @[dut.scala 63:22]
  wire [16:0] _GEN_22 = {{16'd0}, s0_carry}; // @[dut.scala 63:31]
  wire [17:0] add1 = _add1_T + _GEN_22; // @[dut.scala 63:31]
  reg [15:0] s2_sum0; // @[dut.scala 77:25]
  reg [15:0] s2_sum1; // @[dut.scala 78:25]
  reg [15:0] s2_sum2; // @[dut.scala 79:25]
  reg  s2_carry; // @[dut.scala 80:25]
  reg [15:0] s2_a3; // @[dut.scala 81:25]
  reg [15:0] s2_b3; // @[dut.scala 82:25]
  wire [16:0] _add2_T = s1_a2 + s1_b2; // @[dut.scala 85:22]
  wire [16:0] _GEN_23 = {{16'd0}, s1_carry}; // @[dut.scala 85:31]
  wire [17:0] add2 = _add2_T + _GEN_23; // @[dut.scala 85:31]
  reg [64:0] resultReg; // @[dut.scala 98:26]
  wire [16:0] _add3_T = s2_a3 + s2_b3; // @[dut.scala 101:22]
  wire [16:0] _GEN_24 = {{16'd0}, s2_carry}; // @[dut.scala 101:31]
  wire [17:0] add3 = _add3_T + _GEN_24; // @[dut.scala 101:31]
  wire [15:0] sum3 = add3[15:0]; // @[dut.scala 102:20]
  wire  cOut = add3[16]; // @[dut.scala 103:20]
  wire [64:0] _resultReg_T = {cOut,sum3,s2_sum2,s2_sum1,s2_sum0}; // @[Cat.scala 33:92]
  assign io_result = resultReg; // @[dut.scala 108:13]
  assign io_o_en = v3; // @[dut.scala 109:13]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:19]
      v0 <= 1'h0; // @[dut.scala 16:19]
    end else begin
      v0 <= io_i_en; // @[dut.scala 21:6]
    end
    if (reset) begin // @[dut.scala 17:19]
      v1 <= 1'h0; // @[dut.scala 17:19]
    end else begin
      v1 <= v0; // @[dut.scala 22:6]
    end
    if (reset) begin // @[dut.scala 18:19]
      v2 <= 1'h0; // @[dut.scala 18:19]
    end else begin
      v2 <= v1; // @[dut.scala 23:6]
    end
    if (reset) begin // @[dut.scala 19:19]
      v3 <= 1'h0; // @[dut.scala 19:19]
    end else begin
      v3 <= v2; // @[dut.scala 24:6]
    end
    if (reset) begin // @[dut.scala 29:25]
      s0_sum0 <= 16'h0; // @[dut.scala 29:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_sum0 <= add0[15:0]; // @[dut.scala 40:14]
    end
    if (reset) begin // @[dut.scala 30:25]
      s0_carry <= 1'h0; // @[dut.scala 30:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_carry <= add0[16]; // @[dut.scala 41:14]
    end
    if (reset) begin // @[dut.scala 31:25]
      s0_a1 <= 16'h0; // @[dut.scala 31:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_a1 <= io_adda[31:16]; // @[dut.scala 43:11]
    end
    if (reset) begin // @[dut.scala 32:25]
      s0_b1 <= 16'h0; // @[dut.scala 32:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_b1 <= io_addb[31:16]; // @[dut.scala 44:11]
    end
    if (reset) begin // @[dut.scala 33:25]
      s0_a2 <= 16'h0; // @[dut.scala 33:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_a2 <= io_adda[47:32]; // @[dut.scala 45:11]
    end
    if (reset) begin // @[dut.scala 34:25]
      s0_b2 <= 16'h0; // @[dut.scala 34:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_b2 <= io_addb[47:32]; // @[dut.scala 46:11]
    end
    if (reset) begin // @[dut.scala 35:25]
      s0_a3 <= 16'h0; // @[dut.scala 35:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_a3 <= io_adda[63:48]; // @[dut.scala 47:11]
    end
    if (reset) begin // @[dut.scala 36:25]
      s0_b3 <= 16'h0; // @[dut.scala 36:25]
    end else if (io_i_en) begin // @[dut.scala 38:17]
      s0_b3 <= io_addb[63:48]; // @[dut.scala 48:11]
    end
    if (reset) begin // @[dut.scala 54:25]
      s1_sum0 <= 16'h0; // @[dut.scala 54:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_sum0 <= s0_sum0; // @[dut.scala 64:14]
    end
    if (reset) begin // @[dut.scala 55:25]
      s1_sum1 <= 16'h0; // @[dut.scala 55:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_sum1 <= add1[15:0]; // @[dut.scala 65:14]
    end
    if (reset) begin // @[dut.scala 56:25]
      s1_carry <= 1'h0; // @[dut.scala 56:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_carry <= add1[16]; // @[dut.scala 66:14]
    end
    if (reset) begin // @[dut.scala 57:25]
      s1_a2 <= 16'h0; // @[dut.scala 57:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_a2 <= s0_a2; // @[dut.scala 68:11]
    end
    if (reset) begin // @[dut.scala 58:25]
      s1_b2 <= 16'h0; // @[dut.scala 58:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_b2 <= s0_b2; // @[dut.scala 69:11]
    end
    if (reset) begin // @[dut.scala 59:25]
      s1_a3 <= 16'h0; // @[dut.scala 59:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_a3 <= s0_a3; // @[dut.scala 70:11]
    end
    if (reset) begin // @[dut.scala 60:25]
      s1_b3 <= 16'h0; // @[dut.scala 60:25]
    end else if (v0) begin // @[dut.scala 62:12]
      s1_b3 <= s0_b3; // @[dut.scala 71:11]
    end
    if (reset) begin // @[dut.scala 77:25]
      s2_sum0 <= 16'h0; // @[dut.scala 77:25]
    end else if (v1) begin // @[dut.scala 84:12]
      s2_sum0 <= s1_sum0; // @[dut.scala 86:14]
    end
    if (reset) begin // @[dut.scala 78:25]
      s2_sum1 <= 16'h0; // @[dut.scala 78:25]
    end else if (v1) begin // @[dut.scala 84:12]
      s2_sum1 <= s1_sum1; // @[dut.scala 87:14]
    end
    if (reset) begin // @[dut.scala 79:25]
      s2_sum2 <= 16'h0; // @[dut.scala 79:25]
    end else if (v1) begin // @[dut.scala 84:12]
      s2_sum2 <= add2[15:0]; // @[dut.scala 88:14]
    end
    if (reset) begin // @[dut.scala 80:25]
      s2_carry <= 1'h0; // @[dut.scala 80:25]
    end else if (v1) begin // @[dut.scala 84:12]
      s2_carry <= add2[16]; // @[dut.scala 89:14]
    end
    if (reset) begin // @[dut.scala 81:25]
      s2_a3 <= 16'h0; // @[dut.scala 81:25]
    end else if (v1) begin // @[dut.scala 84:12]
      s2_a3 <= s1_a3; // @[dut.scala 91:11]
    end
    if (reset) begin // @[dut.scala 82:25]
      s2_b3 <= 16'h0; // @[dut.scala 82:25]
    end else if (v1) begin // @[dut.scala 84:12]
      s2_b3 <= s1_b3; // @[dut.scala 92:11]
    end
    if (reset) begin // @[dut.scala 98:26]
      resultReg <= 65'h0; // @[dut.scala 98:26]
    end else if (v2) begin // @[dut.scala 100:12]
      resultReg <= _resultReg_T; // @[dut.scala 105:15]
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
  v0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  v1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  v2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  v3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  s0_sum0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  s0_carry = _RAND_5[0:0];
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
  s1_sum0 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  s1_sum1 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  s1_carry = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  s1_a2 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  s1_b2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  s1_a3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  s1_b3 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  s2_sum0 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  s2_sum1 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  s2_sum2 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  s2_carry = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  s2_a3 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  s2_b3 = _RAND_24[15:0];
  _RAND_25 = {3{`RANDOM}};
  resultReg = _RAND_25[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
