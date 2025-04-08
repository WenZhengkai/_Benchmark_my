module FullAdder(
  input   io_a,
  input   io_b,
  input   io_cin,
  output  io_sum,
  output  io_cout
);
  assign io_sum = io_a ^ io_b ^ io_cin; // @[dut.scala 41:25]
  assign io_cout = io_a & io_b | io_a & io_cin | io_b & io_cin; // @[dut.scala 42:46]
endmodule
module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  FullAdder_io_a; // @[dut.scala 14:41]
  wire  FullAdder_io_b; // @[dut.scala 14:41]
  wire  FullAdder_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_1_io_a; // @[dut.scala 14:41]
  wire  FullAdder_1_io_b; // @[dut.scala 14:41]
  wire  FullAdder_1_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_1_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_1_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_2_io_a; // @[dut.scala 14:41]
  wire  FullAdder_2_io_b; // @[dut.scala 14:41]
  wire  FullAdder_2_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_2_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_2_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_3_io_a; // @[dut.scala 14:41]
  wire  FullAdder_3_io_b; // @[dut.scala 14:41]
  wire  FullAdder_3_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_3_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_3_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_4_io_a; // @[dut.scala 14:41]
  wire  FullAdder_4_io_b; // @[dut.scala 14:41]
  wire  FullAdder_4_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_4_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_4_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_5_io_a; // @[dut.scala 14:41]
  wire  FullAdder_5_io_b; // @[dut.scala 14:41]
  wire  FullAdder_5_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_5_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_5_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_6_io_a; // @[dut.scala 14:41]
  wire  FullAdder_6_io_b; // @[dut.scala 14:41]
  wire  FullAdder_6_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_6_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_6_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_7_io_a; // @[dut.scala 14:41]
  wire  FullAdder_7_io_b; // @[dut.scala 14:41]
  wire  FullAdder_7_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_7_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_7_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_8_io_a; // @[dut.scala 14:41]
  wire  FullAdder_8_io_b; // @[dut.scala 14:41]
  wire  FullAdder_8_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_8_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_8_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_9_io_a; // @[dut.scala 14:41]
  wire  FullAdder_9_io_b; // @[dut.scala 14:41]
  wire  FullAdder_9_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_9_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_9_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_10_io_a; // @[dut.scala 14:41]
  wire  FullAdder_10_io_b; // @[dut.scala 14:41]
  wire  FullAdder_10_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_10_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_10_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_11_io_a; // @[dut.scala 14:41]
  wire  FullAdder_11_io_b; // @[dut.scala 14:41]
  wire  FullAdder_11_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_11_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_11_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_12_io_a; // @[dut.scala 14:41]
  wire  FullAdder_12_io_b; // @[dut.scala 14:41]
  wire  FullAdder_12_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_12_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_12_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_13_io_a; // @[dut.scala 14:41]
  wire  FullAdder_13_io_b; // @[dut.scala 14:41]
  wire  FullAdder_13_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_13_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_13_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_14_io_a; // @[dut.scala 14:41]
  wire  FullAdder_14_io_b; // @[dut.scala 14:41]
  wire  FullAdder_14_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_14_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_14_io_cout; // @[dut.scala 14:41]
  wire  FullAdder_15_io_a; // @[dut.scala 14:41]
  wire  FullAdder_15_io_b; // @[dut.scala 14:41]
  wire  FullAdder_15_io_cin; // @[dut.scala 14:41]
  wire  FullAdder_15_io_sum; // @[dut.scala 14:41]
  wire  FullAdder_15_io_cout; // @[dut.scala 14:41]
  wire [7:0] io_sum_lo = {FullAdder_7_io_sum,FullAdder_6_io_sum,FullAdder_5_io_sum,FullAdder_4_io_sum,FullAdder_3_io_sum
    ,FullAdder_2_io_sum,FullAdder_1_io_sum,FullAdder_io_sum}; // @[Cat.scala 33:92]
  wire [7:0] io_sum_hi = {FullAdder_15_io_sum,FullAdder_14_io_sum,FullAdder_13_io_sum,FullAdder_12_io_sum,
    FullAdder_11_io_sum,FullAdder_10_io_sum,FullAdder_9_io_sum,FullAdder_8_io_sum}; // @[Cat.scala 33:92]
  FullAdder FullAdder ( // @[dut.scala 14:41]
    .io_a(FullAdder_io_a),
    .io_b(FullAdder_io_b),
    .io_cin(FullAdder_io_cin),
    .io_sum(FullAdder_io_sum),
    .io_cout(FullAdder_io_cout)
  );
  FullAdder FullAdder_1 ( // @[dut.scala 14:41]
    .io_a(FullAdder_1_io_a),
    .io_b(FullAdder_1_io_b),
    .io_cin(FullAdder_1_io_cin),
    .io_sum(FullAdder_1_io_sum),
    .io_cout(FullAdder_1_io_cout)
  );
  FullAdder FullAdder_2 ( // @[dut.scala 14:41]
    .io_a(FullAdder_2_io_a),
    .io_b(FullAdder_2_io_b),
    .io_cin(FullAdder_2_io_cin),
    .io_sum(FullAdder_2_io_sum),
    .io_cout(FullAdder_2_io_cout)
  );
  FullAdder FullAdder_3 ( // @[dut.scala 14:41]
    .io_a(FullAdder_3_io_a),
    .io_b(FullAdder_3_io_b),
    .io_cin(FullAdder_3_io_cin),
    .io_sum(FullAdder_3_io_sum),
    .io_cout(FullAdder_3_io_cout)
  );
  FullAdder FullAdder_4 ( // @[dut.scala 14:41]
    .io_a(FullAdder_4_io_a),
    .io_b(FullAdder_4_io_b),
    .io_cin(FullAdder_4_io_cin),
    .io_sum(FullAdder_4_io_sum),
    .io_cout(FullAdder_4_io_cout)
  );
  FullAdder FullAdder_5 ( // @[dut.scala 14:41]
    .io_a(FullAdder_5_io_a),
    .io_b(FullAdder_5_io_b),
    .io_cin(FullAdder_5_io_cin),
    .io_sum(FullAdder_5_io_sum),
    .io_cout(FullAdder_5_io_cout)
  );
  FullAdder FullAdder_6 ( // @[dut.scala 14:41]
    .io_a(FullAdder_6_io_a),
    .io_b(FullAdder_6_io_b),
    .io_cin(FullAdder_6_io_cin),
    .io_sum(FullAdder_6_io_sum),
    .io_cout(FullAdder_6_io_cout)
  );
  FullAdder FullAdder_7 ( // @[dut.scala 14:41]
    .io_a(FullAdder_7_io_a),
    .io_b(FullAdder_7_io_b),
    .io_cin(FullAdder_7_io_cin),
    .io_sum(FullAdder_7_io_sum),
    .io_cout(FullAdder_7_io_cout)
  );
  FullAdder FullAdder_8 ( // @[dut.scala 14:41]
    .io_a(FullAdder_8_io_a),
    .io_b(FullAdder_8_io_b),
    .io_cin(FullAdder_8_io_cin),
    .io_sum(FullAdder_8_io_sum),
    .io_cout(FullAdder_8_io_cout)
  );
  FullAdder FullAdder_9 ( // @[dut.scala 14:41]
    .io_a(FullAdder_9_io_a),
    .io_b(FullAdder_9_io_b),
    .io_cin(FullAdder_9_io_cin),
    .io_sum(FullAdder_9_io_sum),
    .io_cout(FullAdder_9_io_cout)
  );
  FullAdder FullAdder_10 ( // @[dut.scala 14:41]
    .io_a(FullAdder_10_io_a),
    .io_b(FullAdder_10_io_b),
    .io_cin(FullAdder_10_io_cin),
    .io_sum(FullAdder_10_io_sum),
    .io_cout(FullAdder_10_io_cout)
  );
  FullAdder FullAdder_11 ( // @[dut.scala 14:41]
    .io_a(FullAdder_11_io_a),
    .io_b(FullAdder_11_io_b),
    .io_cin(FullAdder_11_io_cin),
    .io_sum(FullAdder_11_io_sum),
    .io_cout(FullAdder_11_io_cout)
  );
  FullAdder FullAdder_12 ( // @[dut.scala 14:41]
    .io_a(FullAdder_12_io_a),
    .io_b(FullAdder_12_io_b),
    .io_cin(FullAdder_12_io_cin),
    .io_sum(FullAdder_12_io_sum),
    .io_cout(FullAdder_12_io_cout)
  );
  FullAdder FullAdder_13 ( // @[dut.scala 14:41]
    .io_a(FullAdder_13_io_a),
    .io_b(FullAdder_13_io_b),
    .io_cin(FullAdder_13_io_cin),
    .io_sum(FullAdder_13_io_sum),
    .io_cout(FullAdder_13_io_cout)
  );
  FullAdder FullAdder_14 ( // @[dut.scala 14:41]
    .io_a(FullAdder_14_io_a),
    .io_b(FullAdder_14_io_b),
    .io_cin(FullAdder_14_io_cin),
    .io_sum(FullAdder_14_io_sum),
    .io_cout(FullAdder_14_io_cout)
  );
  FullAdder FullAdder_15 ( // @[dut.scala 14:41]
    .io_a(FullAdder_15_io_a),
    .io_b(FullAdder_15_io_b),
    .io_cin(FullAdder_15_io_cin),
    .io_sum(FullAdder_15_io_sum),
    .io_cout(FullAdder_15_io_cout)
  );
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[Cat.scala 33:92]
  assign io_cout = FullAdder_15_io_cout; // @[dut.scala 29:11]
  assign FullAdder_io_a = io_a[0]; // @[dut.scala 18:30]
  assign FullAdder_io_b = io_b[0]; // @[dut.scala 19:30]
  assign FullAdder_io_cin = io_cin; // @[dut.scala 20:25]
  assign FullAdder_1_io_a = io_a[1]; // @[dut.scala 22:30]
  assign FullAdder_1_io_b = io_b[1]; // @[dut.scala 23:30]
  assign FullAdder_1_io_cin = FullAdder_io_cout; // @[dut.scala 24:25]
  assign FullAdder_2_io_a = io_a[2]; // @[dut.scala 22:30]
  assign FullAdder_2_io_b = io_b[2]; // @[dut.scala 23:30]
  assign FullAdder_2_io_cin = FullAdder_1_io_cout; // @[dut.scala 24:25]
  assign FullAdder_3_io_a = io_a[3]; // @[dut.scala 22:30]
  assign FullAdder_3_io_b = io_b[3]; // @[dut.scala 23:30]
  assign FullAdder_3_io_cin = FullAdder_2_io_cout; // @[dut.scala 24:25]
  assign FullAdder_4_io_a = io_a[4]; // @[dut.scala 22:30]
  assign FullAdder_4_io_b = io_b[4]; // @[dut.scala 23:30]
  assign FullAdder_4_io_cin = FullAdder_3_io_cout; // @[dut.scala 24:25]
  assign FullAdder_5_io_a = io_a[5]; // @[dut.scala 22:30]
  assign FullAdder_5_io_b = io_b[5]; // @[dut.scala 23:30]
  assign FullAdder_5_io_cin = FullAdder_4_io_cout; // @[dut.scala 24:25]
  assign FullAdder_6_io_a = io_a[6]; // @[dut.scala 22:30]
  assign FullAdder_6_io_b = io_b[6]; // @[dut.scala 23:30]
  assign FullAdder_6_io_cin = FullAdder_5_io_cout; // @[dut.scala 24:25]
  assign FullAdder_7_io_a = io_a[7]; // @[dut.scala 22:30]
  assign FullAdder_7_io_b = io_b[7]; // @[dut.scala 23:30]
  assign FullAdder_7_io_cin = FullAdder_6_io_cout; // @[dut.scala 24:25]
  assign FullAdder_8_io_a = io_a[8]; // @[dut.scala 22:30]
  assign FullAdder_8_io_b = io_b[8]; // @[dut.scala 23:30]
  assign FullAdder_8_io_cin = FullAdder_7_io_cout; // @[dut.scala 24:25]
  assign FullAdder_9_io_a = io_a[9]; // @[dut.scala 22:30]
  assign FullAdder_9_io_b = io_b[9]; // @[dut.scala 23:30]
  assign FullAdder_9_io_cin = FullAdder_8_io_cout; // @[dut.scala 24:25]
  assign FullAdder_10_io_a = io_a[10]; // @[dut.scala 22:30]
  assign FullAdder_10_io_b = io_b[10]; // @[dut.scala 23:30]
  assign FullAdder_10_io_cin = FullAdder_9_io_cout; // @[dut.scala 24:25]
  assign FullAdder_11_io_a = io_a[11]; // @[dut.scala 22:30]
  assign FullAdder_11_io_b = io_b[11]; // @[dut.scala 23:30]
  assign FullAdder_11_io_cin = FullAdder_10_io_cout; // @[dut.scala 24:25]
  assign FullAdder_12_io_a = io_a[12]; // @[dut.scala 22:30]
  assign FullAdder_12_io_b = io_b[12]; // @[dut.scala 23:30]
  assign FullAdder_12_io_cin = FullAdder_11_io_cout; // @[dut.scala 24:25]
  assign FullAdder_13_io_a = io_a[13]; // @[dut.scala 22:30]
  assign FullAdder_13_io_b = io_b[13]; // @[dut.scala 23:30]
  assign FullAdder_13_io_cin = FullAdder_12_io_cout; // @[dut.scala 24:25]
  assign FullAdder_14_io_a = io_a[14]; // @[dut.scala 22:30]
  assign FullAdder_14_io_b = io_b[14]; // @[dut.scala 23:30]
  assign FullAdder_14_io_cin = FullAdder_13_io_cout; // @[dut.scala 24:25]
  assign FullAdder_15_io_a = io_a[15]; // @[dut.scala 22:30]
  assign FullAdder_15_io_b = io_b[15]; // @[dut.scala 23:30]
  assign FullAdder_15_io_cin = FullAdder_14_io_cout; // @[dut.scala 24:25]
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
  wire [15:0] rca2_io_a; // @[dut.scala 65:20]
  wire [15:0] rca2_io_b; // @[dut.scala 65:20]
  wire  rca2_io_cin; // @[dut.scala 65:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 65:20]
  wire  rca2_io_cout; // @[dut.scala 65:20]
  wire [15:0] rca3_io_a; // @[dut.scala 66:20]
  wire [15:0] rca3_io_b; // @[dut.scala 66:20]
  wire  rca3_io_cin; // @[dut.scala 66:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 66:20]
  wire  rca3_io_cout; // @[dut.scala 66:20]
  wire [15:0] rca4_io_a; // @[dut.scala 67:20]
  wire [15:0] rca4_io_b; // @[dut.scala 67:20]
  wire  rca4_io_cin; // @[dut.scala 67:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 67:20]
  wire  rca4_io_cout; // @[dut.scala 67:20]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 57:28]
  reg  en_pipeline_1; // @[dut.scala 57:28]
  reg  en_pipeline_2; // @[dut.scala 57:28]
  reg  en_pipeline_3; // @[dut.scala 57:28]
  reg [15:0] stage1_sum; // @[dut.scala 70:23]
  reg  stage1_cout; // @[dut.scala 71:24]
  reg [15:0] stage2_sum; // @[dut.scala 72:23]
  reg  stage2_cout; // @[dut.scala 73:24]
  reg [15:0] stage3_sum; // @[dut.scala 74:23]
  reg  stage3_cout; // @[dut.scala 75:24]
  reg [15:0] stage4_sum; // @[dut.scala 76:23]
  reg  stage4_cout; // @[dut.scala 77:24]
  reg [64:0] result_reg; // @[dut.scala 108:23]
  wire [31:0] result_reg_lo = {stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  wire [32:0] result_reg_hi = {stage4_cout,stage4_sum,stage3_sum}; // @[Cat.scala 33:92]
  RCA16 rca1 ( // @[dut.scala 64:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 65:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 66:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  RCA16 rca4 ( // @[dut.scala 67:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 110:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 113:11]
  assign rca1_io_a = adda_reg[15:0]; // @[dut.scala 80:24]
  assign rca1_io_b = addb_reg[15:0]; // @[dut.scala 81:24]
  assign rca1_io_cin = 1'h0; // @[dut.scala 82:15]
  assign rca2_io_a = adda_reg[31:16]; // @[dut.scala 87:24]
  assign rca2_io_b = addb_reg[31:16]; // @[dut.scala 88:24]
  assign rca2_io_cin = stage1_cout; // @[dut.scala 89:15]
  assign rca3_io_a = adda_reg[47:32]; // @[dut.scala 94:24]
  assign rca3_io_b = addb_reg[47:32]; // @[dut.scala 95:24]
  assign rca3_io_cin = stage2_cout; // @[dut.scala 96:15]
  assign rca4_io_a = adda_reg[63:48]; // @[dut.scala 101:24]
  assign rca4_io_b = addb_reg[63:48]; // @[dut.scala 102:24]
  assign rca4_io_cin = stage3_cout; // @[dut.scala 103:15]
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
    if (reset) begin // @[dut.scala 57:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 57:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 58:18]
    end
    if (reset) begin // @[dut.scala 57:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 57:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 60:20]
    end
    if (reset) begin // @[dut.scala 57:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 57:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 60:20]
    end
    if (reset) begin // @[dut.scala 57:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 57:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 60:20]
    end
    stage1_sum <= rca1_io_sum; // @[dut.scala 83:14]
    stage1_cout <= rca1_io_cout; // @[dut.scala 84:15]
    stage2_sum <= rca2_io_sum; // @[dut.scala 90:14]
    stage2_cout <= rca2_io_cout; // @[dut.scala 91:15]
    stage3_sum <= rca3_io_sum; // @[dut.scala 97:14]
    stage3_cout <= rca3_io_cout; // @[dut.scala 98:15]
    stage4_sum <= rca4_io_sum; // @[dut.scala 104:14]
    stage4_cout <= rca4_io_cout; // @[dut.scala 105:15]
    result_reg <= {result_reg_hi,result_reg_lo}; // @[Cat.scala 33:92]
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
