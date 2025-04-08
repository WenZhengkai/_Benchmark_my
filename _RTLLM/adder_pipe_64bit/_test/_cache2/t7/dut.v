module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  sum_0 = io_a[0] ^ io_b[0] ^ io_cin; // @[dut.scala 20:29]
  wire  _T_8 = io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin; // @[dut.scala 21:50]
  wire  sum_1 = io_a[1] ^ io_b[1] ^ _T_8; // @[dut.scala 20:29]
  wire  _T_17 = io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (
    io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin); // @[dut.scala 21:50]
  wire  sum_2 = io_a[2] ^ io_b[2] ^ _T_17; // @[dut.scala 20:29]
  wire  _T_25 = io_b[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) |
    io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)); // @[dut.scala 21:59]
  wire  _T_26 = io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin |
    io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_25; // @[dut.scala 21:50]
  wire  sum_3 = io_a[3] ^ io_b[3] ^ _T_26; // @[dut.scala 20:29]
  wire  _T_34 = io_b[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] &
    io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_25); // @[dut.scala 21:59]
  wire  _T_35 = io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] &
    io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)
    ) | _T_25) | _T_34; // @[dut.scala 21:50]
  wire  sum_4 = io_a[4] ^ io_b[4] ^ _T_35; // @[dut.scala 20:29]
  wire  _T_43 = io_b[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (
    io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0]
     & io_cin)) | _T_25) | _T_34); // @[dut.scala 21:59]
  wire  _T_44 = io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] &
    io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[
    0] & io_cin | io_b[0] & io_cin)) | _T_25) | _T_34) | _T_43; // @[dut.scala 21:50]
  wire  sum_5 = io_a[5] ^ io_b[5] ^ _T_44; // @[dut.scala 20:29]
  wire  _T_51 = io_a[5] & io_b[5] | io_a[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] &
    io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[
    1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_25) | _T_34) | _T_43); // @[dut.scala 21:32]
  wire  _T_53 = _T_51 | io_b[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] |
    io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a
    [0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_25) | _T_34) | _T_43); // @[dut.scala 21:50]
  wire  sum_6 = io_a[6] ^ io_b[6] ^ _T_53; // @[dut.scala 20:29]
  wire  _T_59 = io_a[6] & (_T_51 | io_b[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] &
    io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[
    1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_25) | _T_34) | _T_43)); // @[dut.scala 21:41]
  wire  _T_61 = io_b[6] & (_T_51 | io_b[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] &
    io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[
    1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_25) | _T_34) | _T_43)); // @[dut.scala 21:59]
  wire  _T_62 = io_a[6] & io_b[6] | _T_59 | _T_61; // @[dut.scala 21:50]
  wire  sum_7 = io_a[7] ^ io_b[7] ^ _T_62; // @[dut.scala 20:29]
  wire  _T_71 = io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59
     | _T_61); // @[dut.scala 21:50]
  wire  sum_8 = io_a[8] ^ io_b[8] ^ _T_71; // @[dut.scala 20:29]
  wire  _T_80 = io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] | _T_59 | _T_61) | io_b[
    7] & (io_a[6] & io_b[6] | _T_59 | _T_61)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] | _T_59 |
    _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)); // @[dut.scala 21:50]
  wire  sum_9 = io_a[9] ^ io_b[9] ^ _T_80; // @[dut.scala 20:29]
  wire  _T_87 = io_a[9] & io_b[9] | io_a[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] &
    io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7]
     & (io_a[6] & io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61))); // @[dut.scala 21:32]
  wire  _T_89 = _T_87 | io_b[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] |
    _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6]
     & io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61))); // @[dut.scala 21:50]
  wire  sum_10 = io_a[10] ^ io_b[10] ^ _T_89; // @[dut.scala 20:29]
  wire  _T_95 = io_a[10] & (_T_87 | io_b[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] &
    io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7]
     & (io_a[6] & io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)))); // @[dut.scala 21:41]
  wire  _T_97 = io_b[10] & (_T_87 | io_b[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] &
    io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7]
     & (io_a[6] & io_b[6] | _T_59 | _T_61) | io_b[7] & (io_a[6] & io_b[6] | _T_59 | _T_61)))); // @[dut.scala 21:59]
  wire  _T_98 = io_a[10] & io_b[10] | _T_95 | _T_97; // @[dut.scala 21:50]
  wire  sum_11 = io_a[11] ^ io_b[11] ^ _T_98; // @[dut.scala 20:29]
  wire  _T_107 = io_a[11] & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10
    ] | _T_95 | _T_97); // @[dut.scala 21:50]
  wire  sum_12 = io_a[12] ^ io_b[12] ^ _T_107; // @[dut.scala 20:29]
  wire  _T_116 = io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_95 | _T_97
    ) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)) | io_b[12] & (io_a[11] & io_b[11] | io_a[11] & (io_a[10] &
    io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)); // @[dut.scala 21:50]
  wire  sum_13 = io_a[13] ^ io_b[13] ^ _T_116; // @[dut.scala 20:29]
  wire  _T_123 = io_a[13] & io_b[13] | io_a[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (
    io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)) | io_b[12] & (io_a[11] &
    io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97))); // @[dut.scala 21:32]
  wire  _T_125 = _T_123 | io_b[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (io_a[10] &
    io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)) | io_b[12] & (io_a[11] & io_b[11] |
    io_a[11] & (io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97))); // @[dut.scala 21:50]
  wire  sum_14 = io_a[14] ^ io_b[14] ^ _T_125; // @[dut.scala 20:29]
  wire  _T_131 = io_a[14] & (_T_123 | io_b[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (
    io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)) | io_b[12] & (io_a[11] &
    io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)))); // @[dut.scala 21:41]
  wire  _T_133 = io_b[14] & (_T_123 | io_b[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (
    io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)) | io_b[12] & (io_a[11] &
    io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_95 | _T_97) | io_b[11] & (io_a[10] & io_b[10] | _T_95 | _T_97)))); // @[dut.scala 21:59]
  wire  _T_134 = io_a[14] & io_b[14] | _T_131 | _T_133; // @[dut.scala 21:50]
  wire  sum_15 = io_a[15] ^ io_b[15] ^ _T_134; // @[dut.scala 20:29]
  wire [7:0] io_sum_lo = {sum_7,sum_6,sum_5,sum_4,sum_3,sum_2,sum_1,sum_0}; // @[dut.scala 27:23]
  wire [7:0] io_sum_hi = {sum_15,sum_14,sum_13,sum_12,sum_11,sum_10,sum_9,sum_8}; // @[dut.scala 27:23]
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[dut.scala 27:23]
  assign io_cout = io_a[15] & io_b[15] | io_a[15] & (io_a[14] & io_b[14] | _T_131 | _T_133) | io_b[15] & (io_a[14] &
    io_b[14] | _T_131 | _T_133); // @[dut.scala 21:50]
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
  reg [95:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] rca1_io_a; // @[dut.scala 64:20]
  wire [15:0] rca1_io_b; // @[dut.scala 64:20]
  wire  rca1_io_cin; // @[dut.scala 64:20]
  wire [15:0] rca1_io_sum; // @[dut.scala 64:20]
  wire  rca1_io_cout; // @[dut.scala 64:20]
  wire [15:0] rca2_io_a; // @[dut.scala 72:20]
  wire [15:0] rca2_io_b; // @[dut.scala 72:20]
  wire  rca2_io_cin; // @[dut.scala 72:20]
  wire [15:0] rca2_io_sum; // @[dut.scala 72:20]
  wire  rca2_io_cout; // @[dut.scala 72:20]
  wire [15:0] rca3_io_a; // @[dut.scala 80:20]
  wire [15:0] rca3_io_b; // @[dut.scala 80:20]
  wire  rca3_io_cin; // @[dut.scala 80:20]
  wire [15:0] rca3_io_sum; // @[dut.scala 80:20]
  wire  rca3_io_cout; // @[dut.scala 80:20]
  wire [15:0] rca4_io_a; // @[dut.scala 88:20]
  wire [15:0] rca4_io_b; // @[dut.scala 88:20]
  wire  rca4_io_cin; // @[dut.scala 88:20]
  wire [15:0] rca4_io_sum; // @[dut.scala 88:20]
  wire  rca4_io_cout; // @[dut.scala 88:20]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 45:28]
  reg  en_pipeline_1; // @[dut.scala 45:28]
  reg  en_pipeline_2; // @[dut.scala 45:28]
  reg  en_pipeline_3; // @[dut.scala 45:28]
  reg [15:0] stage1_sum; // @[dut.scala 53:23]
  reg [15:0] stage2_sum; // @[dut.scala 54:23]
  reg [15:0] stage3_sum; // @[dut.scala 55:23]
  reg [15:0] stage4_sum; // @[dut.scala 56:23]
  reg  stage1_carry; // @[dut.scala 58:25]
  reg  stage2_carry; // @[dut.scala 59:25]
  reg  stage3_carry; // @[dut.scala 60:25]
  reg [64:0] result_reg; // @[dut.scala 96:23]
  wire [31:0] result_reg_lo = {stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  wire  stage4_carry = rca4_io_cout; // @[dut.scala 61:26 93:16]
  wire [32:0] result_reg_hi = {stage4_carry,stage4_sum,stage3_sum}; // @[Cat.scala 33:92]
  RCA16 rca1 ( // @[dut.scala 64:20]
    .io_a(rca1_io_a),
    .io_b(rca1_io_b),
    .io_cin(rca1_io_cin),
    .io_sum(rca1_io_sum),
    .io_cout(rca1_io_cout)
  );
  RCA16 rca2 ( // @[dut.scala 72:20]
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
  RCA16 rca4 ( // @[dut.scala 88:20]
    .io_a(rca4_io_a),
    .io_b(rca4_io_b),
    .io_cin(rca4_io_cin),
    .io_sum(rca4_io_sum),
    .io_cout(rca4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 98:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 50:11]
  assign rca1_io_a = adda_reg[15:0]; // @[dut.scala 65:24]
  assign rca1_io_b = addb_reg[15:0]; // @[dut.scala 66:24]
  assign rca1_io_cin = 1'h0; // @[dut.scala 67:15]
  assign rca2_io_a = adda_reg[31:16]; // @[dut.scala 73:24]
  assign rca2_io_b = addb_reg[31:16]; // @[dut.scala 74:24]
  assign rca2_io_cin = stage1_carry; // @[dut.scala 75:15]
  assign rca3_io_a = adda_reg[47:32]; // @[dut.scala 81:24]
  assign rca3_io_b = addb_reg[47:32]; // @[dut.scala 82:24]
  assign rca3_io_cin = stage2_carry; // @[dut.scala 83:15]
  assign rca4_io_a = adda_reg[63:48]; // @[dut.scala 89:24]
  assign rca4_io_b = addb_reg[63:48]; // @[dut.scala 90:24]
  assign rca4_io_cin = stage3_carry; // @[dut.scala 91:15]
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
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 46:18]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 48:20]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 48:20]
    end
    if (reset) begin // @[dut.scala 45:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 45:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 48:20]
    end
    stage1_sum <= rca1_io_sum; // @[dut.scala 68:14]
    stage2_sum <= rca2_io_sum; // @[dut.scala 76:14]
    stage3_sum <= rca3_io_sum; // @[dut.scala 84:14]
    stage4_sum <= rca4_io_sum; // @[dut.scala 92:14]
    stage1_carry <= rca1_io_cout; // @[dut.scala 69:16]
    stage2_carry <= rca2_io_cout; // @[dut.scala 77:16]
    stage3_carry <= rca3_io_cout; // @[dut.scala 85:16]
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
  stage2_sum = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  stage3_sum = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage4_sum = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  stage1_carry = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  stage2_carry = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  stage3_carry = _RAND_12[0:0];
  _RAND_13 = {3{`RANDOM}};
  result_reg = _RAND_13[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
