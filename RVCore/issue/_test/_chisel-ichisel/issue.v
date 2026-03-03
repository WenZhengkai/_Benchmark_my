module ISU(
  input         clock,
  input         reset,
  output        io_from_idu_ready,
  input         io_from_idu_valid,
  input  [31:0] io_from_idu_bits_cf_inst,
  input  [31:0] io_from_idu_bits_cf_pc,
  input  [31:0] io_from_idu_bits_cf_next_pc,
  input         io_from_idu_bits_cf_isBranch,
  input         io_from_idu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_idu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc1Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuType,
  input  [6:0]  io_from_idu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_idu_bits_ctrl_rs1,
  input  [4:0]  io_from_idu_bits_ctrl_rs2,
  input         io_from_idu_bits_ctrl_rfWen,
  input  [4:0]  io_from_idu_bits_ctrl_rd,
  input  [31:0] io_from_idu_bits_data_imm,
  input         io_to_exu_ready,
  output        io_to_exu_valid,
  output [31:0] io_to_exu_bits_cf_inst,
  output [31:0] io_to_exu_bits_cf_pc,
  output [31:0] io_to_exu_bits_cf_next_pc,
  output        io_to_exu_bits_cf_isBranch,
  output        io_to_exu_bits_ctrl_MemWrite,
  output [1:0]  io_to_exu_bits_ctrl_ResSrc,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [6:0]  io_to_exu_bits_ctrl_fuOpType,
  output        io_to_exu_bits_ctrl_rfWen,
  output [4:0]  io_to_exu_bits_ctrl_rd,
  output [31:0] io_to_exu_bits_data_fuSrc1,
  output [31:0] io_to_exu_bits_data_fuSrc2,
  output [31:0] io_to_exu_bits_data_imm,
  output [31:0] io_to_exu_bits_data_rfSrc1,
  output [31:0] io_to_exu_bits_data_rfSrc2,
  input  [4:0]  io_wb_rd,
  input         io_wb_RegWrite,
  input  [31:0] io_from_reg_rfSrc1,
  input  [31:0] io_from_reg_rfSrc2
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] busy_1; // @[ISU.scala 23:23]
  reg [1:0] busy_2; // @[ISU.scala 23:23]
  reg [1:0] busy_3; // @[ISU.scala 23:23]
  reg [1:0] busy_4; // @[ISU.scala 23:23]
  reg [1:0] busy_5; // @[ISU.scala 23:23]
  reg [1:0] busy_6; // @[ISU.scala 23:23]
  reg [1:0] busy_7; // @[ISU.scala 23:23]
  reg [1:0] busy_8; // @[ISU.scala 23:23]
  reg [1:0] busy_9; // @[ISU.scala 23:23]
  reg [1:0] busy_10; // @[ISU.scala 23:23]
  reg [1:0] busy_11; // @[ISU.scala 23:23]
  reg [1:0] busy_12; // @[ISU.scala 23:23]
  reg [1:0] busy_13; // @[ISU.scala 23:23]
  reg [1:0] busy_14; // @[ISU.scala 23:23]
  reg [1:0] busy_15; // @[ISU.scala 23:23]
  wire [1:0] _GEN_1 = 4'h1 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_1 : 2'h0; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_2 = 4'h2 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_2 : _GEN_1; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_3 = 4'h3 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_3 : _GEN_2; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_4 = 4'h4 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_4 : _GEN_3; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_5 = 4'h5 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_5 : _GEN_4; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_6 = 4'h6 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_6 : _GEN_5; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_7 = 4'h7 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_7 : _GEN_6; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_8 = 4'h8 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_8 : _GEN_7; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_9 = 4'h9 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_9 : _GEN_8; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_10 = 4'ha == io_from_idu_bits_ctrl_rs1[3:0] ? busy_10 : _GEN_9; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_11 = 4'hb == io_from_idu_bits_ctrl_rs1[3:0] ? busy_11 : _GEN_10; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_12 = 4'hc == io_from_idu_bits_ctrl_rs1[3:0] ? busy_12 : _GEN_11; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_13 = 4'hd == io_from_idu_bits_ctrl_rs1[3:0] ? busy_13 : _GEN_12; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_14 = 4'he == io_from_idu_bits_ctrl_rs1[3:0] ? busy_14 : _GEN_13; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_15 = 4'hf == io_from_idu_bits_ctrl_rs1[3:0] ? busy_15 : _GEN_14; // @[ISU.scala 24:{47,47}]
  wire  _AnyInvalidCondition_T_1 = _GEN_15 != 2'h0; // @[ISU.scala 24:47]
  wire [1:0] _GEN_17 = 4'h1 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_1 : 2'h0; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_18 = 4'h2 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_2 : _GEN_17; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_19 = 4'h3 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_3 : _GEN_18; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_20 = 4'h4 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_4 : _GEN_19; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_21 = 4'h5 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_5 : _GEN_20; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_22 = 4'h6 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_6 : _GEN_21; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_23 = 4'h7 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_7 : _GEN_22; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_24 = 4'h8 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_8 : _GEN_23; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_25 = 4'h9 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_9 : _GEN_24; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_26 = 4'ha == io_from_idu_bits_ctrl_rs2[3:0] ? busy_10 : _GEN_25; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_27 = 4'hb == io_from_idu_bits_ctrl_rs2[3:0] ? busy_11 : _GEN_26; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_28 = 4'hc == io_from_idu_bits_ctrl_rs2[3:0] ? busy_12 : _GEN_27; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_29 = 4'hd == io_from_idu_bits_ctrl_rs2[3:0] ? busy_13 : _GEN_28; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_30 = 4'he == io_from_idu_bits_ctrl_rs2[3:0] ? busy_14 : _GEN_29; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_31 = 4'hf == io_from_idu_bits_ctrl_rs2[3:0] ? busy_15 : _GEN_30; // @[ISU.scala 24:{47,47}]
  wire  _AnyInvalidCondition_T_3 = _GEN_31 != 2'h0; // @[ISU.scala 24:47]
  wire  AnyInvalidCondition = _AnyInvalidCondition_T_1 | _AnyInvalidCondition_T_3; // @[ISU.scala 138:66]
  wire  _io_from_idu_ready_T_1 = io_to_exu_ready & io_to_exu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _fuSrc1_T_1 = 3'h0 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_reg_rfSrc1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc1_T_3 = 3'h2 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_idu_bits_cf_pc : _fuSrc1_T_1; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc2_T_1 = 3'h1 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_reg_rfSrc2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc2_T_3 = 3'h3 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_idu_bits_data_imm : _fuSrc2_T_1; // @[Mux.scala 81:58]
  wire [46:0] _isFireSetMask_T_2 = 47'h1 << io_from_idu_bits_ctrl_rd; // @[ISU.scala 25:50]
  wire [15:0] isFireSetMask = io_from_idu_bits_ctrl_rfWen & _io_from_idu_ready_T_1 ? _isFireSetMask_T_2[15:0] : 16'h0; // @[ISU.scala 159:26]
  wire [46:0] _wbuClearMask_T = 47'h1 << io_wb_rd; // @[ISU.scala 25:50]
  wire [15:0] wbuClearMask = io_wb_RegWrite ? _wbuClearMask_T[15:0] : 16'h0; // @[ISU.scala 160:25]
  wire [1:0] _busy_1_T_2 = busy_1 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_1_T_6 = busy_1 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_1_T_7 = busy_1 == 2'h0 ? 2'h0 : _busy_1_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_2_T_2 = busy_2 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_2_T_6 = busy_2 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_2_T_7 = busy_2 == 2'h0 ? 2'h0 : _busy_2_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_3_T_2 = busy_3 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_3_T_6 = busy_3 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_3_T_7 = busy_3 == 2'h0 ? 2'h0 : _busy_3_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_4_T_2 = busy_4 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_4_T_6 = busy_4 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_4_T_7 = busy_4 == 2'h0 ? 2'h0 : _busy_4_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_5_T_2 = busy_5 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_5_T_6 = busy_5 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_5_T_7 = busy_5 == 2'h0 ? 2'h0 : _busy_5_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_6_T_2 = busy_6 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_6_T_6 = busy_6 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_6_T_7 = busy_6 == 2'h0 ? 2'h0 : _busy_6_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_7_T_2 = busy_7 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_7_T_6 = busy_7 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_7_T_7 = busy_7 == 2'h0 ? 2'h0 : _busy_7_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_8_T_2 = busy_8 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_8_T_6 = busy_8 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_8_T_7 = busy_8 == 2'h0 ? 2'h0 : _busy_8_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_9_T_2 = busy_9 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_9_T_6 = busy_9 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_9_T_7 = busy_9 == 2'h0 ? 2'h0 : _busy_9_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_10_T_2 = busy_10 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_10_T_6 = busy_10 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_10_T_7 = busy_10 == 2'h0 ? 2'h0 : _busy_10_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_11_T_2 = busy_11 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_11_T_6 = busy_11 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_11_T_7 = busy_11 == 2'h0 ? 2'h0 : _busy_11_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_12_T_2 = busy_12 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_12_T_6 = busy_12 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_12_T_7 = busy_12 == 2'h0 ? 2'h0 : _busy_12_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_13_T_2 = busy_13 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_13_T_6 = busy_13 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_13_T_7 = busy_13 == 2'h0 ? 2'h0 : _busy_13_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_14_T_2 = busy_14 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_14_T_6 = busy_14 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_14_T_7 = busy_14 == 2'h0 ? 2'h0 : _busy_14_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_15_T_2 = busy_15 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_15_T_6 = busy_15 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_15_T_7 = busy_15 == 2'h0 ? 2'h0 : _busy_15_T_6; // @[ISU.scala 34:33]
  assign io_from_idu_ready = ~io_from_idu_valid | _io_from_idu_ready_T_1; // @[RVCore.scala 66:56]
  assign io_to_exu_valid = io_from_idu_valid & ~AnyInvalidCondition; // @[RVCore.scala 67:40]
  assign io_to_exu_bits_cf_inst = io_from_idu_bits_cf_inst; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_pc = io_from_idu_bits_cf_pc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_next_pc = io_from_idu_bits_cf_next_pc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_isBranch = io_from_idu_bits_cf_isBranch; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_MemWrite = io_from_idu_bits_ctrl_MemWrite; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_ResSrc = io_from_idu_bits_ctrl_ResSrc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_fuType = io_from_idu_bits_ctrl_fuType; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_fuOpType = io_from_idu_bits_ctrl_fuOpType; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_rfWen = io_from_idu_bits_ctrl_rfWen; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_rd = io_from_idu_bits_ctrl_rd; // @[ISU.scala 153:18]
  assign io_to_exu_bits_data_fuSrc1 = 3'h4 == io_from_idu_bits_ctrl_fuSrc1Type ? 32'h0 : _fuSrc1_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_fuSrc2 = 3'h5 == io_from_idu_bits_ctrl_fuSrc2Type ? 32'h4 : _fuSrc2_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_imm = io_from_idu_bits_data_imm; // @[ISU.scala 153:18]
  assign io_to_exu_bits_data_rfSrc1 = io_from_reg_rfSrc1; // @[ISU.scala 156:30]
  assign io_to_exu_bits_data_rfSrc2 = io_from_reg_rfSrc2; // @[ISU.scala 157:30]
  always @(posedge clock) begin
    if (reset) begin // @[ISU.scala 23:23]
      busy_1 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[1] & wbuClearMask[1])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[1]) begin // @[ISU.scala 31:38]
        if (busy_1 == 2'h3) begin // @[ISU.scala 32:33]
          busy_1 <= 2'h3;
        end else begin
          busy_1 <= _busy_1_T_2;
        end
      end else if (wbuClearMask[1]) begin // @[ISU.scala 33:40]
        busy_1 <= _busy_1_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_2 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[2] & wbuClearMask[2])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[2]) begin // @[ISU.scala 31:38]
        if (busy_2 == 2'h3) begin // @[ISU.scala 32:33]
          busy_2 <= 2'h3;
        end else begin
          busy_2 <= _busy_2_T_2;
        end
      end else if (wbuClearMask[2]) begin // @[ISU.scala 33:40]
        busy_2 <= _busy_2_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_3 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[3] & wbuClearMask[3])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[3]) begin // @[ISU.scala 31:38]
        if (busy_3 == 2'h3) begin // @[ISU.scala 32:33]
          busy_3 <= 2'h3;
        end else begin
          busy_3 <= _busy_3_T_2;
        end
      end else if (wbuClearMask[3]) begin // @[ISU.scala 33:40]
        busy_3 <= _busy_3_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_4 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[4] & wbuClearMask[4])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[4]) begin // @[ISU.scala 31:38]
        if (busy_4 == 2'h3) begin // @[ISU.scala 32:33]
          busy_4 <= 2'h3;
        end else begin
          busy_4 <= _busy_4_T_2;
        end
      end else if (wbuClearMask[4]) begin // @[ISU.scala 33:40]
        busy_4 <= _busy_4_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_5 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[5] & wbuClearMask[5])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[5]) begin // @[ISU.scala 31:38]
        if (busy_5 == 2'h3) begin // @[ISU.scala 32:33]
          busy_5 <= 2'h3;
        end else begin
          busy_5 <= _busy_5_T_2;
        end
      end else if (wbuClearMask[5]) begin // @[ISU.scala 33:40]
        busy_5 <= _busy_5_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_6 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[6] & wbuClearMask[6])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[6]) begin // @[ISU.scala 31:38]
        if (busy_6 == 2'h3) begin // @[ISU.scala 32:33]
          busy_6 <= 2'h3;
        end else begin
          busy_6 <= _busy_6_T_2;
        end
      end else if (wbuClearMask[6]) begin // @[ISU.scala 33:40]
        busy_6 <= _busy_6_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_7 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[7] & wbuClearMask[7])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[7]) begin // @[ISU.scala 31:38]
        if (busy_7 == 2'h3) begin // @[ISU.scala 32:33]
          busy_7 <= 2'h3;
        end else begin
          busy_7 <= _busy_7_T_2;
        end
      end else if (wbuClearMask[7]) begin // @[ISU.scala 33:40]
        busy_7 <= _busy_7_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_8 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[8] & wbuClearMask[8])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[8]) begin // @[ISU.scala 31:38]
        if (busy_8 == 2'h3) begin // @[ISU.scala 32:33]
          busy_8 <= 2'h3;
        end else begin
          busy_8 <= _busy_8_T_2;
        end
      end else if (wbuClearMask[8]) begin // @[ISU.scala 33:40]
        busy_8 <= _busy_8_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_9 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[9] & wbuClearMask[9])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[9]) begin // @[ISU.scala 31:38]
        if (busy_9 == 2'h3) begin // @[ISU.scala 32:33]
          busy_9 <= 2'h3;
        end else begin
          busy_9 <= _busy_9_T_2;
        end
      end else if (wbuClearMask[9]) begin // @[ISU.scala 33:40]
        busy_9 <= _busy_9_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_10 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[10] & wbuClearMask[10])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[10]) begin // @[ISU.scala 31:38]
        if (busy_10 == 2'h3) begin // @[ISU.scala 32:33]
          busy_10 <= 2'h3;
        end else begin
          busy_10 <= _busy_10_T_2;
        end
      end else if (wbuClearMask[10]) begin // @[ISU.scala 33:40]
        busy_10 <= _busy_10_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_11 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[11] & wbuClearMask[11])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[11]) begin // @[ISU.scala 31:38]
        if (busy_11 == 2'h3) begin // @[ISU.scala 32:33]
          busy_11 <= 2'h3;
        end else begin
          busy_11 <= _busy_11_T_2;
        end
      end else if (wbuClearMask[11]) begin // @[ISU.scala 33:40]
        busy_11 <= _busy_11_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_12 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[12] & wbuClearMask[12])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[12]) begin // @[ISU.scala 31:38]
        if (busy_12 == 2'h3) begin // @[ISU.scala 32:33]
          busy_12 <= 2'h3;
        end else begin
          busy_12 <= _busy_12_T_2;
        end
      end else if (wbuClearMask[12]) begin // @[ISU.scala 33:40]
        busy_12 <= _busy_12_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_13 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[13] & wbuClearMask[13])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[13]) begin // @[ISU.scala 31:38]
        if (busy_13 == 2'h3) begin // @[ISU.scala 32:33]
          busy_13 <= 2'h3;
        end else begin
          busy_13 <= _busy_13_T_2;
        end
      end else if (wbuClearMask[13]) begin // @[ISU.scala 33:40]
        busy_13 <= _busy_13_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_14 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[14] & wbuClearMask[14])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[14]) begin // @[ISU.scala 31:38]
        if (busy_14 == 2'h3) begin // @[ISU.scala 32:33]
          busy_14 <= 2'h3;
        end else begin
          busy_14 <= _busy_14_T_2;
        end
      end else if (wbuClearMask[14]) begin // @[ISU.scala 33:40]
        busy_14 <= _busy_14_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_15 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[15] & wbuClearMask[15])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[15]) begin // @[ISU.scala 31:38]
        if (busy_15 == 2'h3) begin // @[ISU.scala 32:33]
          busy_15 <= 2'h3;
        end else begin
          busy_15 <= _busy_15_T_2;
        end
      end else if (wbuClearMask[15]) begin // @[ISU.scala 33:40]
        busy_15 <= _busy_15_T_7; // @[ISU.scala 34:27]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
