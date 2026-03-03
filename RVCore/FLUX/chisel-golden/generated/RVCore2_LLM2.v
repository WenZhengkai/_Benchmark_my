module RVCore2_LLM2(
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
`endif // RANDOMIZE_REG_INIT
  wire  frontend_clock; // @[RVCore.scala 161:24]
  wire  frontend_reset; // @[RVCore.scala 161:24]
  wire  frontend_io_redirect; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_inst; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_pc; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_ifuredirect_target; // @[RVCore.scala 161:24]
  wire  frontend_io_ifuredirect_valid; // @[RVCore.scala 161:24]
  wire  frontend_io_to_exu_ready; // @[RVCore.scala 161:24]
  wire  frontend_io_to_exu_valid; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_cf_inst; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_cf_pc; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_cf_next_pc; // @[RVCore.scala 161:24]
  wire  frontend_io_to_exu_bits_cf_isBranch; // @[RVCore.scala 161:24]
  wire  frontend_io_to_exu_bits_ctrl_MemWrite; // @[RVCore.scala 161:24]
  wire [1:0] frontend_io_to_exu_bits_ctrl_ResSrc; // @[RVCore.scala 161:24]
  wire [2:0] frontend_io_to_exu_bits_ctrl_fuType; // @[RVCore.scala 161:24]
  wire [6:0] frontend_io_to_exu_bits_ctrl_fuOpType; // @[RVCore.scala 161:24]
  wire  frontend_io_to_exu_bits_ctrl_rfWen; // @[RVCore.scala 161:24]
  wire [4:0] frontend_io_to_exu_bits_ctrl_rd; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_data_fuSrc1; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_data_fuSrc2; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_data_imm; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_data_rfSrc1; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_to_exu_bits_data_rfSrc2; // @[RVCore.scala 161:24]
  wire [4:0] frontend_io_wb_rd; // @[RVCore.scala 161:24]
  wire  frontend_io_wb_RegWrite; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_rfSrc1; // @[RVCore.scala 161:24]
  wire [31:0] frontend_io_rfSrc2; // @[RVCore.scala 161:24]
  wire [4:0] frontend_io_rs1; // @[RVCore.scala 161:24]
  wire [4:0] frontend_io_rs2; // @[RVCore.scala 161:24]
  wire  exu_clock; // @[RVCore.scala 162:19]
  wire  exu_reset; // @[RVCore.scala 162:19]
  wire  exu_io_from_isu_ready; // @[RVCore.scala 162:19]
  wire  exu_io_from_isu_valid; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_cf_inst; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_cf_pc; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_cf_next_pc; // @[RVCore.scala 162:19]
  wire  exu_io_from_isu_bits_cf_isBranch; // @[RVCore.scala 162:19]
  wire  exu_io_from_isu_bits_ctrl_MemWrite; // @[RVCore.scala 162:19]
  wire [1:0] exu_io_from_isu_bits_ctrl_ResSrc; // @[RVCore.scala 162:19]
  wire [2:0] exu_io_from_isu_bits_ctrl_fuType; // @[RVCore.scala 162:19]
  wire [6:0] exu_io_from_isu_bits_ctrl_fuOpType; // @[RVCore.scala 162:19]
  wire  exu_io_from_isu_bits_ctrl_rfWen; // @[RVCore.scala 162:19]
  wire [4:0] exu_io_from_isu_bits_ctrl_rd; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_data_fuSrc1; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_data_fuSrc2; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_data_imm; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_data_rfSrc1; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_isu_bits_data_rfSrc2; // @[RVCore.scala 162:19]
  wire  exu_io_to_wbu_ready; // @[RVCore.scala 162:19]
  wire  exu_io_to_wbu_valid; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_wbu_bits_cf_inst; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_wbu_bits_cf_pc; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_wbu_bits_cf_next_pc; // @[RVCore.scala 162:19]
  wire [1:0] exu_io_to_wbu_bits_ctrl_ResSrc; // @[RVCore.scala 162:19]
  wire  exu_io_to_wbu_bits_ctrl_rfWen; // @[RVCore.scala 162:19]
  wire [4:0] exu_io_to_wbu_bits_ctrl_rd; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_wbu_bits_data_Alu0Res_bits; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_wbu_bits_data_data_from_mem; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_wbu_bits_data_csrRdata; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_mem_data; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_to_mem_addr; // @[RVCore.scala 162:19]
  wire [7:0] exu_io_to_mem_Wmask; // @[RVCore.scala 162:19]
  wire  exu_io_to_mem_MemWrite; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_from_mem_data; // @[RVCore.scala 162:19]
  wire [31:0] exu_io_redirect_target; // @[RVCore.scala 162:19]
  wire  exu_io_redirect_valid; // @[RVCore.scala 162:19]
  wire  wbu_io_from_exu_ready; // @[RVCore.scala 163:19]
  wire  wbu_io_from_exu_valid; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_from_exu_bits_cf_inst; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_from_exu_bits_cf_pc; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_from_exu_bits_cf_next_pc; // @[RVCore.scala 163:19]
  wire [1:0] wbu_io_from_exu_bits_ctrl_ResSrc; // @[RVCore.scala 163:19]
  wire  wbu_io_from_exu_bits_ctrl_rfWen; // @[RVCore.scala 163:19]
  wire [4:0] wbu_io_from_exu_bits_ctrl_rd; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_from_exu_bits_data_Alu0Res_bits; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_from_exu_bits_data_data_from_mem; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_from_exu_bits_data_csrRdata; // @[RVCore.scala 163:19]
  wire  wbu_io_to_reg_valid; // @[RVCore.scala 163:19]
  wire [4:0] wbu_io_to_reg_bits_rd; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_to_reg_bits_Res; // @[RVCore.scala 163:19]
  wire  wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_to_commit_inst; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_to_commit_pc; // @[RVCore.scala 163:19]
  wire [31:0] wbu_io_to_commit_next_pc; // @[RVCore.scala 163:19]
  wire  regfile_clk; // @[RVCore.scala 202:23]
  wire [4:0] regfile_rs1; // @[RVCore.scala 202:23]
  wire [4:0] regfile_rs2; // @[RVCore.scala 202:23]
  wire [4:0] regfile_rd; // @[RVCore.scala 202:23]
  wire [31:0] regfile_dest; // @[RVCore.scala 202:23]
  wire  regfile_RegWrite; // @[RVCore.scala 202:23]
  wire [31:0] regfile_src1; // @[RVCore.scala 202:23]
  wire [31:0] regfile_src2; // @[RVCore.scala 202:23]
  wire  _T = exu_io_to_wbu_ready & exu_io_to_wbu_valid; // @[Decoupled.scala 51:35]
  reg  valid; // @[RVCore.scala 48:26]
  wire  _exu_io_from_isu_bits_T = frontend_io_to_exu_valid & exu_io_from_isu_ready; // @[RVCore.scala 57:53]
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
  wire  _T_2 = wbu_io_to_reg_valid; // @[RVCore.scala 184:68]
  reg  valid_1; // @[RVCore.scala 48:26]
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
  reg  io_commit_valid_REG; // @[RVCore.scala 196:29]
  reg [31:0] io_commit_pc_REG; // @[RVCore.scala 197:26]
  reg [31:0] io_commit_next_pc_REG; // @[RVCore.scala 198:31]
  reg [31:0] io_commit_inst_REG; // @[RVCore.scala 199:28]
  frontend frontend ( // @[RVCore.scala 161:24]
    .clock(frontend_clock),
    .reset(frontend_reset),
    .io_redirect(frontend_io_redirect),
    .io_inst(frontend_io_inst),
    .io_pc(frontend_io_pc),
    .io_ifuredirect_target(frontend_io_ifuredirect_target),
    .io_ifuredirect_valid(frontend_io_ifuredirect_valid),
    .io_to_exu_ready(frontend_io_to_exu_ready),
    .io_to_exu_valid(frontend_io_to_exu_valid),
    .io_to_exu_bits_cf_inst(frontend_io_to_exu_bits_cf_inst),
    .io_to_exu_bits_cf_pc(frontend_io_to_exu_bits_cf_pc),
    .io_to_exu_bits_cf_next_pc(frontend_io_to_exu_bits_cf_next_pc),
    .io_to_exu_bits_cf_isBranch(frontend_io_to_exu_bits_cf_isBranch),
    .io_to_exu_bits_ctrl_MemWrite(frontend_io_to_exu_bits_ctrl_MemWrite),
    .io_to_exu_bits_ctrl_ResSrc(frontend_io_to_exu_bits_ctrl_ResSrc),
    .io_to_exu_bits_ctrl_fuType(frontend_io_to_exu_bits_ctrl_fuType),
    .io_to_exu_bits_ctrl_fuOpType(frontend_io_to_exu_bits_ctrl_fuOpType),
    .io_to_exu_bits_ctrl_rfWen(frontend_io_to_exu_bits_ctrl_rfWen),
    .io_to_exu_bits_ctrl_rd(frontend_io_to_exu_bits_ctrl_rd),
    .io_to_exu_bits_data_fuSrc1(frontend_io_to_exu_bits_data_fuSrc1),
    .io_to_exu_bits_data_fuSrc2(frontend_io_to_exu_bits_data_fuSrc2),
    .io_to_exu_bits_data_imm(frontend_io_to_exu_bits_data_imm),
    .io_to_exu_bits_data_rfSrc1(frontend_io_to_exu_bits_data_rfSrc1),
    .io_to_exu_bits_data_rfSrc2(frontend_io_to_exu_bits_data_rfSrc2),
    .io_wb_rd(frontend_io_wb_rd),
    .io_wb_RegWrite(frontend_io_wb_RegWrite),
    .io_rfSrc1(frontend_io_rfSrc1),
    .io_rfSrc2(frontend_io_rfSrc2),
    .io_rs1(frontend_io_rs1),
    .io_rs2(frontend_io_rs2)
  );
  EXU exu ( // @[RVCore.scala 162:19]
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
  WBU wbu ( // @[RVCore.scala 163:19]
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
  ysyx_23060228_RegFile_BlackBox #(.DATA_WIDTH(32)) regfile ( // @[RVCore.scala 202:23]
    .clk(regfile_clk),
    .rs1(regfile_rs1),
    .rs2(regfile_rs2),
    .rd(regfile_rd),
    .dest(regfile_dest),
    .RegWrite(regfile_RegWrite),
    .src1(regfile_src1),
    .src2(regfile_src2)
  );
  assign io_to_mem_data = exu_io_to_mem_data; // @[RVCore.scala 173:13]
  assign io_to_mem_addr = exu_io_to_mem_addr; // @[RVCore.scala 173:13]
  assign io_to_mem_Wmask = exu_io_to_mem_Wmask; // @[RVCore.scala 173:13]
  assign io_to_mem_MemWrite = exu_io_to_mem_MemWrite; // @[RVCore.scala 173:13]
  assign io_pc = frontend_io_pc; // @[RVCore.scala 169:9]
  assign io_commit_valid = io_commit_valid_REG; // @[RVCore.scala 196:19]
  assign io_commit_pc = io_commit_pc_REG; // @[RVCore.scala 197:16]
  assign io_commit_next_pc = io_commit_next_pc_REG; // @[RVCore.scala 198:21]
  assign io_commit_inst = io_commit_inst_REG; // @[RVCore.scala 199:18]
  assign frontend_clock = clock;
  assign frontend_reset = reset;
  assign frontend_io_redirect = exu_io_redirect_valid; // @[RVCore.scala 178:24]
  assign frontend_io_inst = io_inst; // @[RVCore.scala 166:20]
  assign frontend_io_ifuredirect_target = exu_io_redirect_target; // @[RVCore.scala 187:27]
  assign frontend_io_ifuredirect_valid = exu_io_redirect_valid; // @[RVCore.scala 187:27]
  assign frontend_io_to_exu_ready = exu_io_from_isu_ready; // @[RVCore.scala 55:18]
  assign frontend_io_wb_rd = wbu_io_to_reg_bits_rd; // @[RVCore.scala 189:18]
  assign frontend_io_wb_RegWrite = wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 189:18]
  assign frontend_io_rfSrc1 = regfile_src1; // @[frontend.scala 536:23]
  assign frontend_io_rfSrc2 = regfile_src2; // @[frontend.scala 537:23]
  assign exu_clock = clock;
  assign exu_reset = reset;
  assign exu_io_from_isu_valid = valid; // @[RVCore.scala 54:19]
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
  assign exu_io_from_mem_data = io_from_mem_data; // @[RVCore.scala 172:19]
  assign wbu_io_from_exu_valid = valid_1; // @[RVCore.scala 54:19]
  assign wbu_io_from_exu_bits_cf_inst = wbu_io_from_exu_bits_r_cf_inst; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_cf_pc = wbu_io_from_exu_bits_r_cf_pc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_cf_next_pc = wbu_io_from_exu_bits_r_cf_next_pc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_ResSrc = wbu_io_from_exu_bits_r_ctrl_ResSrc; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_rfWen = wbu_io_from_exu_bits_r_ctrl_rfWen; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_ctrl_rd = wbu_io_from_exu_bits_r_ctrl_rd; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_Alu0Res_bits = wbu_io_from_exu_bits_r_data_Alu0Res_bits; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_data_from_mem = wbu_io_from_exu_bits_r_data_data_from_mem; // @[RVCore.scala 57:18]
  assign wbu_io_from_exu_bits_data_csrRdata = wbu_io_from_exu_bits_r_data_csrRdata; // @[RVCore.scala 57:18]
  assign regfile_clk = clock; // @[RVCore.scala 203:18]
  assign regfile_rs1 = frontend_io_rs1; // @[RVCore.scala 205:18]
  assign regfile_rs2 = frontend_io_rs2; // @[RVCore.scala 206:18]
  assign regfile_rd = wbu_io_to_reg_bits_rd; // @[RVCore.scala 207:19]
  assign regfile_dest = wbu_io_to_reg_bits_Res; // @[RVCore.scala 208:19]
  assign regfile_RegWrite = wbu_io_to_reg_bits_RegWrite; // @[RVCore.scala 209:23]
  always @(posedge clock) begin
    if (reset) begin // @[RVCore.scala 48:26]
      valid <= 1'h0; // @[RVCore.scala 48:26]
    end else if (exu_io_from_isu_ready & frontend_io_to_exu_valid) begin // @[RVCore.scala 50:44]
      valid <= frontend_io_to_exu_valid; // @[RVCore.scala 50:51]
    end else if (_T) begin // @[RVCore.scala 51:38]
      valid <= 1'h0; // @[RVCore.scala 51:45]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_inst <= frontend_io_to_exu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_pc <= frontend_io_to_exu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_next_pc <= frontend_io_to_exu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_cf_isBranch <= frontend_io_to_exu_bits_cf_isBranch; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_MemWrite <= frontend_io_to_exu_bits_ctrl_MemWrite; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_ResSrc <= frontend_io_to_exu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_fuType <= frontend_io_to_exu_bits_ctrl_fuType; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_fuOpType <= frontend_io_to_exu_bits_ctrl_fuOpType; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_rfWen <= frontend_io_to_exu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_ctrl_rd <= frontend_io_to_exu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_fuSrc1 <= frontend_io_to_exu_bits_data_fuSrc1; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_fuSrc2 <= frontend_io_to_exu_bits_data_fuSrc2; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_imm <= frontend_io_to_exu_bits_data_imm; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_rfSrc1 <= frontend_io_to_exu_bits_data_rfSrc1; // @[Reg.scala 20:22]
    end
    if (_exu_io_from_isu_bits_T) begin // @[Reg.scala 20:18]
      exu_io_from_isu_bits_r_data_rfSrc2 <= frontend_io_to_exu_bits_data_rfSrc2; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[RVCore.scala 48:26]
      valid_1 <= 1'h0; // @[RVCore.scala 48:26]
    end else if (wbu_io_from_exu_ready & exu_io_to_wbu_valid) begin // @[RVCore.scala 50:44]
      valid_1 <= exu_io_to_wbu_valid; // @[RVCore.scala 50:51]
    end else if (_T_2) begin // @[RVCore.scala 51:38]
      valid_1 <= 1'h0; // @[RVCore.scala 51:45]
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
    if (reset) begin // @[RVCore.scala 196:29]
      io_commit_valid_REG <= 1'h0; // @[RVCore.scala 196:29]
    end else begin
      io_commit_valid_REG <= wbu_io_to_reg_valid; // @[RVCore.scala 196:29]
    end
    io_commit_pc_REG <= wbu_io_to_commit_pc; // @[RVCore.scala 197:26]
    io_commit_next_pc_REG <= wbu_io_to_commit_next_pc; // @[RVCore.scala 198:31]
    io_commit_inst_REG <= wbu_io_to_commit_inst; // @[RVCore.scala 199:28]
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
  exu_io_from_isu_bits_r_cf_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_next_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_cf_isBranch = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_MemWrite = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_ResSrc = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_fuType = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_fuOpType = _RAND_8[6:0];
  _RAND_9 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_rfWen = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_ctrl_rd = _RAND_10[4:0];
  _RAND_11 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_fuSrc1 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_fuSrc2 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_imm = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_rfSrc1 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  exu_io_from_isu_bits_r_data_rfSrc2 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  valid_1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_inst = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_pc = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_cf_next_pc = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_ResSrc = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_rfWen = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_ctrl_rd = _RAND_22[4:0];
  _RAND_23 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_Alu0Res_bits = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_data_from_mem = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  wbu_io_from_exu_bits_r_data_csrRdata = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  io_commit_valid_REG = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  io_commit_pc_REG = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  io_commit_next_pc_REG = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  io_commit_inst_REG = _RAND_29[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
