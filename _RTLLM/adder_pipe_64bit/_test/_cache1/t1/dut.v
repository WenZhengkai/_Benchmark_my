module FullAdder(
  input   io_a,
  input   io_b,
  input   io_cin,
  output  io_sum,
  output  io_cout
);
  assign io_sum = io_a ^ io_b ^ io_cin; // @[dut.scala 14:25]
  assign io_cout = io_a & io_b | io_a & io_cin | io_b & io_cin; // @[dut.scala 15:46]
endmodule
module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  fa_io_a; // @[dut.scala 37:20]
  wire  fa_io_b; // @[dut.scala 37:20]
  wire  fa_io_cin; // @[dut.scala 37:20]
  wire  fa_io_sum; // @[dut.scala 37:20]
  wire  fa_io_cout; // @[dut.scala 37:20]
  wire  fa_1_io_a; // @[dut.scala 37:20]
  wire  fa_1_io_b; // @[dut.scala 37:20]
  wire  fa_1_io_cin; // @[dut.scala 37:20]
  wire  fa_1_io_sum; // @[dut.scala 37:20]
  wire  fa_1_io_cout; // @[dut.scala 37:20]
  wire  fa_2_io_a; // @[dut.scala 37:20]
  wire  fa_2_io_b; // @[dut.scala 37:20]
  wire  fa_2_io_cin; // @[dut.scala 37:20]
  wire  fa_2_io_sum; // @[dut.scala 37:20]
  wire  fa_2_io_cout; // @[dut.scala 37:20]
  wire  fa_3_io_a; // @[dut.scala 37:20]
  wire  fa_3_io_b; // @[dut.scala 37:20]
  wire  fa_3_io_cin; // @[dut.scala 37:20]
  wire  fa_3_io_sum; // @[dut.scala 37:20]
  wire  fa_3_io_cout; // @[dut.scala 37:20]
  wire  fa_4_io_a; // @[dut.scala 37:20]
  wire  fa_4_io_b; // @[dut.scala 37:20]
  wire  fa_4_io_cin; // @[dut.scala 37:20]
  wire  fa_4_io_sum; // @[dut.scala 37:20]
  wire  fa_4_io_cout; // @[dut.scala 37:20]
  wire  fa_5_io_a; // @[dut.scala 37:20]
  wire  fa_5_io_b; // @[dut.scala 37:20]
  wire  fa_5_io_cin; // @[dut.scala 37:20]
  wire  fa_5_io_sum; // @[dut.scala 37:20]
  wire  fa_5_io_cout; // @[dut.scala 37:20]
  wire  fa_6_io_a; // @[dut.scala 37:20]
  wire  fa_6_io_b; // @[dut.scala 37:20]
  wire  fa_6_io_cin; // @[dut.scala 37:20]
  wire  fa_6_io_sum; // @[dut.scala 37:20]
  wire  fa_6_io_cout; // @[dut.scala 37:20]
  wire  fa_7_io_a; // @[dut.scala 37:20]
  wire  fa_7_io_b; // @[dut.scala 37:20]
  wire  fa_7_io_cin; // @[dut.scala 37:20]
  wire  fa_7_io_sum; // @[dut.scala 37:20]
  wire  fa_7_io_cout; // @[dut.scala 37:20]
  wire  fa_8_io_a; // @[dut.scala 37:20]
  wire  fa_8_io_b; // @[dut.scala 37:20]
  wire  fa_8_io_cin; // @[dut.scala 37:20]
  wire  fa_8_io_sum; // @[dut.scala 37:20]
  wire  fa_8_io_cout; // @[dut.scala 37:20]
  wire  fa_9_io_a; // @[dut.scala 37:20]
  wire  fa_9_io_b; // @[dut.scala 37:20]
  wire  fa_9_io_cin; // @[dut.scala 37:20]
  wire  fa_9_io_sum; // @[dut.scala 37:20]
  wire  fa_9_io_cout; // @[dut.scala 37:20]
  wire  fa_10_io_a; // @[dut.scala 37:20]
  wire  fa_10_io_b; // @[dut.scala 37:20]
  wire  fa_10_io_cin; // @[dut.scala 37:20]
  wire  fa_10_io_sum; // @[dut.scala 37:20]
  wire  fa_10_io_cout; // @[dut.scala 37:20]
  wire  fa_11_io_a; // @[dut.scala 37:20]
  wire  fa_11_io_b; // @[dut.scala 37:20]
  wire  fa_11_io_cin; // @[dut.scala 37:20]
  wire  fa_11_io_sum; // @[dut.scala 37:20]
  wire  fa_11_io_cout; // @[dut.scala 37:20]
  wire  fa_12_io_a; // @[dut.scala 37:20]
  wire  fa_12_io_b; // @[dut.scala 37:20]
  wire  fa_12_io_cin; // @[dut.scala 37:20]
  wire  fa_12_io_sum; // @[dut.scala 37:20]
  wire  fa_12_io_cout; // @[dut.scala 37:20]
  wire  fa_13_io_a; // @[dut.scala 37:20]
  wire  fa_13_io_b; // @[dut.scala 37:20]
  wire  fa_13_io_cin; // @[dut.scala 37:20]
  wire  fa_13_io_sum; // @[dut.scala 37:20]
  wire  fa_13_io_cout; // @[dut.scala 37:20]
  wire  fa_14_io_a; // @[dut.scala 37:20]
  wire  fa_14_io_b; // @[dut.scala 37:20]
  wire  fa_14_io_cin; // @[dut.scala 37:20]
  wire  fa_14_io_sum; // @[dut.scala 37:20]
  wire  fa_14_io_cout; // @[dut.scala 37:20]
  wire  fa_15_io_a; // @[dut.scala 37:20]
  wire  fa_15_io_b; // @[dut.scala 37:20]
  wire  fa_15_io_cin; // @[dut.scala 37:20]
  wire  fa_15_io_sum; // @[dut.scala 37:20]
  wire  fa_15_io_cout; // @[dut.scala 37:20]
  wire  sum_1 = fa_1_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_0 = fa_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_3 = fa_3_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_2 = fa_2_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_5 = fa_5_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_4 = fa_4_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_7 = fa_7_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_6 = fa_6_io_sum; // @[dut.scala 34:17 41:12]
  wire [7:0] io_sum_lo = {sum_7,sum_6,sum_5,sum_4,sum_3,sum_2,sum_1,sum_0}; // @[dut.scala 45:17]
  wire  sum_9 = fa_9_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_8 = fa_8_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_11 = fa_11_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_10 = fa_10_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_13 = fa_13_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_12 = fa_12_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_15 = fa_15_io_sum; // @[dut.scala 34:17 41:12]
  wire  sum_14 = fa_14_io_sum; // @[dut.scala 34:17 41:12]
  wire [7:0] io_sum_hi = {sum_15,sum_14,sum_13,sum_12,sum_11,sum_10,sum_9,sum_8}; // @[dut.scala 45:17]
  FullAdder fa ( // @[dut.scala 37:20]
    .io_a(fa_io_a),
    .io_b(fa_io_b),
    .io_cin(fa_io_cin),
    .io_sum(fa_io_sum),
    .io_cout(fa_io_cout)
  );
  FullAdder fa_1 ( // @[dut.scala 37:20]
    .io_a(fa_1_io_a),
    .io_b(fa_1_io_b),
    .io_cin(fa_1_io_cin),
    .io_sum(fa_1_io_sum),
    .io_cout(fa_1_io_cout)
  );
  FullAdder fa_2 ( // @[dut.scala 37:20]
    .io_a(fa_2_io_a),
    .io_b(fa_2_io_b),
    .io_cin(fa_2_io_cin),
    .io_sum(fa_2_io_sum),
    .io_cout(fa_2_io_cout)
  );
  FullAdder fa_3 ( // @[dut.scala 37:20]
    .io_a(fa_3_io_a),
    .io_b(fa_3_io_b),
    .io_cin(fa_3_io_cin),
    .io_sum(fa_3_io_sum),
    .io_cout(fa_3_io_cout)
  );
  FullAdder fa_4 ( // @[dut.scala 37:20]
    .io_a(fa_4_io_a),
    .io_b(fa_4_io_b),
    .io_cin(fa_4_io_cin),
    .io_sum(fa_4_io_sum),
    .io_cout(fa_4_io_cout)
  );
  FullAdder fa_5 ( // @[dut.scala 37:20]
    .io_a(fa_5_io_a),
    .io_b(fa_5_io_b),
    .io_cin(fa_5_io_cin),
    .io_sum(fa_5_io_sum),
    .io_cout(fa_5_io_cout)
  );
  FullAdder fa_6 ( // @[dut.scala 37:20]
    .io_a(fa_6_io_a),
    .io_b(fa_6_io_b),
    .io_cin(fa_6_io_cin),
    .io_sum(fa_6_io_sum),
    .io_cout(fa_6_io_cout)
  );
  FullAdder fa_7 ( // @[dut.scala 37:20]
    .io_a(fa_7_io_a),
    .io_b(fa_7_io_b),
    .io_cin(fa_7_io_cin),
    .io_sum(fa_7_io_sum),
    .io_cout(fa_7_io_cout)
  );
  FullAdder fa_8 ( // @[dut.scala 37:20]
    .io_a(fa_8_io_a),
    .io_b(fa_8_io_b),
    .io_cin(fa_8_io_cin),
    .io_sum(fa_8_io_sum),
    .io_cout(fa_8_io_cout)
  );
  FullAdder fa_9 ( // @[dut.scala 37:20]
    .io_a(fa_9_io_a),
    .io_b(fa_9_io_b),
    .io_cin(fa_9_io_cin),
    .io_sum(fa_9_io_sum),
    .io_cout(fa_9_io_cout)
  );
  FullAdder fa_10 ( // @[dut.scala 37:20]
    .io_a(fa_10_io_a),
    .io_b(fa_10_io_b),
    .io_cin(fa_10_io_cin),
    .io_sum(fa_10_io_sum),
    .io_cout(fa_10_io_cout)
  );
  FullAdder fa_11 ( // @[dut.scala 37:20]
    .io_a(fa_11_io_a),
    .io_b(fa_11_io_b),
    .io_cin(fa_11_io_cin),
    .io_sum(fa_11_io_sum),
    .io_cout(fa_11_io_cout)
  );
  FullAdder fa_12 ( // @[dut.scala 37:20]
    .io_a(fa_12_io_a),
    .io_b(fa_12_io_b),
    .io_cin(fa_12_io_cin),
    .io_sum(fa_12_io_sum),
    .io_cout(fa_12_io_cout)
  );
  FullAdder fa_13 ( // @[dut.scala 37:20]
    .io_a(fa_13_io_a),
    .io_b(fa_13_io_b),
    .io_cin(fa_13_io_cin),
    .io_sum(fa_13_io_sum),
    .io_cout(fa_13_io_cout)
  );
  FullAdder fa_14 ( // @[dut.scala 37:20]
    .io_a(fa_14_io_a),
    .io_b(fa_14_io_b),
    .io_cin(fa_14_io_cin),
    .io_sum(fa_14_io_sum),
    .io_cout(fa_14_io_cout)
  );
  FullAdder fa_15 ( // @[dut.scala 37:20]
    .io_a(fa_15_io_a),
    .io_b(fa_15_io_b),
    .io_cin(fa_15_io_cin),
    .io_sum(fa_15_io_sum),
    .io_cout(fa_15_io_cout)
  );
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 45:17]
  assign io_cout = fa_15_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_io_a = io_a[0]; // @[dut.scala 38:20]
  assign fa_io_b = io_b[0]; // @[dut.scala 39:20]
  assign fa_io_cin = io_cin; // @[dut.scala 31:19 32:12]
  assign fa_1_io_a = io_a[1]; // @[dut.scala 38:20]
  assign fa_1_io_b = io_b[1]; // @[dut.scala 39:20]
  assign fa_1_io_cin = fa_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_2_io_a = io_a[2]; // @[dut.scala 38:20]
  assign fa_2_io_b = io_b[2]; // @[dut.scala 39:20]
  assign fa_2_io_cin = fa_1_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_3_io_a = io_a[3]; // @[dut.scala 38:20]
  assign fa_3_io_b = io_b[3]; // @[dut.scala 39:20]
  assign fa_3_io_cin = fa_2_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_4_io_a = io_a[4]; // @[dut.scala 38:20]
  assign fa_4_io_b = io_b[4]; // @[dut.scala 39:20]
  assign fa_4_io_cin = fa_3_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_5_io_a = io_a[5]; // @[dut.scala 38:20]
  assign fa_5_io_b = io_b[5]; // @[dut.scala 39:20]
  assign fa_5_io_cin = fa_4_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_6_io_a = io_a[6]; // @[dut.scala 38:20]
  assign fa_6_io_b = io_b[6]; // @[dut.scala 39:20]
  assign fa_6_io_cin = fa_5_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_7_io_a = io_a[7]; // @[dut.scala 38:20]
  assign fa_7_io_b = io_b[7]; // @[dut.scala 39:20]
  assign fa_7_io_cin = fa_6_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_8_io_a = io_a[8]; // @[dut.scala 38:20]
  assign fa_8_io_b = io_b[8]; // @[dut.scala 39:20]
  assign fa_8_io_cin = fa_7_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_9_io_a = io_a[9]; // @[dut.scala 38:20]
  assign fa_9_io_b = io_b[9]; // @[dut.scala 39:20]
  assign fa_9_io_cin = fa_8_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_10_io_a = io_a[10]; // @[dut.scala 38:20]
  assign fa_10_io_b = io_b[10]; // @[dut.scala 39:20]
  assign fa_10_io_cin = fa_9_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_11_io_a = io_a[11]; // @[dut.scala 38:20]
  assign fa_11_io_b = io_b[11]; // @[dut.scala 39:20]
  assign fa_11_io_cin = fa_10_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_12_io_a = io_a[12]; // @[dut.scala 38:20]
  assign fa_12_io_b = io_b[12]; // @[dut.scala 39:20]
  assign fa_12_io_cin = fa_11_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_13_io_a = io_a[13]; // @[dut.scala 38:20]
  assign fa_13_io_b = io_b[13]; // @[dut.scala 39:20]
  assign fa_13_io_cin = fa_12_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_14_io_a = io_a[14]; // @[dut.scala 38:20]
  assign fa_14_io_b = io_b[14]; // @[dut.scala 39:20]
  assign fa_14_io_cin = fa_13_io_cout; // @[dut.scala 31:19 42:18]
  assign fa_15_io_a = io_a[15]; // @[dut.scala 38:20]
  assign fa_15_io_b = io_b[15]; // @[dut.scala 39:20]
  assign fa_15_io_cin = fa_14_io_cout; // @[dut.scala 31:19 42:18]
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
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] stage1_io_a; // @[dut.scala 74:22]
  wire [15:0] stage1_io_b; // @[dut.scala 74:22]
  wire  stage1_io_cin; // @[dut.scala 74:22]
  wire [15:0] stage1_io_sum; // @[dut.scala 74:22]
  wire  stage1_io_cout; // @[dut.scala 74:22]
  wire [15:0] stage2_io_a; // @[dut.scala 82:22]
  wire [15:0] stage2_io_b; // @[dut.scala 82:22]
  wire  stage2_io_cin; // @[dut.scala 82:22]
  wire [15:0] stage2_io_sum; // @[dut.scala 82:22]
  wire  stage2_io_cout; // @[dut.scala 82:22]
  wire [15:0] stage3_io_a; // @[dut.scala 90:22]
  wire [15:0] stage3_io_b; // @[dut.scala 90:22]
  wire  stage3_io_cin; // @[dut.scala 90:22]
  wire [15:0] stage3_io_sum; // @[dut.scala 90:22]
  wire  stage3_io_cout; // @[dut.scala 90:22]
  wire [15:0] stage4_io_a; // @[dut.scala 98:22]
  wire [15:0] stage4_io_b; // @[dut.scala 98:22]
  wire  stage4_io_cin; // @[dut.scala 98:22]
  wire [15:0] stage4_io_sum; // @[dut.scala 98:22]
  wire  stage4_io_cout; // @[dut.scala 98:22]
  reg [63:0] addaReg; // @[Reg.scala 35:20]
  reg [63:0] addbReg; // @[Reg.scala 35:20]
  reg  enPipeline_0; // @[dut.scala 63:27]
  reg  enPipeline_1; // @[dut.scala 63:27]
  reg  enPipeline_2; // @[dut.scala 63:27]
  reg  enPipeline_3; // @[dut.scala 63:27]
  reg [15:0] stage1SumReg; // @[Reg.scala 35:20]
  reg  carry1Reg; // @[Reg.scala 35:20]
  reg [15:0] stage2SumReg; // @[Reg.scala 35:20]
  reg  carry2Reg; // @[Reg.scala 35:20]
  reg [15:0] stage3SumReg; // @[Reg.scala 35:20]
  reg  carry3Reg; // @[Reg.scala 35:20]
  reg [15:0] stage4SumReg; // @[Reg.scala 35:20]
  reg  finalCarryReg; // @[Reg.scala 35:20]
  wire [64:0] _resultReg_T = {finalCarryReg,stage4SumReg,stage3SumReg,stage2SumReg,stage1SumReg}; // @[Cat.scala 33:92]
  reg [64:0] resultReg; // @[dut.scala 107:26]
  reg  io_o_en_REG; // @[dut.scala 112:21]
  RCA16 stage1 ( // @[dut.scala 74:22]
    .io_a(stage1_io_a),
    .io_b(stage1_io_b),
    .io_cin(stage1_io_cin),
    .io_sum(stage1_io_sum),
    .io_cout(stage1_io_cout)
  );
  RCA16 stage2 ( // @[dut.scala 82:22]
    .io_a(stage2_io_a),
    .io_b(stage2_io_b),
    .io_cin(stage2_io_cin),
    .io_sum(stage2_io_sum),
    .io_cout(stage2_io_cout)
  );
  RCA16 stage3 ( // @[dut.scala 90:22]
    .io_a(stage3_io_a),
    .io_b(stage3_io_b),
    .io_cin(stage3_io_cin),
    .io_sum(stage3_io_sum),
    .io_cout(stage3_io_cout)
  );
  RCA16 stage4 ( // @[dut.scala 98:22]
    .io_a(stage4_io_a),
    .io_b(stage4_io_b),
    .io_cin(stage4_io_cin),
    .io_sum(stage4_io_sum),
    .io_cout(stage4_io_cout)
  );
  assign io_result = resultReg; // @[dut.scala 109:13]
  assign io_o_en = io_o_en_REG; // @[dut.scala 112:11]
  assign stage1_io_a = addaReg[15:0]; // @[dut.scala 75:25]
  assign stage1_io_b = addbReg[15:0]; // @[dut.scala 76:25]
  assign stage1_io_cin = 1'h0; // @[dut.scala 77:17]
  assign stage2_io_a = addaReg[31:16]; // @[dut.scala 83:25]
  assign stage2_io_b = addbReg[31:16]; // @[dut.scala 84:25]
  assign stage2_io_cin = carry1Reg; // @[dut.scala 85:17]
  assign stage3_io_a = addaReg[47:32]; // @[dut.scala 91:25]
  assign stage3_io_b = addbReg[47:32]; // @[dut.scala 92:25]
  assign stage3_io_cin = carry2Reg; // @[dut.scala 93:17]
  assign stage4_io_a = addaReg[63:48]; // @[dut.scala 99:25]
  assign stage4_io_b = addbReg[63:48]; // @[dut.scala 100:25]
  assign stage4_io_cin = carry3Reg; // @[dut.scala 101:17]
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
    if (reset) begin // @[dut.scala 63:27]
      enPipeline_0 <= 1'h0; // @[dut.scala 63:27]
    end else begin
      enPipeline_0 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 63:27]
      enPipeline_1 <= 1'h0; // @[dut.scala 63:27]
    end else begin
      enPipeline_1 <= enPipeline_0; // @[dut.scala 70:19]
    end
    if (reset) begin // @[dut.scala 63:27]
      enPipeline_2 <= 1'h0; // @[dut.scala 63:27]
    end else begin
      enPipeline_2 <= enPipeline_1; // @[dut.scala 70:19]
    end
    if (reset) begin // @[dut.scala 63:27]
      enPipeline_3 <= 1'h0; // @[dut.scala 63:27]
    end else begin
      enPipeline_3 <= enPipeline_2; // @[dut.scala 70:19]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage1SumReg <= 16'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_0) begin // @[Reg.scala 36:18]
      stage1SumReg <= stage1_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      carry1Reg <= 1'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_0) begin // @[Reg.scala 36:18]
      carry1Reg <= stage1_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage2SumReg <= 16'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_1) begin // @[Reg.scala 36:18]
      stage2SumReg <= stage2_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      carry2Reg <= 1'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_1) begin // @[Reg.scala 36:18]
      carry2Reg <= stage2_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage3SumReg <= 16'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_2) begin // @[Reg.scala 36:18]
      stage3SumReg <= stage3_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      carry3Reg <= 1'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_2) begin // @[Reg.scala 36:18]
      carry3Reg <= stage3_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      stage4SumReg <= 16'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_3) begin // @[Reg.scala 36:18]
      stage4SumReg <= stage4_io_sum; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      finalCarryReg <= 1'h0; // @[Reg.scala 35:20]
    end else if (enPipeline_3) begin // @[Reg.scala 36:18]
      finalCarryReg <= stage4_io_cout; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 107:26]
      resultReg <= 65'h0; // @[dut.scala 107:26]
    end else begin
      resultReg <= _resultReg_T; // @[dut.scala 107:26]
    end
    if (reset) begin // @[dut.scala 112:21]
      io_o_en_REG <= 1'h0; // @[dut.scala 112:21]
    end else begin
      io_o_en_REG <= enPipeline_3; // @[dut.scala 112:21]
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
  stage1SumReg = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  carry1Reg = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  stage2SumReg = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  carry2Reg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3SumReg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry3Reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage4SumReg = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  finalCarryReg = _RAND_13[0:0];
  _RAND_14 = {3{`RANDOM}};
  resultReg = _RAND_14[64:0];
  _RAND_15 = {1{`RANDOM}};
  io_o_en_REG = _RAND_15[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
