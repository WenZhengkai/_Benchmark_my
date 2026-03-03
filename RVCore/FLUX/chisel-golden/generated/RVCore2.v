module RVCore2(
  input         clock,
  input         reset,
  input  [31:0] io_from_mem_data,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_inst,
  output [31:0] io_pc,
  output        io_commit_valid,
  output [31:0] io_commit_pc,
  output [31:0] io_commit_next_pc,
  output [31:0] io_commit_inst
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
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
`endif // RANDOMIZE_REG_INIT
  wire  ifu_clock; // @[RVCore.scala 96:19]
  wire  ifu_reset; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_inst; // @[RVCore.scala 96:19]
  wire  ifu_io_to_idu_ready; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_to_idu_bits_inst; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_to_idu_bits_pc; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_to_idu_bits_next_pc; // @[RVCore.scala 96:19]
  wire  ifu_io_to_idu_bits_isBranch; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_pc; // @[RVCore.scala 96:19]
  wire [31:0] ifu_io_redirect_target; // @[RVCore.scala 96:19]
  wire  ifu_io_redirect_valid; // @[RVCore.scala 96:19]
  wire  idu_io_from_ifu_ready; // @[RVCore.scala 97:19]
  wire  idu_io_from_ifu_valid; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_from_ifu_bits_inst; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_from_ifu_bits_pc; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_from_ifu_bits_next_pc; // @[RVCore.scala 97:19]
  wire  idu_io_from_ifu_bits_isBranch; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_ready; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_valid; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_cf_inst; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_cf_pc; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_cf_next_pc; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_bits_cf_isBranch; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_bits_ctrl_MemWrite; // @[RVCore.scala 97:19]
  wire [1:0] idu_io_to_isu_bits_ctrl_ResSrc; // @[RVCore.scala 97:19]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[RVCore.scala 97:19]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[RVCore.scala 97:19]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuType; // @[RVCore.scala 97:19]
  wire [6:0] idu_io_to_isu_bits_ctrl_fuOpType; // @[RVCore.scala 97:19]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs1; // @[RVCore.scala 97:19]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs2; // @[RVCore.scala 97:19]
  wire  idu_io_to_isu_bits_ctrl_rfWen; // @[RVCore.scala 97:19]
  wire [4:0] idu_io_to_isu_bits_ctrl_rd; // @[RVCore.scala 97:19]
  wire [31:0] idu_io_to_isu_bits_data_imm; // @[RVCore.scala 97:19]
  wire  isu_clock; // @[RVCore.scala 98:19]
  wire  isu_reset; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_ready; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_valid; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_cf_inst; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_cf_pc; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_cf_next_pc; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_bits_cf_isBranch; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_bits_ctrl_MemWrite; // @[RVCore.scala 98:19]
  wire [1:0] isu_io_from_idu_bits_ctrl_ResSrc; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc1Type; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc2Type; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuType; // @[RVCore.scala 98:19]
  wire [6:0] isu_io_from_idu_bits_ctrl_fuOpType; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs1; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs2; // @[RVCore.scala 98:19]
  wire  isu_io_from_idu_bits_ctrl_rfWen; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_from_idu_bits_ctrl_rd; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_idu_bits_data_imm; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_ready; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_valid; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_cf_inst; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_cf_pc; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_cf_next_pc; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_bits_cf_isBranch; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_bits_ctrl_MemWrite; // @[RVCore.scala 98:19]
  wire [1:0] isu_io_to_exu_bits_ctrl_ResSrc; // @[RVCore.scala 98:19]
  wire [2:0] isu_io_to_exu_bits_ctrl_fuType; // @[RVCore.scala 98:19]
  wire [6:0] isu_io_to_exu_bits_ctrl_fuOpType; // @[RVCore.scala 98:19]
  wire  isu_io_to_exu_bits_ctrl_rfWen; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_to_exu_bits_ctrl_rd; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc1; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc2; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_imm; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc1; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc2; // @[RVCore.scala 98:19]
  wire [4:0] isu_io_wb_rd; // @[RVCore.scala 98:19]
  wire  isu_io_wb_RegWrite; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_reg_rfSrc1; // @[RVCore.scala 98:19]
  wire [31:0] isu_io_from_reg_rfSrc2; // @[RVCore.scala 98:19]
  wire  exu_clock; // @[RVCore.scala 99:19]
  wire  exu_reset; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_ready; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_valid; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_cf_inst; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_cf_pc; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_cf_next_pc; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_bits_cf_isBranch; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_bits_ctrl_MemWrite; // @[RVCore.scala 99:19]
  wire [1:0] exu_io_from_isu_bits_ctrl_ResSrc; // @[RVCore.scala 99:19]
  wire [2:0] exu_io_from_isu_bits_ctrl_fuType; // @[RVCore.scala 99:19]
  wire [6:0] exu_io_from_isu_bits_ctrl_fuOpType; // @[RVCore.scala 99:19]
  wire  exu_io_from_isu_bits_ctrl_rfWen; // @[RVCore.scala 99:19]
  wire [4:0] exu_io_from_isu_bits_ctrl_rd; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_fuSrc1; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_fuSrc2; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_imm; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_rfSrc1; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_isu_bits_data_rfSrc2; // @[RVCore.scala 99:19]
  wire  exu_io_to_wbu_ready; // @[RVCore.scala 99:19]
  wire  exu_io_to_wbu_valid; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_cf_inst; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_cf_pc; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_cf_next_pc; // @[RVCore.scala 99:19]
  wire [1:0] exu_io_to_wbu_bits_ctrl_ResSrc; // @[RVCore.scala 99:19]
  wire  exu_io_to_wbu_bits_ctrl_rfWen; // @[RVCore.scala 99:19]
  wire [4:0] exu_io_to_wbu_bits_ctrl_rd; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_data_Alu0Res_bits; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_data_data_from_mem; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_wbu_bits_data_csrRdata; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_mem_data; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_to_mem_addr; // @[RVCore.scala 99:19]
  wire [7:0] exu_io_to_mem_Wmask; // @[RVCore.scala 99:19]
  wire  exu_io_to_mem_MemWrite; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_from_mem_data; // @[RVCore.scala 99:19]
  wire [31:0] exu_io_redirect_target; // @[RVCore.scala 99:19]
  wire  exu_io_redirect_valid; // @[RVCore.scala 99:19]
  wire  wbu_io_from_exu_ready; // @[RVCore.scala 101:19]
  wire  wbu_io_from_exu_valid; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_from_exu_bits_cf_inst; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_from_exu_bits_cf_pc; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_from_exu_bits_cf_next_pc; // @[RVCore.scala 101:19]
  wire [1:0] wbu_io_from_exu_bits_ctrl_ResSrc; // @[RVCore.scala 101:19]
  wire  wbu_io_from_exu_bits_ctrl_rfWen; // @[RVCore.scala 101:19]
  wire [4:0] wbu_io_from_exu_bits_ctrl_rd; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_from_exu_bits_data_Alu0Res_bits; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_from_exu_bits_data_data_from_mem; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_from_exu_bits_data_csrRdata; // @[RVCore.scala 101:19]
  wire  wbu_io_to_reg_valid; // @[RVCore.scala 101:19]
  wire [4:0] wbu_io_to_reg_bits_rd; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_to_reg_bits_Res; // @[RVCore.scala 101:19]
  wire  wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_to_commit_inst; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_to_commit_pc; // @[RVCore.scala 101:19]
  wire [31:0] wbu_io_to_commit_next_pc; // @[RVCore.scala 101:19]
  wire  regfile_clk; // @[RVCore.scala 137:23]
  wire [4:0] regfile_rs1; // @[RVCore.scala 137:23]
  wire [4:0] regfile_rs2; // @[RVCore.scala 137:23]
  wire [4:0] regfile_rd; // @[RVCore.scala 137:23]
  wire [31:0] regfile_dest; // @[RVCore.scala 137:23]
  wire  regfile_RegWrite; // @[RVCore.scala 137:23]
  wire [31:0] regfile_src1; // @[RVCore.scala 137:23]
  wire [31:0] regfile_src2; // @[RVCore.scala 137:23]
  wire  _T = idu_io_to_isu_ready & idu_io_to_isu_valid; // @[Decoupled.scala 51:35]
  reg  valid; // @[RVCore.scala 48:26]
  wire  _T_1 = idu_io_from_ifu_ready; // @[RVCore.scala 50:29]
  wire  _GEN_0 = _T ? 1'h0 : valid; // @[RVCore.scala 51:{38,45} 52:25]
  wire  _GEN_1 = idu_io_from_ifu_ready | _GEN_0; // @[RVCore.scala 50:{44,51}]
  reg [31:0] idu_io_from_ifu_bits_r_inst; // @[Reg.scala 19:16]
  reg [31:0] idu_io_from_ifu_bits_r_pc; // @[Reg.scala 19:16]
  reg [31:0] idu_io_from_ifu_bits_r_next_pc; // @[Reg.scala 19:16]
  reg  idu_io_from_ifu_bits_r_isBranch; // @[Reg.scala 19:16]
  wire  _T_2 = isu_io_to_exu_ready & isu_io_to_exu_valid; // @[Decoupled.scala 51:35]
  reg  valid_1; // @[RVCore.scala 48:26]
  wire  _isu_io_from_idu_bits_T = idu_io_to_isu_valid & isu_io_from_idu_ready; // @[RVCore.scala 57:53]
  reg [31:0] isu_io_from_idu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_cf_isBranch; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_ctrl_MemWrite; // @[Reg.scala 19:16]
  reg [1:0] isu_io_from_idu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuSrc1Type; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuSrc2Type; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuType; // @[Reg.scala 19:16]
  reg [6:0] isu_io_from_idu_bits_r_ctrl_fuOpType; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rs1; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rs2; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_data_imm; // @[Reg.scala 19:16]
  wire  _T_4 = exu_io_to_wbu_ready & exu_io_to_wbu_valid; // @[Decoupled.scala 51:35]
  reg  valid_2; // @[RVCore.scala 48:26]
  wire  _exu_io_from_isu_bits_T = isu_io_to_exu_valid & exu_io_from_isu_ready; // @[RVCore.scala 57:53]
  reg [31:0] exu_io_from_isu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg  exu_io_from_isu_bits_r_cf_isBranch; // @[Reg.scala 19:16]
  reg  exu_io_from_isu_bits_r_ctrl_MemWrite; // @[Reg.scala 19:16]
  reg [1:0] exu_io_from_isu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg [2:0] exu_io_from_isu_bits_r_ctrl_fuType; // @[Reg.scala 19:16]
  reg [6:0] exu_io_from_isu_bits_r_ctrl_fuOpType; // @[Reg.scala 19:16]
  reg  exu_io_from_isu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] exu_io_from_isu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_fuSrc1; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_fuSrc2; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_imm; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_rfSrc1; // @[Reg.scala 19:16]
  reg [31:0] exu_io_from_isu_bits_r_data_rfSrc2; // @[Reg.scala 19:16]
  wire  _T_6 = wbu_io_to_reg_valid; // @[RVCore.scala 116:68]
  reg  valid_3; // @[RVCore.scala 48:26]
  wire  _wbu_io_from_exu_bits_T = exu_io_to_wbu_valid & wbu_io_from_exu_ready; // @[RVCore.scala 57:53]
  reg [31:0] wbu_io_from_exu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg [1:0] wbu_io_from_exu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg  wbu_io_from_exu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] wbu_io_from_exu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_data_Alu0Res_bits; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_data_data_from_mem; // @[Reg.scala 19:16]
  reg [31:0] wbu_io_from_exu_bits_r_data_csrRdata; // @[Reg.scala 19:16]
  reg  io_commit_valid_REG; // @[RVCore.scala 130:29]
  reg [31:0] io_commit_pc_REG; // @[RVCore.scala 132:26]
  reg [31:0] io_commit_next_pc_REG; // @[RVCore.scala 133:31]
  reg [31:0] io_commit_inst_REG; // @[RVCore.scala 134:28]
  IFU_LLM ifu ( // @[RVCore.scala 96:19]
    .clock(ifu_clock),
    .reset(ifu_reset),
    .io_inst(ifu_io_inst),
    .io_to_idu_ready(ifu_io_to_idu_ready),
    .io_to_idu_bits_inst(ifu_io_to_idu_bits_inst),
    .io_to_idu_bits_pc(ifu_io_to_idu_bits_pc),
    .io_to_idu_bits_next_pc(ifu_io_to_idu_bits_next_pc),
    .io_to_idu_bits_isBranch(ifu_io_to_idu_bits_isBranch),
    .io_pc(ifu_io_pc),
    .io_redirect_target(ifu_io_redirect_target),
    .io_redirect_valid(ifu_io_redirect_valid)
  );
  IDU_LLM idu ( // @[RVCore.scala 97:19]
    .io_from_ifu_ready(idu_io_from_ifu_ready),
    .io_from_ifu_valid(idu_io_from_ifu_valid),
    .io_from_ifu_bits_inst(idu_io_from_ifu_bits_inst),
    .io_from_ifu_bits_pc(idu_io_from_ifu_bits_pc),
    .io_from_ifu_bits_next_pc(idu_io_from_ifu_bits_next_pc),
    .io_from_ifu_bits_isBranch(idu_io_from_ifu_bits_isBranch),
    .io_to_isu_ready(idu_io_to_isu_ready),
    .io_to_isu_valid(idu_io_to_isu_valid),
    .io_to_isu_bits_cf_inst(idu_io_to_isu_bits_cf_inst),
    .io_to_isu_bits_cf_pc(idu_io_to_isu_bits_cf_pc),
    .io_to_isu_bits_cf_next_pc(idu_io_to_isu_bits_cf_next_pc),
    .io_to_isu_bits_cf_isBranch(idu_io_to_isu_bits_cf_isBranch),
    .io_to_isu_bits_ctrl_MemWrite(idu_io_to_isu_bits_ctrl_MemWrite),
    .io_to_isu_bits_ctrl_ResSrc(idu_io_to_isu_bits_ctrl_ResSrc),
    .io_to_isu_bits_ctrl_fuSrc1Type(idu_io_to_isu_bits_ctrl_fuSrc1Type),
    .io_to_isu_bits_ctrl_fuSrc2Type(idu_io_to_isu_bits_ctrl_fuSrc2Type),
    .io_to_isu_bits_ctrl_fuType(idu_io_to_isu_bits_ctrl_fuType),
    .io_to_isu_bits_ctrl_fuOpType(idu_io_to_isu_bits_ctrl_fuOpType),
    .io_to_isu_bits_ctrl_rs1(idu_io_to_isu_bits_ctrl_rs1),
    .io_to_isu_bits_ctrl_rs2(idu_io_to_isu_bits_ctrl_rs2),
    .io_to_isu_bits_ctrl_rfWen(idu_io_to_isu_bits_ctrl_rfWen),
    .io_to_isu_bits_ctrl_rd(idu_io_to_isu_bits_ctrl_rd),
    .io_to_isu_bits_data_imm(idu_io_to_isu_bits_data_imm)
  );
  ISU_LLM isu ( // @[RVCore.scala 98:19]
    .clock(isu_clock),
    .reset(isu_reset),
    .io_from_idu_ready(isu_io_from_idu_ready),
    .io_from_idu_valid(isu_io_from_idu_valid),
    .io_from_idu_bits_cf_inst(isu_io_from_idu_bits_cf_inst),
    .io_from_idu_bits_cf_pc(isu_io_from_idu_bits_cf_pc),
    .io_from_idu_bits_cf_next_pc(isu_io_from_idu_bits_cf_next_pc),
    .io_from_idu_bits_cf_isBranch(isu_io_from_idu_bits_cf_isBranch),
    .io_from_idu_bits_ctrl_MemWrite(isu_io_from_idu_bits_ctrl_MemWrite),
    .io_from_idu_bits_ctrl_ResSrc(isu_io_from_idu_bits_ctrl_ResSrc),
    .io_from_idu_bits_ctrl_fuSrc1Type(isu_io_from_idu_bits_ctrl_fuSrc1Type),
    .io_from_idu_bits_ctrl_fuSrc2Type(isu_io_from_idu_bits_ctrl_fuSrc2Type),
    .io_from_idu_bits_ctrl_fuType(isu_io_from_idu_bits_ctrl_fuType),
    .io_from_idu_bits_ctrl_fuOpType(isu_io_from_idu_bits_ctrl_fuOpType),
    .io_from_idu_bits_ctrl_rs1(isu_io_from_idu_bits_ctrl_rs1),
    .io_from_idu_bits_ctrl_rs2(isu_io_from_idu_bits_ctrl_rs2),
    .io_from_idu_bits_ctrl_rfWen(isu_io_from_idu_bits_ctrl_rfWen),
    .io_from_idu_bits_ctrl_rd(isu_io_from_idu_bits_ctrl_rd),
    .io_from_idu_bits_data_imm(isu_io_from_idu_bits_data_imm),
    .io_to_exu_ready(isu_io_to_exu_ready),
    .io_to_exu_valid(isu_io_to_exu_valid),
    .io_to_exu_bits_cf_inst(isu_io_to_exu_bits_cf_inst),
    .io_to_exu_bits_cf_pc(isu_io_to_exu_bits_cf_pc),
    .io_to_exu_bits_cf_next_pc(isu_io_to_exu_bits_cf_next_pc),
    .io_to_exu_bits_cf_isBranch(isu_io_to_exu_bits_cf_isBranch),
    .io_to_exu_bits_ctrl_MemWrite(isu_io_to_exu_bits_ctrl_MemWrite),
    .io_to_exu_bits_ctrl_ResSrc(isu_io_to_exu_bits_ctrl_ResSrc),
    .io_to_exu_bits_ctrl_fuType(isu_io_to_exu_bits_ctrl_fuType),
    .io_to_exu_bits_ctrl_fuOpType(isu_io_to_exu_bits_ctrl_fuOpType),
    .io_to_exu_bits_ctrl_rfWen(isu_io_to_exu_bits_ctrl_rfWen),
    .io_to_exu_bits_ctrl_rd(isu_io_to_exu_bits_ctrl_rd),
    .io_to_exu_bits_data_fuSrc1(isu_io_to_exu_bits_data_fuSrc1),
    .io_to_exu_bits_data_fuSrc2(isu_io_to_exu_bits_data_fuSrc2),
    .io_to_exu_bits_data_imm(isu_io_to_exu_bits_data_imm),
    .io_to_exu_bits_data_rfSrc1(isu_io_to_exu_bits_data_rfSrc1),
    .io_to_exu_bits_data_rfSrc2(isu_io_to_exu_bits_data_rfSrc2),
    .io_wb_rd(isu_io_wb_rd),
    .io_wb_RegWrite(isu_io_wb_RegWrite),
    .io_from_reg_rfSrc1(isu_io_from_reg_rfSrc1),
    .io_from_reg_rfSrc2(isu_io_from_reg_rfSrc2)
  );
  EXU_LLM exu ( // @[RVCore.scala 99:19]
    .clock(exu_clock),
    .reset(exu_reset),
    .io_from_isu_ready(exu_io_from_isu_ready),
    .io_from_isu_valid(exu_io_from_isu_valid),
    .io_from_isu_bits_cf_inst(exu_io_from_isu_bits_cf_inst),
    .io_from_isu_bits_cf_pc(exu_io_from_isu_bits_cf_pc),
    .io_from_isu_bits_cf_next_pc(exu_io_from_isu_bits_cf_next_pc),
    .io_from_isu_bits_cf_isBranch(exu_io_from_isu_bits_cf_isBranch),
    .io_from_isu_bits_ctrl_MemWrite(exu_io_from_isu_bits_ctrl_MemWrite),
    .io_from_isu_bits_ctrl_ResSrc(exu_io_from_isu_bits_ctrl_ResSrc),
    .io_from_isu_bits_ctrl_fuType(exu_io_from_isu_bits_ctrl_fuType),
    .io_from_isu_bits_ctrl_fuOpType(exu_io_from_isu_bits_ctrl_fuOpType),
    .io_from_isu_bits_ctrl_rfWen(exu_io_from_isu_bits_ctrl_rfWen),
    .io_from_isu_bits_ctrl_rd(exu_io_from_isu_bits_ctrl_rd),
    .io_from_isu_bits_data_fuSrc1(exu_io_from_isu_bits_data_fuSrc1),
    .io_from_isu_bits_data_fuSrc2(exu_io_from_isu_bits_data_fuSrc2),
    .io_from_isu_bits_data_imm(exu_io_from_isu_bits_data_imm),
    .io_from_isu_bits_data_rfSrc1(exu_io_from_isu_bits_data_rfSrc1),
    .io_from_isu_bits_data_rfSrc2(exu_io_from_isu_bits_data_rfSrc2),
    .io_to_wbu_ready(exu_io_to_wbu_ready),
    .io_to_wbu_valid(exu_io_to_wbu_valid),
    .io_to_wbu_bits_cf_inst(exu_io_to_wbu_bits_cf_inst),
    .io_to_wbu_bits_cf_pc(exu_io_to_wbu_bits_cf_pc),
    .io_to_wbu_bits_cf_next_pc(exu_io_to_wbu_bits_cf_next_pc),
    .io_to_wbu_bits_ctrl_ResSrc(exu_io_to_wbu_bits_ctrl_ResSrc),
    .io_to_wbu_bits_ctrl_rfWen(exu_io_to_wbu_bits_ctrl_rfWen),
    .io_to_wbu_bits_ctrl_rd(exu_io_to_wbu_bits_ctrl_rd),
    .io_to_wbu_bits_data_Alu0Res_bits(exu_io_to_wbu_bits_data_Alu0Res_bits),
    .io_to_wbu_bits_data_data_from_mem(exu_io_to_wbu_bits_data_data_from_mem),
    .io_to_wbu_bits_data_csrRdata(exu_io_to_wbu_bits_data_csrRdata),
    .io_to_mem_data(exu_io_to_mem_data),
    .io_to_mem_addr(exu_io_to_mem_addr),
    .io_to_mem_Wmask(exu_io_to_mem_Wmask),
    .io_to_mem_MemWrite(exu_io_to_mem_MemWrite),
    .io_from_mem_data(exu_io_from_mem_data),
    .io_redirect_target(exu_io_redirect_target),
    .io_redirect_valid(exu_io_redirect_valid)
  );
  WBU_LLM wbu ( // @[RVCore.scala 101:19]
    .io_from_exu_ready(wbu_io_from_exu_ready),
    .io_from_exu_valid(wbu_io_from_exu_valid),
    .io_from_exu_bits_cf_inst(wbu_io_from_exu_bits_cf_inst),
    .io_from_exu_bits_cf_pc(wbu_io_from_exu_bits_cf_pc),
    .io_from_exu_bits_cf_next_pc(wbu_io_from_exu_bits_cf_next_pc),
    .io_from_exu_bits_ctrl_ResSrc(wbu_io_from_exu_bits_ctrl_ResSrc),
    .io_from_exu_bits_ctrl_rfWen(wbu_io_from_exu_bits_ctrl_rfWen),
    .io_from_exu_bits_ctrl_rd(wbu_io_from_exu_bits_ctrl_rd),
    .io_from_exu_bits_data_Alu0Res_bits(wbu_io_from_exu_bits_data_Alu0Res_bits),
    .io_from_exu_bits_data_data_from_mem(wbu_io_from_exu_bits_data_data_from_mem),
    .io_from_exu_bits_data_csrRdata(wbu_io_from_exu_bits_data_csrRdata),
    .io_to_reg_valid(wbu_io_to_reg_valid),
    .io_to_reg_bits_rd(wbu_io_to_reg_bits_rd),
    .io_to_reg_bits_Res(wbu_io_to_reg_bits_Res),
    .io_to_reg_bits_RegWrite(wbu_io_to_reg_bits_RegWrite),
    .io_to_commit_inst(wbu_io_to_commit_inst),
    .io_to_commit_pc(wbu_io_to_commit_pc),
    .io_to_commit_next_pc(wbu_io_to_commit_next_pc)
  );
  ysyx_23060228_RegFile_BlackBox #(.DATA_WIDTH(32)) regfile ( // @[RVCore.scala 137:23]
    .clk(regfile_clk),
    .rs1(regfile_rs1),
    .rs2(regfile_rs2),
    .rd(regfile_rd),
    .dest(regfile_dest),
    .RegWrite(regfile_RegWrite),
    .src1(regfile_src1),
    .src2(regfile_src2)
  );
  assign io_to_mem_data = exu_io_to_mem_data; // @[RVCore.scala 108:13]
  assign io_to_mem_addr = exu_io_to_mem_addr; // @[RVCore.scala 108:13]
  assign io_to_mem_Wmask = exu_io_to_mem_Wmask; // @[RVCore.scala 108:13]
  assign io_to_mem_MemWrite = exu_io_to_mem_MemWrite; // @[RVCore.scala 108:13]
  assign io_pc = ifu_io_pc; // @[RVCore.scala 105:9]
  assign io_commit_valid = io_commit_valid_REG; // @[RVCore.scala 130:19]
  assign io_commit_pc = io_commit_pc_REG; // @[RVCore.scala 132:16]
  assign io_commit_next_pc = io_commit_next_pc_REG; // @[RVCore.scala 133:21]
  assign io_commit_inst = io_commit_inst_REG; // @[RVCore.scala 134:18]
  assign ifu_clock = clock;
  assign ifu_reset = reset;
  assign ifu_io_inst = io_inst; // @[RVCore.scala 103:15]
  assign ifu_io_to_idu_ready = idu_io_from_ifu_ready; // @[RVCore.scala 55:18]
  assign ifu_io_redirect_target = exu_io_redirect_target; // @[RVCore.scala 120:19]
  assign ifu_io_redirect_valid = exu_io_redirect_valid; // @[RVCore.scala 120:19]
  assign idu_io_from_ifu_valid = valid; // @[RVCore.scala 54:19]
  assign idu_io_from_ifu_bits_inst = idu_io_from_ifu_bits_r_inst; // @[RVCore.scala 57:18]
  assign idu_io_from_ifu_bits_pc = idu_io_from_ifu_bits_r_pc; // @[RVCore.scala 57:18]
  assign idu_io_from_ifu_bits_next_pc = idu_io_from_ifu_bits_r_next_pc; // @[RVCore.scala 57:18]
  assign idu_io_from_ifu_bits_isBranch = idu_io_from_ifu_bits_r_isBranch; // @[RVCore.scala 57:18]
  assign idu_io_to_isu_ready = isu_io_from_idu_ready; // @[RVCore.scala 55:18]
  assign isu_clock = clock;
  assign isu_reset = reset;
  assign isu_io_from_idu_valid = valid_1; // @[RVCore.scala 54:19]
  assign isu_io_from_idu_bits_cf_inst = isu_io_from_idu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_cf_pc = isu_io_from_idu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_cf_next_pc = isu_io_from_idu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_cf_isBranch = isu_io_from_idu_bits_r_cf_isBranch; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_MemWrite = isu_io_from_idu_bits_r_ctrl_MemWrite; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_ResSrc = isu_io_from_idu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuSrc1Type = isu_io_from_idu_bits_r_ctrl_fuSrc1Type; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuSrc2Type = isu_io_from_idu_bits_r_ctrl_fuSrc2Type; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuType = isu_io_from_idu_bits_r_ctrl_fuType; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_fuOpType = isu_io_from_idu_bits_r_ctrl_fuOpType; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rs1 = isu_io_from_idu_bits_r_ctrl_rs1; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rs2 = isu_io_from_idu_bits_r_ctrl_rs2; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rfWen = isu_io_from_idu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_ctrl_rd = isu_io_from_idu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign isu_io_from_idu_bits_data_imm = isu_io_from_idu_bits_r_data_imm; // @[RVCore.scala 57:18]
  assign isu_io_to_exu_ready = exu_io_from_isu_ready; // @[RVCore.scala 55:18]
  assign isu_io_wb_rd = wbu_io_to_reg_bits_rd; // @[RVCore.scala 122:13]
  assign isu_io_wb_RegWrite = wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 122:13]
  assign isu_io_from_reg_rfSrc1 = regfile_src1; // @[ISU.scala 142:32]
  assign isu_io_from_reg_rfSrc2 = regfile_src2; // @[ISU.scala 143:32]
  assign exu_clock = clock;
  assign exu_reset = reset;
  assign exu_io_from_isu_valid = valid_2; // @[RVCore.scala 54:19]
  assign exu_io_from_isu_bits_cf_inst = exu_io_from_isu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_cf_pc = exu_io_from_isu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_cf_next_pc = exu_io_from_isu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_cf_isBranch = exu_io_from_isu_bits_r_cf_isBranch; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_MemWrite = exu_io_from_isu_bits_r_ctrl_MemWrite; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_ResSrc = exu_io_from_isu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_fuType = exu_io_from_isu_bits_r_ctrl_fuType; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_fuOpType = exu_io_from_isu_bits_r_ctrl_fuOpType; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_rfWen = exu_io_from_isu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_ctrl_rd = exu_io_from_isu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_fuSrc1 = exu_io_from_isu_bits_r_data_fuSrc1; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_fuSrc2 = exu_io_from_isu_bits_r_data_fuSrc2; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_imm = exu_io_from_isu_bits_r_data_imm; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_rfSrc1 = exu_io_from_isu_bits_r_data_rfSrc1; // @[RVCore.scala 57:18]
  assign exu_io_from_isu_bits_data_rfSrc2 = exu_io_from_isu_bits_r_data_rfSrc2; // @[RVCore.scala 57:18]
  assign exu_io_to_wbu_ready = wbu_io_from_exu_ready; // @[RVCore.scala 55:18]
  assign exu_io_from_mem_data = io_from_mem_data; // @[RVCore.scala 104:19]
  assign wbu_io_from_exu_valid = valid_3; // @[RVCore.scala 54:19]
  assign wbu_io_from_exu_bits_cf_inst = wbu_io_from_exu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_cf_pc = wbu_io_from_exu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_cf_next_pc = wbu_io_from_exu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_ResSrc = wbu_io_from_exu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_rfWen = wbu_io_from_exu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_rd = wbu_io_from_exu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_Alu0Res_bits = wbu_io_from_exu_bits_r_data_Alu0Res_bits; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_data_from_mem = wbu_io_from_exu_bits_r_data_data_from_mem; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_csrRdata = wbu_io_from_exu_bits_r_data_csrRdata; // @[RVCore.scala 57:18]
  assign regfile_clk = clock; // @[RVCore.scala 138:18]
  assign regfile_rs1 = isu_io_from_idu_bits_ctrl_rs1; // @[RVCore.scala 140:18]
  assign regfile_rs2 = isu_io_from_idu_bits_ctrl_rs2; // @[RVCore.scala 141:18]
  assign regfile_rd = wbu_io_to_reg_bits_rd; // @[RVCore.scala 142:19]
  assign regfile_dest = wbu_io_to_reg_bits_Res; // @[RVCore.scala 143:19]
  assign regfile_RegWrite = wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 144:23]
  always @(posedge clock) begin
    if (reset) begin // @[RVCore.scala 48:26]
      valid <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_redirect_valid) begin // @[RVCore.scala 49:21]
      valid <= 1'h0; // @[RVCore.scala 49:28]
    end else begin
      valid <= _GEN_1;
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_inst <= ifu_io_to_idu_bits_inst; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_pc <= ifu_io_to_idu_bits_pc; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_next_pc <= ifu_io_to_idu_bits_next_pc; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_isBranch <= ifu_io_to_idu_bits_isBranch; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_1 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_redirect_valid) begin // @[RVCore.scala 49:21]
      valid_1 <= 1'h0; // @[RVCore.scala 49:28]
    end else if (isu_io_from_idu_ready & idu_io_to_isu_valid) begin // @[RVCore.scala 50:44]
      valid_1 <= idu_io_to_isu_valid; // @[RVCore.scala 50:51]
    end else if (_T_2) begin // @[RVCore.scala 51:38]
      valid_1 <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_inst <= idu_io_to_isu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_pc <= idu_io_to_isu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_next_pc <= idu_io_to_isu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_isBranch <= idu_io_to_isu_bits_cf_isBranch; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_MemWrite <= idu_io_to_isu_bits_ctrl_MemWrite; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_ResSrc <= idu_io_to_isu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuSrc1Type <= idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuSrc2Type <= idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuType <= idu_io_to_isu_bits_ctrl_fuType; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuOpType <= idu_io_to_isu_bits_ctrl_fuOpType; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rs1 <= idu_io_to_isu_bits_ctrl_rs1; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rs2 <= idu_io_to_isu_bits_ctrl_rs2; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rfWen <= idu_io_to_isu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rd <= idu_io_to_isu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_data_imm <= idu_io_to_isu_bits_data_imm; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_2 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_from_isu_ready & isu_io_to_exu_valid) begin // @[RVCore.scala 50:44]
      valid_2 <= isu_io_to_exu_valid; // @[RVCore.scala 50:51]
    end else if (_T_4) begin // @[RVCore.scala 51:38]
      valid_2 <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_inst <= isu_io_to_exu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_pc <= isu_io_to_exu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_next_pc <= isu_io_to_exu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_isBranch <= isu_io_to_exu_bits_cf_isBranch; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_MemWrite <= isu_io_to_exu_bits_ctrl_MemWrite; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_ResSrc <= isu_io_to_exu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_fuType <= isu_io_to_exu_bits_ctrl_fuType; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_fuOpType <= isu_io_to_exu_bits_ctrl_fuOpType; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_rfWen <= isu_io_to_exu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_rd <= isu_io_to_exu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_fuSrc1 <= isu_io_to_exu_bits_data_fuSrc1; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_fuSrc2 <= isu_io_to_exu_bits_data_fuSrc2; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_imm <= isu_io_to_exu_bits_data_imm; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_rfSrc1 <= isu_io_to_exu_bits_data_rfSrc1; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_rfSrc2 <= isu_io_to_exu_bits_data_rfSrc2; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_3 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (wbu_io_from_exu_ready & exu_io_to_wbu_valid) begin // @[RVCore.scala 50:44]
      valid_3 <= exu_io_to_wbu_valid; // @[RVCore.scala 50:51]
    end else if (_T_6) begin // @[RVCore.scala 51:38]
      valid_3 <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_cf_inst <= exu_io_to_wbu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_cf_pc <= exu_io_to_wbu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_cf_next_pc <= exu_io_to_wbu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_ctrl_ResSrc <= exu_io_to_wbu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_ctrl_rfWen <= exu_io_to_wbu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_ctrl_rd <= exu_io_to_wbu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_data_Alu0Res_bits <= exu_io_to_wbu_bits_data_Alu0Res_bits; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_data_data_from_mem <= exu_io_to_wbu_bits_data_data_from_mem; // @[Reg.scala 20:22]
    end
    if (_wbu_io_from_exu_bits_T) begin // @[Reg.scala 20:18]
      wbu_io_from_exu_bits_r_data_csrRdata <= exu_io_to_wbu_bits_data_csrRdata; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 130:29]
      io_commit_valid_REG <= 1'h0; // @[RVCore.scala 130:29]
    end else begin
      io_commit_valid_REG <= wbu_io_to_reg_valid; // @[RVCore.scala 130:29]
    end
    io_commit_pc_REG <= wbu_io_to_commit_pc; // @[RVCore.scala 132:26]
    io_commit_next_pc_REG <= wbu_io_to_commit_next_pc; // @[RVCore.scala 133:31]
    io_commit_inst_REG <= wbu_io_to_commit_inst; // @[RVCore.scala 134:28]
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
  valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_next_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_isBranch = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  valid_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_inst = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_pc = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_next_pc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_isBranch = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_MemWrite = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_ResSrc = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuSrc1Type = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuSrc2Type = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuType = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuOpType = _RAND_15[6:0];
  _RAND_16 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rs1 = _RAND_16[4:0];
  _RAND_17 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rs2 = _RAND_17[4:0];
  _RAND_18 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rfWen = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rd = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_data_imm = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  valid_2 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_inst = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_pc = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_next_pc = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_isBranch = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_MemWrite = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_ResSrc = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_fuType = _RAND_28[2:0];
  _RAND_29 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_fuOpType = _RAND_29[6:0];
  _RAND_30 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_rfWen = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_rd = _RAND_31[4:0];
  _RAND_32 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_fuSrc1 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_fuSrc2 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_imm = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_rfSrc1 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_rfSrc2 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  valid_3 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_inst = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_pc = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_next_pc = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_ResSrc = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_rfWen = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_rd = _RAND_43[4:0];
  _RAND_44 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_Alu0Res_bits = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_data_from_mem = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_csrRdata = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  io_commit_valid_REG = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  io_commit_pc_REG = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  io_commit_next_pc_REG = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  io_commit_inst_REG = _RAND_50[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
