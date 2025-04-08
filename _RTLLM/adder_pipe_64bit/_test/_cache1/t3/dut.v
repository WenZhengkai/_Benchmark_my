module RCA16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire  _T_3 = io_a[0] ^ io_b[0] ^ io_cin; // @[dut.scala 17:30]
  wire  _T_8 = io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin; // @[dut.scala 18:53]
  wire [15:0] _T_10 = {{15'd0}, _T_3}; // @[dut.scala 19:13]
  wire  _T_14 = io_a[1] ^ io_b[1] ^ _T_8; // @[dut.scala 17:30]
  wire  _T_19 = io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (
    io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin); // @[dut.scala 18:53]
  wire [1:0] _T_20 = {_T_14, 1'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_0 = {{14'd0}, _T_20}; // @[dut.scala 19:13]
  wire [15:0] _T_21 = _T_10 | _GEN_0; // @[dut.scala 19:13]
  wire  _T_25 = io_a[2] ^ io_b[2] ^ _T_19; // @[dut.scala 17:30]
  wire  _T_29 = io_b[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) |
    io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)); // @[dut.scala 18:61]
  wire  _T_30 = io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin |
    io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_29; // @[dut.scala 18:53]
  wire [2:0] _T_31 = {_T_25, 2'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_1 = {{13'd0}, _T_31}; // @[dut.scala 19:13]
  wire [15:0] _T_32 = _T_21 | _GEN_1; // @[dut.scala 19:13]
  wire  _T_36 = io_a[3] ^ io_b[3] ^ _T_30; // @[dut.scala 17:30]
  wire  _T_40 = io_b[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] &
    io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_29); // @[dut.scala 18:61]
  wire  _T_41 = io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] &
    io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)
    ) | _T_29) | _T_40; // @[dut.scala 18:53]
  wire [3:0] _T_42 = {_T_36, 3'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_2 = {{12'd0}, _T_42}; // @[dut.scala 19:13]
  wire [15:0] _T_43 = _T_32 | _GEN_2; // @[dut.scala 19:13]
  wire  _T_47 = io_a[4] ^ io_b[4] ^ _T_41; // @[dut.scala 17:30]
  wire  _T_51 = io_b[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (
    io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0]
     & io_cin)) | _T_29) | _T_40); // @[dut.scala 18:61]
  wire  _T_52 = io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] | io_a[2] & (io_a[1] &
    io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a[0] & io_b[0] | io_a[
    0] & io_cin | io_b[0] & io_cin)) | _T_29) | _T_40) | _T_51; // @[dut.scala 18:53]
  wire [4:0] _T_53 = {_T_47, 4'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_3 = {{11'd0}, _T_53}; // @[dut.scala 19:13]
  wire [15:0] _T_54 = _T_43 | _GEN_3; // @[dut.scala 19:13]
  wire  _T_58 = io_a[5] ^ io_b[5] ^ _T_52; // @[dut.scala 17:30]
  wire  _T_61 = io_a[5] & io_b[5] | io_a[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] &
    io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[
    1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_29) | _T_40) | _T_51); // @[dut.scala 18:34]
  wire  _T_63 = _T_61 | io_b[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] & io_b[2] |
    io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[1] & (io_a
    [0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_29) | _T_40) | _T_51); // @[dut.scala 18:53]
  wire [5:0] _T_64 = {_T_58, 5'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_4 = {{10'd0}, _T_64}; // @[dut.scala 19:13]
  wire [15:0] _T_65 = _T_54 | _GEN_4; // @[dut.scala 19:13]
  wire  _T_69 = io_a[6] ^ io_b[6] ^ _T_63; // @[dut.scala 17:30]
  wire  _T_71 = io_a[6] & (_T_61 | io_b[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] &
    io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[
    1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_29) | _T_40) | _T_51)); // @[dut.scala 18:42]
  wire  _T_73 = io_b[6] & (_T_61 | io_b[5] & (io_a[4] & io_b[4] | io_a[4] & (io_a[3] & io_b[3] | io_a[3] & (io_a[2] &
    io_b[2] | io_a[2] & (io_a[1] & io_b[1] | io_a[1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin) | io_b[
    1] & (io_a[0] & io_b[0] | io_a[0] & io_cin | io_b[0] & io_cin)) | _T_29) | _T_40) | _T_51)); // @[dut.scala 18:61]
  wire  _T_74 = io_a[6] & io_b[6] | _T_71 | _T_73; // @[dut.scala 18:53]
  wire [6:0] _T_75 = {_T_69, 6'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_5 = {{9'd0}, _T_75}; // @[dut.scala 19:13]
  wire [15:0] _T_76 = _T_65 | _GEN_5; // @[dut.scala 19:13]
  wire  _T_80 = io_a[7] ^ io_b[7] ^ _T_74; // @[dut.scala 17:30]
  wire  _T_85 = io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71
     | _T_73); // @[dut.scala 18:53]
  wire [7:0] _T_86 = {_T_80, 7'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_6 = {{8'd0}, _T_86}; // @[dut.scala 19:13]
  wire [15:0] _T_87 = _T_76 | _GEN_6; // @[dut.scala 19:13]
  wire  _T_91 = io_a[8] ^ io_b[8] ^ _T_85; // @[dut.scala 17:30]
  wire  _T_96 = io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] | _T_71 | _T_73) | io_b[
    7] & (io_a[6] & io_b[6] | _T_71 | _T_73)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] | _T_71 |
    _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)); // @[dut.scala 18:53]
  wire [8:0] _T_97 = {_T_91, 8'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_7 = {{7'd0}, _T_97}; // @[dut.scala 19:13]
  wire [15:0] _T_98 = _T_87 | _GEN_7; // @[dut.scala 19:13]
  wire  _T_102 = io_a[9] ^ io_b[9] ^ _T_96; // @[dut.scala 17:30]
  wire  _T_105 = io_a[9] & io_b[9] | io_a[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] &
    io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7]
     & (io_a[6] & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73))); // @[dut.scala 18:34]
  wire  _T_107 = _T_105 | io_b[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6] & io_b[6] |
    _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6]
     & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73))); // @[dut.scala 18:53]
  wire [9:0] _T_108 = {_T_102, 9'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_8 = {{6'd0}, _T_108}; // @[dut.scala 19:13]
  wire [15:0] _T_109 = _T_98 | _GEN_8; // @[dut.scala 19:13]
  wire  _T_113 = io_a[10] ^ io_b[10] ^ _T_107; // @[dut.scala 17:30]
  wire  _T_115 = io_a[10] & (_T_105 | io_b[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6]
     & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7
    ] & (io_a[6] & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)))); // @[dut.scala 18:42]
  wire  _T_117 = io_b[10] & (_T_105 | io_b[9] & (io_a[8] & io_b[8] | io_a[8] & (io_a[7] & io_b[7] | io_a[7] & (io_a[6]
     & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)) | io_b[8] & (io_a[7] & io_b[7] | io_a[7
    ] & (io_a[6] & io_b[6] | _T_71 | _T_73) | io_b[7] & (io_a[6] & io_b[6] | _T_71 | _T_73)))); // @[dut.scala 18:61]
  wire  _T_118 = io_a[10] & io_b[10] | _T_115 | _T_117; // @[dut.scala 18:53]
  wire [10:0] _T_119 = {_T_113, 10'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_9 = {{5'd0}, _T_119}; // @[dut.scala 19:13]
  wire [15:0] _T_120 = _T_109 | _GEN_9; // @[dut.scala 19:13]
  wire  _T_124 = io_a[11] ^ io_b[11] ^ _T_118; // @[dut.scala 17:30]
  wire  _T_129 = io_a[11] & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[
    10] | _T_115 | _T_117); // @[dut.scala 18:53]
  wire [11:0] _T_130 = {_T_124, 11'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_10 = {{4'd0}, _T_130}; // @[dut.scala 19:13]
  wire [15:0] _T_131 = _T_120 | _GEN_10; // @[dut.scala 19:13]
  wire  _T_135 = io_a[12] ^ io_b[12] ^ _T_129; // @[dut.scala 17:30]
  wire  _T_140 = io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_115 |
    _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117)) | io_b[12] & (io_a[11] & io_b[11] | io_a[11] & (io_a[
    10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117)); // @[dut.scala 18:53]
  wire [12:0] _T_141 = {_T_135, 12'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_11 = {{3'd0}, _T_141}; // @[dut.scala 19:13]
  wire [15:0] _T_142 = _T_131 | _GEN_11; // @[dut.scala 19:13]
  wire  _T_146 = io_a[13] ^ io_b[13] ^ _T_140; // @[dut.scala 17:30]
  wire  _T_149 = io_a[13] & io_b[13] | io_a[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (
    io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117)) | io_b[12] & (io_a[11]
     & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117
    ))); // @[dut.scala 18:34]
  wire  _T_151 = _T_149 | io_b[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (io_a[10] &
    io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117)) | io_b[12] & (io_a[11] & io_b[11]
     | io_a[11] & (io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117))); // @[dut.scala 18:53]
  wire [13:0] _T_152 = {_T_146, 13'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_12 = {{2'd0}, _T_152}; // @[dut.scala 19:13]
  wire [15:0] _T_153 = _T_142 | _GEN_12; // @[dut.scala 19:13]
  wire  _T_157 = io_a[14] ^ io_b[14] ^ _T_151; // @[dut.scala 17:30]
  wire  _T_159 = io_a[14] & (_T_149 | io_b[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (
    io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117)) | io_b[12] & (io_a[11]
     & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117
    )))); // @[dut.scala 18:42]
  wire  _T_161 = io_b[14] & (_T_149 | io_b[13] & (io_a[12] & io_b[12] | io_a[12] & (io_a[11] & io_b[11] | io_a[11] & (
    io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117)) | io_b[12] & (io_a[11]
     & io_b[11] | io_a[11] & (io_a[10] & io_b[10] | _T_115 | _T_117) | io_b[11] & (io_a[10] & io_b[10] | _T_115 | _T_117
    )))); // @[dut.scala 18:61]
  wire  _T_162 = io_a[14] & io_b[14] | _T_159 | _T_161; // @[dut.scala 18:53]
  wire [14:0] _T_163 = {_T_157, 14'h0}; // @[dut.scala 19:23]
  wire [15:0] _GEN_13 = {{1'd0}, _T_163}; // @[dut.scala 19:13]
  wire [15:0] _T_164 = _T_153 | _GEN_13; // @[dut.scala 19:13]
  wire  _T_168 = io_a[15] ^ io_b[15] ^ _T_162; // @[dut.scala 17:30]
  wire [15:0] _T_173 = {_T_168, 15'h0}; // @[dut.scala 19:23]
  assign io_sum = _T_164 | _T_173; // @[dut.scala 19:13]
  assign io_cout = io_a[15] & io_b[15] | io_a[15] & (io_a[14] & io_b[14] | _T_159 | _T_161) | io_b[15] & (io_a[14] &
    io_b[14] | _T_159 | _T_161); // @[dut.scala 18:53]
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
  wire [15:0] stage1_io_a; // @[dut.scala 46:22]
  wire [15:0] stage1_io_b; // @[dut.scala 46:22]
  wire  stage1_io_cin; // @[dut.scala 46:22]
  wire [15:0] stage1_io_sum; // @[dut.scala 46:22]
  wire  stage1_io_cout; // @[dut.scala 46:22]
  wire [15:0] stage2_io_a; // @[dut.scala 56:22]
  wire [15:0] stage2_io_b; // @[dut.scala 56:22]
  wire  stage2_io_cin; // @[dut.scala 56:22]
  wire [15:0] stage2_io_sum; // @[dut.scala 56:22]
  wire  stage2_io_cout; // @[dut.scala 56:22]
  wire [15:0] stage3_io_a; // @[dut.scala 66:22]
  wire [15:0] stage3_io_b; // @[dut.scala 66:22]
  wire  stage3_io_cin; // @[dut.scala 66:22]
  wire [15:0] stage3_io_sum; // @[dut.scala 66:22]
  wire  stage3_io_cout; // @[dut.scala 66:22]
  wire [15:0] stage4_io_a; // @[dut.scala 76:22]
  wire [15:0] stage4_io_b; // @[dut.scala 76:22]
  wire  stage4_io_cin; // @[dut.scala 76:22]
  wire [15:0] stage4_io_sum; // @[dut.scala 76:22]
  wire  stage4_io_cout; // @[dut.scala 76:22]
  reg [63:0] adda_reg; // @[Reg.scala 35:20]
  reg [63:0] addb_reg; // @[Reg.scala 35:20]
  reg  en_pipeline_0; // @[dut.scala 38:28]
  reg  en_pipeline_1; // @[dut.scala 38:28]
  reg  en_pipeline_2; // @[dut.scala 38:28]
  reg  en_pipeline_3; // @[dut.scala 38:28]
  reg [15:0] stage1_sum; // @[dut.scala 51:27]
  reg  stage1_cout; // @[dut.scala 52:28]
  reg [15:0] stage2_sum; // @[dut.scala 61:27]
  reg  stage2_cout; // @[dut.scala 62:28]
  reg [15:0] stage3_sum; // @[dut.scala 71:27]
  reg  stage3_cout; // @[dut.scala 72:28]
  reg [15:0] stage4_sum; // @[dut.scala 81:27]
  reg  final_carry; // @[dut.scala 82:28]
  wire [31:0] result_reg_lo = {stage2_sum,stage1_sum}; // @[Cat.scala 33:92]
  wire [32:0] result_reg_hi = {final_carry,stage4_sum,stage3_sum}; // @[Cat.scala 33:92]
  reg [64:0] result_reg; // @[dut.scala 86:27]
  RCA16 stage1 ( // @[dut.scala 46:22]
    .io_a(stage1_io_a),
    .io_b(stage1_io_b),
    .io_cin(stage1_io_cin),
    .io_sum(stage1_io_sum),
    .io_cout(stage1_io_cout)
  );
  RCA16 stage2 ( // @[dut.scala 56:22]
    .io_a(stage2_io_a),
    .io_b(stage2_io_b),
    .io_cin(stage2_io_cin),
    .io_sum(stage2_io_sum),
    .io_cout(stage2_io_cout)
  );
  RCA16 stage3 ( // @[dut.scala 66:22]
    .io_a(stage3_io_a),
    .io_b(stage3_io_b),
    .io_cin(stage3_io_cin),
    .io_sum(stage3_io_sum),
    .io_cout(stage3_io_cout)
  );
  RCA16 stage4 ( // @[dut.scala 76:22]
    .io_a(stage4_io_a),
    .io_b(stage4_io_b),
    .io_cin(stage4_io_cin),
    .io_sum(stage4_io_sum),
    .io_cout(stage4_io_cout)
  );
  assign io_result = result_reg; // @[dut.scala 88:13]
  assign io_o_en = en_pipeline_3; // @[dut.scala 91:11]
  assign stage1_io_a = adda_reg[15:0]; // @[dut.scala 47:26]
  assign stage1_io_b = addb_reg[15:0]; // @[dut.scala 48:26]
  assign stage1_io_cin = 1'h0; // @[dut.scala 49:17]
  assign stage2_io_a = adda_reg[31:16]; // @[dut.scala 57:26]
  assign stage2_io_b = addb_reg[31:16]; // @[dut.scala 58:26]
  assign stage2_io_cin = stage1_cout; // @[dut.scala 59:17]
  assign stage3_io_a = adda_reg[47:32]; // @[dut.scala 67:26]
  assign stage3_io_b = addb_reg[47:32]; // @[dut.scala 68:26]
  assign stage3_io_cin = stage2_cout; // @[dut.scala 69:17]
  assign stage4_io_a = adda_reg[63:48]; // @[dut.scala 77:26]
  assign stage4_io_b = addb_reg[63:48]; // @[dut.scala 78:26]
  assign stage4_io_cin = stage3_cout; // @[dut.scala 79:17]
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
    if (reset) begin // @[dut.scala 38:28]
      en_pipeline_0 <= 1'h0; // @[dut.scala 38:28]
    end else begin
      en_pipeline_0 <= io_i_en; // @[dut.scala 39:18]
    end
    if (reset) begin // @[dut.scala 38:28]
      en_pipeline_1 <= 1'h0; // @[dut.scala 38:28]
    end else begin
      en_pipeline_1 <= en_pipeline_0; // @[dut.scala 41:20]
    end
    if (reset) begin // @[dut.scala 38:28]
      en_pipeline_2 <= 1'h0; // @[dut.scala 38:28]
    end else begin
      en_pipeline_2 <= en_pipeline_1; // @[dut.scala 41:20]
    end
    if (reset) begin // @[dut.scala 38:28]
      en_pipeline_3 <= 1'h0; // @[dut.scala 38:28]
    end else begin
      en_pipeline_3 <= en_pipeline_2; // @[dut.scala 41:20]
    end
    stage1_sum <= stage1_io_sum; // @[dut.scala 51:27]
    stage1_cout <= stage1_io_cout; // @[dut.scala 52:28]
    stage2_sum <= stage2_io_sum; // @[dut.scala 61:27]
    stage2_cout <= stage2_io_cout; // @[dut.scala 62:28]
    stage3_sum <= stage3_io_sum; // @[dut.scala 71:27]
    stage3_cout <= stage3_io_cout; // @[dut.scala 72:28]
    stage4_sum <= stage4_io_sum; // @[dut.scala 81:27]
    final_carry <= stage4_io_cout; // @[dut.scala 82:28]
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
