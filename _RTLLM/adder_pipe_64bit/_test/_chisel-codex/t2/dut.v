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
  reg [15:0] s0Sum0; // @[dut.scala 29:24]
  reg  s0Carry; // @[dut.scala 30:24]
  reg [15:0] s0A1; // @[dut.scala 31:24]
  reg [15:0] s0B1; // @[dut.scala 32:24]
  reg [15:0] s0A2; // @[dut.scala 33:24]
  reg [15:0] s0B2; // @[dut.scala 34:24]
  reg [15:0] s0A3; // @[dut.scala 35:24]
  reg [15:0] s0B3; // @[dut.scala 36:24]
  reg [15:0] s1Sum0; // @[dut.scala 41:24]
  reg [15:0] s1Sum1; // @[dut.scala 42:24]
  reg  s1Carry; // @[dut.scala 43:24]
  reg [15:0] s1A2; // @[dut.scala 44:24]
  reg [15:0] s1B2; // @[dut.scala 45:24]
  reg [15:0] s1A3; // @[dut.scala 46:24]
  reg [15:0] s1B3; // @[dut.scala 47:24]
  reg [15:0] s2Sum0; // @[dut.scala 52:24]
  reg [15:0] s2Sum1; // @[dut.scala 53:24]
  reg [15:0] s2Sum2; // @[dut.scala 54:24]
  reg  s2Carry; // @[dut.scala 55:24]
  reg [15:0] s2A3; // @[dut.scala 56:24]
  reg [15:0] s2B3; // @[dut.scala 57:24]
  reg [64:0] resultReg; // @[dut.scala 62:26]
  wire [16:0] t0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 66:29]
  wire  _GEN_1 = io_i_en & t0[16]; // @[dut.scala 65:17 68:13 78:13]
  wire [16:0] _t1_T = s0A1 + s0B1; // @[dut.scala 89:19]
  wire [16:0] _GEN_22 = {{16'd0}, s0Carry}; // @[dut.scala 89:27]
  wire [17:0] t1 = _t1_T + _GEN_22; // @[dut.scala 89:27]
  wire  _GEN_10 = v0 & t1[16]; // @[dut.scala 88:12 101:13 92:13]
  wire [16:0] _t2_T = s1A2 + s1B2; // @[dut.scala 110:19]
  wire [16:0] _GEN_23 = {{16'd0}, s1Carry}; // @[dut.scala 110:27]
  wire [17:0] t2 = _t2_T + _GEN_23; // @[dut.scala 110:27]
  wire  _GEN_18 = v1 & t2[16]; // @[dut.scala 109:12 114:13 122:13]
  wire [16:0] _t3_T = s2A3 + s2B3; // @[dut.scala 129:19]
  wire [16:0] _GEN_24 = {{16'd0}, s2Carry}; // @[dut.scala 129:27]
  wire [17:0] t3 = _t3_T + _GEN_24; // @[dut.scala 129:27]
  wire [64:0] _resultReg_T_2 = {t3[16],t3[15:0],s2Sum2,s2Sum1,s2Sum0}; // @[Cat.scala 33:92]
  assign io_result = resultReg; // @[dut.scala 135:13]
  assign io_o_en = v3; // @[dut.scala 136:13]
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
    if (reset) begin // @[dut.scala 29:24]
      s0Sum0 <= 16'h0; // @[dut.scala 29:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0Sum0 <= t0[15:0]; // @[dut.scala 67:13]
    end else begin
      s0Sum0 <= 16'h0; // @[dut.scala 77:13]
    end
    if (reset) begin // @[dut.scala 30:24]
      s0Carry <= 1'h0; // @[dut.scala 30:24]
    end else begin
      s0Carry <= _GEN_1;
    end
    if (reset) begin // @[dut.scala 31:24]
      s0A1 <= 16'h0; // @[dut.scala 31:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0A1 <= io_adda[31:16]; // @[dut.scala 70:10]
    end else begin
      s0A1 <= 16'h0; // @[dut.scala 79:13]
    end
    if (reset) begin // @[dut.scala 32:24]
      s0B1 <= 16'h0; // @[dut.scala 32:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0B1 <= io_addb[31:16]; // @[dut.scala 71:10]
    end else begin
      s0B1 <= 16'h0; // @[dut.scala 80:13]
    end
    if (reset) begin // @[dut.scala 33:24]
      s0A2 <= 16'h0; // @[dut.scala 33:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0A2 <= io_adda[47:32]; // @[dut.scala 72:10]
    end else begin
      s0A2 <= 16'h0; // @[dut.scala 81:13]
    end
    if (reset) begin // @[dut.scala 34:24]
      s0B2 <= 16'h0; // @[dut.scala 34:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0B2 <= io_addb[47:32]; // @[dut.scala 73:10]
    end else begin
      s0B2 <= 16'h0; // @[dut.scala 82:13]
    end
    if (reset) begin // @[dut.scala 35:24]
      s0A3 <= 16'h0; // @[dut.scala 35:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0A3 <= io_adda[63:48]; // @[dut.scala 74:10]
    end else begin
      s0A3 <= 16'h0; // @[dut.scala 83:13]
    end
    if (reset) begin // @[dut.scala 36:24]
      s0B3 <= 16'h0; // @[dut.scala 36:24]
    end else if (io_i_en) begin // @[dut.scala 65:17]
      s0B3 <= io_addb[63:48]; // @[dut.scala 75:10]
    end else begin
      s0B3 <= 16'h0; // @[dut.scala 84:13]
    end
    if (reset) begin // @[dut.scala 41:24]
      s1Sum0 <= 16'h0; // @[dut.scala 41:24]
    end else if (v0) begin // @[dut.scala 88:12]
      s1Sum0 <= s0Sum0; // @[dut.scala 90:13]
    end else begin
      s1Sum0 <= 16'h0; // @[dut.scala 99:13]
    end
    if (reset) begin // @[dut.scala 42:24]
      s1Sum1 <= 16'h0; // @[dut.scala 42:24]
    end else if (v0) begin // @[dut.scala 88:12]
      s1Sum1 <= t1[15:0]; // @[dut.scala 91:13]
    end else begin
      s1Sum1 <= 16'h0; // @[dut.scala 100:13]
    end
    if (reset) begin // @[dut.scala 43:24]
      s1Carry <= 1'h0; // @[dut.scala 43:24]
    end else begin
      s1Carry <= _GEN_10;
    end
    if (reset) begin // @[dut.scala 44:24]
      s1A2 <= 16'h0; // @[dut.scala 44:24]
    end else if (v0) begin // @[dut.scala 88:12]
      s1A2 <= s0A2; // @[dut.scala 94:10]
    end else begin
      s1A2 <= 16'h0; // @[dut.scala 102:13]
    end
    if (reset) begin // @[dut.scala 45:24]
      s1B2 <= 16'h0; // @[dut.scala 45:24]
    end else if (v0) begin // @[dut.scala 88:12]
      s1B2 <= s0B2; // @[dut.scala 95:10]
    end else begin
      s1B2 <= 16'h0; // @[dut.scala 103:13]
    end
    if (reset) begin // @[dut.scala 46:24]
      s1A3 <= 16'h0; // @[dut.scala 46:24]
    end else if (v0) begin // @[dut.scala 88:12]
      s1A3 <= s0A3; // @[dut.scala 96:10]
    end else begin
      s1A3 <= 16'h0; // @[dut.scala 104:13]
    end
    if (reset) begin // @[dut.scala 47:24]
      s1B3 <= 16'h0; // @[dut.scala 47:24]
    end else if (v0) begin // @[dut.scala 88:12]
      s1B3 <= s0B3; // @[dut.scala 97:10]
    end else begin
      s1B3 <= 16'h0; // @[dut.scala 105:13]
    end
    if (reset) begin // @[dut.scala 52:24]
      s2Sum0 <= 16'h0; // @[dut.scala 52:24]
    end else if (v1) begin // @[dut.scala 109:12]
      s2Sum0 <= s1Sum0; // @[dut.scala 111:13]
    end else begin
      s2Sum0 <= 16'h0; // @[dut.scala 119:13]
    end
    if (reset) begin // @[dut.scala 53:24]
      s2Sum1 <= 16'h0; // @[dut.scala 53:24]
    end else if (v1) begin // @[dut.scala 109:12]
      s2Sum1 <= s1Sum1; // @[dut.scala 112:13]
    end else begin
      s2Sum1 <= 16'h0; // @[dut.scala 120:13]
    end
    if (reset) begin // @[dut.scala 54:24]
      s2Sum2 <= 16'h0; // @[dut.scala 54:24]
    end else if (v1) begin // @[dut.scala 109:12]
      s2Sum2 <= t2[15:0]; // @[dut.scala 113:13]
    end else begin
      s2Sum2 <= 16'h0; // @[dut.scala 121:13]
    end
    if (reset) begin // @[dut.scala 55:24]
      s2Carry <= 1'h0; // @[dut.scala 55:24]
    end else begin
      s2Carry <= _GEN_18;
    end
    if (reset) begin // @[dut.scala 56:24]
      s2A3 <= 16'h0; // @[dut.scala 56:24]
    end else if (v1) begin // @[dut.scala 109:12]
      s2A3 <= s1A3; // @[dut.scala 116:10]
    end else begin
      s2A3 <= 16'h0; // @[dut.scala 123:13]
    end
    if (reset) begin // @[dut.scala 57:24]
      s2B3 <= 16'h0; // @[dut.scala 57:24]
    end else if (v1) begin // @[dut.scala 109:12]
      s2B3 <= s1B3; // @[dut.scala 117:10]
    end else begin
      s2B3 <= 16'h0; // @[dut.scala 124:13]
    end
    if (reset) begin // @[dut.scala 62:26]
      resultReg <= 65'h0; // @[dut.scala 62:26]
    end else if (v2) begin // @[dut.scala 128:12]
      resultReg <= _resultReg_T_2; // @[dut.scala 130:15]
    end else begin
      resultReg <= 65'h0; // @[dut.scala 132:15]
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
  s0Sum0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  s0Carry = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s0A1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  s0B1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  s0A2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  s0B2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  s0A3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  s0B3 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  s1Sum0 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  s1Sum1 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  s1Carry = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  s1A2 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  s1B2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  s1A3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  s1B3 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  s2Sum0 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  s2Sum1 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  s2Sum2 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  s2Carry = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  s2A3 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  s2B3 = _RAND_24[15:0];
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
