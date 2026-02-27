module dut(
  input         clock,
  input         reset,
  output        io_from_idu_ready,
  input         io_from_idu_valid,
  input  [31:0] io_from_idu_bits_cf_inst,
  input  [63:0] io_from_idu_bits_cf_pc,
  input  [63:0] io_from_idu_bits_cf_next_pc,
  input         io_from_idu_bits_cf_isBranch,
  input         io_from_idu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_idu_bits_ctrl_ResSrc,
  input  [1:0]  io_from_idu_bits_ctrl_fuSrc1Type,
  input  [1:0]  io_from_idu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuType,
  input  [4:0]  io_from_idu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_idu_bits_ctrl_rs1,
  input  [4:0]  io_from_idu_bits_ctrl_rs2,
  input         io_from_idu_bits_ctrl_rfWen,
  input  [4:0]  io_from_idu_bits_ctrl_rd,
  input  [63:0] io_from_idu_bits_data_fuSrc1,
  input  [63:0] io_from_idu_bits_data_fuSrc2,
  input  [63:0] io_from_idu_bits_data_imm,
  input         io_from_idu_bits_data_Alu0Res_ready,
  input         io_from_idu_bits_data_Alu0Res_valid,
  input  [63:0] io_from_idu_bits_data_Alu0Res_bits,
  input  [63:0] io_from_idu_bits_data_data_from_mem,
  input  [63:0] io_from_idu_bits_data_csrRdata,
  input  [63:0] io_from_idu_bits_data_rfSrc1,
  input  [63:0] io_from_idu_bits_data_rfSrc2,
  input         io_to_exu_ready,
  output        io_to_exu_valid,
  output [31:0] io_to_exu_bits_cf_inst,
  output [63:0] io_to_exu_bits_cf_pc,
  output [63:0] io_to_exu_bits_cf_next_pc,
  output        io_to_exu_bits_cf_isBranch,
  output        io_to_exu_bits_ctrl_MemWrite,
  output [1:0]  io_to_exu_bits_ctrl_ResSrc,
  output [1:0]  io_to_exu_bits_ctrl_fuSrc1Type,
  output [1:0]  io_to_exu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [4:0]  io_to_exu_bits_ctrl_fuOpType,
  output [4:0]  io_to_exu_bits_ctrl_rs1,
  output [4:0]  io_to_exu_bits_ctrl_rs2,
  output        io_to_exu_bits_ctrl_rfWen,
  output [4:0]  io_to_exu_bits_ctrl_rd,
  output [63:0] io_to_exu_bits_data_fuSrc1,
  output [63:0] io_to_exu_bits_data_fuSrc2,
  output [63:0] io_to_exu_bits_data_imm,
  output        io_to_exu_bits_data_Alu0Res_ready,
  output        io_to_exu_bits_data_Alu0Res_valid,
  output [63:0] io_to_exu_bits_data_Alu0Res_bits,
  output [63:0] io_to_exu_bits_data_data_from_mem,
  output [63:0] io_to_exu_bits_data_csrRdata,
  output [63:0] io_to_exu_bits_data_rfSrc1,
  output [63:0] io_to_exu_bits_data_rfSrc2,
  input  [4:0]  io_wb_rd,
  input  [63:0] io_wb_Res,
  input         io_wb_RegWrite,
  input  [63:0] io_from_reg_rfSrc1,
  input  [63:0] io_from_reg_rfSrc2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
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
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] busy_1; // @[dut.scala 89:21]
  reg [1:0] busy_2; // @[dut.scala 89:21]
  reg [1:0] busy_3; // @[dut.scala 89:21]
  reg [1:0] busy_4; // @[dut.scala 89:21]
  reg [1:0] busy_5; // @[dut.scala 89:21]
  reg [1:0] busy_6; // @[dut.scala 89:21]
  reg [1:0] busy_7; // @[dut.scala 89:21]
  reg [1:0] busy_8; // @[dut.scala 89:21]
  reg [1:0] busy_9; // @[dut.scala 89:21]
  reg [1:0] busy_10; // @[dut.scala 89:21]
  reg [1:0] busy_11; // @[dut.scala 89:21]
  reg [1:0] busy_12; // @[dut.scala 89:21]
  reg [1:0] busy_13; // @[dut.scala 89:21]
  reg [1:0] busy_14; // @[dut.scala 89:21]
  reg [1:0] busy_15; // @[dut.scala 89:21]
  reg [1:0] busy_16; // @[dut.scala 89:21]
  reg [1:0] busy_17; // @[dut.scala 89:21]
  reg [1:0] busy_18; // @[dut.scala 89:21]
  reg [1:0] busy_19; // @[dut.scala 89:21]
  reg [1:0] busy_20; // @[dut.scala 89:21]
  reg [1:0] busy_21; // @[dut.scala 89:21]
  reg [1:0] busy_22; // @[dut.scala 89:21]
  reg [1:0] busy_23; // @[dut.scala 89:21]
  reg [1:0] busy_24; // @[dut.scala 89:21]
  reg [1:0] busy_25; // @[dut.scala 89:21]
  reg [1:0] busy_26; // @[dut.scala 89:21]
  reg [1:0] busy_27; // @[dut.scala 89:21]
  reg [1:0] busy_28; // @[dut.scala 89:21]
  reg [1:0] busy_29; // @[dut.scala 89:21]
  reg [1:0] busy_30; // @[dut.scala 89:21]
  reg [1:0] busy_31; // @[dut.scala 89:21]
  wire [1:0] _GEN_1 = 5'h1 == io_from_idu_bits_ctrl_rs1 ? busy_1 : 2'h0; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_2 = 5'h2 == io_from_idu_bits_ctrl_rs1 ? busy_2 : _GEN_1; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_3 = 5'h3 == io_from_idu_bits_ctrl_rs1 ? busy_3 : _GEN_2; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_4 = 5'h4 == io_from_idu_bits_ctrl_rs1 ? busy_4 : _GEN_3; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_5 = 5'h5 == io_from_idu_bits_ctrl_rs1 ? busy_5 : _GEN_4; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_6 = 5'h6 == io_from_idu_bits_ctrl_rs1 ? busy_6 : _GEN_5; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_7 = 5'h7 == io_from_idu_bits_ctrl_rs1 ? busy_7 : _GEN_6; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_8 = 5'h8 == io_from_idu_bits_ctrl_rs1 ? busy_8 : _GEN_7; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_9 = 5'h9 == io_from_idu_bits_ctrl_rs1 ? busy_9 : _GEN_8; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_10 = 5'ha == io_from_idu_bits_ctrl_rs1 ? busy_10 : _GEN_9; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_11 = 5'hb == io_from_idu_bits_ctrl_rs1 ? busy_11 : _GEN_10; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_12 = 5'hc == io_from_idu_bits_ctrl_rs1 ? busy_12 : _GEN_11; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_13 = 5'hd == io_from_idu_bits_ctrl_rs1 ? busy_13 : _GEN_12; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_14 = 5'he == io_from_idu_bits_ctrl_rs1 ? busy_14 : _GEN_13; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_15 = 5'hf == io_from_idu_bits_ctrl_rs1 ? busy_15 : _GEN_14; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_16 = 5'h10 == io_from_idu_bits_ctrl_rs1 ? busy_16 : _GEN_15; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_17 = 5'h11 == io_from_idu_bits_ctrl_rs1 ? busy_17 : _GEN_16; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_18 = 5'h12 == io_from_idu_bits_ctrl_rs1 ? busy_18 : _GEN_17; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_19 = 5'h13 == io_from_idu_bits_ctrl_rs1 ? busy_19 : _GEN_18; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_20 = 5'h14 == io_from_idu_bits_ctrl_rs1 ? busy_20 : _GEN_19; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_21 = 5'h15 == io_from_idu_bits_ctrl_rs1 ? busy_21 : _GEN_20; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_22 = 5'h16 == io_from_idu_bits_ctrl_rs1 ? busy_22 : _GEN_21; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_23 = 5'h17 == io_from_idu_bits_ctrl_rs1 ? busy_23 : _GEN_22; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_24 = 5'h18 == io_from_idu_bits_ctrl_rs1 ? busy_24 : _GEN_23; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_25 = 5'h19 == io_from_idu_bits_ctrl_rs1 ? busy_25 : _GEN_24; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_26 = 5'h1a == io_from_idu_bits_ctrl_rs1 ? busy_26 : _GEN_25; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_27 = 5'h1b == io_from_idu_bits_ctrl_rs1 ? busy_27 : _GEN_26; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_28 = 5'h1c == io_from_idu_bits_ctrl_rs1 ? busy_28 : _GEN_27; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_29 = 5'h1d == io_from_idu_bits_ctrl_rs1 ? busy_29 : _GEN_28; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_30 = 5'h1e == io_from_idu_bits_ctrl_rs1 ? busy_30 : _GEN_29; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_31 = 5'h1f == io_from_idu_bits_ctrl_rs1 ? busy_31 : _GEN_30; // @[dut.scala 93:{15,15}]
  wire  _rs1Busy_T = _GEN_31 != 2'h0; // @[dut.scala 93:15]
  wire  rs1Busy = _rs1Busy_T & io_from_idu_bits_ctrl_rs1 != 5'h0; // @[dut.scala 142:44]
  wire [1:0] _GEN_33 = 5'h1 == io_from_idu_bits_ctrl_rs2 ? busy_1 : 2'h0; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_34 = 5'h2 == io_from_idu_bits_ctrl_rs2 ? busy_2 : _GEN_33; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_35 = 5'h3 == io_from_idu_bits_ctrl_rs2 ? busy_3 : _GEN_34; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_36 = 5'h4 == io_from_idu_bits_ctrl_rs2 ? busy_4 : _GEN_35; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_37 = 5'h5 == io_from_idu_bits_ctrl_rs2 ? busy_5 : _GEN_36; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_38 = 5'h6 == io_from_idu_bits_ctrl_rs2 ? busy_6 : _GEN_37; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_39 = 5'h7 == io_from_idu_bits_ctrl_rs2 ? busy_7 : _GEN_38; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_40 = 5'h8 == io_from_idu_bits_ctrl_rs2 ? busy_8 : _GEN_39; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_41 = 5'h9 == io_from_idu_bits_ctrl_rs2 ? busy_9 : _GEN_40; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_42 = 5'ha == io_from_idu_bits_ctrl_rs2 ? busy_10 : _GEN_41; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_43 = 5'hb == io_from_idu_bits_ctrl_rs2 ? busy_11 : _GEN_42; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_44 = 5'hc == io_from_idu_bits_ctrl_rs2 ? busy_12 : _GEN_43; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_45 = 5'hd == io_from_idu_bits_ctrl_rs2 ? busy_13 : _GEN_44; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_46 = 5'he == io_from_idu_bits_ctrl_rs2 ? busy_14 : _GEN_45; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_47 = 5'hf == io_from_idu_bits_ctrl_rs2 ? busy_15 : _GEN_46; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_48 = 5'h10 == io_from_idu_bits_ctrl_rs2 ? busy_16 : _GEN_47; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_49 = 5'h11 == io_from_idu_bits_ctrl_rs2 ? busy_17 : _GEN_48; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_50 = 5'h12 == io_from_idu_bits_ctrl_rs2 ? busy_18 : _GEN_49; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_51 = 5'h13 == io_from_idu_bits_ctrl_rs2 ? busy_19 : _GEN_50; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_52 = 5'h14 == io_from_idu_bits_ctrl_rs2 ? busy_20 : _GEN_51; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_53 = 5'h15 == io_from_idu_bits_ctrl_rs2 ? busy_21 : _GEN_52; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_54 = 5'h16 == io_from_idu_bits_ctrl_rs2 ? busy_22 : _GEN_53; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_55 = 5'h17 == io_from_idu_bits_ctrl_rs2 ? busy_23 : _GEN_54; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_56 = 5'h18 == io_from_idu_bits_ctrl_rs2 ? busy_24 : _GEN_55; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_57 = 5'h19 == io_from_idu_bits_ctrl_rs2 ? busy_25 : _GEN_56; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_58 = 5'h1a == io_from_idu_bits_ctrl_rs2 ? busy_26 : _GEN_57; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_59 = 5'h1b == io_from_idu_bits_ctrl_rs2 ? busy_27 : _GEN_58; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_60 = 5'h1c == io_from_idu_bits_ctrl_rs2 ? busy_28 : _GEN_59; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_61 = 5'h1d == io_from_idu_bits_ctrl_rs2 ? busy_29 : _GEN_60; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_62 = 5'h1e == io_from_idu_bits_ctrl_rs2 ? busy_30 : _GEN_61; // @[dut.scala 93:{15,15}]
  wire [1:0] _GEN_63 = 5'h1f == io_from_idu_bits_ctrl_rs2 ? busy_31 : _GEN_62; // @[dut.scala 93:{15,15}]
  wire  _rs2Busy_T = _GEN_63 != 2'h0; // @[dut.scala 93:15]
  wire  rs2Busy = _rs2Busy_T & io_from_idu_bits_ctrl_rs2 != 5'h0; // @[dut.scala 143:44]
  wire  rs1Used = io_from_idu_bits_ctrl_fuSrc1Type == 2'h0; // @[dut.scala 144:40]
  wire  rs2Used = io_from_idu_bits_ctrl_fuSrc2Type == 2'h0; // @[dut.scala 145:40]
  wire  AnyInvalidCondition = rs1Busy & rs1Used | rs2Busy & rs2Used; // @[dut.scala 148:50]
  wire [63:0] _rs1_T_1 = 2'h0 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_reg_rfSrc1 : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _rs1_T_3 = 2'h1 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_idu_bits_cf_pc : _rs1_T_1; // @[Mux.scala 81:58]
  wire [63:0] _rs2_T_1 = 2'h0 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_reg_rfSrc2 : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _rs2_T_3 = 2'h1 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_idu_bits_data_imm : _rs2_T_1; // @[Mux.scala 81:58]
  wire  _io_to_exu_valid_T = ~AnyInvalidCondition; // @[dut.scala 178:43]
  wire [62:0] _wbuClearMask_maskWire_T = 63'h1 << io_wb_rd; // @[dut.scala 99:32]
  wire [31:0] wbuClearMask_maskWire = _wbuClearMask_maskWire_T[31:0]; // @[dut.scala 98:24 99:14]
  wire [31:0] wbuClearMask = io_wb_RegWrite ? wbuClearMask_maskWire : 32'h0; // @[dut.scala 183:25]
  wire  _isFireSetMask_T = io_to_exu_ready & io_to_exu_valid; // @[Decoupled.scala 51:35]
  wire [62:0] _isFireSetMask_maskWire_T = 63'h1 << io_from_idu_bits_ctrl_rd; // @[dut.scala 99:32]
  wire [31:0] isFireSetMask_maskWire = _isFireSetMask_maskWire_T[31:0]; // @[dut.scala 98:24 99:14]
  wire [31:0] isFireSetMask = io_from_idu_bits_ctrl_rfWen & _isFireSetMask_T ? isFireSetMask_maskWire : 32'h0; // @[dut.scala 184:26]
  wire [31:0] _set_T_1 = isFireSetMask & 32'h2; // @[dut.scala 110:28]
  wire  set = |_set_T_1; // @[dut.scala 110:44]
  wire [31:0] _clear_T_1 = wbuClearMask & 32'h2; // @[dut.scala 111:32]
  wire  clear = |_clear_T_1; // @[dut.scala 111:48]
  wire  _busy_1_T = set & clear; // @[dut.scala 114:16]
  wire [1:0] _busy_1_T_3 = busy_1 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_1_T_7 = busy_1 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_1_T_8 = busy_1 == 2'h0 ? 2'h0 : _busy_1_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_3 = isFireSetMask & 32'h4; // @[dut.scala 110:28]
  wire  set_1 = |_set_T_3; // @[dut.scala 110:44]
  wire [31:0] _clear_T_3 = wbuClearMask & 32'h4; // @[dut.scala 111:32]
  wire  clear_1 = |_clear_T_3; // @[dut.scala 111:48]
  wire  _busy_2_T = set_1 & clear_1; // @[dut.scala 114:16]
  wire [1:0] _busy_2_T_3 = busy_2 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_2_T_7 = busy_2 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_2_T_8 = busy_2 == 2'h0 ? 2'h0 : _busy_2_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_5 = isFireSetMask & 32'h8; // @[dut.scala 110:28]
  wire  set_2 = |_set_T_5; // @[dut.scala 110:44]
  wire [31:0] _clear_T_5 = wbuClearMask & 32'h8; // @[dut.scala 111:32]
  wire  clear_2 = |_clear_T_5; // @[dut.scala 111:48]
  wire  _busy_3_T = set_2 & clear_2; // @[dut.scala 114:16]
  wire [1:0] _busy_3_T_3 = busy_3 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_3_T_7 = busy_3 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_3_T_8 = busy_3 == 2'h0 ? 2'h0 : _busy_3_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_7 = isFireSetMask & 32'h10; // @[dut.scala 110:28]
  wire  set_3 = |_set_T_7; // @[dut.scala 110:44]
  wire [31:0] _clear_T_7 = wbuClearMask & 32'h10; // @[dut.scala 111:32]
  wire  clear_3 = |_clear_T_7; // @[dut.scala 111:48]
  wire  _busy_4_T = set_3 & clear_3; // @[dut.scala 114:16]
  wire [1:0] _busy_4_T_3 = busy_4 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_4_T_7 = busy_4 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_4_T_8 = busy_4 == 2'h0 ? 2'h0 : _busy_4_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_9 = isFireSetMask & 32'h20; // @[dut.scala 110:28]
  wire  set_4 = |_set_T_9; // @[dut.scala 110:44]
  wire [31:0] _clear_T_9 = wbuClearMask & 32'h20; // @[dut.scala 111:32]
  wire  clear_4 = |_clear_T_9; // @[dut.scala 111:48]
  wire  _busy_5_T = set_4 & clear_4; // @[dut.scala 114:16]
  wire [1:0] _busy_5_T_3 = busy_5 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_5_T_7 = busy_5 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_5_T_8 = busy_5 == 2'h0 ? 2'h0 : _busy_5_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_11 = isFireSetMask & 32'h40; // @[dut.scala 110:28]
  wire  set_5 = |_set_T_11; // @[dut.scala 110:44]
  wire [31:0] _clear_T_11 = wbuClearMask & 32'h40; // @[dut.scala 111:32]
  wire  clear_5 = |_clear_T_11; // @[dut.scala 111:48]
  wire  _busy_6_T = set_5 & clear_5; // @[dut.scala 114:16]
  wire [1:0] _busy_6_T_3 = busy_6 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_6_T_7 = busy_6 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_6_T_8 = busy_6 == 2'h0 ? 2'h0 : _busy_6_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_13 = isFireSetMask & 32'h80; // @[dut.scala 110:28]
  wire  set_6 = |_set_T_13; // @[dut.scala 110:44]
  wire [31:0] _clear_T_13 = wbuClearMask & 32'h80; // @[dut.scala 111:32]
  wire  clear_6 = |_clear_T_13; // @[dut.scala 111:48]
  wire  _busy_7_T = set_6 & clear_6; // @[dut.scala 114:16]
  wire [1:0] _busy_7_T_3 = busy_7 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_7_T_7 = busy_7 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_7_T_8 = busy_7 == 2'h0 ? 2'h0 : _busy_7_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_15 = isFireSetMask & 32'h100; // @[dut.scala 110:28]
  wire  set_7 = |_set_T_15; // @[dut.scala 110:44]
  wire [31:0] _clear_T_15 = wbuClearMask & 32'h100; // @[dut.scala 111:32]
  wire  clear_7 = |_clear_T_15; // @[dut.scala 111:48]
  wire  _busy_8_T = set_7 & clear_7; // @[dut.scala 114:16]
  wire [1:0] _busy_8_T_3 = busy_8 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_8_T_7 = busy_8 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_8_T_8 = busy_8 == 2'h0 ? 2'h0 : _busy_8_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_17 = isFireSetMask & 32'h200; // @[dut.scala 110:28]
  wire  set_8 = |_set_T_17; // @[dut.scala 110:44]
  wire [31:0] _clear_T_17 = wbuClearMask & 32'h200; // @[dut.scala 111:32]
  wire  clear_8 = |_clear_T_17; // @[dut.scala 111:48]
  wire  _busy_9_T = set_8 & clear_8; // @[dut.scala 114:16]
  wire [1:0] _busy_9_T_3 = busy_9 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_9_T_7 = busy_9 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_9_T_8 = busy_9 == 2'h0 ? 2'h0 : _busy_9_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_19 = isFireSetMask & 32'h400; // @[dut.scala 110:28]
  wire  set_9 = |_set_T_19; // @[dut.scala 110:44]
  wire [31:0] _clear_T_19 = wbuClearMask & 32'h400; // @[dut.scala 111:32]
  wire  clear_9 = |_clear_T_19; // @[dut.scala 111:48]
  wire  _busy_10_T = set_9 & clear_9; // @[dut.scala 114:16]
  wire [1:0] _busy_10_T_3 = busy_10 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_10_T_7 = busy_10 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_10_T_8 = busy_10 == 2'h0 ? 2'h0 : _busy_10_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_21 = isFireSetMask & 32'h800; // @[dut.scala 110:28]
  wire  set_10 = |_set_T_21; // @[dut.scala 110:44]
  wire [31:0] _clear_T_21 = wbuClearMask & 32'h800; // @[dut.scala 111:32]
  wire  clear_10 = |_clear_T_21; // @[dut.scala 111:48]
  wire  _busy_11_T = set_10 & clear_10; // @[dut.scala 114:16]
  wire [1:0] _busy_11_T_3 = busy_11 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_11_T_7 = busy_11 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_11_T_8 = busy_11 == 2'h0 ? 2'h0 : _busy_11_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_23 = isFireSetMask & 32'h1000; // @[dut.scala 110:28]
  wire  set_11 = |_set_T_23; // @[dut.scala 110:44]
  wire [31:0] _clear_T_23 = wbuClearMask & 32'h1000; // @[dut.scala 111:32]
  wire  clear_11 = |_clear_T_23; // @[dut.scala 111:48]
  wire  _busy_12_T = set_11 & clear_11; // @[dut.scala 114:16]
  wire [1:0] _busy_12_T_3 = busy_12 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_12_T_7 = busy_12 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_12_T_8 = busy_12 == 2'h0 ? 2'h0 : _busy_12_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_25 = isFireSetMask & 32'h2000; // @[dut.scala 110:28]
  wire  set_12 = |_set_T_25; // @[dut.scala 110:44]
  wire [31:0] _clear_T_25 = wbuClearMask & 32'h2000; // @[dut.scala 111:32]
  wire  clear_12 = |_clear_T_25; // @[dut.scala 111:48]
  wire  _busy_13_T = set_12 & clear_12; // @[dut.scala 114:16]
  wire [1:0] _busy_13_T_3 = busy_13 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_13_T_7 = busy_13 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_13_T_8 = busy_13 == 2'h0 ? 2'h0 : _busy_13_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_27 = isFireSetMask & 32'h4000; // @[dut.scala 110:28]
  wire  set_13 = |_set_T_27; // @[dut.scala 110:44]
  wire [31:0] _clear_T_27 = wbuClearMask & 32'h4000; // @[dut.scala 111:32]
  wire  clear_13 = |_clear_T_27; // @[dut.scala 111:48]
  wire  _busy_14_T = set_13 & clear_13; // @[dut.scala 114:16]
  wire [1:0] _busy_14_T_3 = busy_14 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_14_T_7 = busy_14 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_14_T_8 = busy_14 == 2'h0 ? 2'h0 : _busy_14_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_29 = isFireSetMask & 32'h8000; // @[dut.scala 110:28]
  wire  set_14 = |_set_T_29; // @[dut.scala 110:44]
  wire [31:0] _clear_T_29 = wbuClearMask & 32'h8000; // @[dut.scala 111:32]
  wire  clear_14 = |_clear_T_29; // @[dut.scala 111:48]
  wire  _busy_15_T = set_14 & clear_14; // @[dut.scala 114:16]
  wire [1:0] _busy_15_T_3 = busy_15 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_15_T_7 = busy_15 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_15_T_8 = busy_15 == 2'h0 ? 2'h0 : _busy_15_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_31 = isFireSetMask & 32'h10000; // @[dut.scala 110:28]
  wire  set_15 = |_set_T_31; // @[dut.scala 110:44]
  wire [31:0] _clear_T_31 = wbuClearMask & 32'h10000; // @[dut.scala 111:32]
  wire  clear_15 = |_clear_T_31; // @[dut.scala 111:48]
  wire  _busy_16_T = set_15 & clear_15; // @[dut.scala 114:16]
  wire [1:0] _busy_16_T_3 = busy_16 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_16_T_7 = busy_16 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_16_T_8 = busy_16 == 2'h0 ? 2'h0 : _busy_16_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_33 = isFireSetMask & 32'h20000; // @[dut.scala 110:28]
  wire  set_16 = |_set_T_33; // @[dut.scala 110:44]
  wire [31:0] _clear_T_33 = wbuClearMask & 32'h20000; // @[dut.scala 111:32]
  wire  clear_16 = |_clear_T_33; // @[dut.scala 111:48]
  wire  _busy_17_T = set_16 & clear_16; // @[dut.scala 114:16]
  wire [1:0] _busy_17_T_3 = busy_17 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_17_T_7 = busy_17 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_17_T_8 = busy_17 == 2'h0 ? 2'h0 : _busy_17_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_35 = isFireSetMask & 32'h40000; // @[dut.scala 110:28]
  wire  set_17 = |_set_T_35; // @[dut.scala 110:44]
  wire [31:0] _clear_T_35 = wbuClearMask & 32'h40000; // @[dut.scala 111:32]
  wire  clear_17 = |_clear_T_35; // @[dut.scala 111:48]
  wire  _busy_18_T = set_17 & clear_17; // @[dut.scala 114:16]
  wire [1:0] _busy_18_T_3 = busy_18 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_18_T_7 = busy_18 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_18_T_8 = busy_18 == 2'h0 ? 2'h0 : _busy_18_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_37 = isFireSetMask & 32'h80000; // @[dut.scala 110:28]
  wire  set_18 = |_set_T_37; // @[dut.scala 110:44]
  wire [31:0] _clear_T_37 = wbuClearMask & 32'h80000; // @[dut.scala 111:32]
  wire  clear_18 = |_clear_T_37; // @[dut.scala 111:48]
  wire  _busy_19_T = set_18 & clear_18; // @[dut.scala 114:16]
  wire [1:0] _busy_19_T_3 = busy_19 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_19_T_7 = busy_19 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_19_T_8 = busy_19 == 2'h0 ? 2'h0 : _busy_19_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_39 = isFireSetMask & 32'h100000; // @[dut.scala 110:28]
  wire  set_19 = |_set_T_39; // @[dut.scala 110:44]
  wire [31:0] _clear_T_39 = wbuClearMask & 32'h100000; // @[dut.scala 111:32]
  wire  clear_19 = |_clear_T_39; // @[dut.scala 111:48]
  wire  _busy_20_T = set_19 & clear_19; // @[dut.scala 114:16]
  wire [1:0] _busy_20_T_3 = busy_20 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_20_T_7 = busy_20 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_20_T_8 = busy_20 == 2'h0 ? 2'h0 : _busy_20_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_41 = isFireSetMask & 32'h200000; // @[dut.scala 110:28]
  wire  set_20 = |_set_T_41; // @[dut.scala 110:44]
  wire [31:0] _clear_T_41 = wbuClearMask & 32'h200000; // @[dut.scala 111:32]
  wire  clear_20 = |_clear_T_41; // @[dut.scala 111:48]
  wire  _busy_21_T = set_20 & clear_20; // @[dut.scala 114:16]
  wire [1:0] _busy_21_T_3 = busy_21 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_21_T_7 = busy_21 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_21_T_8 = busy_21 == 2'h0 ? 2'h0 : _busy_21_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_43 = isFireSetMask & 32'h400000; // @[dut.scala 110:28]
  wire  set_21 = |_set_T_43; // @[dut.scala 110:44]
  wire [31:0] _clear_T_43 = wbuClearMask & 32'h400000; // @[dut.scala 111:32]
  wire  clear_21 = |_clear_T_43; // @[dut.scala 111:48]
  wire  _busy_22_T = set_21 & clear_21; // @[dut.scala 114:16]
  wire [1:0] _busy_22_T_3 = busy_22 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_22_T_7 = busy_22 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_22_T_8 = busy_22 == 2'h0 ? 2'h0 : _busy_22_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_45 = isFireSetMask & 32'h800000; // @[dut.scala 110:28]
  wire  set_22 = |_set_T_45; // @[dut.scala 110:44]
  wire [31:0] _clear_T_45 = wbuClearMask & 32'h800000; // @[dut.scala 111:32]
  wire  clear_22 = |_clear_T_45; // @[dut.scala 111:48]
  wire  _busy_23_T = set_22 & clear_22; // @[dut.scala 114:16]
  wire [1:0] _busy_23_T_3 = busy_23 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_23_T_7 = busy_23 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_23_T_8 = busy_23 == 2'h0 ? 2'h0 : _busy_23_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_47 = isFireSetMask & 32'h1000000; // @[dut.scala 110:28]
  wire  set_23 = |_set_T_47; // @[dut.scala 110:44]
  wire [31:0] _clear_T_47 = wbuClearMask & 32'h1000000; // @[dut.scala 111:32]
  wire  clear_23 = |_clear_T_47; // @[dut.scala 111:48]
  wire  _busy_24_T = set_23 & clear_23; // @[dut.scala 114:16]
  wire [1:0] _busy_24_T_3 = busy_24 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_24_T_7 = busy_24 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_24_T_8 = busy_24 == 2'h0 ? 2'h0 : _busy_24_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_49 = isFireSetMask & 32'h2000000; // @[dut.scala 110:28]
  wire  set_24 = |_set_T_49; // @[dut.scala 110:44]
  wire [31:0] _clear_T_49 = wbuClearMask & 32'h2000000; // @[dut.scala 111:32]
  wire  clear_24 = |_clear_T_49; // @[dut.scala 111:48]
  wire  _busy_25_T = set_24 & clear_24; // @[dut.scala 114:16]
  wire [1:0] _busy_25_T_3 = busy_25 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_25_T_7 = busy_25 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_25_T_8 = busy_25 == 2'h0 ? 2'h0 : _busy_25_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_51 = isFireSetMask & 32'h4000000; // @[dut.scala 110:28]
  wire  set_25 = |_set_T_51; // @[dut.scala 110:44]
  wire [31:0] _clear_T_51 = wbuClearMask & 32'h4000000; // @[dut.scala 111:32]
  wire  clear_25 = |_clear_T_51; // @[dut.scala 111:48]
  wire  _busy_26_T = set_25 & clear_25; // @[dut.scala 114:16]
  wire [1:0] _busy_26_T_3 = busy_26 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_26_T_7 = busy_26 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_26_T_8 = busy_26 == 2'h0 ? 2'h0 : _busy_26_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_53 = isFireSetMask & 32'h8000000; // @[dut.scala 110:28]
  wire  set_26 = |_set_T_53; // @[dut.scala 110:44]
  wire [31:0] _clear_T_53 = wbuClearMask & 32'h8000000; // @[dut.scala 111:32]
  wire  clear_26 = |_clear_T_53; // @[dut.scala 111:48]
  wire  _busy_27_T = set_26 & clear_26; // @[dut.scala 114:16]
  wire [1:0] _busy_27_T_3 = busy_27 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_27_T_7 = busy_27 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_27_T_8 = busy_27 == 2'h0 ? 2'h0 : _busy_27_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_55 = isFireSetMask & 32'h10000000; // @[dut.scala 110:28]
  wire  set_27 = |_set_T_55; // @[dut.scala 110:44]
  wire [31:0] _clear_T_55 = wbuClearMask & 32'h10000000; // @[dut.scala 111:32]
  wire  clear_27 = |_clear_T_55; // @[dut.scala 111:48]
  wire  _busy_28_T = set_27 & clear_27; // @[dut.scala 114:16]
  wire [1:0] _busy_28_T_3 = busy_28 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_28_T_7 = busy_28 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_28_T_8 = busy_28 == 2'h0 ? 2'h0 : _busy_28_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_57 = isFireSetMask & 32'h20000000; // @[dut.scala 110:28]
  wire  set_28 = |_set_T_57; // @[dut.scala 110:44]
  wire [31:0] _clear_T_57 = wbuClearMask & 32'h20000000; // @[dut.scala 111:32]
  wire  clear_28 = |_clear_T_57; // @[dut.scala 111:48]
  wire  _busy_29_T = set_28 & clear_28; // @[dut.scala 114:16]
  wire [1:0] _busy_29_T_3 = busy_29 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_29_T_7 = busy_29 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_29_T_8 = busy_29 == 2'h0 ? 2'h0 : _busy_29_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_59 = isFireSetMask & 32'h40000000; // @[dut.scala 110:28]
  wire  set_29 = |_set_T_59; // @[dut.scala 110:44]
  wire [31:0] _clear_T_59 = wbuClearMask & 32'h40000000; // @[dut.scala 111:32]
  wire  clear_29 = |_clear_T_59; // @[dut.scala 111:48]
  wire  _busy_30_T = set_29 & clear_29; // @[dut.scala 114:16]
  wire [1:0] _busy_30_T_3 = busy_30 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_30_T_7 = busy_30 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_30_T_8 = busy_30 == 2'h0 ? 2'h0 : _busy_30_T_7; // @[dut.scala 116:23]
  wire [31:0] _set_T_61 = isFireSetMask & 32'h80000000; // @[dut.scala 110:28]
  wire  set_30 = |_set_T_61; // @[dut.scala 110:44]
  wire [31:0] _clear_T_61 = wbuClearMask & 32'h80000000; // @[dut.scala 111:32]
  wire  clear_30 = |_clear_T_61; // @[dut.scala 111:48]
  wire  _busy_31_T = set_30 & clear_30; // @[dut.scala 114:16]
  wire [1:0] _busy_31_T_3 = busy_31 + 2'h1; // @[dut.scala 115:66]
  wire [1:0] _busy_31_T_7 = busy_31 - 2'h1; // @[dut.scala 116:54]
  wire [1:0] _busy_31_T_8 = busy_31 == 2'h0 ? 2'h0 : _busy_31_T_7; // @[dut.scala 116:23]
  assign io_from_idu_ready = io_to_exu_ready & _io_to_exu_valid_T; // @[dut.scala 179:40]
  assign io_to_exu_valid = io_from_idu_valid & ~AnyInvalidCondition; // @[dut.scala 178:40]
  assign io_to_exu_bits_cf_inst = io_from_idu_bits_cf_inst; // @[dut.scala 168:18]
  assign io_to_exu_bits_cf_pc = io_from_idu_bits_cf_pc; // @[dut.scala 168:18]
  assign io_to_exu_bits_cf_next_pc = io_from_idu_bits_cf_next_pc; // @[dut.scala 168:18]
  assign io_to_exu_bits_cf_isBranch = io_from_idu_bits_cf_isBranch; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_MemWrite = io_from_idu_bits_ctrl_MemWrite; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_ResSrc = io_from_idu_bits_ctrl_ResSrc; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_fuSrc1Type = io_from_idu_bits_ctrl_fuSrc1Type; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_fuSrc2Type = io_from_idu_bits_ctrl_fuSrc2Type; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_fuType = io_from_idu_bits_ctrl_fuType; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_fuOpType = io_from_idu_bits_ctrl_fuOpType; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_rs1 = io_from_idu_bits_ctrl_rs1; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_rs2 = io_from_idu_bits_ctrl_rs2; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_rfWen = io_from_idu_bits_ctrl_rfWen; // @[dut.scala 168:18]
  assign io_to_exu_bits_ctrl_rd = io_from_idu_bits_ctrl_rd; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_fuSrc1 = 2'h2 == io_from_idu_bits_ctrl_fuSrc1Type ? 64'h0 : _rs1_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_fuSrc2 = 2'h2 == io_from_idu_bits_ctrl_fuSrc2Type ? 64'h4 : _rs2_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_imm = io_from_idu_bits_data_imm; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_Alu0Res_ready = io_from_idu_bits_data_Alu0Res_ready; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_Alu0Res_valid = io_from_idu_bits_data_Alu0Res_valid; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_Alu0Res_bits = io_from_idu_bits_data_Alu0Res_bits; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_data_from_mem = io_from_idu_bits_data_data_from_mem; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_csrRdata = io_from_idu_bits_data_csrRdata; // @[dut.scala 168:18]
  assign io_to_exu_bits_data_rfSrc1 = io_from_reg_rfSrc1; // @[dut.scala 174:30]
  assign io_to_exu_bits_data_rfSrc2 = io_from_reg_rfSrc2; // @[dut.scala 175:30]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 89:21]
      busy_1 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_1_T)) begin // @[Mux.scala 101:16]
      if (set) begin // @[Mux.scala 101:16]
        if (busy_1 == 2'h3) begin // @[dut.scala 115:21]
          busy_1 <= 2'h3;
        end else begin
          busy_1 <= _busy_1_T_3;
        end
      end else if (clear) begin // @[Mux.scala 101:16]
        busy_1 <= _busy_1_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_2 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_2_T)) begin // @[Mux.scala 101:16]
      if (set_1) begin // @[Mux.scala 101:16]
        if (busy_2 == 2'h3) begin // @[dut.scala 115:21]
          busy_2 <= 2'h3;
        end else begin
          busy_2 <= _busy_2_T_3;
        end
      end else if (clear_1) begin // @[Mux.scala 101:16]
        busy_2 <= _busy_2_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_3 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_3_T)) begin // @[Mux.scala 101:16]
      if (set_2) begin // @[Mux.scala 101:16]
        if (busy_3 == 2'h3) begin // @[dut.scala 115:21]
          busy_3 <= 2'h3;
        end else begin
          busy_3 <= _busy_3_T_3;
        end
      end else if (clear_2) begin // @[Mux.scala 101:16]
        busy_3 <= _busy_3_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_4 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_4_T)) begin // @[Mux.scala 101:16]
      if (set_3) begin // @[Mux.scala 101:16]
        if (busy_4 == 2'h3) begin // @[dut.scala 115:21]
          busy_4 <= 2'h3;
        end else begin
          busy_4 <= _busy_4_T_3;
        end
      end else if (clear_3) begin // @[Mux.scala 101:16]
        busy_4 <= _busy_4_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_5 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_5_T)) begin // @[Mux.scala 101:16]
      if (set_4) begin // @[Mux.scala 101:16]
        if (busy_5 == 2'h3) begin // @[dut.scala 115:21]
          busy_5 <= 2'h3;
        end else begin
          busy_5 <= _busy_5_T_3;
        end
      end else if (clear_4) begin // @[Mux.scala 101:16]
        busy_5 <= _busy_5_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_6 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_6_T)) begin // @[Mux.scala 101:16]
      if (set_5) begin // @[Mux.scala 101:16]
        if (busy_6 == 2'h3) begin // @[dut.scala 115:21]
          busy_6 <= 2'h3;
        end else begin
          busy_6 <= _busy_6_T_3;
        end
      end else if (clear_5) begin // @[Mux.scala 101:16]
        busy_6 <= _busy_6_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_7 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_7_T)) begin // @[Mux.scala 101:16]
      if (set_6) begin // @[Mux.scala 101:16]
        if (busy_7 == 2'h3) begin // @[dut.scala 115:21]
          busy_7 <= 2'h3;
        end else begin
          busy_7 <= _busy_7_T_3;
        end
      end else if (clear_6) begin // @[Mux.scala 101:16]
        busy_7 <= _busy_7_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_8 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_8_T)) begin // @[Mux.scala 101:16]
      if (set_7) begin // @[Mux.scala 101:16]
        if (busy_8 == 2'h3) begin // @[dut.scala 115:21]
          busy_8 <= 2'h3;
        end else begin
          busy_8 <= _busy_8_T_3;
        end
      end else if (clear_7) begin // @[Mux.scala 101:16]
        busy_8 <= _busy_8_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_9 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_9_T)) begin // @[Mux.scala 101:16]
      if (set_8) begin // @[Mux.scala 101:16]
        if (busy_9 == 2'h3) begin // @[dut.scala 115:21]
          busy_9 <= 2'h3;
        end else begin
          busy_9 <= _busy_9_T_3;
        end
      end else if (clear_8) begin // @[Mux.scala 101:16]
        busy_9 <= _busy_9_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_10 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_10_T)) begin // @[Mux.scala 101:16]
      if (set_9) begin // @[Mux.scala 101:16]
        if (busy_10 == 2'h3) begin // @[dut.scala 115:21]
          busy_10 <= 2'h3;
        end else begin
          busy_10 <= _busy_10_T_3;
        end
      end else if (clear_9) begin // @[Mux.scala 101:16]
        busy_10 <= _busy_10_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_11 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_11_T)) begin // @[Mux.scala 101:16]
      if (set_10) begin // @[Mux.scala 101:16]
        if (busy_11 == 2'h3) begin // @[dut.scala 115:21]
          busy_11 <= 2'h3;
        end else begin
          busy_11 <= _busy_11_T_3;
        end
      end else if (clear_10) begin // @[Mux.scala 101:16]
        busy_11 <= _busy_11_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_12 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_12_T)) begin // @[Mux.scala 101:16]
      if (set_11) begin // @[Mux.scala 101:16]
        if (busy_12 == 2'h3) begin // @[dut.scala 115:21]
          busy_12 <= 2'h3;
        end else begin
          busy_12 <= _busy_12_T_3;
        end
      end else if (clear_11) begin // @[Mux.scala 101:16]
        busy_12 <= _busy_12_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_13 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_13_T)) begin // @[Mux.scala 101:16]
      if (set_12) begin // @[Mux.scala 101:16]
        if (busy_13 == 2'h3) begin // @[dut.scala 115:21]
          busy_13 <= 2'h3;
        end else begin
          busy_13 <= _busy_13_T_3;
        end
      end else if (clear_12) begin // @[Mux.scala 101:16]
        busy_13 <= _busy_13_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_14 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_14_T)) begin // @[Mux.scala 101:16]
      if (set_13) begin // @[Mux.scala 101:16]
        if (busy_14 == 2'h3) begin // @[dut.scala 115:21]
          busy_14 <= 2'h3;
        end else begin
          busy_14 <= _busy_14_T_3;
        end
      end else if (clear_13) begin // @[Mux.scala 101:16]
        busy_14 <= _busy_14_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_15 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_15_T)) begin // @[Mux.scala 101:16]
      if (set_14) begin // @[Mux.scala 101:16]
        if (busy_15 == 2'h3) begin // @[dut.scala 115:21]
          busy_15 <= 2'h3;
        end else begin
          busy_15 <= _busy_15_T_3;
        end
      end else if (clear_14) begin // @[Mux.scala 101:16]
        busy_15 <= _busy_15_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_16 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_16_T)) begin // @[Mux.scala 101:16]
      if (set_15) begin // @[Mux.scala 101:16]
        if (busy_16 == 2'h3) begin // @[dut.scala 115:21]
          busy_16 <= 2'h3;
        end else begin
          busy_16 <= _busy_16_T_3;
        end
      end else if (clear_15) begin // @[Mux.scala 101:16]
        busy_16 <= _busy_16_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_17 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_17_T)) begin // @[Mux.scala 101:16]
      if (set_16) begin // @[Mux.scala 101:16]
        if (busy_17 == 2'h3) begin // @[dut.scala 115:21]
          busy_17 <= 2'h3;
        end else begin
          busy_17 <= _busy_17_T_3;
        end
      end else if (clear_16) begin // @[Mux.scala 101:16]
        busy_17 <= _busy_17_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_18 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_18_T)) begin // @[Mux.scala 101:16]
      if (set_17) begin // @[Mux.scala 101:16]
        if (busy_18 == 2'h3) begin // @[dut.scala 115:21]
          busy_18 <= 2'h3;
        end else begin
          busy_18 <= _busy_18_T_3;
        end
      end else if (clear_17) begin // @[Mux.scala 101:16]
        busy_18 <= _busy_18_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_19 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_19_T)) begin // @[Mux.scala 101:16]
      if (set_18) begin // @[Mux.scala 101:16]
        if (busy_19 == 2'h3) begin // @[dut.scala 115:21]
          busy_19 <= 2'h3;
        end else begin
          busy_19 <= _busy_19_T_3;
        end
      end else if (clear_18) begin // @[Mux.scala 101:16]
        busy_19 <= _busy_19_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_20 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_20_T)) begin // @[Mux.scala 101:16]
      if (set_19) begin // @[Mux.scala 101:16]
        if (busy_20 == 2'h3) begin // @[dut.scala 115:21]
          busy_20 <= 2'h3;
        end else begin
          busy_20 <= _busy_20_T_3;
        end
      end else if (clear_19) begin // @[Mux.scala 101:16]
        busy_20 <= _busy_20_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_21 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_21_T)) begin // @[Mux.scala 101:16]
      if (set_20) begin // @[Mux.scala 101:16]
        if (busy_21 == 2'h3) begin // @[dut.scala 115:21]
          busy_21 <= 2'h3;
        end else begin
          busy_21 <= _busy_21_T_3;
        end
      end else if (clear_20) begin // @[Mux.scala 101:16]
        busy_21 <= _busy_21_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_22 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_22_T)) begin // @[Mux.scala 101:16]
      if (set_21) begin // @[Mux.scala 101:16]
        if (busy_22 == 2'h3) begin // @[dut.scala 115:21]
          busy_22 <= 2'h3;
        end else begin
          busy_22 <= _busy_22_T_3;
        end
      end else if (clear_21) begin // @[Mux.scala 101:16]
        busy_22 <= _busy_22_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_23 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_23_T)) begin // @[Mux.scala 101:16]
      if (set_22) begin // @[Mux.scala 101:16]
        if (busy_23 == 2'h3) begin // @[dut.scala 115:21]
          busy_23 <= 2'h3;
        end else begin
          busy_23 <= _busy_23_T_3;
        end
      end else if (clear_22) begin // @[Mux.scala 101:16]
        busy_23 <= _busy_23_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_24 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_24_T)) begin // @[Mux.scala 101:16]
      if (set_23) begin // @[Mux.scala 101:16]
        if (busy_24 == 2'h3) begin // @[dut.scala 115:21]
          busy_24 <= 2'h3;
        end else begin
          busy_24 <= _busy_24_T_3;
        end
      end else if (clear_23) begin // @[Mux.scala 101:16]
        busy_24 <= _busy_24_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_25 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_25_T)) begin // @[Mux.scala 101:16]
      if (set_24) begin // @[Mux.scala 101:16]
        if (busy_25 == 2'h3) begin // @[dut.scala 115:21]
          busy_25 <= 2'h3;
        end else begin
          busy_25 <= _busy_25_T_3;
        end
      end else if (clear_24) begin // @[Mux.scala 101:16]
        busy_25 <= _busy_25_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_26 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_26_T)) begin // @[Mux.scala 101:16]
      if (set_25) begin // @[Mux.scala 101:16]
        if (busy_26 == 2'h3) begin // @[dut.scala 115:21]
          busy_26 <= 2'h3;
        end else begin
          busy_26 <= _busy_26_T_3;
        end
      end else if (clear_25) begin // @[Mux.scala 101:16]
        busy_26 <= _busy_26_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_27 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_27_T)) begin // @[Mux.scala 101:16]
      if (set_26) begin // @[Mux.scala 101:16]
        if (busy_27 == 2'h3) begin // @[dut.scala 115:21]
          busy_27 <= 2'h3;
        end else begin
          busy_27 <= _busy_27_T_3;
        end
      end else if (clear_26) begin // @[Mux.scala 101:16]
        busy_27 <= _busy_27_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_28 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_28_T)) begin // @[Mux.scala 101:16]
      if (set_27) begin // @[Mux.scala 101:16]
        if (busy_28 == 2'h3) begin // @[dut.scala 115:21]
          busy_28 <= 2'h3;
        end else begin
          busy_28 <= _busy_28_T_3;
        end
      end else if (clear_27) begin // @[Mux.scala 101:16]
        busy_28 <= _busy_28_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_29 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_29_T)) begin // @[Mux.scala 101:16]
      if (set_28) begin // @[Mux.scala 101:16]
        if (busy_29 == 2'h3) begin // @[dut.scala 115:21]
          busy_29 <= 2'h3;
        end else begin
          busy_29 <= _busy_29_T_3;
        end
      end else if (clear_28) begin // @[Mux.scala 101:16]
        busy_29 <= _busy_29_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_30 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_30_T)) begin // @[Mux.scala 101:16]
      if (set_29) begin // @[Mux.scala 101:16]
        if (busy_30 == 2'h3) begin // @[dut.scala 115:21]
          busy_30 <= 2'h3;
        end else begin
          busy_30 <= _busy_30_T_3;
        end
      end else if (clear_29) begin // @[Mux.scala 101:16]
        busy_30 <= _busy_30_T_8;
      end
    end
    if (reset) begin // @[dut.scala 89:21]
      busy_31 <= 2'h0; // @[dut.scala 89:21]
    end else if (!(_busy_31_T)) begin // @[Mux.scala 101:16]
      if (set_30) begin // @[Mux.scala 101:16]
        if (busy_31 == 2'h3) begin // @[dut.scala 115:21]
          busy_31 <= 2'h3;
        end else begin
          busy_31 <= _busy_31_T_3;
        end
      end else if (clear_30) begin // @[Mux.scala 101:16]
        busy_31 <= _busy_31_T_8;
      end
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
  busy_1 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  busy_2 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  busy_3 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  busy_4 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  busy_5 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  busy_6 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  busy_7 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  busy_8 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  busy_9 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  busy_10 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  busy_11 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  busy_12 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  busy_13 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  busy_14 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  busy_15 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  busy_16 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  busy_17 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  busy_18 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  busy_19 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  busy_20 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  busy_21 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  busy_22 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  busy_23 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  busy_24 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  busy_25 = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  busy_26 = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  busy_27 = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  busy_28 = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  busy_29 = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  busy_30 = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  busy_31 = _RAND_30[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
