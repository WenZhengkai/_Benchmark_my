module EXU_LLM(
  input         clock,
  input         reset,
  output        io_from_isu_ready,
  input         io_from_isu_valid,
  input  [31:0] io_from_isu_bits_cf_inst,
  input  [31:0] io_from_isu_bits_cf_pc,
  input  [31:0] io_from_isu_bits_cf_next_pc,
  input         io_from_isu_bits_cf_isBranch,
  input         io_from_isu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_isu_bits_ctrl_fuType,
  input  [6:0]  io_from_isu_bits_ctrl_fuOpType,
  input         io_from_isu_bits_ctrl_rfWen,
  input  [4:0]  io_from_isu_bits_ctrl_rd,
  input  [31:0] io_from_isu_bits_data_fuSrc1,
  input  [31:0] io_from_isu_bits_data_fuSrc2,
  input  [31:0] io_from_isu_bits_data_imm,
  input  [31:0] io_from_isu_bits_data_rfSrc1,
  input  [31:0] io_from_isu_bits_data_rfSrc2,
  input         io_to_wbu_ready,
  output        io_to_wbu_valid,
  output [31:0] io_to_wbu_bits_cf_inst,
  output [31:0] io_to_wbu_bits_cf_pc,
  output [31:0] io_to_wbu_bits_cf_next_pc,
  output [1:0]  io_to_wbu_bits_ctrl_ResSrc,
  output        io_to_wbu_bits_ctrl_rfWen,
  output [4:0]  io_to_wbu_bits_ctrl_rd,
  output [31:0] io_to_wbu_bits_data_Alu0Res_bits,
  output [31:0] io_to_wbu_bits_data_data_from_mem,
  output [31:0] io_to_wbu_bits_data_csrRdata,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  output [31:0] io_redirect_target,
  output        io_redirect_valid
);
  wire [31:0] alu0_io_out_bits; // @[EXU.scala 402:20]
  wire [31:0] alu0_io_in_bits_srca; // @[EXU.scala 402:20]
  wire [31:0] alu0_io_in_bits_srcb; // @[EXU.scala 402:20]
  wire [6:0] alu0_io_in_bits_fuOpType; // @[EXU.scala 402:20]
  wire  alu0_io_taken; // @[EXU.scala 402:20]
  wire [31:0] lsu0_io_out_bits; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_in_bits_srca; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_in_bits_srcb; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_to_mem_data; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_to_mem_addr; // @[EXU.scala 403:20]
  wire [7:0] lsu0_io_to_mem_Wmask; // @[EXU.scala 403:20]
  wire  lsu0_io_to_mem_MemWrite; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_from_mem_data; // @[EXU.scala 403:20]
  wire  lsu0_io_ctrl_MemWrite; // @[EXU.scala 403:20]
  wire [6:0] lsu0_io_ctrl_fuOpType; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_data_rfSrc2; // @[EXU.scala 403:20]
  wire  csr0_clock; // @[EXU.scala 404:20]
  wire  csr0_reset; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_out_bits; // @[EXU.scala 404:20]
  wire  csr0_io_in_valid; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_in_bits_srca; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_in_bits_srcb; // @[EXU.scala 404:20]
  wire [6:0] csr0_io_in_bits_fuOpType; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_cfIn_inst; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_cfIn_pc; // @[EXU.scala 404:20]
  wire  csr0_io_jmp; // @[EXU.scala 404:20]
  wire  bruRes_jalrBruRes_valid = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h67; // @[BruRes.scala 9:48]
  wire [31:0] _bruRes_jalrBruRes_targetPc_T_1 = io_from_isu_bits_data_rfSrc1 + io_from_isu_bits_data_imm; // @[BruRes.scala 10:52]
  wire [31:0] bruRes_jalrBruRes_targetPc = _bruRes_jalrBruRes_targetPc_T_1 & 32'hfffffffe; // @[BruRes.scala 10:71]
  wire  bruRes_typebBruRes_valid = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h63; // @[BruRes.scala 13:49]
  wire [31:0] bruRes_pcIfBranch = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[BruRes.scala 14:39]
  wire [31:0] _bruRes_typebBruRes_targetPc_T_1 = io_from_isu_bits_cf_pc + 32'h4; // @[BruRes.scala 15:77]
  wire [31:0] bruRes_typebBruRes_targetPc = alu0_io_taken ? bruRes_pcIfBranch : _bruRes_typebBruRes_targetPc_T_1; // @[BruRes.scala 15:36]
  wire  bruRes_csrBruRes_valid = csr0_io_jmp; // @[BruRes.scala 17:29 18:25]
  wire [31:0] bruRes_csrBruRes_targetPc = csr0_io_out_bits; // @[BruRes.scala 17:29 19:28]
  wire [31:0] _bruRes_bruRes_T_targetPc = bruRes_csrBruRes_valid ? bruRes_csrBruRes_targetPc : 32'h0; // @[Mux.scala 101:16]
  wire  _bruRes_bruRes_T_1_valid = bruRes_typebBruRes_valid ? bruRes_typebBruRes_valid : bruRes_csrBruRes_valid; // @[Mux.scala 101:16]
  wire [31:0] _bruRes_bruRes_T_1_targetPc = bruRes_typebBruRes_valid ? bruRes_typebBruRes_targetPc :
    _bruRes_bruRes_T_targetPc; // @[Mux.scala 101:16]
  wire  bruRes_bruRes_valid = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_valid : _bruRes_bruRes_T_1_valid; // @[Mux.scala 101:16]
  wire [31:0] bruRes_bruRes_targetPc = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_targetPc :
    _bruRes_bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[EXU.scala 452:41]
  wire  _io_from_isu_ready_T_1 = io_to_wbu_ready & io_to_wbu_valid; // @[Decoupled.scala 51:35]
  ALU alu0 ( // @[EXU.scala 402:20]
    .io_out_bits(alu0_io_out_bits),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_taken(alu0_io_taken)
  );
  LSU lsu0 ( // @[EXU.scala 403:20]
    .io_out_bits(lsu0_io_out_bits),
    .io_in_bits_srca(lsu0_io_in_bits_srca),
    .io_in_bits_srcb(lsu0_io_in_bits_srcb),
    .io_to_mem_data(lsu0_io_to_mem_data),
    .io_to_mem_addr(lsu0_io_to_mem_addr),
    .io_to_mem_Wmask(lsu0_io_to_mem_Wmask),
    .io_to_mem_MemWrite(lsu0_io_to_mem_MemWrite),
    .io_from_mem_data(lsu0_io_from_mem_data),
    .io_ctrl_MemWrite(lsu0_io_ctrl_MemWrite),
    .io_ctrl_fuOpType(lsu0_io_ctrl_fuOpType),
    .io_data_rfSrc2(lsu0_io_data_rfSrc2)
  );
  CSR csr0 ( // @[EXU.scala 404:20]
    .clock(csr0_clock),
    .reset(csr0_reset),
    .io_out_bits(csr0_io_out_bits),
    .io_in_valid(csr0_io_in_valid),
    .io_in_bits_srca(csr0_io_in_bits_srca),
    .io_in_bits_srcb(csr0_io_in_bits_srcb),
    .io_in_bits_fuOpType(csr0_io_in_bits_fuOpType),
    .io_cfIn_inst(csr0_io_cfIn_inst),
    .io_cfIn_pc(csr0_io_cfIn_pc),
    .io_jmp(csr0_io_jmp)
  );
  assign io_from_isu_ready = (~io_from_isu_valid | _io_from_isu_ready_T_1) & ~_T; // @[RVCore.scala 66:74]
  assign io_to_wbu_valid = io_from_isu_valid; // @[RVCore.scala 67:40]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 399:21]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 399:21]
  assign io_to_wbu_bits_cf_next_pc = io_redirect_valid ? bruRes_bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[EXU.scala 445:35]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[EXU.scala 431:36]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[EXU.scala 432:37]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_bits; // @[EXU.scala 434:32]
  assign io_to_mem_data = lsu0_io_to_mem_data; // @[EXU.scala 433:13]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[EXU.scala 433:13]
  assign io_to_mem_Wmask = lsu0_io_to_mem_Wmask; // @[EXU.scala 433:13]
  assign io_to_mem_MemWrite = lsu0_io_to_mem_MemWrite; // @[EXU.scala 433:13]
  assign io_redirect_target = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_targetPc : _bruRes_bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  assign io_redirect_valid = io_from_isu_valid & bruRes_bruRes_valid & io_from_isu_bits_cf_next_pc !=
    bruRes_bruRes_targetPc; // @[EXU.scala 441:58]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 407:24]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 408:24]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 409:28]
  assign lsu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 413:24]
  assign lsu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 414:24]
  assign lsu0_io_from_mem_data = io_from_mem_data; // @[EXU.scala 418:20]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[EXU.scala 416:16]
  assign lsu0_io_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 416:16]
  assign lsu0_io_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[EXU.scala 417:16]
  assign csr0_clock = clock;
  assign csr0_reset = reset;
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 3'h3; // @[EXU.scala 427:41]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 423:24]
  assign csr0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 424:24]
  assign csr0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 425:28]
  assign csr0_io_cfIn_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 426:16]
  assign csr0_io_cfIn_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 426:16]
endmodule
