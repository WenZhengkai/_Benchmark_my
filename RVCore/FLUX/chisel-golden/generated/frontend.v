module frontend(
  input         clock,
  input         reset,
  input         io_redirect,
  input  [31:0] io_inst,
  output [31:0] io_pc,
  input  [31:0] io_ifuredirect_target,
  input         io_ifuredirect_valid,
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
  input  [31:0] io_rfSrc1,
  input  [31:0] io_rfSrc2,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2
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
`endif // RANDOMIZE_REG_INIT
  wire  ifu_clock; // @[frontend.scala 522:21]
  wire  ifu_reset; // @[frontend.scala 522:21]
  wire [31:0] ifu_io_inst; // @[frontend.scala 522:21]
  wire  ifu_io_to_idu_ready; // @[frontend.scala 522:21]
  wire [31:0] ifu_io_to_idu_bits_inst; // @[frontend.scala 522:21]
  wire [31:0] ifu_io_to_idu_bits_pc; // @[frontend.scala 522:21]
  wire [31:0] ifu_io_to_idu_bits_next_pc; // @[frontend.scala 522:21]
  wire  ifu_io_to_idu_bits_isBranch; // @[frontend.scala 522:21]
  wire [31:0] ifu_io_pc; // @[frontend.scala 522:21]
  wire [31:0] ifu_io_redirect_target; // @[frontend.scala 522:21]
  wire  ifu_io_redirect_valid; // @[frontend.scala 522:21]
  wire  idu_io_from_ifu_ready; // @[frontend.scala 523:21]
  wire  idu_io_from_ifu_valid; // @[frontend.scala 523:21]
  wire [31:0] idu_io_from_ifu_bits_inst; // @[frontend.scala 523:21]
  wire [31:0] idu_io_from_ifu_bits_pc; // @[frontend.scala 523:21]
  wire [31:0] idu_io_from_ifu_bits_next_pc; // @[frontend.scala 523:21]
  wire  idu_io_from_ifu_bits_isBranch; // @[frontend.scala 523:21]
  wire  idu_io_to_isu_ready; // @[frontend.scala 523:21]
  wire  idu_io_to_isu_valid; // @[frontend.scala 523:21]
  wire [31:0] idu_io_to_isu_bits_cf_inst; // @[frontend.scala 523:21]
  wire [31:0] idu_io_to_isu_bits_cf_pc; // @[frontend.scala 523:21]
  wire [31:0] idu_io_to_isu_bits_cf_next_pc; // @[frontend.scala 523:21]
  wire  idu_io_to_isu_bits_cf_isBranch; // @[frontend.scala 523:21]
  wire  idu_io_to_isu_bits_ctrl_MemWrite; // @[frontend.scala 523:21]
  wire [1:0] idu_io_to_isu_bits_ctrl_ResSrc; // @[frontend.scala 523:21]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[frontend.scala 523:21]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[frontend.scala 523:21]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuType; // @[frontend.scala 523:21]
  wire [6:0] idu_io_to_isu_bits_ctrl_fuOpType; // @[frontend.scala 523:21]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs1; // @[frontend.scala 523:21]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs2; // @[frontend.scala 523:21]
  wire  idu_io_to_isu_bits_ctrl_rfWen; // @[frontend.scala 523:21]
  wire [4:0] idu_io_to_isu_bits_ctrl_rd; // @[frontend.scala 523:21]
  wire [31:0] idu_io_to_isu_bits_data_imm; // @[frontend.scala 523:21]
  wire  isu_clock; // @[frontend.scala 524:21]
  wire  isu_reset; // @[frontend.scala 524:21]
  wire  isu_io_from_idu_ready; // @[frontend.scala 524:21]
  wire  isu_io_from_idu_valid; // @[frontend.scala 524:21]
  wire [31:0] isu_io_from_idu_bits_cf_inst; // @[frontend.scala 524:21]
  wire [31:0] isu_io_from_idu_bits_cf_pc; // @[frontend.scala 524:21]
  wire [31:0] isu_io_from_idu_bits_cf_next_pc; // @[frontend.scala 524:21]
  wire  isu_io_from_idu_bits_cf_isBranch; // @[frontend.scala 524:21]
  wire  isu_io_from_idu_bits_ctrl_MemWrite; // @[frontend.scala 524:21]
  wire [1:0] isu_io_from_idu_bits_ctrl_ResSrc; // @[frontend.scala 524:21]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc1Type; // @[frontend.scala 524:21]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc2Type; // @[frontend.scala 524:21]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuType; // @[frontend.scala 524:21]
  wire [6:0] isu_io_from_idu_bits_ctrl_fuOpType; // @[frontend.scala 524:21]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs1; // @[frontend.scala 524:21]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs2; // @[frontend.scala 524:21]
  wire  isu_io_from_idu_bits_ctrl_rfWen; // @[frontend.scala 524:21]
  wire [4:0] isu_io_from_idu_bits_ctrl_rd; // @[frontend.scala 524:21]
  wire [31:0] isu_io_from_idu_bits_data_imm; // @[frontend.scala 524:21]
  wire  isu_io_to_exu_ready; // @[frontend.scala 524:21]
  wire  isu_io_to_exu_valid; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_cf_inst; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_cf_pc; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_cf_next_pc; // @[frontend.scala 524:21]
  wire  isu_io_to_exu_bits_cf_isBranch; // @[frontend.scala 524:21]
  wire  isu_io_to_exu_bits_ctrl_MemWrite; // @[frontend.scala 524:21]
  wire [1:0] isu_io_to_exu_bits_ctrl_ResSrc; // @[frontend.scala 524:21]
  wire [2:0] isu_io_to_exu_bits_ctrl_fuType; // @[frontend.scala 524:21]
  wire [6:0] isu_io_to_exu_bits_ctrl_fuOpType; // @[frontend.scala 524:21]
  wire [4:0] isu_io_to_exu_bits_ctrl_rs1; // @[frontend.scala 524:21]
  wire [4:0] isu_io_to_exu_bits_ctrl_rs2; // @[frontend.scala 524:21]
  wire  isu_io_to_exu_bits_ctrl_rfWen; // @[frontend.scala 524:21]
  wire [4:0] isu_io_to_exu_bits_ctrl_rd; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc1; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc2; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_data_imm; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc1; // @[frontend.scala 524:21]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc2; // @[frontend.scala 524:21]
  wire [4:0] isu_io_wb_rd; // @[frontend.scala 524:21]
  wire  isu_io_wb_RegWrite; // @[frontend.scala 524:21]
  wire [31:0] isu_io_from_reg_rfSrc1; // @[frontend.scala 524:21]
  wire [31:0] isu_io_from_reg_rfSrc2; // @[frontend.scala 524:21]
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
  IFU_LLM2 ifu ( // @[frontend.scala 522:21]
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
  IDU_LLM2 idu ( // @[frontend.scala 523:21]
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
  ISU_LLM2 isu ( // @[frontend.scala 524:21]
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
    .io_to_exu_bits_ctrl_rs1(isu_io_to_exu_bits_ctrl_rs1),
    .io_to_exu_bits_ctrl_rs2(isu_io_to_exu_bits_ctrl_rs2),
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
  assign io_pc = ifu_io_pc; // @[frontend.scala 527:17]
  assign io_to_exu_valid = isu_io_to_exu_valid; // @[frontend.scala 529:17]
  assign io_to_exu_bits_cf_inst = isu_io_to_exu_bits_cf_inst; // @[frontend.scala 529:17]
  assign io_to_exu_bits_cf_pc = isu_io_to_exu_bits_cf_pc; // @[frontend.scala 529:17]
  assign io_to_exu_bits_cf_next_pc = isu_io_to_exu_bits_cf_next_pc; // @[frontend.scala 529:17]
  assign io_to_exu_bits_cf_isBranch = isu_io_to_exu_bits_cf_isBranch; // @[frontend.scala 529:17]
  assign io_to_exu_bits_ctrl_MemWrite = isu_io_to_exu_bits_ctrl_MemWrite; // @[frontend.scala 529:17]
  assign io_to_exu_bits_ctrl_ResSrc = isu_io_to_exu_bits_ctrl_ResSrc; // @[frontend.scala 529:17]
  assign io_to_exu_bits_ctrl_fuType = isu_io_to_exu_bits_ctrl_fuType; // @[frontend.scala 529:17]
  assign io_to_exu_bits_ctrl_fuOpType = isu_io_to_exu_bits_ctrl_fuOpType; // @[frontend.scala 529:17]
  assign io_to_exu_bits_ctrl_rfWen = isu_io_to_exu_bits_ctrl_rfWen; // @[frontend.scala 529:17]
  assign io_to_exu_bits_ctrl_rd = isu_io_to_exu_bits_ctrl_rd; // @[frontend.scala 529:17]
  assign io_to_exu_bits_data_fuSrc1 = isu_io_to_exu_bits_data_fuSrc1; // @[frontend.scala 529:17]
  assign io_to_exu_bits_data_fuSrc2 = isu_io_to_exu_bits_data_fuSrc2; // @[frontend.scala 529:17]
  assign io_to_exu_bits_data_imm = isu_io_to_exu_bits_data_imm; // @[frontend.scala 529:17]
  assign io_to_exu_bits_data_rfSrc1 = isu_io_to_exu_bits_data_rfSrc1; // @[frontend.scala 529:17]
  assign io_to_exu_bits_data_rfSrc2 = isu_io_to_exu_bits_data_rfSrc2; // @[frontend.scala 529:17]
  assign io_rs1 = isu_io_to_exu_bits_ctrl_rs1; // @[frontend.scala 532:12]
  assign io_rs2 = isu_io_to_exu_bits_ctrl_rs2; // @[frontend.scala 533:12]
  assign ifu_clock = clock;
  assign ifu_reset = reset;
  assign ifu_io_inst = io_inst; // @[frontend.scala 526:17]
  assign ifu_io_to_idu_ready = idu_io_from_ifu_ready; // @[RVCore.scala 55:18]
  assign ifu_io_redirect_target = io_ifuredirect_target; // @[frontend.scala 528:21]
  assign ifu_io_redirect_valid = io_ifuredirect_valid; // @[frontend.scala 528:21]
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
  assign isu_io_to_exu_ready = io_to_exu_ready; // @[frontend.scala 529:17]
  assign isu_io_wb_rd = io_wb_rd; // @[frontend.scala 530:17]
  assign isu_io_wb_RegWrite = io_wb_RegWrite; // @[frontend.scala 530:17]
  assign isu_io_from_reg_rfSrc1 = io_rfSrc1; // @[frontend.scala 465:32]
  assign isu_io_from_reg_rfSrc2 = io_rfSrc2; // @[frontend.scala 466:32]
  always @(posedge clock) begin
    if (reset) begin // @[RVCore.scala 48:26]
      valid <= 1'h0; // @[RVCore.scala 48:26]
    end else if (io_redirect) begin // @[RVCore.scala 49:21]
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
    end else if (io_redirect) begin // @[RVCore.scala 49:21]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
