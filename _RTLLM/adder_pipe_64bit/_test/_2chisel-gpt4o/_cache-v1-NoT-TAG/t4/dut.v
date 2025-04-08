module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  a_bit = io_a[0]; // @[dut.scala 18:21]
  wire  b_bit = io_b[0]; // @[dut.scala 19:21]
  wire  _sums_0_T = a_bit ^ b_bit; // @[dut.scala 22:22]
  wire  sums_0 = a_bit ^ b_bit ^ io_cin; // @[dut.scala 22:30]
  wire  carries_0 = a_bit & b_bit | io_cin & _sums_0_T; // @[dut.scala 23:35]
  wire  a_bit_1 = io_a[1]; // @[dut.scala 18:21]
  wire  b_bit_1 = io_b[1]; // @[dut.scala 19:21]
  wire  _sums_1_T = a_bit_1 ^ b_bit_1; // @[dut.scala 22:22]
  wire  sums_1 = a_bit_1 ^ b_bit_1 ^ carries_0; // @[dut.scala 22:30]
  wire  carries_1 = a_bit_1 & b_bit_1 | carries_0 & _sums_1_T; // @[dut.scala 23:35]
  wire  a_bit_2 = io_a[2]; // @[dut.scala 18:21]
  wire  b_bit_2 = io_b[2]; // @[dut.scala 19:21]
  wire  _sums_2_T = a_bit_2 ^ b_bit_2; // @[dut.scala 22:22]
  wire  sums_2 = a_bit_2 ^ b_bit_2 ^ carries_1; // @[dut.scala 22:30]
  wire  carries_2 = a_bit_2 & b_bit_2 | carries_1 & _sums_2_T; // @[dut.scala 23:35]
  wire  a_bit_3 = io_a[3]; // @[dut.scala 18:21]
  wire  b_bit_3 = io_b[3]; // @[dut.scala 19:21]
  wire  _sums_3_T = a_bit_3 ^ b_bit_3; // @[dut.scala 22:22]
  wire  sums_3 = a_bit_3 ^ b_bit_3 ^ carries_2; // @[dut.scala 22:30]
  wire  carries_3 = a_bit_3 & b_bit_3 | carries_2 & _sums_3_T; // @[dut.scala 23:35]
  wire  a_bit_4 = io_a[4]; // @[dut.scala 18:21]
  wire  b_bit_4 = io_b[4]; // @[dut.scala 19:21]
  wire  _sums_4_T = a_bit_4 ^ b_bit_4; // @[dut.scala 22:22]
  wire  sums_4 = a_bit_4 ^ b_bit_4 ^ carries_3; // @[dut.scala 22:30]
  wire  carries_4 = a_bit_4 & b_bit_4 | carries_3 & _sums_4_T; // @[dut.scala 23:35]
  wire  a_bit_5 = io_a[5]; // @[dut.scala 18:21]
  wire  b_bit_5 = io_b[5]; // @[dut.scala 19:21]
  wire  _sums_5_T = a_bit_5 ^ b_bit_5; // @[dut.scala 22:22]
  wire  sums_5 = a_bit_5 ^ b_bit_5 ^ carries_4; // @[dut.scala 22:30]
  wire  carries_5 = a_bit_5 & b_bit_5 | carries_4 & _sums_5_T; // @[dut.scala 23:35]
  wire  a_bit_6 = io_a[6]; // @[dut.scala 18:21]
  wire  b_bit_6 = io_b[6]; // @[dut.scala 19:21]
  wire  _sums_6_T = a_bit_6 ^ b_bit_6; // @[dut.scala 22:22]
  wire  sums_6 = a_bit_6 ^ b_bit_6 ^ carries_5; // @[dut.scala 22:30]
  wire  carries_6 = a_bit_6 & b_bit_6 | carries_5 & _sums_6_T; // @[dut.scala 23:35]
  wire  a_bit_7 = io_a[7]; // @[dut.scala 18:21]
  wire  b_bit_7 = io_b[7]; // @[dut.scala 19:21]
  wire  _sums_7_T = a_bit_7 ^ b_bit_7; // @[dut.scala 22:22]
  wire  sums_7 = a_bit_7 ^ b_bit_7 ^ carries_6; // @[dut.scala 22:30]
  wire  carries_7 = a_bit_7 & b_bit_7 | carries_6 & _sums_7_T; // @[dut.scala 23:35]
  wire  a_bit_8 = io_a[8]; // @[dut.scala 18:21]
  wire  b_bit_8 = io_b[8]; // @[dut.scala 19:21]
  wire  _sums_8_T = a_bit_8 ^ b_bit_8; // @[dut.scala 22:22]
  wire  sums_8 = a_bit_8 ^ b_bit_8 ^ carries_7; // @[dut.scala 22:30]
  wire  carries_8 = a_bit_8 & b_bit_8 | carries_7 & _sums_8_T; // @[dut.scala 23:35]
  wire  a_bit_9 = io_a[9]; // @[dut.scala 18:21]
  wire  b_bit_9 = io_b[9]; // @[dut.scala 19:21]
  wire  _sums_9_T = a_bit_9 ^ b_bit_9; // @[dut.scala 22:22]
  wire  sums_9 = a_bit_9 ^ b_bit_9 ^ carries_8; // @[dut.scala 22:30]
  wire  carries_9 = a_bit_9 & b_bit_9 | carries_8 & _sums_9_T; // @[dut.scala 23:35]
  wire  a_bit_10 = io_a[10]; // @[dut.scala 18:21]
  wire  b_bit_10 = io_b[10]; // @[dut.scala 19:21]
  wire  _sums_10_T = a_bit_10 ^ b_bit_10; // @[dut.scala 22:22]
  wire  sums_10 = a_bit_10 ^ b_bit_10 ^ carries_9; // @[dut.scala 22:30]
  wire  carries_10 = a_bit_10 & b_bit_10 | carries_9 & _sums_10_T; // @[dut.scala 23:35]
  wire  a_bit_11 = io_a[11]; // @[dut.scala 18:21]
  wire  b_bit_11 = io_b[11]; // @[dut.scala 19:21]
  wire  _sums_11_T = a_bit_11 ^ b_bit_11; // @[dut.scala 22:22]
  wire  sums_11 = a_bit_11 ^ b_bit_11 ^ carries_10; // @[dut.scala 22:30]
  wire  carries_11 = a_bit_11 & b_bit_11 | carries_10 & _sums_11_T; // @[dut.scala 23:35]
  wire  a_bit_12 = io_a[12]; // @[dut.scala 18:21]
  wire  b_bit_12 = io_b[12]; // @[dut.scala 19:21]
  wire  _sums_12_T = a_bit_12 ^ b_bit_12; // @[dut.scala 22:22]
  wire  sums_12 = a_bit_12 ^ b_bit_12 ^ carries_11; // @[dut.scala 22:30]
  wire  carries_12 = a_bit_12 & b_bit_12 | carries_11 & _sums_12_T; // @[dut.scala 23:35]
  wire  a_bit_13 = io_a[13]; // @[dut.scala 18:21]
  wire  b_bit_13 = io_b[13]; // @[dut.scala 19:21]
  wire  _sums_13_T = a_bit_13 ^ b_bit_13; // @[dut.scala 22:22]
  wire  sums_13 = a_bit_13 ^ b_bit_13 ^ carries_12; // @[dut.scala 22:30]
  wire  carries_13 = a_bit_13 & b_bit_13 | carries_12 & _sums_13_T; // @[dut.scala 23:35]
  wire  a_bit_14 = io_a[14]; // @[dut.scala 18:21]
  wire  b_bit_14 = io_b[14]; // @[dut.scala 19:21]
  wire  _sums_14_T = a_bit_14 ^ b_bit_14; // @[dut.scala 22:22]
  wire  sums_14 = a_bit_14 ^ b_bit_14 ^ carries_13; // @[dut.scala 22:30]
  wire  carries_14 = a_bit_14 & b_bit_14 | carries_13 & _sums_14_T; // @[dut.scala 23:35]
  wire  a_bit_15 = io_a[15]; // @[dut.scala 18:21]
  wire  b_bit_15 = io_b[15]; // @[dut.scala 19:21]
  wire  _sums_15_T = a_bit_15 ^ b_bit_15; // @[dut.scala 22:22]
  wire  sums_15 = a_bit_15 ^ b_bit_15 ^ carries_14; // @[dut.scala 22:30]
  wire [7:0] io_sum_lo = {sums_7,sums_6,sums_5,sums_4,sums_3,sums_2,sums_1,sums_0}; // @[dut.scala 26:18]
  wire [7:0] io_sum_hi = {sums_15,sums_14,sums_13,sums_12,sums_11,sums_10,sums_9,sums_8}; // @[dut.scala 26:18]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 26:18]
  assign io_cout = a_bit_15 & b_bit_15 | carries_14 & _sums_15_T; // @[dut.scala 23:35]
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
  wire [15:0] rca1_io_a; // @[dut.scala 60:20]
  wire [15:0] rca1_io_b; // @[dut.scala 60:20]
  wire  rca1_io_cin; // @[dut.scala 60:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 60:20]
  wire  rca1_io_cout; // @[dut.scala 60:20]
  wire [15:0] rca2_io_a; // @[dut.scala 61:20]
  wire [15:0] rca2_io_b; // @[dut.scala 61:20]
  wire  rca2_io_cin; // @[dut.scala 61:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 61:20]
  wire  rca2_io_cout; // @[dut.scala 61:20]
  wire [15:0] rca3_io_a; // @[dut.scala 62:20]
  wire [15:0] rca3_io_b; // @[dut.scala 62:20]
  wire  rca3_io_cin; // @[dut.scala 62:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 62:20]
  wire  rca3_io_cout; // @[dut.scala 62:20]
  wire [15:0] rca4_io_a; // @[dut.scala 63:20]
  wire [15:0] rca4_io_b; // @[dut.scala 63:20]
  wire  rca4_io_cin; // @[dut.scala 63:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 63:20]
  wire  rca4_io_cout; // @[dut.scala 63:20]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 48:28]
  reg  en_pipeline_1; // @[dut.scala 48:28]
  reg  en_pipeline_2; // @[dut.scala 48:28]
  reg  en_pipeline_3; // @[dut.scala 48:28]
  reg [15:0] sum1; // @[dut.scala 73:21]
  reg  carry1; // @[dut.scala 74:23]
  reg [15:0] sum2; // @[dut.scala 80:21]
  reg  carry2; // @[dut.scala 81:23]
  reg [15:0] sum3; // @[dut.scala 87:21]
  reg  carry3; // @[dut.scala 88:23]
  reg [15:0] sum4; // @[dut.scala 94:21]
  reg  carry4; // @[dut.scala 95:23]
  wire [31:0] result_reg_lo = {sum2,sum1}; // @[Cat.scala 33:92]
  wire [32:0] result_reg_hi = {carry4,sum4,sum3}; // @[Cat.scala 33:92]
  reg [64:0] result_reg; // @[dut.scala 101:27]
  RCA16 rca1 ( // @[dut.scala 60:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 61:20]
    .io_a(rca2_io_a),
    .io_b(rca2_io_b),
    .io_cin(rca2_io_cin),
    .io_sum(rca2_io_sum),
    .io_cout(rca2_io_cout)
  );
  RCA16 rca3 ( // @[dut.scala 62:20]
    .io_a(rca3_io_a),
    .io_b(rca3_io_b),
    .io_cin(rca3_io_cin),
    .io_sum(rca3_io_sum),
    .io_cout(rca3_io_cout)
  );
  RCA16 rca4 ( // @[dut.scala 63:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 102:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 109:11]
  assign rca1_io_a = adda_reg[15:0]; // @[dut.scala 70:24]
  assign rca1_io_b = addb_reg[15:0]; // @[dut.scala 71:24]
  assign rca1_io_cin = 1'h0; // @[dut.scala 72:15]
  assign rca2_io_a = adda_reg[31:16]; // @[dut.scala 77:24]
  assign rca2_io_b = addb_reg[31:16]; // @[dut.scala 78:24]
  assign rca2_io_cin = carry1; // @[dut.scala 79:15]
  assign rca3_io_a = adda_reg[47:32]; // @[dut.scala 84:24]
  assign rca3_io_b = addb_reg[47:32]; // @[dut.scala 85:24]
  assign rca3_io_cin = carry2; // @[dut.scala 86:15]
  assign rca4_io_a = adda_reg[63:48]; // @[dut.scala 91:24]
  assign rca4_io_b = addb_reg[63:48]; // @[dut.scala 92:24]
  assign rca4_io_cin = carry3; // @[dut.scala 93:15]
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
    if (reset) begin // @[dut.scala 48:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 48:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 49:18]
    end
    if (reset) begin // @[dut.scala 48:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 48:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 51:20]
    end
    if (reset) begin // @[dut.scala 48:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 48:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 51:20]
    end
    if (reset) begin // @[dut.scala 48:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 48:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 51:20]
    end
    sum1 <= rca1_io_sum; // @[dut.scala 73:21]
    carry1 <= rca1_io_cout; // @[dut.scala 74:23]
    sum2 <= rca2_io_sum; // @[dut.scala 80:21]
    carry2 <= rca2_io_cout; // @[dut.scala 81:23]
    sum3 <= rca3_io_sum; // @[dut.scala 87:21]
    carry3 <= rca3_io_cout; // @[dut.scala 88:23]
    sum4 <= rca4_io_sum; // @[dut.scala 94:21]
    carry4 <= rca4_io_cout; // @[dut.scala 95:23]
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
  sum1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  carry1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sum2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  carry2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sum4 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  carry4 = _RAND_13[0:0];
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
