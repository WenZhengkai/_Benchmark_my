module FullAdder(
  input   io_a,
  input   io_b,
  input   io_cin,
  output  io_sum,
  output  io_cout
);
  assign io_sum = io_a ^ io_b ^ io_cin; // @[dut.scala 39:25]
  assign io_cout = io_a & io_b | io_b & io_cin | io_a & io_cin; // @[dut.scala 40:46]
endmodule
module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  FullAdder_io_a; // @[dut.scala 17:29]
  wire  FullAdder_io_b; // @[dut.scala 17:29]
  wire  FullAdder_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_1_io_a; // @[dut.scala 17:29]
  wire  FullAdder_1_io_b; // @[dut.scala 17:29]
  wire  FullAdder_1_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_1_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_1_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_2_io_a; // @[dut.scala 17:29]
  wire  FullAdder_2_io_b; // @[dut.scala 17:29]
  wire  FullAdder_2_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_2_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_2_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_3_io_a; // @[dut.scala 17:29]
  wire  FullAdder_3_io_b; // @[dut.scala 17:29]
  wire  FullAdder_3_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_3_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_3_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_4_io_a; // @[dut.scala 17:29]
  wire  FullAdder_4_io_b; // @[dut.scala 17:29]
  wire  FullAdder_4_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_4_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_4_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_5_io_a; // @[dut.scala 17:29]
  wire  FullAdder_5_io_b; // @[dut.scala 17:29]
  wire  FullAdder_5_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_5_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_5_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_6_io_a; // @[dut.scala 17:29]
  wire  FullAdder_6_io_b; // @[dut.scala 17:29]
  wire  FullAdder_6_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_6_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_6_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_7_io_a; // @[dut.scala 17:29]
  wire  FullAdder_7_io_b; // @[dut.scala 17:29]
  wire  FullAdder_7_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_7_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_7_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_8_io_a; // @[dut.scala 17:29]
  wire  FullAdder_8_io_b; // @[dut.scala 17:29]
  wire  FullAdder_8_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_8_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_8_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_9_io_a; // @[dut.scala 17:29]
  wire  FullAdder_9_io_b; // @[dut.scala 17:29]
  wire  FullAdder_9_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_9_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_9_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_10_io_a; // @[dut.scala 17:29]
  wire  FullAdder_10_io_b; // @[dut.scala 17:29]
  wire  FullAdder_10_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_10_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_10_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_11_io_a; // @[dut.scala 17:29]
  wire  FullAdder_11_io_b; // @[dut.scala 17:29]
  wire  FullAdder_11_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_11_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_11_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_12_io_a; // @[dut.scala 17:29]
  wire  FullAdder_12_io_b; // @[dut.scala 17:29]
  wire  FullAdder_12_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_12_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_12_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_13_io_a; // @[dut.scala 17:29]
  wire  FullAdder_13_io_b; // @[dut.scala 17:29]
  wire  FullAdder_13_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_13_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_13_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_14_io_a; // @[dut.scala 17:29]
  wire  FullAdder_14_io_b; // @[dut.scala 17:29]
  wire  FullAdder_14_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_14_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_14_io_cout; // @[dut.scala 17:29]
  wire  FullAdder_15_io_a; // @[dut.scala 17:29]
  wire  FullAdder_15_io_b; // @[dut.scala 17:29]
  wire  FullAdder_15_io_cin; // @[dut.scala 17:29]
  wire  FullAdder_15_io_sum; // @[dut.scala 17:29]
  wire  FullAdder_15_io_cout; // @[dut.scala 17:29]
  wire  sum_1 = FullAdder_1_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_0 = FullAdder_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_3 = FullAdder_3_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_2 = FullAdder_2_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_5 = FullAdder_5_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_4 = FullAdder_4_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_7 = FullAdder_7_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_6 = FullAdder_6_io_sum; // @[dut.scala 15:52 22:17]
  wire [7:0] io_sum_lo = {sum_7,sum_6,sum_5,sum_4,sum_3,sum_2,sum_1,sum_0}; // @[dut.scala 26:17]
  wire  sum_9 = FullAdder_9_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_8 = FullAdder_8_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_11 = FullAdder_11_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_10 = FullAdder_10_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_13 = FullAdder_13_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_12 = FullAdder_12_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_15 = FullAdder_15_io_sum; // @[dut.scala 15:52 22:17]
  wire  sum_14 = FullAdder_14_io_sum; // @[dut.scala 15:52 22:17]
  wire [7:0] io_sum_hi = {sum_15,sum_14,sum_13,sum_12,sum_11,sum_10,sum_9,sum_8}; // @[dut.scala 26:17]
  FullAdder FullAdder ( // @[dut.scala 17:29]
    .io_a(FullAdder_io_a),
    .io_b(FullAdder_io_b),
    .io_cin(FullAdder_io_cin),
    .io_sum(FullAdder_io_sum),
    .io_cout(FullAdder_io_cout)
  );
  FullAdder FullAdder_1 ( // @[dut.scala 17:29]
    .io_a(FullAdder_1_io_a),
    .io_b(FullAdder_1_io_b),
    .io_cin(FullAdder_1_io_cin),
    .io_sum(FullAdder_1_io_sum),
    .io_cout(FullAdder_1_io_cout)
  );
  FullAdder FullAdder_2 ( // @[dut.scala 17:29]
    .io_a(FullAdder_2_io_a),
    .io_b(FullAdder_2_io_b),
    .io_cin(FullAdder_2_io_cin),
    .io_sum(FullAdder_2_io_sum),
    .io_cout(FullAdder_2_io_cout)
  );
  FullAdder FullAdder_3 ( // @[dut.scala 17:29]
    .io_a(FullAdder_3_io_a),
    .io_b(FullAdder_3_io_b),
    .io_cin(FullAdder_3_io_cin),
    .io_sum(FullAdder_3_io_sum),
    .io_cout(FullAdder_3_io_cout)
  );
  FullAdder FullAdder_4 ( // @[dut.scala 17:29]
    .io_a(FullAdder_4_io_a),
    .io_b(FullAdder_4_io_b),
    .io_cin(FullAdder_4_io_cin),
    .io_sum(FullAdder_4_io_sum),
    .io_cout(FullAdder_4_io_cout)
  );
  FullAdder FullAdder_5 ( // @[dut.scala 17:29]
    .io_a(FullAdder_5_io_a),
    .io_b(FullAdder_5_io_b),
    .io_cin(FullAdder_5_io_cin),
    .io_sum(FullAdder_5_io_sum),
    .io_cout(FullAdder_5_io_cout)
  );
  FullAdder FullAdder_6 ( // @[dut.scala 17:29]
    .io_a(FullAdder_6_io_a),
    .io_b(FullAdder_6_io_b),
    .io_cin(FullAdder_6_io_cin),
    .io_sum(FullAdder_6_io_sum),
    .io_cout(FullAdder_6_io_cout)
  );
  FullAdder FullAdder_7 ( // @[dut.scala 17:29]
    .io_a(FullAdder_7_io_a),
    .io_b(FullAdder_7_io_b),
    .io_cin(FullAdder_7_io_cin),
    .io_sum(FullAdder_7_io_sum),
    .io_cout(FullAdder_7_io_cout)
  );
  FullAdder FullAdder_8 ( // @[dut.scala 17:29]
    .io_a(FullAdder_8_io_a),
    .io_b(FullAdder_8_io_b),
    .io_cin(FullAdder_8_io_cin),
    .io_sum(FullAdder_8_io_sum),
    .io_cout(FullAdder_8_io_cout)
  );
  FullAdder FullAdder_9 ( // @[dut.scala 17:29]
    .io_a(FullAdder_9_io_a),
    .io_b(FullAdder_9_io_b),
    .io_cin(FullAdder_9_io_cin),
    .io_sum(FullAdder_9_io_sum),
    .io_cout(FullAdder_9_io_cout)
  );
  FullAdder FullAdder_10 ( // @[dut.scala 17:29]
    .io_a(FullAdder_10_io_a),
    .io_b(FullAdder_10_io_b),
    .io_cin(FullAdder_10_io_cin),
    .io_sum(FullAdder_10_io_sum),
    .io_cout(FullAdder_10_io_cout)
  );
  FullAdder FullAdder_11 ( // @[dut.scala 17:29]
    .io_a(FullAdder_11_io_a),
    .io_b(FullAdder_11_io_b),
    .io_cin(FullAdder_11_io_cin),
    .io_sum(FullAdder_11_io_sum),
    .io_cout(FullAdder_11_io_cout)
  );
  FullAdder FullAdder_12 ( // @[dut.scala 17:29]
    .io_a(FullAdder_12_io_a),
    .io_b(FullAdder_12_io_b),
    .io_cin(FullAdder_12_io_cin),
    .io_sum(FullAdder_12_io_sum),
    .io_cout(FullAdder_12_io_cout)
  );
  FullAdder FullAdder_13 ( // @[dut.scala 17:29]
    .io_a(FullAdder_13_io_a),
    .io_b(FullAdder_13_io_b),
    .io_cin(FullAdder_13_io_cin),
    .io_sum(FullAdder_13_io_sum),
    .io_cout(FullAdder_13_io_cout)
  );
  FullAdder FullAdder_14 ( // @[dut.scala 17:29]
    .io_a(FullAdder_14_io_a),
    .io_b(FullAdder_14_io_b),
    .io_cin(FullAdder_14_io_cin),
    .io_sum(FullAdder_14_io_sum),
    .io_cout(FullAdder_14_io_cout)
  );
  FullAdder FullAdder_15 ( // @[dut.scala 17:29]
    .io_a(FullAdder_15_io_a),
    .io_b(FullAdder_15_io_b),
    .io_cin(FullAdder_15_io_cin),
    .io_sum(FullAdder_15_io_sum),
    .io_cout(FullAdder_15_io_cout)
  );
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 26:17]
  assign io_cout = FullAdder_15_io_cout; // @[dut.scala 27:11]
  assign FullAdder_io_a = io_a[0]; // @[dut.scala 18:29]
  assign FullAdder_io_b = io_b[0]; // @[dut.scala 19:29]
  assign FullAdder_io_cin = io_cin; // @[dut.scala 20:24]
  assign FullAdder_1_io_a = io_a[1]; // @[dut.scala 18:29]
  assign FullAdder_1_io_b = io_b[1]; // @[dut.scala 19:29]
  assign FullAdder_1_io_cin = FullAdder_io_cout; // @[dut.scala 20:24]
  assign FullAdder_2_io_a = io_a[2]; // @[dut.scala 18:29]
  assign FullAdder_2_io_b = io_b[2]; // @[dut.scala 19:29]
  assign FullAdder_2_io_cin = FullAdder_1_io_cout; // @[dut.scala 20:24]
  assign FullAdder_3_io_a = io_a[3]; // @[dut.scala 18:29]
  assign FullAdder_3_io_b = io_b[3]; // @[dut.scala 19:29]
  assign FullAdder_3_io_cin = FullAdder_2_io_cout; // @[dut.scala 20:24]
  assign FullAdder_4_io_a = io_a[4]; // @[dut.scala 18:29]
  assign FullAdder_4_io_b = io_b[4]; // @[dut.scala 19:29]
  assign FullAdder_4_io_cin = FullAdder_3_io_cout; // @[dut.scala 20:24]
  assign FullAdder_5_io_a = io_a[5]; // @[dut.scala 18:29]
  assign FullAdder_5_io_b = io_b[5]; // @[dut.scala 19:29]
  assign FullAdder_5_io_cin = FullAdder_4_io_cout; // @[dut.scala 20:24]
  assign FullAdder_6_io_a = io_a[6]; // @[dut.scala 18:29]
  assign FullAdder_6_io_b = io_b[6]; // @[dut.scala 19:29]
  assign FullAdder_6_io_cin = FullAdder_5_io_cout; // @[dut.scala 20:24]
  assign FullAdder_7_io_a = io_a[7]; // @[dut.scala 18:29]
  assign FullAdder_7_io_b = io_b[7]; // @[dut.scala 19:29]
  assign FullAdder_7_io_cin = FullAdder_6_io_cout; // @[dut.scala 20:24]
  assign FullAdder_8_io_a = io_a[8]; // @[dut.scala 18:29]
  assign FullAdder_8_io_b = io_b[8]; // @[dut.scala 19:29]
  assign FullAdder_8_io_cin = FullAdder_7_io_cout; // @[dut.scala 20:24]
  assign FullAdder_9_io_a = io_a[9]; // @[dut.scala 18:29]
  assign FullAdder_9_io_b = io_b[9]; // @[dut.scala 19:29]
  assign FullAdder_9_io_cin = FullAdder_8_io_cout; // @[dut.scala 20:24]
  assign FullAdder_10_io_a = io_a[10]; // @[dut.scala 18:29]
  assign FullAdder_10_io_b = io_b[10]; // @[dut.scala 19:29]
  assign FullAdder_10_io_cin = FullAdder_9_io_cout; // @[dut.scala 20:24]
  assign FullAdder_11_io_a = io_a[11]; // @[dut.scala 18:29]
  assign FullAdder_11_io_b = io_b[11]; // @[dut.scala 19:29]
  assign FullAdder_11_io_cin = FullAdder_10_io_cout; // @[dut.scala 20:24]
  assign FullAdder_12_io_a = io_a[12]; // @[dut.scala 18:29]
  assign FullAdder_12_io_b = io_b[12]; // @[dut.scala 19:29]
  assign FullAdder_12_io_cin = FullAdder_11_io_cout; // @[dut.scala 20:24]
  assign FullAdder_13_io_a = io_a[13]; // @[dut.scala 18:29]
  assign FullAdder_13_io_b = io_b[13]; // @[dut.scala 19:29]
  assign FullAdder_13_io_cin = FullAdder_12_io_cout; // @[dut.scala 20:24]
  assign FullAdder_14_io_a = io_a[14]; // @[dut.scala 18:29]
  assign FullAdder_14_io_b = io_b[14]; // @[dut.scala 19:29]
  assign FullAdder_14_io_cin = FullAdder_13_io_cout; // @[dut.scala 20:24]
  assign FullAdder_15_io_a = io_a[15]; // @[dut.scala 18:29]
  assign FullAdder_15_io_b = io_b[15]; // @[dut.scala 19:29]
  assign FullAdder_15_io_cin = FullAdder_14_io_cout; // @[dut.scala 20:24]
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
  wire [15:0] rca1_io_a; // @[dut.scala 64:20]
  wire [15:0] rca1_io_b; // @[dut.scala 64:20]
  wire  rca1_io_cin; // @[dut.scala 64:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 64:20]
  wire  rca1_io_cout; // @[dut.scala 64:20]
  wire [15:0] rca2_io_a; // @[dut.scala 71:20]
  wire [15:0] rca2_io_b; // @[dut.scala 71:20]
  wire  rca2_io_cin; // @[dut.scala 71:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 71:20]
  wire  rca2_io_cout; // @[dut.scala 71:20]
  wire [15:0] rca3_io_a; // @[dut.scala 78:20]
  wire [15:0] rca3_io_b; // @[dut.scala 78:20]
  wire  rca3_io_cin; // @[dut.scala 78:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 78:20]
  wire  rca3_io_cout; // @[dut.scala 78:20]
  wire [15:0] rca4_io_a; // @[dut.scala 85:20]
  wire [15:0] rca4_io_b; // @[dut.scala 85:20]
  wire  rca4_io_cin; // @[dut.scala 85:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 85:20]
  wire  rca4_io_cout; // @[dut.scala 85:20]
  reg [63:0] addaReg; // @[Reg.scala 35:20]
  reg [63:0] addbReg; // @[Reg.scala 35:20]
  reg  enPipeline_0; // @[dut.scala 56:27]
  reg  enPipeline_1; // @[dut.scala 56:27]
  reg  enPipeline_2; // @[dut.scala 56:27]
  reg  enPipeline_3; // @[dut.scala 56:27]
  reg [15:0] stage1Sum; // @[dut.scala 68:26]
  reg  stage1Cout; // @[dut.scala 69:27]
  reg [15:0] stage2Sum; // @[dut.scala 75:26]
  reg  stage2Cout; // @[dut.scala 76:27]
  reg [15:0] stage3Sum; // @[dut.scala 82:26]
  reg  stage3Cout; // @[dut.scala 83:27]
  reg [15:0] stage4Sum; // @[dut.scala 89:26]
  reg  stage4Cout; // @[dut.scala 90:27]
  wire [31:0] resultReg_lo = {stage2Sum,stage1Sum}; // @[Cat.scala 33:92]
  wire [32:0] resultReg_hi = {stage4Cout,stage4Sum,stage3Sum}; // @[Cat.scala 33:92]
  reg [64:0] resultReg; // @[dut.scala 93:26]
  RCA16 rca1 ( // @[dut.scala 64:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 71:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 78:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  RCA16 rca4 ( // @[dut.scala 85:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = resultReg; // @[dut.scala 94:13]
  assign io_o_en = enPipeline_3; // @[dut.scala 97:11]
  assign rca1_io_a = addaReg[15:0]; // @[dut.scala 65:23]
  assign rca1_io_b = addbReg[15:0]; // @[dut.scala 66:23]
  assign rca1_io_cin = 1'h0; // @[dut.scala 67:15]
  assign rca2_io_a = addaReg[31:16]; // @[dut.scala 72:23]
  assign rca2_io_b = addbReg[31:16]; // @[dut.scala 73:23]
  assign rca2_io_cin = stage1Cout; // @[dut.scala 74:15]
  assign rca3_io_a = addaReg[47:32]; // @[dut.scala 79:23]
  assign rca3_io_b = addbReg[47:32]; // @[dut.scala 80:23]
  assign rca3_io_cin = stage2Cout; // @[dut.scala 81:15]
  assign rca4_io_a = addaReg[63:48]; // @[dut.scala 86:23]
  assign rca4_io_b = addbReg[63:48]; // @[dut.scala 87:23]
  assign rca4_io_cin = stage3Cout; // @[dut.scala 88:15]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 35:20]
      addaReg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      addaReg <= io_adda; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      addbReg <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_i_en) begin // @[Reg.scala 36:18]
      addbReg <= io_addb; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 56:27]
      enPipeline_0 <= 1'h0; // @[dut.scala 56:27]
    end else begin
      enPipeline_0 <= io_i_en; // @[dut.scala 58:17]
    end
    if (reset) begin // @[dut.scala 56:27]
      enPipeline_1 <= 1'h0; // @[dut.scala 56:27]
    end else begin
      enPipeline_1 <= enPipeline_0; // @[dut.scala 60:19]
    end
    if (reset) begin // @[dut.scala 56:27]
      enPipeline_2 <= 1'h0; // @[dut.scala 56:27]
    end else begin
      enPipeline_2 <= enPipeline_1; // @[dut.scala 60:19]
    end
    if (reset) begin // @[dut.scala 56:27]
      enPipeline_3 <= 1'h0; // @[dut.scala 56:27]
    end else begin
      enPipeline_3 <= enPipeline_2; // @[dut.scala 60:19]
    end
    stage1Sum <= rca1_io_sum; // @[dut.scala 68:26]
    stage1Cout <= rca1_io_cout; // @[dut.scala 69:27]
    stage2Sum <= rca2_io_sum; // @[dut.scala 75:26]
    stage2Cout <= rca2_io_cout; // @[dut.scala 76:27]
    stage3Sum <= rca3_io_sum; // @[dut.scala 82:26]
    stage3Cout <= rca3_io_cout; // @[dut.scala 83:27]
    stage4Sum <= rca4_io_sum; // @[dut.scala 89:26]
    stage4Cout <= rca4_io_cout; // @[dut.scala 90:27]
    resultReg <= {resultReg_hi,resultReg_lo}; // @[Cat.scala 33:92]
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
  addaReg = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addbReg = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  enPipeline_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  enPipeline_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  enPipeline_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  enPipeline_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage1Sum = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  stage1Cout = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2Sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage2Cout = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3Sum = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  stage3Cout = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage4Sum = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  stage4Cout = _RAND_13[0:0];
  _RAND_14 = {3{`RANDOM}};
  resultReg = _RAND_14[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
