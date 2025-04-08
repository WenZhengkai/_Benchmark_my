module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  a_bit = io_a[0]; // @[dut.scala 19:21]
  wire  b_bit = io_b[0]; // @[dut.scala 20:21]
  wire  sumWithCarry_0 = a_bit ^ b_bit ^ io_cin; // @[dut.scala 21:38]
  wire  carry_1 = a_bit & b_bit | a_bit & io_cin | b_bit & io_cin; // @[dut.scala 22:58]
  wire  a_bit_1 = io_a[1]; // @[dut.scala 19:21]
  wire  b_bit_1 = io_b[1]; // @[dut.scala 20:21]
  wire  sumWithCarry_1 = a_bit_1 ^ b_bit_1 ^ carry_1; // @[dut.scala 21:38]
  wire  carry_2 = a_bit_1 & b_bit_1 | a_bit_1 & carry_1 | b_bit_1 & carry_1; // @[dut.scala 22:58]
  wire  a_bit_2 = io_a[2]; // @[dut.scala 19:21]
  wire  b_bit_2 = io_b[2]; // @[dut.scala 20:21]
  wire  sumWithCarry_2 = a_bit_2 ^ b_bit_2 ^ carry_2; // @[dut.scala 21:38]
  wire  carry_3 = a_bit_2 & b_bit_2 | a_bit_2 & carry_2 | b_bit_2 & carry_2; // @[dut.scala 22:58]
  wire  a_bit_3 = io_a[3]; // @[dut.scala 19:21]
  wire  b_bit_3 = io_b[3]; // @[dut.scala 20:21]
  wire  sumWithCarry_3 = a_bit_3 ^ b_bit_3 ^ carry_3; // @[dut.scala 21:38]
  wire  carry_4 = a_bit_3 & b_bit_3 | a_bit_3 & carry_3 | b_bit_3 & carry_3; // @[dut.scala 22:58]
  wire  a_bit_4 = io_a[4]; // @[dut.scala 19:21]
  wire  b_bit_4 = io_b[4]; // @[dut.scala 20:21]
  wire  sumWithCarry_4 = a_bit_4 ^ b_bit_4 ^ carry_4; // @[dut.scala 21:38]
  wire  carry_5 = a_bit_4 & b_bit_4 | a_bit_4 & carry_4 | b_bit_4 & carry_4; // @[dut.scala 22:58]
  wire  a_bit_5 = io_a[5]; // @[dut.scala 19:21]
  wire  b_bit_5 = io_b[5]; // @[dut.scala 20:21]
  wire  sumWithCarry_5 = a_bit_5 ^ b_bit_5 ^ carry_5; // @[dut.scala 21:38]
  wire  carry_6 = a_bit_5 & b_bit_5 | a_bit_5 & carry_5 | b_bit_5 & carry_5; // @[dut.scala 22:58]
  wire  a_bit_6 = io_a[6]; // @[dut.scala 19:21]
  wire  b_bit_6 = io_b[6]; // @[dut.scala 20:21]
  wire  sumWithCarry_6 = a_bit_6 ^ b_bit_6 ^ carry_6; // @[dut.scala 21:38]
  wire  carry_7 = a_bit_6 & b_bit_6 | a_bit_6 & carry_6 | b_bit_6 & carry_6; // @[dut.scala 22:58]
  wire  a_bit_7 = io_a[7]; // @[dut.scala 19:21]
  wire  b_bit_7 = io_b[7]; // @[dut.scala 20:21]
  wire  sumWithCarry_7 = a_bit_7 ^ b_bit_7 ^ carry_7; // @[dut.scala 21:38]
  wire  carry_8 = a_bit_7 & b_bit_7 | a_bit_7 & carry_7 | b_bit_7 & carry_7; // @[dut.scala 22:58]
  wire  a_bit_8 = io_a[8]; // @[dut.scala 19:21]
  wire  b_bit_8 = io_b[8]; // @[dut.scala 20:21]
  wire  sumWithCarry_8 = a_bit_8 ^ b_bit_8 ^ carry_8; // @[dut.scala 21:38]
  wire  carry_9 = a_bit_8 & b_bit_8 | a_bit_8 & carry_8 | b_bit_8 & carry_8; // @[dut.scala 22:58]
  wire  a_bit_9 = io_a[9]; // @[dut.scala 19:21]
  wire  b_bit_9 = io_b[9]; // @[dut.scala 20:21]
  wire  sumWithCarry_9 = a_bit_9 ^ b_bit_9 ^ carry_9; // @[dut.scala 21:38]
  wire  carry_10 = a_bit_9 & b_bit_9 | a_bit_9 & carry_9 | b_bit_9 & carry_9; // @[dut.scala 22:58]
  wire  a_bit_10 = io_a[10]; // @[dut.scala 19:21]
  wire  b_bit_10 = io_b[10]; // @[dut.scala 20:21]
  wire  sumWithCarry_10 = a_bit_10 ^ b_bit_10 ^ carry_10; // @[dut.scala 21:38]
  wire  carry_11 = a_bit_10 & b_bit_10 | a_bit_10 & carry_10 | b_bit_10 & carry_10; // @[dut.scala 22:58]
  wire  a_bit_11 = io_a[11]; // @[dut.scala 19:21]
  wire  b_bit_11 = io_b[11]; // @[dut.scala 20:21]
  wire  sumWithCarry_11 = a_bit_11 ^ b_bit_11 ^ carry_11; // @[dut.scala 21:38]
  wire  carry_12 = a_bit_11 & b_bit_11 | a_bit_11 & carry_11 | b_bit_11 & carry_11; // @[dut.scala 22:58]
  wire  a_bit_12 = io_a[12]; // @[dut.scala 19:21]
  wire  b_bit_12 = io_b[12]; // @[dut.scala 20:21]
  wire  sumWithCarry_12 = a_bit_12 ^ b_bit_12 ^ carry_12; // @[dut.scala 21:38]
  wire  carry_13 = a_bit_12 & b_bit_12 | a_bit_12 & carry_12 | b_bit_12 & carry_12; // @[dut.scala 22:58]
  wire  a_bit_13 = io_a[13]; // @[dut.scala 19:21]
  wire  b_bit_13 = io_b[13]; // @[dut.scala 20:21]
  wire  sumWithCarry_13 = a_bit_13 ^ b_bit_13 ^ carry_13; // @[dut.scala 21:38]
  wire  carry_14 = a_bit_13 & b_bit_13 | a_bit_13 & carry_13 | b_bit_13 & carry_13; // @[dut.scala 22:58]
  wire  a_bit_14 = io_a[14]; // @[dut.scala 19:21]
  wire  b_bit_14 = io_b[14]; // @[dut.scala 20:21]
  wire  sumWithCarry_14 = a_bit_14 ^ b_bit_14 ^ carry_14; // @[dut.scala 21:38]
  wire  carry_15 = a_bit_14 & b_bit_14 | a_bit_14 & carry_14 | b_bit_14 & carry_14; // @[dut.scala 22:58]
  wire  a_bit_15 = io_a[15]; // @[dut.scala 19:21]
  wire  b_bit_15 = io_b[15]; // @[dut.scala 20:21]
  wire  sumWithCarry_15 = a_bit_15 ^ b_bit_15 ^ carry_15; // @[dut.scala 21:38]
  wire [7:0] io_sum_lo = {sumWithCarry_7,sumWithCarry_6,sumWithCarry_5,sumWithCarry_4,sumWithCarry_3,sumWithCarry_2,
    sumWithCarry_1,sumWithCarry_0}; // @[dut.scala 25:26]
  wire [7:0] io_sum_hi = {sumWithCarry_15,sumWithCarry_14,sumWithCarry_13,sumWithCarry_12,sumWithCarry_11,
    sumWithCarry_10,sumWithCarry_9,sumWithCarry_8}; // @[dut.scala 25:26]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 25:26]
  assign io_cout = a_bit_15 & b_bit_15 | a_bit_15 & carry_15 | b_bit_15 & carry_15; // @[dut.scala 22:58]
