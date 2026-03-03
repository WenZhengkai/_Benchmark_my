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
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [95:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg  en1; // @[dut.scala 19:20]
  reg  en2; // @[dut.scala 20:20]
  reg  en3; // @[dut.scala 21:20]
  reg  en4; // @[dut.scala 22:20]
  reg [63:0] a0; // @[dut.scala 31:19]
  reg [63:0] b0; // @[dut.scala 32:19]
  reg [15:0] s0_reg; // @[dut.scala 39:24]
  reg  c1_reg; // @[dut.scala 40:24]
  reg [63:0] a1_reg; // @[dut.scala 41:24]
  reg [63:0] b1_reg; // @[dut.scala 42:24]
  wire [16:0] part0 = a0[15:0] + b0[15:0]; // @[dut.scala 44:25]
  reg  c2_reg; // @[dut.scala 54:24]
  reg [31:0] s01_reg; // @[dut.scala 55:24]
  reg [63:0] a2_reg; // @[dut.scala 56:24]
  reg [63:0] b2_reg; // @[dut.scala 57:24]
  wire [16:0] _part1_T_2 = a1_reg[31:16] + b1_reg[31:16]; // @[dut.scala 59:30]
  wire [16:0] _GEN_17 = {{16'd0}, c1_reg}; // @[dut.scala 59:48]
  wire [16:0] part1 = _part1_T_2 + _GEN_17; // @[dut.scala 59:48]
  wire [31:0] _s01_reg_T_1 = {part1[15:0],s0_reg}; // @[Cat.scala 33:92]
  reg  c3_reg; // @[dut.scala 70:25]
  reg [47:0] s012_reg; // @[dut.scala 71:25]
  reg [63:0] a3_reg; // @[dut.scala 72:25]
  reg [63:0] b3_reg; // @[dut.scala 73:25]
  wire [16:0] _part2_T_2 = a2_reg[47:32] + b2_reg[47:32]; // @[dut.scala 75:30]
  wire [16:0] _GEN_18 = {{16'd0}, c2_reg}; // @[dut.scala 75:48]
  wire [16:0] part2 = _part2_T_2 + _GEN_18; // @[dut.scala 75:48]
  wire [47:0] _s012_reg_T_1 = {part2[15:0],s01_reg}; // @[Cat.scala 33:92]
  reg [64:0] result_reg; // @[dut.scala 85:27]
  wire [16:0] _part3_T_2 = a3_reg[63:48] + b3_reg[63:48]; // @[dut.scala 87:30]
  wire [16:0] _GEN_19 = {{16'd0}, c3_reg}; // @[dut.scala 87:48]
  wire [16:0] part3 = _part3_T_2 + _GEN_19; // @[dut.scala 87:48]
  wire [64:0] _result_reg_T_2 = {part3[16],part3[15:0],s012_reg}; // @[Cat.scala 33:92]
  assign io_result = result_reg; // @[dut.scala 93:13]
  assign io_o_en = en4; // @[dut.scala 28:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:20]
      en1 <= 1'h0; // @[dut.scala 19:20]
    end else begin
      en1 <= io_i_en; // @[dut.scala 24:7]
    end
    if (reset) begin // @[dut.scala 20:20]
      en2 <= 1'h0; // @[dut.scala 20:20]
    end else begin
      en2 <= en1; // @[dut.scala 25:7]
    end
    if (reset) begin // @[dut.scala 21:20]
      en3 <= 1'h0; // @[dut.scala 21:20]
    end else begin
      en3 <= en2; // @[dut.scala 26:7]
    end
    if (reset) begin // @[dut.scala 22:20]
      en4 <= 1'h0; // @[dut.scala 22:20]
    end else begin
      en4 <= en3; // @[dut.scala 27:7]
    end
    if (reset) begin // @[dut.scala 31:19]
      a0 <= 64'h0; // @[dut.scala 31:19]
    end else if (io_i_en) begin // @[dut.scala 33:17]
      a0 <= io_adda; // @[dut.scala 34:8]
    end
    if (reset) begin // @[dut.scala 32:19]
      b0 <= 64'h0; // @[dut.scala 32:19]
    end else if (io_i_en) begin // @[dut.scala 33:17]
      b0 <= io_addb; // @[dut.scala 35:8]
    end
    if (reset) begin // @[dut.scala 39:24]
      s0_reg <= 16'h0; // @[dut.scala 39:24]
    end else if (en1) begin // @[dut.scala 45:13]
      s0_reg <= part0[15:0]; // @[dut.scala 46:12]
    end
    if (reset) begin // @[dut.scala 40:24]
      c1_reg <= 1'h0; // @[dut.scala 40:24]
    end else if (en1) begin // @[dut.scala 45:13]
      c1_reg <= part0[16]; // @[dut.scala 47:12]
    end
    if (reset) begin // @[dut.scala 41:24]
      a1_reg <= 64'h0; // @[dut.scala 41:24]
    end else if (en1) begin // @[dut.scala 45:13]
      a1_reg <= a0; // @[dut.scala 48:12]
    end
    if (reset) begin // @[dut.scala 42:24]
      b1_reg <= 64'h0; // @[dut.scala 42:24]
    end else if (en1) begin // @[dut.scala 45:13]
      b1_reg <= b0; // @[dut.scala 49:12]
    end
    if (reset) begin // @[dut.scala 54:24]
      c2_reg <= 1'h0; // @[dut.scala 54:24]
    end else if (en2) begin // @[dut.scala 60:13]
      c2_reg <= part1[16]; // @[dut.scala 62:13]
    end
    if (reset) begin // @[dut.scala 55:24]
      s01_reg <= 32'h0; // @[dut.scala 55:24]
    end else if (en2) begin // @[dut.scala 60:13]
      s01_reg <= _s01_reg_T_1; // @[dut.scala 63:13]
    end
    if (reset) begin // @[dut.scala 56:24]
      a2_reg <= 64'h0; // @[dut.scala 56:24]
    end else if (en2) begin // @[dut.scala 60:13]
      a2_reg <= a1_reg; // @[dut.scala 64:13]
    end
    if (reset) begin // @[dut.scala 57:24]
      b2_reg <= 64'h0; // @[dut.scala 57:24]
    end else if (en2) begin // @[dut.scala 60:13]
      b2_reg <= b1_reg; // @[dut.scala 65:13]
    end
    if (reset) begin // @[dut.scala 70:25]
      c3_reg <= 1'h0; // @[dut.scala 70:25]
    end else if (en3) begin // @[dut.scala 76:13]
      c3_reg <= part2[16]; // @[dut.scala 78:14]
    end
    if (reset) begin // @[dut.scala 71:25]
      s012_reg <= 48'h0; // @[dut.scala 71:25]
    end else if (en3) begin // @[dut.scala 76:13]
      s012_reg <= _s012_reg_T_1; // @[dut.scala 79:14]
    end
    if (reset) begin // @[dut.scala 72:25]
      a3_reg <= 64'h0; // @[dut.scala 72:25]
    end else if (en3) begin // @[dut.scala 76:13]
      a3_reg <= a2_reg; // @[dut.scala 80:14]
    end
    if (reset) begin // @[dut.scala 73:25]
      b3_reg <= 64'h0; // @[dut.scala 73:25]
    end else if (en3) begin // @[dut.scala 76:13]
      b3_reg <= b2_reg; // @[dut.scala 81:14]
    end
    if (reset) begin // @[dut.scala 85:27]
      result_reg <= 65'h0; // @[dut.scala 85:27]
    end else if (en4) begin // @[dut.scala 88:13]
      result_reg <= _result_reg_T_2; // @[dut.scala 90:16]
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
  a0 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  b0 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  s0_reg = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  c1_reg = _RAND_7[0:0];
  _RAND_8 = {2{`RANDOM}};
  a1_reg = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  b1_reg = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  c2_reg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  s01_reg = _RAND_11[31:0];
  _RAND_12 = {2{`RANDOM}};
  a2_reg = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  b2_reg = _RAND_13[63:0];
  _RAND_14 = {1{`RANDOM}};
  c3_reg = _RAND_14[0:0];
  _RAND_15 = {2{`RANDOM}};
  s012_reg = _RAND_15[47:0];
  _RAND_16 = {2{`RANDOM}};
  a3_reg = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  b3_reg = _RAND_17[63:0];
  _RAND_18 = {3{`RANDOM}};
  result_reg = _RAND_18[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
