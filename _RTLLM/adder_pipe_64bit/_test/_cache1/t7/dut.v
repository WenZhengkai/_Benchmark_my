module FullAdder(
  input   io_a,
  input   io_b,
  input   io_cin,
  output  io_sum,
  output  io_cout
);
  assign io_sum = io_a ^ io_b ^ io_cin; // @[dut.scala 45:25]
  assign io_cout = io_a & io_b | io_a & io_cin | io_b & io_cin; // @[dut.scala 46:46]
endmodule
module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  FullAdder_io_a; // @[dut.scala 13:41]
  wire  FullAdder_io_b; // @[dut.scala 13:41]
  wire  FullAdder_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_1_io_a; // @[dut.scala 13:41]
  wire  FullAdder_1_io_b; // @[dut.scala 13:41]
  wire  FullAdder_1_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_1_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_1_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_2_io_a; // @[dut.scala 13:41]
  wire  FullAdder_2_io_b; // @[dut.scala 13:41]
  wire  FullAdder_2_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_2_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_2_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_3_io_a; // @[dut.scala 13:41]
  wire  FullAdder_3_io_b; // @[dut.scala 13:41]
  wire  FullAdder_3_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_3_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_3_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_4_io_a; // @[dut.scala 13:41]
  wire  FullAdder_4_io_b; // @[dut.scala 13:41]
  wire  FullAdder_4_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_4_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_4_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_5_io_a; // @[dut.scala 13:41]
  wire  FullAdder_5_io_b; // @[dut.scala 13:41]
  wire  FullAdder_5_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_5_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_5_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_6_io_a; // @[dut.scala 13:41]
  wire  FullAdder_6_io_b; // @[dut.scala 13:41]
  wire  FullAdder_6_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_6_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_6_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_7_io_a; // @[dut.scala 13:41]
  wire  FullAdder_7_io_b; // @[dut.scala 13:41]
  wire  FullAdder_7_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_7_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_7_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_8_io_a; // @[dut.scala 13:41]
  wire  FullAdder_8_io_b; // @[dut.scala 13:41]
  wire  FullAdder_8_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_8_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_8_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_9_io_a; // @[dut.scala 13:41]
  wire  FullAdder_9_io_b; // @[dut.scala 13:41]
  wire  FullAdder_9_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_9_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_9_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_10_io_a; // @[dut.scala 13:41]
  wire  FullAdder_10_io_b; // @[dut.scala 13:41]
  wire  FullAdder_10_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_10_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_10_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_11_io_a; // @[dut.scala 13:41]
  wire  FullAdder_11_io_b; // @[dut.scala 13:41]
  wire  FullAdder_11_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_11_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_11_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_12_io_a; // @[dut.scala 13:41]
  wire  FullAdder_12_io_b; // @[dut.scala 13:41]
  wire  FullAdder_12_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_12_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_12_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_13_io_a; // @[dut.scala 13:41]
  wire  FullAdder_13_io_b; // @[dut.scala 13:41]
  wire  FullAdder_13_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_13_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_13_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_14_io_a; // @[dut.scala 13:41]
  wire  FullAdder_14_io_b; // @[dut.scala 13:41]
  wire  FullAdder_14_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_14_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_14_io_cout; // @[dut.scala 13:41]
  wire  FullAdder_15_io_a; // @[dut.scala 13:41]
  wire  FullAdder_15_io_b; // @[dut.scala 13:41]
  wire  FullAdder_15_io_cin; // @[dut.scala 13:41]
  wire  FullAdder_15_io_sum; // @[dut.scala 13:41]
  wire  FullAdder_15_io_cout; // @[dut.scala 13:41]
  wire  sumBits_1 = FullAdder_1_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_0 = FullAdder_io_sum; // @[dut.scala 14:21 17:14]
  wire  sumBits_3 = FullAdder_3_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_2 = FullAdder_2_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_5 = FullAdder_5_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_4 = FullAdder_4_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_7 = FullAdder_7_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_6 = FullAdder_6_io_sum; // @[dut.scala 14:21 28:16]
  wire [7:0] io_sum_lo = {sumBits_7,sumBits_6,sumBits_5,sumBits_4,sumBits_3,sumBits_2,sumBits_1,sumBits_0}; // @[dut.scala 32:27]
  wire  sumBits_9 = FullAdder_9_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_8 = FullAdder_8_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_11 = FullAdder_11_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_10 = FullAdder_10_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_13 = FullAdder_13_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_12 = FullAdder_12_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_15 = FullAdder_15_io_sum; // @[dut.scala 14:21 28:16]
  wire  sumBits_14 = FullAdder_14_io_sum; // @[dut.scala 14:21 28:16]
  wire [7:0] io_sum_hi = {sumBits_15,sumBits_14,sumBits_13,sumBits_12,sumBits_11,sumBits_10,sumBits_9,sumBits_8}; // @[dut.scala 32:27]
  FullAdder FullAdder ( // @[dut.scala 13:41]
    .io_a(FullAdder_io_a),
    .io_b(FullAdder_io_b),
    .io_cin(FullAdder_io_cin),
    .io_sum(FullAdder_io_sum),
    .io_cout(FullAdder_io_cout)
  );
  FullAdder FullAdder_1 ( // @[dut.scala 13:41]
    .io_a(FullAdder_1_io_a),
    .io_b(FullAdder_1_io_b),
    .io_cin(FullAdder_1_io_cin),
    .io_sum(FullAdder_1_io_sum),
    .io_cout(FullAdder_1_io_cout)
  );
  FullAdder FullAdder_2 ( // @[dut.scala 13:41]
    .io_a(FullAdder_2_io_a),
    .io_b(FullAdder_2_io_b),
    .io_cin(FullAdder_2_io_cin),
    .io_sum(FullAdder_2_io_sum),
    .io_cout(FullAdder_2_io_cout)
  );
  FullAdder FullAdder_3 ( // @[dut.scala 13:41]
    .io_a(FullAdder_3_io_a),
    .io_b(FullAdder_3_io_b),
    .io_cin(FullAdder_3_io_cin),
    .io_sum(FullAdder_3_io_sum),
    .io_cout(FullAdder_3_io_cout)
  );
  FullAdder FullAdder_4 ( // @[dut.scala 13:41]
    .io_a(FullAdder_4_io_a),
    .io_b(FullAdder_4_io_b),
    .io_cin(FullAdder_4_io_cin),
    .io_sum(FullAdder_4_io_sum),
    .io_cout(FullAdder_4_io_cout)
  );
  FullAdder FullAdder_5 ( // @[dut.scala 13:41]
    .io_a(FullAdder_5_io_a),
    .io_b(FullAdder_5_io_b),
    .io_cin(FullAdder_5_io_cin),
    .io_sum(FullAdder_5_io_sum),
    .io_cout(FullAdder_5_io_cout)
  );
  FullAdder FullAdder_6 ( // @[dut.scala 13:41]
    .io_a(FullAdder_6_io_a),
    .io_b(FullAdder_6_io_b),
    .io_cin(FullAdder_6_io_cin),
    .io_sum(FullAdder_6_io_sum),
    .io_cout(FullAdder_6_io_cout)
  );
  FullAdder FullAdder_7 ( // @[dut.scala 13:41]
    .io_a(FullAdder_7_io_a),
    .io_b(FullAdder_7_io_b),
    .io_cin(FullAdder_7_io_cin),
    .io_sum(FullAdder_7_io_sum),
    .io_cout(FullAdder_7_io_cout)
  );
  FullAdder FullAdder_8 ( // @[dut.scala 13:41]
    .io_a(FullAdder_8_io_a),
    .io_b(FullAdder_8_io_b),
    .io_cin(FullAdder_8_io_cin),
    .io_sum(FullAdder_8_io_sum),
    .io_cout(FullAdder_8_io_cout)
  );
  FullAdder FullAdder_9 ( // @[dut.scala 13:41]
    .io_a(FullAdder_9_io_a),
    .io_b(FullAdder_9_io_b),
    .io_cin(FullAdder_9_io_cin),
    .io_sum(FullAdder_9_io_sum),
    .io_cout(FullAdder_9_io_cout)
  );
  FullAdder FullAdder_10 ( // @[dut.scala 13:41]
    .io_a(FullAdder_10_io_a),
    .io_b(FullAdder_10_io_b),
    .io_cin(FullAdder_10_io_cin),
    .io_sum(FullAdder_10_io_sum),
    .io_cout(FullAdder_10_io_cout)
  );
  FullAdder FullAdder_11 ( // @[dut.scala 13:41]
    .io_a(FullAdder_11_io_a),
    .io_b(FullAdder_11_io_b),
    .io_cin(FullAdder_11_io_cin),
    .io_sum(FullAdder_11_io_sum),
    .io_cout(FullAdder_11_io_cout)
  );
  FullAdder FullAdder_12 ( // @[dut.scala 13:41]
    .io_a(FullAdder_12_io_a),
    .io_b(FullAdder_12_io_b),
    .io_cin(FullAdder_12_io_cin),
    .io_sum(FullAdder_12_io_sum),
    .io_cout(FullAdder_12_io_cout)
  );
  FullAdder FullAdder_13 ( // @[dut.scala 13:41]
    .io_a(FullAdder_13_io_a),
    .io_b(FullAdder_13_io_b),
    .io_cin(FullAdder_13_io_cin),
    .io_sum(FullAdder_13_io_sum),
    .io_cout(FullAdder_13_io_cout)
  );
  FullAdder FullAdder_14 ( // @[dut.scala 13:41]
    .io_a(FullAdder_14_io_a),
    .io_b(FullAdder_14_io_b),
    .io_cin(FullAdder_14_io_cin),
    .io_sum(FullAdder_14_io_sum),
    .io_cout(FullAdder_14_io_cout)
  );
  FullAdder FullAdder_15 ( // @[dut.scala 13:41]
    .io_a(FullAdder_15_io_a),
    .io_b(FullAdder_15_io_b),
    .io_cin(FullAdder_15_io_cin),
    .io_sum(FullAdder_15_io_sum),
    .io_cout(FullAdder_15_io_cout)
  );
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 32:27]
  assign io_cout = FullAdder_15_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_io_a = io_a[0]; // @[dut.scala 20:29]
  assign FullAdder_io_b = io_b[0]; // @[dut.scala 21:29]
  assign FullAdder_io_cin = io_cin; // @[dut.scala 22:24]
  assign FullAdder_1_io_a = io_a[1]; // @[dut.scala 25:31]
  assign FullAdder_1_io_b = io_b[1]; // @[dut.scala 26:31]
  assign FullAdder_1_io_cin = FullAdder_io_cout; // @[dut.scala 15:22 18:15]
  assign FullAdder_2_io_a = io_a[2]; // @[dut.scala 25:31]
  assign FullAdder_2_io_b = io_b[2]; // @[dut.scala 26:31]
  assign FullAdder_2_io_cin = FullAdder_1_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_3_io_a = io_a[3]; // @[dut.scala 25:31]
  assign FullAdder_3_io_b = io_b[3]; // @[dut.scala 26:31]
  assign FullAdder_3_io_cin = FullAdder_2_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_4_io_a = io_a[4]; // @[dut.scala 25:31]
  assign FullAdder_4_io_b = io_b[4]; // @[dut.scala 26:31]
  assign FullAdder_4_io_cin = FullAdder_3_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_5_io_a = io_a[5]; // @[dut.scala 25:31]
  assign FullAdder_5_io_b = io_b[5]; // @[dut.scala 26:31]
  assign FullAdder_5_io_cin = FullAdder_4_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_6_io_a = io_a[6]; // @[dut.scala 25:31]
  assign FullAdder_6_io_b = io_b[6]; // @[dut.scala 26:31]
  assign FullAdder_6_io_cin = FullAdder_5_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_7_io_a = io_a[7]; // @[dut.scala 25:31]
  assign FullAdder_7_io_b = io_b[7]; // @[dut.scala 26:31]
  assign FullAdder_7_io_cin = FullAdder_6_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_8_io_a = io_a[8]; // @[dut.scala 25:31]
  assign FullAdder_8_io_b = io_b[8]; // @[dut.scala 26:31]
  assign FullAdder_8_io_cin = FullAdder_7_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_9_io_a = io_a[9]; // @[dut.scala 25:31]
  assign FullAdder_9_io_b = io_b[9]; // @[dut.scala 26:31]
  assign FullAdder_9_io_cin = FullAdder_8_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_10_io_a = io_a[10]; // @[dut.scala 25:31]
  assign FullAdder_10_io_b = io_b[10]; // @[dut.scala 26:31]
  assign FullAdder_10_io_cin = FullAdder_9_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_11_io_a = io_a[11]; // @[dut.scala 25:31]
  assign FullAdder_11_io_b = io_b[11]; // @[dut.scala 26:31]
  assign FullAdder_11_io_cin = FullAdder_10_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_12_io_a = io_a[12]; // @[dut.scala 25:31]
  assign FullAdder_12_io_b = io_b[12]; // @[dut.scala 26:31]
  assign FullAdder_12_io_cin = FullAdder_11_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_13_io_a = io_a[13]; // @[dut.scala 25:31]
  assign FullAdder_13_io_b = io_b[13]; // @[dut.scala 26:31]
  assign FullAdder_13_io_cin = FullAdder_12_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_14_io_a = io_a[14]; // @[dut.scala 25:31]
  assign FullAdder_14_io_b = io_b[14]; // @[dut.scala 26:31]
  assign FullAdder_14_io_cin = FullAdder_13_io_cout; // @[dut.scala 15:22 29:17]
  assign FullAdder_15_io_a = io_a[15]; // @[dut.scala 25:31]
  assign FullAdder_15_io_b = io_b[15]; // @[dut.scala 26:31]
  assign FullAdder_15_io_cin = FullAdder_14_io_cout; // @[dut.scala 15:22 29:17]
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
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
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
  reg [95:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] stage1_io_a; // @[dut.scala 69:22]
  wire [15:0] stage1_io_b; // @[dut.scala 69:22]
  wire  stage1_io_cin; // @[dut.scala 69:22]
  wire [15:0] stage1_io_sum; // @[dut.scala 69:22]
  wire  stage1_io_cout; // @[dut.scala 69:22]
  wire [15:0] stage2_io_a; // @[dut.scala 76:22]
  wire [15:0] stage2_io_b; // @[dut.scala 76:22]
  wire  stage2_io_cin; // @[dut.scala 76:22]
  wire [15:0] stage2_io_sum; // @[dut.scala 76:22]
  wire  stage2_io_cout; // @[dut.scala 76:22]
  wire [15:0] stage3_io_a; // @[dut.scala 83:22]
  wire [15:0] stage3_io_b; // @[dut.scala 83:22]
  wire  stage3_io_cin; // @[dut.scala 83:22]
  wire [15:0] stage3_io_sum; // @[dut.scala 83:22]
  wire  stage3_io_cout; // @[dut.scala 83:22]
  wire [15:0] stage4_io_a; // @[dut.scala 90:22]
  wire [15:0] stage4_io_b; // @[dut.scala 90:22]
  wire  stage4_io_cin; // @[dut.scala 90:22]
  wire [15:0] stage4_io_sum; // @[dut.scala 90:22]
  wire  stage4_io_cout; // @[dut.scala 90:22]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 62:28]
  reg  en_pipeline_1; // @[dut.scala 62:28]
  reg  en_pipeline_2; // @[dut.scala 62:28]
  reg  en_pipeline_3; // @[dut.scala 62:28]
  reg [15:0] stage1_sum; // @[Reg.scala 35:20]
  reg  stage1_cout; // @[Reg.scala 35:20]
  reg [15:0] stage2_sum; // @[Reg.scala 35:20]
  reg  stage2_cout; // @[Reg.scala 35:20]
  reg [15:0] stage3_sum; // @[Reg.scala 35:20]
  reg  stage3_cout; // @[Reg.scala 35:20]
  reg [15:0] stage4_sum; // @[Reg.scala 35:20]
  reg  final_carry; // @[Reg.scala 35:20]
  reg [64:0] result_reg; // @[dut.scala 98:27]
  wire [64:0] _result_reg_T = {final_carry,stage4_sum,stage3_sum,stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  RCA16 stage1 ( // @[dut.scala 69:22]
    .io_a(stage1_io_a),
    .io_b(stage1_io_b),
    .io_cin(stage1_io_cin),
    .io_sum(stage1_io_sum),
    .io_cout(stage1_io_cout)
  );
  RCA16 stage2 ( // @[dut.scala 76:22]
    .io_a(stage2_io_a),
    .io_b(stage2_io_b),
    .io_cin(stage2_io_cin),
    .io_sum(stage2_io_sum),
    .io_cout(stage2_io_cout)
  );
  RCA16 stage3 ( // @[dut.scala 83:22]
    .io_a(stage3_io_a),
    .io_b(stage3_io_b),
    .io_cin(stage3_io_cin),
    .io_sum(stage3_io_sum),
    .io_cout(stage3_io_cout)
  );
  RCA16 stage4 ( // @[dut.scala 90:22]
    .io_a(stage4_io_a),
    .io_b(stage4_io_b),
    .io_cin(stage4_io_cin),
    .io_sum(stage4_io_sum),
    .io_cout(stage4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 100:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 103:11]
  assign stage1_io_a = adda_reg[15:0]; // @[dut.scala 70:26]
  assign stage1_io_b = addb_reg[15:0]; // @[dut.scala 71:26]
  assign stage1_io_cin = 1'h0; // @[dut.scala 72:17]
  assign stage2_io_a = adda_reg[31:16]; // @[dut.scala 77:26]
  assign stage2_io_b = addb_reg[31:16]; // @[dut.scala 78:26]
  assign stage2_io_cin = stage1_cout; // @[dut.scala 79:17]
  assign stage3_io_a = adda_reg[47:32]; // @[dut.scala 84:26]
  assign stage3_io_b = addb_reg[47:32]; // @[dut.scala 85:26]
  assign stage3_io_cin = stage2_cout; // @[dut.scala 86:17]
  assign stage4_io_a = adda_reg[63:48]; // @[dut.scala 91:26]
  assign stage4_io_b = addb_reg[63:48]; // @[dut.scala 92:26]
  assign stage4_io_cin = stage3_cout; // @[dut.scala 93:17]
  always @(posedge clock) begin
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
    if (reset) begin // @[dut.scala 62:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 62:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 63:18]
    end
    if (reset) begin // @[dut.scala 62:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 62:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 65:20]
    end
    if (reset) begin // @[dut.scala 62:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 62:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 65:20]
    end
    if (reset) begin // @[dut.scala 62:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 62:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 65:20]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage1_sum <= 16'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_0) begin // @[Reg.scala 36:18]
      stage1_sum <= stage1_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage1_cout <= 1'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_0) begin // @[Reg.scala 36:18]
      stage1_cout <= stage1_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage2_sum <= 16'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_1) begin // @[Reg.scala 36:18]
      stage2_sum <= stage2_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage2_cout <= 1'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_1) begin // @[Reg.scala 36:18]
      stage2_cout <= stage2_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage3_sum <= 16'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_2) begin // @[Reg.scala 36:18]
      stage3_sum <= stage3_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage3_cout <= 1'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_2) begin // @[Reg.scala 36:18]
      stage3_cout <= stage3_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage4_sum <= 16'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_3) begin // @[Reg.scala 36:18]
      stage4_sum <= stage4_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      final_carry <= 1'h0; // @[Reg.scala 35:20]
    end else if (en_pipeline_3) begin // @[Reg.scala 36:18]
      final_carry <= stage4_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 98:27]
      result_reg <= 65'h0; // @[dut.scala 98:27]
    end else begin
      result_reg <= _result_reg_T; // @[dut.scala 99:14]
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
  _RAND_0 = {2{`RANDOM}};
  adda_reg = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addb_reg = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  en_pipeline_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_pipeline_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  en_pipeline_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  en_pipeline_3 = _RAND_5[0:0];
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
  final_carry = _RAND_13[0:0];
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
