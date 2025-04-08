module FullAdder(
  input   io_a,
  input   io_b,
  input   io_cin,
  output  io_sum,
  output  io_cout
);
  assign io_sum = io_a ^ io_b ^ io_cin; // @[dut.scala 34:25]
  assign io_cout = io_a & io_b | io_b & io_cin | io_a & io_cin; // @[dut.scala 35:46]
endmodule
module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  FullAdder_io_a; // @[dut.scala 14:27]
  wire  FullAdder_io_b; // @[dut.scala 14:27]
  wire  FullAdder_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_1_io_a; // @[dut.scala 14:27]
  wire  FullAdder_1_io_b; // @[dut.scala 14:27]
  wire  FullAdder_1_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_1_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_1_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_2_io_a; // @[dut.scala 14:27]
  wire  FullAdder_2_io_b; // @[dut.scala 14:27]
  wire  FullAdder_2_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_2_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_2_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_3_io_a; // @[dut.scala 14:27]
  wire  FullAdder_3_io_b; // @[dut.scala 14:27]
  wire  FullAdder_3_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_3_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_3_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_4_io_a; // @[dut.scala 14:27]
  wire  FullAdder_4_io_b; // @[dut.scala 14:27]
  wire  FullAdder_4_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_4_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_4_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_5_io_a; // @[dut.scala 14:27]
  wire  FullAdder_5_io_b; // @[dut.scala 14:27]
  wire  FullAdder_5_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_5_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_5_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_6_io_a; // @[dut.scala 14:27]
  wire  FullAdder_6_io_b; // @[dut.scala 14:27]
  wire  FullAdder_6_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_6_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_6_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_7_io_a; // @[dut.scala 14:27]
  wire  FullAdder_7_io_b; // @[dut.scala 14:27]
  wire  FullAdder_7_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_7_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_7_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_8_io_a; // @[dut.scala 14:27]
  wire  FullAdder_8_io_b; // @[dut.scala 14:27]
  wire  FullAdder_8_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_8_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_8_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_9_io_a; // @[dut.scala 14:27]
  wire  FullAdder_9_io_b; // @[dut.scala 14:27]
  wire  FullAdder_9_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_9_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_9_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_10_io_a; // @[dut.scala 14:27]
  wire  FullAdder_10_io_b; // @[dut.scala 14:27]
  wire  FullAdder_10_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_10_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_10_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_11_io_a; // @[dut.scala 14:27]
  wire  FullAdder_11_io_b; // @[dut.scala 14:27]
  wire  FullAdder_11_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_11_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_11_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_12_io_a; // @[dut.scala 14:27]
  wire  FullAdder_12_io_b; // @[dut.scala 14:27]
  wire  FullAdder_12_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_12_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_12_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_13_io_a; // @[dut.scala 14:27]
  wire  FullAdder_13_io_b; // @[dut.scala 14:27]
  wire  FullAdder_13_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_13_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_13_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_14_io_a; // @[dut.scala 14:27]
  wire  FullAdder_14_io_b; // @[dut.scala 14:27]
  wire  FullAdder_14_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_14_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_14_io_cout; // @[dut.scala 14:27]
  wire  FullAdder_15_io_a; // @[dut.scala 14:27]
  wire  FullAdder_15_io_b; // @[dut.scala 14:27]
  wire  FullAdder_15_io_cin; // @[dut.scala 14:27]
  wire  FullAdder_15_io_sum; // @[dut.scala 14:27]
  wire  FullAdder_15_io_cout; // @[dut.scala 14:27]
  wire  _T_2 = FullAdder_io_sum; // @[dut.scala 18:28]
  wire [15:0] _T_3 = {{15'd0}, _T_2}; // @[dut.scala 18:8]
  wire [1:0] _T_6 = {FullAdder_1_io_sum, 1'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_0 = {{14'd0}, _T_6}; // @[dut.scala 18:8]
  wire [15:0] _T_7 = _T_3 | _GEN_0; // @[dut.scala 18:8]
  wire [2:0] _T_10 = {FullAdder_2_io_sum, 2'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_1 = {{13'd0}, _T_10}; // @[dut.scala 18:8]
  wire [15:0] _T_11 = _T_7 | _GEN_1; // @[dut.scala 18:8]
  wire [3:0] _T_14 = {FullAdder_3_io_sum, 3'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_2 = {{12'd0}, _T_14}; // @[dut.scala 18:8]
  wire [15:0] _T_15 = _T_11 | _GEN_2; // @[dut.scala 18:8]
  wire [4:0] _T_18 = {FullAdder_4_io_sum, 4'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_3 = {{11'd0}, _T_18}; // @[dut.scala 18:8]
  wire [15:0] _T_19 = _T_15 | _GEN_3; // @[dut.scala 18:8]
  wire [5:0] _T_22 = {FullAdder_5_io_sum, 5'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_4 = {{10'd0}, _T_22}; // @[dut.scala 18:8]
  wire [15:0] _T_23 = _T_19 | _GEN_4; // @[dut.scala 18:8]
  wire [6:0] _T_26 = {FullAdder_6_io_sum, 6'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_5 = {{9'd0}, _T_26}; // @[dut.scala 18:8]
  wire [15:0] _T_27 = _T_23 | _GEN_5; // @[dut.scala 18:8]
  wire [7:0] _T_30 = {FullAdder_7_io_sum, 7'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_6 = {{8'd0}, _T_30}; // @[dut.scala 18:8]
  wire [15:0] _T_31 = _T_27 | _GEN_6; // @[dut.scala 18:8]
  wire [8:0] _T_34 = {FullAdder_8_io_sum, 8'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_7 = {{7'd0}, _T_34}; // @[dut.scala 18:8]
  wire [15:0] _T_35 = _T_31 | _GEN_7; // @[dut.scala 18:8]
  wire [9:0] _T_38 = {FullAdder_9_io_sum, 9'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_8 = {{6'd0}, _T_38}; // @[dut.scala 18:8]
  wire [15:0] _T_39 = _T_35 | _GEN_8; // @[dut.scala 18:8]
  wire [10:0] _T_42 = {FullAdder_10_io_sum, 10'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_9 = {{5'd0}, _T_42}; // @[dut.scala 18:8]
  wire [15:0] _T_43 = _T_39 | _GEN_9; // @[dut.scala 18:8]
  wire [11:0] _T_46 = {FullAdder_11_io_sum, 11'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_10 = {{4'd0}, _T_46}; // @[dut.scala 18:8]
  wire [15:0] _T_47 = _T_43 | _GEN_10; // @[dut.scala 18:8]
  wire [12:0] _T_50 = {FullAdder_12_io_sum, 12'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_11 = {{3'd0}, _T_50}; // @[dut.scala 18:8]
  wire [15:0] _T_51 = _T_47 | _GEN_11; // @[dut.scala 18:8]
  wire [13:0] _T_54 = {FullAdder_13_io_sum, 13'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_12 = {{2'd0}, _T_54}; // @[dut.scala 18:8]
  wire [15:0] _T_55 = _T_51 | _GEN_12; // @[dut.scala 18:8]
  wire [14:0] _T_58 = {FullAdder_14_io_sum, 14'h0}; // @[dut.scala 18:28]
  wire [15:0] _GEN_13 = {{1'd0}, _T_58}; // @[dut.scala 18:8]
  wire [15:0] _T_59 = _T_55 | _GEN_13; // @[dut.scala 18:8]
  wire [15:0] _T_62 = {FullAdder_15_io_sum, 15'h0}; // @[dut.scala 18:28]
  FullAdder FullAdder ( // @[dut.scala 14:27]
    .io_a(FullAdder_io_a),
    .io_b(FullAdder_io_b),
    .io_cin(FullAdder_io_cin),
    .io_sum(FullAdder_io_sum),
    .io_cout(FullAdder_io_cout)
  );
  FullAdder FullAdder_1 ( // @[dut.scala 14:27]
    .io_a(FullAdder_1_io_a),
    .io_b(FullAdder_1_io_b),
    .io_cin(FullAdder_1_io_cin),
    .io_sum(FullAdder_1_io_sum),
    .io_cout(FullAdder_1_io_cout)
  );
  FullAdder FullAdder_2 ( // @[dut.scala 14:27]
    .io_a(FullAdder_2_io_a),
    .io_b(FullAdder_2_io_b),
    .io_cin(FullAdder_2_io_cin),
    .io_sum(FullAdder_2_io_sum),
    .io_cout(FullAdder_2_io_cout)
  );
  FullAdder FullAdder_3 ( // @[dut.scala 14:27]
    .io_a(FullAdder_3_io_a),
    .io_b(FullAdder_3_io_b),
    .io_cin(FullAdder_3_io_cin),
    .io_sum(FullAdder_3_io_sum),
    .io_cout(FullAdder_3_io_cout)
  );
  FullAdder FullAdder_4 ( // @[dut.scala 14:27]
    .io_a(FullAdder_4_io_a),
    .io_b(FullAdder_4_io_b),
    .io_cin(FullAdder_4_io_cin),
    .io_sum(FullAdder_4_io_sum),
    .io_cout(FullAdder_4_io_cout)
  );
  FullAdder FullAdder_5 ( // @[dut.scala 14:27]
    .io_a(FullAdder_5_io_a),
    .io_b(FullAdder_5_io_b),
    .io_cin(FullAdder_5_io_cin),
    .io_sum(FullAdder_5_io_sum),
    .io_cout(FullAdder_5_io_cout)
  );
  FullAdder FullAdder_6 ( // @[dut.scala 14:27]
    .io_a(FullAdder_6_io_a),
    .io_b(FullAdder_6_io_b),
    .io_cin(FullAdder_6_io_cin),
    .io_sum(FullAdder_6_io_sum),
    .io_cout(FullAdder_6_io_cout)
  );
  FullAdder FullAdder_7 ( // @[dut.scala 14:27]
    .io_a(FullAdder_7_io_a),
    .io_b(FullAdder_7_io_b),
    .io_cin(FullAdder_7_io_cin),
    .io_sum(FullAdder_7_io_sum),
    .io_cout(FullAdder_7_io_cout)
  );
  FullAdder FullAdder_8 ( // @[dut.scala 14:27]
    .io_a(FullAdder_8_io_a),
    .io_b(FullAdder_8_io_b),
    .io_cin(FullAdder_8_io_cin),
    .io_sum(FullAdder_8_io_sum),
    .io_cout(FullAdder_8_io_cout)
  );
  FullAdder FullAdder_9 ( // @[dut.scala 14:27]
    .io_a(FullAdder_9_io_a),
    .io_b(FullAdder_9_io_b),
    .io_cin(FullAdder_9_io_cin),
    .io_sum(FullAdder_9_io_sum),
    .io_cout(FullAdder_9_io_cout)
  );
  FullAdder FullAdder_10 ( // @[dut.scala 14:27]
    .io_a(FullAdder_10_io_a),
    .io_b(FullAdder_10_io_b),
    .io_cin(FullAdder_10_io_cin),
    .io_sum(FullAdder_10_io_sum),
    .io_cout(FullAdder_10_io_cout)
  );
  FullAdder FullAdder_11 ( // @[dut.scala 14:27]
    .io_a(FullAdder_11_io_a),
    .io_b(FullAdder_11_io_b),
    .io_cin(FullAdder_11_io_cin),
    .io_sum(FullAdder_11_io_sum),
    .io_cout(FullAdder_11_io_cout)
  );
  FullAdder FullAdder_12 ( // @[dut.scala 14:27]
    .io_a(FullAdder_12_io_a),
    .io_b(FullAdder_12_io_b),
    .io_cin(FullAdder_12_io_cin),
    .io_sum(FullAdder_12_io_sum),
    .io_cout(FullAdder_12_io_cout)
  );
  FullAdder FullAdder_13 ( // @[dut.scala 14:27]
    .io_a(FullAdder_13_io_a),
    .io_b(FullAdder_13_io_b),
    .io_cin(FullAdder_13_io_cin),
    .io_sum(FullAdder_13_io_sum),
    .io_cout(FullAdder_13_io_cout)
  );
  FullAdder FullAdder_14 ( // @[dut.scala 14:27]
    .io_a(FullAdder_14_io_a),
    .io_b(FullAdder_14_io_b),
    .io_cin(FullAdder_14_io_cin),
    .io_sum(FullAdder_14_io_sum),
    .io_cout(FullAdder_14_io_cout)
  );
  FullAdder FullAdder_15 ( // @[dut.scala 14:27]
    .io_a(FullAdder_15_io_a),
    .io_b(FullAdder_15_io_b),
    .io_cin(FullAdder_15_io_cin),
    .io_sum(FullAdder_15_io_sum),
    .io_cout(FullAdder_15_io_cout)
  );
  assign io_sum = _T_59 | _T_62; // @[dut.scala 18:8]
  assign io_cout = FullAdder_15_io_cout; // @[dut.scala 22:11]
  assign FullAdder_io_a = io_a[0]; // @[dut.scala 15:27]
  assign FullAdder_io_b = io_b[0]; // @[dut.scala 16:27]
  assign FullAdder_io_cin = io_cin; // @[dut.scala 17:22]
  assign FullAdder_1_io_a = io_a[1]; // @[dut.scala 15:27]
  assign FullAdder_1_io_b = io_b[1]; // @[dut.scala 16:27]
  assign FullAdder_1_io_cin = FullAdder_io_cout; // @[dut.scala 17:22]
  assign FullAdder_2_io_a = io_a[2]; // @[dut.scala 15:27]
  assign FullAdder_2_io_b = io_b[2]; // @[dut.scala 16:27]
  assign FullAdder_2_io_cin = FullAdder_1_io_cout; // @[dut.scala 17:22]
  assign FullAdder_3_io_a = io_a[3]; // @[dut.scala 15:27]
  assign FullAdder_3_io_b = io_b[3]; // @[dut.scala 16:27]
  assign FullAdder_3_io_cin = FullAdder_2_io_cout; // @[dut.scala 17:22]
  assign FullAdder_4_io_a = io_a[4]; // @[dut.scala 15:27]
  assign FullAdder_4_io_b = io_b[4]; // @[dut.scala 16:27]
  assign FullAdder_4_io_cin = FullAdder_3_io_cout; // @[dut.scala 17:22]
  assign FullAdder_5_io_a = io_a[5]; // @[dut.scala 15:27]
  assign FullAdder_5_io_b = io_b[5]; // @[dut.scala 16:27]
  assign FullAdder_5_io_cin = FullAdder_4_io_cout; // @[dut.scala 17:22]
  assign FullAdder_6_io_a = io_a[6]; // @[dut.scala 15:27]
  assign FullAdder_6_io_b = io_b[6]; // @[dut.scala 16:27]
  assign FullAdder_6_io_cin = FullAdder_5_io_cout; // @[dut.scala 17:22]
  assign FullAdder_7_io_a = io_a[7]; // @[dut.scala 15:27]
  assign FullAdder_7_io_b = io_b[7]; // @[dut.scala 16:27]
  assign FullAdder_7_io_cin = FullAdder_6_io_cout; // @[dut.scala 17:22]
  assign FullAdder_8_io_a = io_a[8]; // @[dut.scala 15:27]
  assign FullAdder_8_io_b = io_b[8]; // @[dut.scala 16:27]
  assign FullAdder_8_io_cin = FullAdder_7_io_cout; // @[dut.scala 17:22]
  assign FullAdder_9_io_a = io_a[9]; // @[dut.scala 15:27]
  assign FullAdder_9_io_b = io_b[9]; // @[dut.scala 16:27]
  assign FullAdder_9_io_cin = FullAdder_8_io_cout; // @[dut.scala 17:22]
  assign FullAdder_10_io_a = io_a[10]; // @[dut.scala 15:27]
  assign FullAdder_10_io_b = io_b[10]; // @[dut.scala 16:27]
  assign FullAdder_10_io_cin = FullAdder_9_io_cout; // @[dut.scala 17:22]
  assign FullAdder_11_io_a = io_a[11]; // @[dut.scala 15:27]
  assign FullAdder_11_io_b = io_b[11]; // @[dut.scala 16:27]
  assign FullAdder_11_io_cin = FullAdder_10_io_cout; // @[dut.scala 17:22]
  assign FullAdder_12_io_a = io_a[12]; // @[dut.scala 15:27]
  assign FullAdder_12_io_b = io_b[12]; // @[dut.scala 16:27]
  assign FullAdder_12_io_cin = FullAdder_11_io_cout; // @[dut.scala 17:22]
  assign FullAdder_13_io_a = io_a[13]; // @[dut.scala 15:27]
  assign FullAdder_13_io_b = io_b[13]; // @[dut.scala 16:27]
  assign FullAdder_13_io_cin = FullAdder_12_io_cout; // @[dut.scala 17:22]
  assign FullAdder_14_io_a = io_a[14]; // @[dut.scala 15:27]
  assign FullAdder_14_io_b = io_b[14]; // @[dut.scala 16:27]
  assign FullAdder_14_io_cin = FullAdder_13_io_cout; // @[dut.scala 17:22]
  assign FullAdder_15_io_a = io_a[15]; // @[dut.scala 15:27]
  assign FullAdder_15_io_b = io_b[15]; // @[dut.scala 16:27]
  assign FullAdder_15_io_cin = FullAdder_14_io_cout; // @[dut.scala 17:22]
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
  reg [31:0] _RAND_14;
  reg [95:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] rca_io_a; // @[dut.scala 62:21]
  wire [15:0] rca_io_b; // @[dut.scala 62:21]
  wire  rca_io_cin; // @[dut.scala 62:21]
  wire [15:0] rca_io_sum; // @[dut.scala 62:21]
  wire  rca_io_cout; // @[dut.scala 62:21]
  wire [15:0] rca_1_io_a; // @[dut.scala 62:21]
  wire [15:0] rca_1_io_b; // @[dut.scala 62:21]
  wire  rca_1_io_cin; // @[dut.scala 62:21]
  wire [15:0] rca_1_io_sum; // @[dut.scala 62:21]
  wire  rca_1_io_cout; // @[dut.scala 62:21]
  wire [15:0] rca_2_io_a; // @[dut.scala 62:21]
  wire [15:0] rca_2_io_b; // @[dut.scala 62:21]
  wire  rca_2_io_cin; // @[dut.scala 62:21]
  wire [15:0] rca_2_io_sum; // @[dut.scala 62:21]
  wire  rca_2_io_cout; // @[dut.scala 62:21]
  wire [15:0] rca_3_io_a; // @[dut.scala 62:21]
  wire [15:0] rca_3_io_b; // @[dut.scala 62:21]
  wire  rca_3_io_cin; // @[dut.scala 62:21]
  wire [15:0] rca_3_io_sum; // @[dut.scala 62:21]
  wire  rca_3_io_cout; // @[dut.scala 62:21]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 50:28]
  reg  en_pipeline_1; // @[dut.scala 50:28]
  reg  en_pipeline_2; // @[dut.scala 50:28]
  reg  en_pipeline_3; // @[dut.scala 50:28]
  reg [15:0] r; // @[Reg.scala 19:16]
  reg [15:0] r_1; // @[Reg.scala 19:16]
  reg  r_2; // @[Reg.scala 19:16]
  reg [15:0] r_3; // @[Reg.scala 19:16]
  reg [15:0] r_4; // @[Reg.scala 19:16]
  reg  r_5; // @[Reg.scala 19:16]
  reg [15:0] r_6; // @[Reg.scala 19:16]
  reg [15:0] r_7; // @[Reg.scala 19:16]
  reg  r_8; // @[Reg.scala 19:16]
  wire [64:0] _result_reg_T = {rca_3_io_cout,rca_3_io_sum,rca_2_io_sum,rca_1_io_sum,rca_io_sum}; // @[Cat.scala 33:92]
  reg [64:0] result_reg; // @[Reg.scala 19:16]
  RCA16 rca ( // @[dut.scala 62:21]
    .io_a(rca_io_a),
    .io_b(rca_io_b),
    .io_cin(rca_io_cin),
    .io_sum(rca_io_sum),
    .io_cout(rca_io_cout)
  );
  RCA16 rca_1 ( // @[dut.scala 62:21]
    .io_a(rca_1_io_a),
    .io_b(rca_1_io_b),
    .io_cin(rca_1_io_cin),
    .io_sum(rca_1_io_sum),
    .io_cout(rca_1_io_cout)
  );
  RCA16 rca_2 ( // @[dut.scala 62:21]
    .io_a(rca_2_io_a),
    .io_b(rca_2_io_b),
    .io_cin(rca_2_io_cin),
    .io_sum(rca_2_io_sum),
    .io_cout(rca_2_io_cout)
  );
  RCA16 rca_3 ( // @[dut.scala 62:21]
    .io_a(rca_3_io_a),
    .io_b(rca_3_io_b),
    .io_cin(rca_3_io_cin),
    .io_sum(rca_3_io_sum),
    .io_cout(rca_3_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 77:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 80:11]
  assign rca_io_a = adda_reg[15:0]; // @[dut.scala 70:53]
  assign rca_io_b = addb_reg[15:0]; // @[dut.scala 70:70]
  assign rca_io_cin = 1'h0; // @[dut.scala 65:16]
  assign rca_1_io_a = r; // @[dut.scala 63:14]
  assign rca_1_io_b = r_1; // @[dut.scala 64:14]
  assign rca_1_io_cin = r_2; // @[dut.scala 65:16]
  assign rca_2_io_a = r_3; // @[dut.scala 63:14]
  assign rca_2_io_b = r_4; // @[dut.scala 64:14]
  assign rca_2_io_cin = r_5; // @[dut.scala 65:16]
  assign rca_3_io_a = r_6; // @[dut.scala 63:14]
  assign rca_3_io_b = r_7; // @[dut.scala 64:14]
  assign rca_3_io_cin = r_8; // @[dut.scala 65:16]
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
    if (reset) begin // @[dut.scala 50:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 50:28]
    end else begin
      en_pipeline_0 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 50:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 50:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 57:20]
    end
    if (reset) begin // @[dut.scala 50:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 50:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 57:20]
    end
    if (reset) begin // @[dut.scala 50:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 50:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 57:20]
    end
    if (en_pipeline_0) begin // @[Reg.scala 20:18]
      r <= adda_reg[31:16]; // @[Reg.scala 20:22]
    end
    if (en_pipeline_0) begin // @[Reg.scala 20:18]
      r_1 <= addb_reg[31:16]; // @[Reg.scala 20:22]
    end
    if (en_pipeline_0) begin // @[Reg.scala 20:18]
      r_2 <= rca_io_cout; // @[Reg.scala 20:22]
    end
    if (en_pipeline_1) begin // @[Reg.scala 20:18]
      r_3 <= adda_reg[47:32]; // @[Reg.scala 20:22]
    end
    if (en_pipeline_1) begin // @[Reg.scala 20:18]
      r_4 <= addb_reg[47:32]; // @[Reg.scala 20:22]
    end
    if (en_pipeline_1) begin // @[Reg.scala 20:18]
      r_5 <= rca_1_io_cout; // @[Reg.scala 20:22]
    end
    if (en_pipeline_2) begin // @[Reg.scala 20:18]
      r_6 <= adda_reg[63:48]; // @[Reg.scala 20:22]
    end
    if (en_pipeline_2) begin // @[Reg.scala 20:18]
      r_7 <= addb_reg[63:48]; // @[Reg.scala 20:22]
    end
    if (en_pipeline_2) begin // @[Reg.scala 20:18]
      r_8 <= rca_2_io_cout; // @[Reg.scala 20:22]
    end
    if (en_pipeline_3) begin // @[Reg.scala 20:18]
      result_reg <= _result_reg_T; // @[Reg.scala 20:22]
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
  r = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  r_1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  r_2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  r_3 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  r_4 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  r_5 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  r_6 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  r_7 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  r_8 = _RAND_14[0:0];
  _RAND_15 = {3{`RANDOM}};
  result_reg = _RAND_15[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
