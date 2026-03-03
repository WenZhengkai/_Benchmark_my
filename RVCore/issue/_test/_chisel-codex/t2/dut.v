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
  input  [2:0]  io_from_idu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc1Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuType,
  input  [6:0]  io_from_idu_bits_ctrl_fuOpType,
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
  output [2:0]  io_to_exu_bits_ctrl_ResSrc,
  output [2:0]  io_to_exu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_exu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [6:0]  io_to_exu_bits_ctrl_fuOpType,
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
  reg [1:0] busy_1; // @[dut.scala 70:29]
  reg [1:0] busy_2; // @[dut.scala 70:29]
  reg [1:0] busy_3; // @[dut.scala 70:29]
  reg [1:0] busy_4; // @[dut.scala 70:29]
  reg [1:0] busy_5; // @[dut.scala 70:29]
  reg [1:0] busy_6; // @[dut.scala 70:29]
  reg [1:0] busy_7; // @[dut.scala 70:29]
  reg [1:0] busy_8; // @[dut.scala 70:29]
  reg [1:0] busy_9; // @[dut.scala 70:29]
  reg [1:0] busy_10; // @[dut.scala 70:29]
  reg [1:0] busy_11; // @[dut.scala 70:29]
  reg [1:0] busy_12; // @[dut.scala 70:29]
  reg [1:0] busy_13; // @[dut.scala 70:29]
  reg [1:0] busy_14; // @[dut.scala 70:29]
  reg [1:0] busy_15; // @[dut.scala 70:29]
  reg [1:0] busy_16; // @[dut.scala 70:29]
  reg [1:0] busy_17; // @[dut.scala 70:29]
  reg [1:0] busy_18; // @[dut.scala 70:29]
  reg [1:0] busy_19; // @[dut.scala 70:29]
  reg [1:0] busy_20; // @[dut.scala 70:29]
  reg [1:0] busy_21; // @[dut.scala 70:29]
  reg [1:0] busy_22; // @[dut.scala 70:29]
  reg [1:0] busy_23; // @[dut.scala 70:29]
  reg [1:0] busy_24; // @[dut.scala 70:29]
  reg [1:0] busy_25; // @[dut.scala 70:29]
  reg [1:0] busy_26; // @[dut.scala 70:29]
  reg [1:0] busy_27; // @[dut.scala 70:29]
  reg [1:0] busy_28; // @[dut.scala 70:29]
  reg [1:0] busy_29; // @[dut.scala 70:29]
  reg [1:0] busy_30; // @[dut.scala 70:29]
  reg [1:0] busy_31; // @[dut.scala 70:29]
  wire  _rs1Fwd_T_1 = io_wb_RegWrite & io_wb_rd != 5'h0; // @[dut.scala 116:35]
  wire [63:0] rs1Fwd = io_wb_RegWrite & io_wb_rd != 5'h0 & io_wb_rd == io_from_idu_bits_ctrl_rs1 ? io_wb_Res :
    io_from_reg_rfSrc1; // @[dut.scala 116:19]
  wire [63:0] rs2Fwd = _rs1Fwd_T_1 & io_wb_rd == io_from_idu_bits_ctrl_rs2 ? io_wb_Res : io_from_reg_rfSrc2; // @[dut.scala 117:19]
  wire [63:0] _io_to_exu_bits_data_fuSrc1_T_5 = 3'h0 == io_from_idu_bits_ctrl_fuSrc1Type ? rs1Fwd : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_to_exu_bits_data_fuSrc1_T_7 = 3'h1 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_idu_bits_cf_pc :
    _io_to_exu_bits_data_fuSrc1_T_5; // @[Mux.scala 81:58]
  wire [63:0] _io_to_exu_bits_data_fuSrc2_T_5 = 3'h3 == io_from_idu_bits_ctrl_fuSrc2Type ? rs2Fwd : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_to_exu_bits_data_fuSrc2_T_7 = 3'h4 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_idu_bits_data_imm :
    _io_to_exu_bits_data_fuSrc2_T_5; // @[Mux.scala 81:58]
  wire  rs1Need = io_from_idu_bits_ctrl_fuSrc1Type == 3'h0; // @[dut.scala 142:40]
  wire  rs2Need = io_from_idu_bits_ctrl_fuSrc2Type == 3'h3; // @[dut.scala 143:40]
  wire [1:0] _GEN_1 = 5'h1 == io_from_idu_bits_ctrl_rs1 ? busy_1 : 2'h0; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_2 = 5'h2 == io_from_idu_bits_ctrl_rs1 ? busy_2 : _GEN_1; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_3 = 5'h3 == io_from_idu_bits_ctrl_rs1 ? busy_3 : _GEN_2; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_4 = 5'h4 == io_from_idu_bits_ctrl_rs1 ? busy_4 : _GEN_3; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_5 = 5'h5 == io_from_idu_bits_ctrl_rs1 ? busy_5 : _GEN_4; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_6 = 5'h6 == io_from_idu_bits_ctrl_rs1 ? busy_6 : _GEN_5; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_7 = 5'h7 == io_from_idu_bits_ctrl_rs1 ? busy_7 : _GEN_6; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_8 = 5'h8 == io_from_idu_bits_ctrl_rs1 ? busy_8 : _GEN_7; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_9 = 5'h9 == io_from_idu_bits_ctrl_rs1 ? busy_9 : _GEN_8; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_10 = 5'ha == io_from_idu_bits_ctrl_rs1 ? busy_10 : _GEN_9; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_11 = 5'hb == io_from_idu_bits_ctrl_rs1 ? busy_11 : _GEN_10; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_12 = 5'hc == io_from_idu_bits_ctrl_rs1 ? busy_12 : _GEN_11; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_13 = 5'hd == io_from_idu_bits_ctrl_rs1 ? busy_13 : _GEN_12; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_14 = 5'he == io_from_idu_bits_ctrl_rs1 ? busy_14 : _GEN_13; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_15 = 5'hf == io_from_idu_bits_ctrl_rs1 ? busy_15 : _GEN_14; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_16 = 5'h10 == io_from_idu_bits_ctrl_rs1 ? busy_16 : _GEN_15; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_17 = 5'h11 == io_from_idu_bits_ctrl_rs1 ? busy_17 : _GEN_16; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_18 = 5'h12 == io_from_idu_bits_ctrl_rs1 ? busy_18 : _GEN_17; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_19 = 5'h13 == io_from_idu_bits_ctrl_rs1 ? busy_19 : _GEN_18; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_20 = 5'h14 == io_from_idu_bits_ctrl_rs1 ? busy_20 : _GEN_19; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_21 = 5'h15 == io_from_idu_bits_ctrl_rs1 ? busy_21 : _GEN_20; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_22 = 5'h16 == io_from_idu_bits_ctrl_rs1 ? busy_22 : _GEN_21; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_23 = 5'h17 == io_from_idu_bits_ctrl_rs1 ? busy_23 : _GEN_22; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_24 = 5'h18 == io_from_idu_bits_ctrl_rs1 ? busy_24 : _GEN_23; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_25 = 5'h19 == io_from_idu_bits_ctrl_rs1 ? busy_25 : _GEN_24; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_26 = 5'h1a == io_from_idu_bits_ctrl_rs1 ? busy_26 : _GEN_25; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_27 = 5'h1b == io_from_idu_bits_ctrl_rs1 ? busy_27 : _GEN_26; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_28 = 5'h1c == io_from_idu_bits_ctrl_rs1 ? busy_28 : _GEN_27; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_29 = 5'h1d == io_from_idu_bits_ctrl_rs1 ? busy_29 : _GEN_28; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_30 = 5'h1e == io_from_idu_bits_ctrl_rs1 ? busy_30 : _GEN_29; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_31 = 5'h1f == io_from_idu_bits_ctrl_rs1 ? busy_31 : _GEN_30; // @[dut.scala 72:{69,69}]
  wire  _anyInvalidCondition_T_2 = io_from_idu_bits_ctrl_rs1 == 5'h0 ? 1'h0 : _GEN_31 != 2'h0; // @[dut.scala 72:36]
  wire [1:0] _GEN_33 = 5'h1 == io_from_idu_bits_ctrl_rs2 ? busy_1 : 2'h0; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_34 = 5'h2 == io_from_idu_bits_ctrl_rs2 ? busy_2 : _GEN_33; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_35 = 5'h3 == io_from_idu_bits_ctrl_rs2 ? busy_3 : _GEN_34; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_36 = 5'h4 == io_from_idu_bits_ctrl_rs2 ? busy_4 : _GEN_35; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_37 = 5'h5 == io_from_idu_bits_ctrl_rs2 ? busy_5 : _GEN_36; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_38 = 5'h6 == io_from_idu_bits_ctrl_rs2 ? busy_6 : _GEN_37; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_39 = 5'h7 == io_from_idu_bits_ctrl_rs2 ? busy_7 : _GEN_38; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_40 = 5'h8 == io_from_idu_bits_ctrl_rs2 ? busy_8 : _GEN_39; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_41 = 5'h9 == io_from_idu_bits_ctrl_rs2 ? busy_9 : _GEN_40; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_42 = 5'ha == io_from_idu_bits_ctrl_rs2 ? busy_10 : _GEN_41; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_43 = 5'hb == io_from_idu_bits_ctrl_rs2 ? busy_11 : _GEN_42; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_44 = 5'hc == io_from_idu_bits_ctrl_rs2 ? busy_12 : _GEN_43; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_45 = 5'hd == io_from_idu_bits_ctrl_rs2 ? busy_13 : _GEN_44; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_46 = 5'he == io_from_idu_bits_ctrl_rs2 ? busy_14 : _GEN_45; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_47 = 5'hf == io_from_idu_bits_ctrl_rs2 ? busy_15 : _GEN_46; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_48 = 5'h10 == io_from_idu_bits_ctrl_rs2 ? busy_16 : _GEN_47; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_49 = 5'h11 == io_from_idu_bits_ctrl_rs2 ? busy_17 : _GEN_48; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_50 = 5'h12 == io_from_idu_bits_ctrl_rs2 ? busy_18 : _GEN_49; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_51 = 5'h13 == io_from_idu_bits_ctrl_rs2 ? busy_19 : _GEN_50; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_52 = 5'h14 == io_from_idu_bits_ctrl_rs2 ? busy_20 : _GEN_51; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_53 = 5'h15 == io_from_idu_bits_ctrl_rs2 ? busy_21 : _GEN_52; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_54 = 5'h16 == io_from_idu_bits_ctrl_rs2 ? busy_22 : _GEN_53; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_55 = 5'h17 == io_from_idu_bits_ctrl_rs2 ? busy_23 : _GEN_54; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_56 = 5'h18 == io_from_idu_bits_ctrl_rs2 ? busy_24 : _GEN_55; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_57 = 5'h19 == io_from_idu_bits_ctrl_rs2 ? busy_25 : _GEN_56; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_58 = 5'h1a == io_from_idu_bits_ctrl_rs2 ? busy_26 : _GEN_57; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_59 = 5'h1b == io_from_idu_bits_ctrl_rs2 ? busy_27 : _GEN_58; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_60 = 5'h1c == io_from_idu_bits_ctrl_rs2 ? busy_28 : _GEN_59; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_61 = 5'h1d == io_from_idu_bits_ctrl_rs2 ? busy_29 : _GEN_60; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_62 = 5'h1e == io_from_idu_bits_ctrl_rs2 ? busy_30 : _GEN_61; // @[dut.scala 72:{69,69}]
  wire [1:0] _GEN_63 = 5'h1f == io_from_idu_bits_ctrl_rs2 ? busy_31 : _GEN_62; // @[dut.scala 72:{69,69}]
  wire  _anyInvalidCondition_T_6 = io_from_idu_bits_ctrl_rs2 == 5'h0 ? 1'h0 : _GEN_63 != 2'h0; // @[dut.scala 72:36]
  wire  anyInvalidCondition = rs1Need & _anyInvalidCondition_T_2 | rs2Need & _anyInvalidCondition_T_6; // @[dut.scala 144:69]
  wire  _io_to_exu_valid_T = ~anyInvalidCondition; // @[dut.scala 104:30]
  wire [31:0] _wbuClearMask_T = 32'h1 << io_wb_rd; // @[OneHot.scala 64:12]
  wire [31:0] wbuClearMask = io_wb_RegWrite ? _wbuClearMask_T : 32'h0; // @[dut.scala 150:25]
  wire  _isFireSetMask_T = io_to_exu_ready & io_to_exu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _isFireSetMask_T_2 = 32'h1 << io_from_idu_bits_ctrl_rd; // @[OneHot.scala 64:12]
  wire [31:0] isFireSetMask = io_from_idu_bits_ctrl_rfWen & _isFireSetMask_T ? _isFireSetMask_T_2 : 32'h0; // @[dut.scala 151:26]
  wire  set = isFireSetMask[1]; // @[dut.scala 79:24]
  wire  clr = wbuClearMask[1]; // @[dut.scala 80:26]
  wire [1:0] _busy_1_T_1 = busy_1 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_1_T_3 = busy_1 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_65 = busy_1 != 2'h0 ? _busy_1_T_3 : busy_1; // @[dut.scala 70:29 86:{31,41}]
  wire  set_1 = isFireSetMask[2]; // @[dut.scala 79:24]
  wire  clr_1 = wbuClearMask[2]; // @[dut.scala 80:26]
  wire [1:0] _busy_2_T_1 = busy_2 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_2_T_3 = busy_2 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_70 = busy_2 != 2'h0 ? _busy_2_T_3 : busy_2; // @[dut.scala 70:29 86:{31,41}]
  wire  set_2 = isFireSetMask[3]; // @[dut.scala 79:24]
  wire  clr_2 = wbuClearMask[3]; // @[dut.scala 80:26]
  wire [1:0] _busy_3_T_1 = busy_3 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_3_T_3 = busy_3 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_75 = busy_3 != 2'h0 ? _busy_3_T_3 : busy_3; // @[dut.scala 70:29 86:{31,41}]
  wire  set_3 = isFireSetMask[4]; // @[dut.scala 79:24]
  wire  clr_3 = wbuClearMask[4]; // @[dut.scala 80:26]
  wire [1:0] _busy_4_T_1 = busy_4 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_4_T_3 = busy_4 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_80 = busy_4 != 2'h0 ? _busy_4_T_3 : busy_4; // @[dut.scala 70:29 86:{31,41}]
  wire  set_4 = isFireSetMask[5]; // @[dut.scala 79:24]
  wire  clr_4 = wbuClearMask[5]; // @[dut.scala 80:26]
  wire [1:0] _busy_5_T_1 = busy_5 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_5_T_3 = busy_5 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_85 = busy_5 != 2'h0 ? _busy_5_T_3 : busy_5; // @[dut.scala 70:29 86:{31,41}]
  wire  set_5 = isFireSetMask[6]; // @[dut.scala 79:24]
  wire  clr_5 = wbuClearMask[6]; // @[dut.scala 80:26]
  wire [1:0] _busy_6_T_1 = busy_6 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_6_T_3 = busy_6 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_90 = busy_6 != 2'h0 ? _busy_6_T_3 : busy_6; // @[dut.scala 70:29 86:{31,41}]
  wire  set_6 = isFireSetMask[7]; // @[dut.scala 79:24]
  wire  clr_6 = wbuClearMask[7]; // @[dut.scala 80:26]
  wire [1:0] _busy_7_T_1 = busy_7 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_7_T_3 = busy_7 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_95 = busy_7 != 2'h0 ? _busy_7_T_3 : busy_7; // @[dut.scala 70:29 86:{31,41}]
  wire  set_7 = isFireSetMask[8]; // @[dut.scala 79:24]
  wire  clr_7 = wbuClearMask[8]; // @[dut.scala 80:26]
  wire [1:0] _busy_8_T_1 = busy_8 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_8_T_3 = busy_8 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_100 = busy_8 != 2'h0 ? _busy_8_T_3 : busy_8; // @[dut.scala 70:29 86:{31,41}]
  wire  set_8 = isFireSetMask[9]; // @[dut.scala 79:24]
  wire  clr_8 = wbuClearMask[9]; // @[dut.scala 80:26]
  wire [1:0] _busy_9_T_1 = busy_9 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_9_T_3 = busy_9 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_105 = busy_9 != 2'h0 ? _busy_9_T_3 : busy_9; // @[dut.scala 70:29 86:{31,41}]
  wire  set_9 = isFireSetMask[10]; // @[dut.scala 79:24]
  wire  clr_9 = wbuClearMask[10]; // @[dut.scala 80:26]
  wire [1:0] _busy_10_T_1 = busy_10 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_10_T_3 = busy_10 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_110 = busy_10 != 2'h0 ? _busy_10_T_3 : busy_10; // @[dut.scala 70:29 86:{31,41}]
  wire  set_10 = isFireSetMask[11]; // @[dut.scala 79:24]
  wire  clr_10 = wbuClearMask[11]; // @[dut.scala 80:26]
  wire [1:0] _busy_11_T_1 = busy_11 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_11_T_3 = busy_11 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_115 = busy_11 != 2'h0 ? _busy_11_T_3 : busy_11; // @[dut.scala 70:29 86:{31,41}]
  wire  set_11 = isFireSetMask[12]; // @[dut.scala 79:24]
  wire  clr_11 = wbuClearMask[12]; // @[dut.scala 80:26]
  wire [1:0] _busy_12_T_1 = busy_12 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_12_T_3 = busy_12 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_120 = busy_12 != 2'h0 ? _busy_12_T_3 : busy_12; // @[dut.scala 70:29 86:{31,41}]
  wire  set_12 = isFireSetMask[13]; // @[dut.scala 79:24]
  wire  clr_12 = wbuClearMask[13]; // @[dut.scala 80:26]
  wire [1:0] _busy_13_T_1 = busy_13 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_13_T_3 = busy_13 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_125 = busy_13 != 2'h0 ? _busy_13_T_3 : busy_13; // @[dut.scala 70:29 86:{31,41}]
  wire  set_13 = isFireSetMask[14]; // @[dut.scala 79:24]
  wire  clr_13 = wbuClearMask[14]; // @[dut.scala 80:26]
  wire [1:0] _busy_14_T_1 = busy_14 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_14_T_3 = busy_14 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_130 = busy_14 != 2'h0 ? _busy_14_T_3 : busy_14; // @[dut.scala 70:29 86:{31,41}]
  wire  set_14 = isFireSetMask[15]; // @[dut.scala 79:24]
  wire  clr_14 = wbuClearMask[15]; // @[dut.scala 80:26]
  wire [1:0] _busy_15_T_1 = busy_15 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_15_T_3 = busy_15 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_135 = busy_15 != 2'h0 ? _busy_15_T_3 : busy_15; // @[dut.scala 70:29 86:{31,41}]
  wire  set_15 = isFireSetMask[16]; // @[dut.scala 79:24]
  wire  clr_15 = wbuClearMask[16]; // @[dut.scala 80:26]
  wire [1:0] _busy_16_T_1 = busy_16 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_16_T_3 = busy_16 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_140 = busy_16 != 2'h0 ? _busy_16_T_3 : busy_16; // @[dut.scala 70:29 86:{31,41}]
  wire  set_16 = isFireSetMask[17]; // @[dut.scala 79:24]
  wire  clr_16 = wbuClearMask[17]; // @[dut.scala 80:26]
  wire [1:0] _busy_17_T_1 = busy_17 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_17_T_3 = busy_17 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_145 = busy_17 != 2'h0 ? _busy_17_T_3 : busy_17; // @[dut.scala 70:29 86:{31,41}]
  wire  set_17 = isFireSetMask[18]; // @[dut.scala 79:24]
  wire  clr_17 = wbuClearMask[18]; // @[dut.scala 80:26]
  wire [1:0] _busy_18_T_1 = busy_18 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_18_T_3 = busy_18 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_150 = busy_18 != 2'h0 ? _busy_18_T_3 : busy_18; // @[dut.scala 70:29 86:{31,41}]
  wire  set_18 = isFireSetMask[19]; // @[dut.scala 79:24]
  wire  clr_18 = wbuClearMask[19]; // @[dut.scala 80:26]
  wire [1:0] _busy_19_T_1 = busy_19 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_19_T_3 = busy_19 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_155 = busy_19 != 2'h0 ? _busy_19_T_3 : busy_19; // @[dut.scala 70:29 86:{31,41}]
  wire  set_19 = isFireSetMask[20]; // @[dut.scala 79:24]
  wire  clr_19 = wbuClearMask[20]; // @[dut.scala 80:26]
  wire [1:0] _busy_20_T_1 = busy_20 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_20_T_3 = busy_20 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_160 = busy_20 != 2'h0 ? _busy_20_T_3 : busy_20; // @[dut.scala 70:29 86:{31,41}]
  wire  set_20 = isFireSetMask[21]; // @[dut.scala 79:24]
  wire  clr_20 = wbuClearMask[21]; // @[dut.scala 80:26]
  wire [1:0] _busy_21_T_1 = busy_21 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_21_T_3 = busy_21 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_165 = busy_21 != 2'h0 ? _busy_21_T_3 : busy_21; // @[dut.scala 70:29 86:{31,41}]
  wire  set_21 = isFireSetMask[22]; // @[dut.scala 79:24]
  wire  clr_21 = wbuClearMask[22]; // @[dut.scala 80:26]
  wire [1:0] _busy_22_T_1 = busy_22 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_22_T_3 = busy_22 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_170 = busy_22 != 2'h0 ? _busy_22_T_3 : busy_22; // @[dut.scala 70:29 86:{31,41}]
  wire  set_22 = isFireSetMask[23]; // @[dut.scala 79:24]
  wire  clr_22 = wbuClearMask[23]; // @[dut.scala 80:26]
  wire [1:0] _busy_23_T_1 = busy_23 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_23_T_3 = busy_23 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_175 = busy_23 != 2'h0 ? _busy_23_T_3 : busy_23; // @[dut.scala 70:29 86:{31,41}]
  wire  set_23 = isFireSetMask[24]; // @[dut.scala 79:24]
  wire  clr_23 = wbuClearMask[24]; // @[dut.scala 80:26]
  wire [1:0] _busy_24_T_1 = busy_24 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_24_T_3 = busy_24 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_180 = busy_24 != 2'h0 ? _busy_24_T_3 : busy_24; // @[dut.scala 70:29 86:{31,41}]
  wire  set_24 = isFireSetMask[25]; // @[dut.scala 79:24]
  wire  clr_24 = wbuClearMask[25]; // @[dut.scala 80:26]
  wire [1:0] _busy_25_T_1 = busy_25 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_25_T_3 = busy_25 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_185 = busy_25 != 2'h0 ? _busy_25_T_3 : busy_25; // @[dut.scala 70:29 86:{31,41}]
  wire  set_25 = isFireSetMask[26]; // @[dut.scala 79:24]
  wire  clr_25 = wbuClearMask[26]; // @[dut.scala 80:26]
  wire [1:0] _busy_26_T_1 = busy_26 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_26_T_3 = busy_26 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_190 = busy_26 != 2'h0 ? _busy_26_T_3 : busy_26; // @[dut.scala 70:29 86:{31,41}]
  wire  set_26 = isFireSetMask[27]; // @[dut.scala 79:24]
  wire  clr_26 = wbuClearMask[27]; // @[dut.scala 80:26]
  wire [1:0] _busy_27_T_1 = busy_27 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_27_T_3 = busy_27 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_195 = busy_27 != 2'h0 ? _busy_27_T_3 : busy_27; // @[dut.scala 70:29 86:{31,41}]
  wire  set_27 = isFireSetMask[28]; // @[dut.scala 79:24]
  wire  clr_27 = wbuClearMask[28]; // @[dut.scala 80:26]
  wire [1:0] _busy_28_T_1 = busy_28 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_28_T_3 = busy_28 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_200 = busy_28 != 2'h0 ? _busy_28_T_3 : busy_28; // @[dut.scala 70:29 86:{31,41}]
  wire  set_28 = isFireSetMask[29]; // @[dut.scala 79:24]
  wire  clr_28 = wbuClearMask[29]; // @[dut.scala 80:26]
  wire [1:0] _busy_29_T_1 = busy_29 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_29_T_3 = busy_29 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_205 = busy_29 != 2'h0 ? _busy_29_T_3 : busy_29; // @[dut.scala 70:29 86:{31,41}]
  wire  set_29 = isFireSetMask[30]; // @[dut.scala 79:24]
  wire  clr_29 = wbuClearMask[30]; // @[dut.scala 80:26]
  wire [1:0] _busy_30_T_1 = busy_30 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_30_T_3 = busy_30 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_210 = busy_30 != 2'h0 ? _busy_30_T_3 : busy_30; // @[dut.scala 70:29 86:{31,41}]
  wire  set_30 = isFireSetMask[31]; // @[dut.scala 79:24]
  wire  clr_30 = wbuClearMask[31]; // @[dut.scala 80:26]
  wire [1:0] _busy_31_T_1 = busy_31 + 2'h1; // @[dut.scala 84:59]
  wire [1:0] _busy_31_T_3 = busy_31 - 2'h1; // @[dut.scala 86:52]
  wire [1:0] _GEN_215 = busy_31 != 2'h0 ? _busy_31_T_3 : busy_31; // @[dut.scala 70:29 86:{31,41}]
  assign io_from_idu_ready = io_to_exu_ready & _io_to_exu_valid_T; // @[dut.scala 105:27]
  assign io_to_exu_valid = io_from_idu_valid & ~anyInvalidCondition; // @[dut.scala 104:27]
  assign io_to_exu_bits_cf_inst = io_from_idu_bits_cf_inst; // @[dut.scala 113:12]
  assign io_to_exu_bits_cf_pc = io_from_idu_bits_cf_pc; // @[dut.scala 113:12]
  assign io_to_exu_bits_cf_next_pc = io_from_idu_bits_cf_next_pc; // @[dut.scala 113:12]
  assign io_to_exu_bits_cf_isBranch = io_from_idu_bits_cf_isBranch; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_MemWrite = io_from_idu_bits_ctrl_MemWrite; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_ResSrc = io_from_idu_bits_ctrl_ResSrc; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_fuSrc1Type = io_from_idu_bits_ctrl_fuSrc1Type; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_fuSrc2Type = io_from_idu_bits_ctrl_fuSrc2Type; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_fuType = io_from_idu_bits_ctrl_fuType; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_fuOpType = io_from_idu_bits_ctrl_fuOpType; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_rs1 = io_from_idu_bits_ctrl_rs1; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_rs2 = io_from_idu_bits_ctrl_rs2; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_rfWen = io_from_idu_bits_ctrl_rfWen; // @[dut.scala 113:12]
  assign io_to_exu_bits_ctrl_rd = io_from_idu_bits_ctrl_rd; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_fuSrc1 = 3'h2 == io_from_idu_bits_ctrl_fuSrc1Type ? 64'h0 : _io_to_exu_bits_data_fuSrc1_T_7
    ; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_fuSrc2 = 3'h5 == io_from_idu_bits_ctrl_fuSrc2Type ? 64'h4 : _io_to_exu_bits_data_fuSrc2_T_7
    ; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_imm = io_from_idu_bits_data_imm; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_Alu0Res_ready = io_from_idu_bits_data_Alu0Res_ready; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_Alu0Res_valid = io_from_idu_bits_data_Alu0Res_valid; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_Alu0Res_bits = io_from_idu_bits_data_Alu0Res_bits; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_data_from_mem = io_from_idu_bits_data_data_from_mem; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_csrRdata = io_from_idu_bits_data_csrRdata; // @[dut.scala 113:12]
  assign io_to_exu_bits_data_rfSrc1 = io_wb_RegWrite & io_wb_rd != 5'h0 & io_wb_rd == io_from_idu_bits_ctrl_rs1 ?
    io_wb_Res : io_from_reg_rfSrc1; // @[dut.scala 116:19]
  assign io_to_exu_bits_data_rfSrc2 = _rs1Fwd_T_1 & io_wb_rd == io_from_idu_bits_ctrl_rs2 ? io_wb_Res :
    io_from_reg_rfSrc2; // @[dut.scala 117:19]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 70:29]
      busy_1 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set & clr)) begin // @[dut.scala 81:24]
      if (set) begin // @[dut.scala 83:23]
        if (busy_1 != 2'h3) begin // @[dut.scala 84:38]
          busy_1 <= _busy_1_T_1; // @[dut.scala 84:48]
        end
      end else if (clr) begin // @[dut.scala 85:23]
        busy_1 <= _GEN_65;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_2 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_1 & clr_1)) begin // @[dut.scala 81:24]
      if (set_1) begin // @[dut.scala 83:23]
        if (busy_2 != 2'h3) begin // @[dut.scala 84:38]
          busy_2 <= _busy_2_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_1) begin // @[dut.scala 85:23]
        busy_2 <= _GEN_70;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_3 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_2 & clr_2)) begin // @[dut.scala 81:24]
      if (set_2) begin // @[dut.scala 83:23]
        if (busy_3 != 2'h3) begin // @[dut.scala 84:38]
          busy_3 <= _busy_3_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_2) begin // @[dut.scala 85:23]
        busy_3 <= _GEN_75;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_4 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_3 & clr_3)) begin // @[dut.scala 81:24]
      if (set_3) begin // @[dut.scala 83:23]
        if (busy_4 != 2'h3) begin // @[dut.scala 84:38]
          busy_4 <= _busy_4_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_3) begin // @[dut.scala 85:23]
        busy_4 <= _GEN_80;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_5 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_4 & clr_4)) begin // @[dut.scala 81:24]
      if (set_4) begin // @[dut.scala 83:23]
        if (busy_5 != 2'h3) begin // @[dut.scala 84:38]
          busy_5 <= _busy_5_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_4) begin // @[dut.scala 85:23]
        busy_5 <= _GEN_85;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_6 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_5 & clr_5)) begin // @[dut.scala 81:24]
      if (set_5) begin // @[dut.scala 83:23]
        if (busy_6 != 2'h3) begin // @[dut.scala 84:38]
          busy_6 <= _busy_6_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_5) begin // @[dut.scala 85:23]
        busy_6 <= _GEN_90;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_7 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_6 & clr_6)) begin // @[dut.scala 81:24]
      if (set_6) begin // @[dut.scala 83:23]
        if (busy_7 != 2'h3) begin // @[dut.scala 84:38]
          busy_7 <= _busy_7_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_6) begin // @[dut.scala 85:23]
        busy_7 <= _GEN_95;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_8 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_7 & clr_7)) begin // @[dut.scala 81:24]
      if (set_7) begin // @[dut.scala 83:23]
        if (busy_8 != 2'h3) begin // @[dut.scala 84:38]
          busy_8 <= _busy_8_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_7) begin // @[dut.scala 85:23]
        busy_8 <= _GEN_100;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_9 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_8 & clr_8)) begin // @[dut.scala 81:24]
      if (set_8) begin // @[dut.scala 83:23]
        if (busy_9 != 2'h3) begin // @[dut.scala 84:38]
          busy_9 <= _busy_9_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_8) begin // @[dut.scala 85:23]
        busy_9 <= _GEN_105;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_10 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_9 & clr_9)) begin // @[dut.scala 81:24]
      if (set_9) begin // @[dut.scala 83:23]
        if (busy_10 != 2'h3) begin // @[dut.scala 84:38]
          busy_10 <= _busy_10_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_9) begin // @[dut.scala 85:23]
        busy_10 <= _GEN_110;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_11 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_10 & clr_10)) begin // @[dut.scala 81:24]
      if (set_10) begin // @[dut.scala 83:23]
        if (busy_11 != 2'h3) begin // @[dut.scala 84:38]
          busy_11 <= _busy_11_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_10) begin // @[dut.scala 85:23]
        busy_11 <= _GEN_115;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_12 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_11 & clr_11)) begin // @[dut.scala 81:24]
      if (set_11) begin // @[dut.scala 83:23]
        if (busy_12 != 2'h3) begin // @[dut.scala 84:38]
          busy_12 <= _busy_12_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_11) begin // @[dut.scala 85:23]
        busy_12 <= _GEN_120;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_13 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_12 & clr_12)) begin // @[dut.scala 81:24]
      if (set_12) begin // @[dut.scala 83:23]
        if (busy_13 != 2'h3) begin // @[dut.scala 84:38]
          busy_13 <= _busy_13_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_12) begin // @[dut.scala 85:23]
        busy_13 <= _GEN_125;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_14 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_13 & clr_13)) begin // @[dut.scala 81:24]
      if (set_13) begin // @[dut.scala 83:23]
        if (busy_14 != 2'h3) begin // @[dut.scala 84:38]
          busy_14 <= _busy_14_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_13) begin // @[dut.scala 85:23]
        busy_14 <= _GEN_130;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_15 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_14 & clr_14)) begin // @[dut.scala 81:24]
      if (set_14) begin // @[dut.scala 83:23]
        if (busy_15 != 2'h3) begin // @[dut.scala 84:38]
          busy_15 <= _busy_15_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_14) begin // @[dut.scala 85:23]
        busy_15 <= _GEN_135;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_16 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_15 & clr_15)) begin // @[dut.scala 81:24]
      if (set_15) begin // @[dut.scala 83:23]
        if (busy_16 != 2'h3) begin // @[dut.scala 84:38]
          busy_16 <= _busy_16_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_15) begin // @[dut.scala 85:23]
        busy_16 <= _GEN_140;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_17 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_16 & clr_16)) begin // @[dut.scala 81:24]
      if (set_16) begin // @[dut.scala 83:23]
        if (busy_17 != 2'h3) begin // @[dut.scala 84:38]
          busy_17 <= _busy_17_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_16) begin // @[dut.scala 85:23]
        busy_17 <= _GEN_145;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_18 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_17 & clr_17)) begin // @[dut.scala 81:24]
      if (set_17) begin // @[dut.scala 83:23]
        if (busy_18 != 2'h3) begin // @[dut.scala 84:38]
          busy_18 <= _busy_18_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_17) begin // @[dut.scala 85:23]
        busy_18 <= _GEN_150;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_19 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_18 & clr_18)) begin // @[dut.scala 81:24]
      if (set_18) begin // @[dut.scala 83:23]
        if (busy_19 != 2'h3) begin // @[dut.scala 84:38]
          busy_19 <= _busy_19_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_18) begin // @[dut.scala 85:23]
        busy_19 <= _GEN_155;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_20 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_19 & clr_19)) begin // @[dut.scala 81:24]
      if (set_19) begin // @[dut.scala 83:23]
        if (busy_20 != 2'h3) begin // @[dut.scala 84:38]
          busy_20 <= _busy_20_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_19) begin // @[dut.scala 85:23]
        busy_20 <= _GEN_160;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_21 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_20 & clr_20)) begin // @[dut.scala 81:24]
      if (set_20) begin // @[dut.scala 83:23]
        if (busy_21 != 2'h3) begin // @[dut.scala 84:38]
          busy_21 <= _busy_21_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_20) begin // @[dut.scala 85:23]
        busy_21 <= _GEN_165;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_22 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_21 & clr_21)) begin // @[dut.scala 81:24]
      if (set_21) begin // @[dut.scala 83:23]
        if (busy_22 != 2'h3) begin // @[dut.scala 84:38]
          busy_22 <= _busy_22_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_21) begin // @[dut.scala 85:23]
        busy_22 <= _GEN_170;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_23 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_22 & clr_22)) begin // @[dut.scala 81:24]
      if (set_22) begin // @[dut.scala 83:23]
        if (busy_23 != 2'h3) begin // @[dut.scala 84:38]
          busy_23 <= _busy_23_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_22) begin // @[dut.scala 85:23]
        busy_23 <= _GEN_175;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_24 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_23 & clr_23)) begin // @[dut.scala 81:24]
      if (set_23) begin // @[dut.scala 83:23]
        if (busy_24 != 2'h3) begin // @[dut.scala 84:38]
          busy_24 <= _busy_24_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_23) begin // @[dut.scala 85:23]
        busy_24 <= _GEN_180;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_25 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_24 & clr_24)) begin // @[dut.scala 81:24]
      if (set_24) begin // @[dut.scala 83:23]
        if (busy_25 != 2'h3) begin // @[dut.scala 84:38]
          busy_25 <= _busy_25_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_24) begin // @[dut.scala 85:23]
        busy_25 <= _GEN_185;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_26 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_25 & clr_25)) begin // @[dut.scala 81:24]
      if (set_25) begin // @[dut.scala 83:23]
        if (busy_26 != 2'h3) begin // @[dut.scala 84:38]
          busy_26 <= _busy_26_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_25) begin // @[dut.scala 85:23]
        busy_26 <= _GEN_190;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_27 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_26 & clr_26)) begin // @[dut.scala 81:24]
      if (set_26) begin // @[dut.scala 83:23]
        if (busy_27 != 2'h3) begin // @[dut.scala 84:38]
          busy_27 <= _busy_27_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_26) begin // @[dut.scala 85:23]
        busy_27 <= _GEN_195;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_28 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_27 & clr_27)) begin // @[dut.scala 81:24]
      if (set_27) begin // @[dut.scala 83:23]
        if (busy_28 != 2'h3) begin // @[dut.scala 84:38]
          busy_28 <= _busy_28_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_27) begin // @[dut.scala 85:23]
        busy_28 <= _GEN_200;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_29 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_28 & clr_28)) begin // @[dut.scala 81:24]
      if (set_28) begin // @[dut.scala 83:23]
        if (busy_29 != 2'h3) begin // @[dut.scala 84:38]
          busy_29 <= _busy_29_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_28) begin // @[dut.scala 85:23]
        busy_29 <= _GEN_205;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_30 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_29 & clr_29)) begin // @[dut.scala 81:24]
      if (set_29) begin // @[dut.scala 83:23]
        if (busy_30 != 2'h3) begin // @[dut.scala 84:38]
          busy_30 <= _busy_30_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_29) begin // @[dut.scala 85:23]
        busy_30 <= _GEN_210;
      end
    end
    if (reset) begin // @[dut.scala 70:29]
      busy_31 <= 2'h0; // @[dut.scala 70:29]
    end else if (!(set_30 & clr_30)) begin // @[dut.scala 81:24]
      if (set_30) begin // @[dut.scala 83:23]
        if (busy_31 != 2'h3) begin // @[dut.scala 84:38]
          busy_31 <= _busy_31_T_1; // @[dut.scala 84:48]
        end
      end else if (clr_30) begin // @[dut.scala 85:23]
        busy_31 <= _GEN_215;
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