endmodule
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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [95:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] rca1_io_a; // @[dut.scala 56:20]
  wire [15:0] rca1_io_b; // @[dut.scala 56:20]
  wire  rca1_io_cin; // @[dut.scala 56:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 56:20]
  wire  rca1_io_cout; // @[dut.scala 56:20]
  wire [15:0] rca2_io_a; // @[dut.scala 68:20]
  wire [15:0] rca2_io_b; // @[dut.scala 68:20]
  wire  rca2_io_cin; // @[dut.scala 68:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 68:20]
  wire  rca2_io_cout; // @[dut.scala 68:20]
  wire [15:0] rca3_io_a; // @[dut.scala 80:20]
  wire [15:0] rca3_io_b; // @[dut.scala 80:20]
  wire  rca3_io_cin; // @[dut.scala 80:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 80:20]
  wire  rca3_io_cout; // @[dut.scala 80:20]
  wire [15:0] rca4_io_a; // @[dut.scala 92:20]
  wire [15:0] rca4_io_b; // @[dut.scala 92:20]
  wire  rca4_io_cin; // @[dut.scala 92:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 92:20]
  wire  rca4_io_cout; // @[dut.scala 92:20]
  reg  en_pipeline_0; // @[dut.scala 39:28]
  reg  en_pipeline_1; // @[dut.scala 39:28]
  reg  en_pipeline_2; // @[dut.scala 39:28]
  reg  en_pipeline_3; // @[dut.scala 39:28]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg [15:0] stage1_sum; // @[dut.scala 54:23]
  reg  stage1_cout; // @[dut.scala 55:24]
  reg [15:0] stage2_sum; // @[dut.scala 66:23]
  reg  stage2_cout; // @[dut.scala 67:24]
  reg [15:0] stage3_sum; // @[dut.scala 78:23]
  reg  stage3_cout; // @[dut.scala 79:24]
  reg [15:0] stage4_sum; // @[dut.scala 90:23]
  reg  stage4_cout; // @[dut.scala 91:24]
  reg [64:0] result_reg; // @[dut.scala 102:23]
  wire [64:0] _result_reg_T = {stage4_cout,stage4_sum,stage3_sum,stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  RCA16 rca1 ( // @[dut.scala 56:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 68:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 80:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  RCA16 rca4 ( // @[dut.scala 92:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 106:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 109:11]
  assign rca1_io_a = adda_reg[15:0]; // @[dut.scala 57:24]
  assign rca1_io_b = addb_reg[15:0]; // @[dut.scala 58:24]
  assign rca1_io_cin = 1'h0; // @[dut.scala 59:15]
  assign rca2_io_a = adda_reg[31:16]; // @[dut.scala 69:24]
  assign rca2_io_b = addb_reg[31:16]; // @[dut.scala 70:24]
  assign rca2_io_cin = stage1_cout; // @[dut.scala 71:15]
  assign rca3_io_a = adda_reg[47:32]; // @[dut.scala 81:24]
  assign rca3_io_b = addb_reg[47:32]; // @[dut.scala 82:24]
  assign rca3_io_cin = stage2_cout; // @[dut.scala 83:15]
  assign rca4_io_a = adda_reg[63:48]; // @[dut.scala 93:24]
  assign rca4_io_b = addb_reg[63:48]; // @[dut.scala 94:24]
  assign rca4_io_cin = stage3_cout; // @[dut.scala 95:15]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 39:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 39:28]
    end else begin
      en_pipeline_0 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 39:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 39:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 46:20]
    end
    if (reset) begin // @[dut.scala 39:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 39:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 46:20]
    end
    if (reset) begin // @[dut.scala 39:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 39:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 46:20]
    end
    if (reset) begin // @[Reg.scala 35:20]
      adda_reg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      adda_reg <= io_adda; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      addb_reg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      addb_reg <= io_addb; // @[Reg.scala 36:22]
    end
    if (en_pipeline_0) begin // @[dut.scala 60:24]
      stage1_sum <= rca1_io_sum; // @[dut.scala 61:16]
    end
    if (en_pipeline_0) begin // @[dut.scala 60:24]
      stage1_cout <= rca1_io_cout; // @[dut.scala 62:17]
    end
    if (en_pipeline_1) begin // @[dut.scala 72:24]
      stage2_sum <= rca2_io_sum; // @[dut.scala 73:16]
    end
    if (en_pipeline_1) begin // @[dut.scala 72:24]
      stage2_cout <= rca2_io_cout; // @[dut.scala 74:17]
    end
    if (en_pipeline_2) begin // @[dut.scala 84:24]
      stage3_sum <= rca3_io_sum; // @[dut.scala 85:16]
    end
    if (en_pipeline_2) begin // @[dut.scala 84:24]
      stage3_cout <= rca3_io_cout; // @[dut.scala 86:17]
    end
    if (en_pipeline_3) begin // @[dut.scala 96:24]
      stage4_sum <= rca4_io_sum; // @[dut.scala 97:16]
    end
    if (en_pipeline_3) begin // @[dut.scala 96:24]
      stage4_cout <= rca4_io_cout; // @[dut.scala 98:17]
    end
    if (en_pipeline_3) begin // @[dut.scala 103:25]
      result_reg <= _result_reg_T; // @[dut.scala 104:16]
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
  en_pipeline_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en_pipeline_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en_pipeline_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_pipeline_3 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  adda_reg = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  stage1_sum = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage1_cout = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2_sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage2_cout = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3_sum = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  stage3_cout = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage4_sum = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  stage4_cout = _RAND_13[0:0];
  _RAND_14 = {3{`RANDOM}};
  result_reg = _RAND_14[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
