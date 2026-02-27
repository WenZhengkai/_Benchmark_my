module dut(
  input         clock,
  input         reset,
  output        io_from_isu_ready,
  input         io_from_isu_valid,
  input  [31:0] io_from_isu_bits_cf_inst,
  input  [31:0] io_from_isu_bits_cf_pc,
  input  [31:0] io_from_isu_bits_cf_next_pc,
  input         io_from_isu_bits_cf_isBranch,
  input         io_from_isu_bits_ctrl_MemWrite,
  input  [2:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_isu_bits_ctrl_fuSrc1Type,
  input  [2:0]  io_from_isu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_isu_bits_ctrl_fuType,
  input  [6:0]  io_from_isu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_isu_bits_ctrl_rs1,
  input  [4:0]  io_from_isu_bits_ctrl_rs2,
  input         io_from_isu_bits_ctrl_rfWen,
  input  [4:0]  io_from_isu_bits_ctrl_rd,
  input  [31:0] io_from_isu_bits_data_fuSrc1,
  input  [31:0] io_from_isu_bits_data_fuSrc2,
  input  [31:0] io_from_isu_bits_data_imm,
  input         io_from_isu_bits_data_Alu0Res_ready,
  input         io_from_isu_bits_data_Alu0Res_valid,
  input  [31:0] io_from_isu_bits_data_Alu0Res_bits,
  input  [31:0] io_from_isu_bits_data_data_from_mem,
  input  [31:0] io_from_isu_bits_data_csrRdata,
  input  [31:0] io_from_isu_bits_data_rfSrc1,
  input  [31:0] io_from_isu_bits_data_rfSrc2,
  input         io_to_wbu_ready,
  output        io_to_wbu_valid,
  output [31:0] io_to_wbu_bits_cf_inst,
  output [31:0] io_to_wbu_bits_cf_pc,
  output [31:0] io_to_wbu_bits_cf_next_pc,
  output        io_to_wbu_bits_cf_isBranch,
  output        io_to_wbu_bits_ctrl_MemWrite,
  output [2:0]  io_to_wbu_bits_ctrl_ResSrc,
  output [2:0]  io_to_wbu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_wbu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_wbu_bits_ctrl_fuType,
  output [6:0]  io_to_wbu_bits_ctrl_fuOpType,
  output [4:0]  io_to_wbu_bits_ctrl_rs1,
  output [4:0]  io_to_wbu_bits_ctrl_rs2,
  output        io_to_wbu_bits_ctrl_rfWen,
  output [4:0]  io_to_wbu_bits_ctrl_rd,
  output [31:0] io_to_wbu_bits_data_fuSrc1,
  output [31:0] io_to_wbu_bits_data_fuSrc2,
  output [31:0] io_to_wbu_bits_data_imm,
  output        io_to_wbu_bits_data_Alu0Res_ready,
  output        io_to_wbu_bits_data_Alu0Res_valid,
  output [31:0] io_to_wbu_bits_data_Alu0Res_bits,
  output [31:0] io_to_wbu_bits_data_data_from_mem,
  output [31:0] io_to_wbu_bits_data_csrRdata,
  output [31:0] io_to_wbu_bits_data_rfSrc1,
  output [31:0] io_to_wbu_bits_data_rfSrc2,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  output [31:0] io_redirect_target,
  output        io_redirect_valid
);
  wire [31:0] alu0_io_out_bits; // @[dut.scala 357:22]
  wire [31:0] alu0_io_in_bits_srca; // @[dut.scala 357:22]
  wire [31:0] alu0_io_in_bits_srcb; // @[dut.scala 357:22]
  wire [6:0] alu0_io_in_bits_fuOpType; // @[dut.scala 357:22]
  wire  alu0_io_taken; // @[dut.scala 357:22]
  wire [31:0] lsu0_io_out_bits; // @[dut.scala 366:22]
  wire [31:0] lsu0_io_in_bits_srca; // @[dut.scala 366:22]
  wire [31:0] lsu0_io_in_bits_srcb; // @[dut.scala 366:22]
  wire [31:0] lsu0_io_to_mem_data; // @[dut.scala 366:22]
  wire [31:0] lsu0_io_to_mem_addr; // @[dut.scala 366:22]
  wire [7:0] lsu0_io_to_mem_Wmask; // @[dut.scala 366:22]
  wire  lsu0_io_to_mem_MemWrite; // @[dut.scala 366:22]
  wire [31:0] lsu0_io_from_mem_data; // @[dut.scala 366:22]
  wire  lsu0_io_ctrl_MemWrite; // @[dut.scala 366:22]
  wire [6:0] lsu0_io_ctrl_fuOpType; // @[dut.scala 366:22]
  wire [31:0] lsu0_io_data_rfSrc2; // @[dut.scala 366:22]
  wire  csr0_clock; // @[dut.scala 380:22]
  wire  csr0_reset; // @[dut.scala 380:22]
  wire [31:0] csr0_io_out_bits; // @[dut.scala 380:22]
  wire  csr0_io_in_valid; // @[dut.scala 380:22]
  wire [31:0] csr0_io_in_bits_srca; // @[dut.scala 380:22]
  wire [31:0] csr0_io_in_bits_srcb; // @[dut.scala 380:22]
  wire [6:0] csr0_io_in_bits_fuOpType; // @[dut.scala 380:22]
  wire [31:0] csr0_io_cfIn_inst; // @[dut.scala 380:22]
  wire [31:0] csr0_io_cfIn_pc; // @[dut.scala 380:22]
  wire  csr0_io_jmp; // @[dut.scala 380:22]
  wire  _jalrBruRes_valid_T = io_from_isu_valid & io_from_isu_bits_cf_isBranch; // @[dut.scala 404:34]
  wire  jalrBruRes_valid = io_from_isu_valid & io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h67; // @[dut.scala 404:56]
  wire [31:0] _jalrBruRes_targetPc_T_1 = io_from_isu_bits_data_rfSrc1 + io_from_isu_bits_data_imm; // @[dut.scala 406:48]
  wire [31:0] jalrBruRes_targetPc = _jalrBruRes_targetPc_T_1 & 32'hfffffffe; // @[dut.scala 406:67]
  wire  typebBruRes_valid = _jalrBruRes_valid_T & io_from_isu_bits_cf_inst[6:0] == 7'h63; // @[dut.scala 409:57]
  wire [31:0] pcIfBranch = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[dut.scala 410:35]
  wire [31:0] _typebBruRes_targetPc_T_1 = io_from_isu_bits_cf_pc + 32'h4; // @[dut.scala 411:73]
  wire [31:0] typebBruRes_targetPc = alu0_io_taken ? pcIfBranch : _typebBruRes_targetPc_T_1; // @[dut.scala 411:32]
  wire  csrBruRes_valid = io_from_isu_valid & csr0_io_jmp; // @[dut.scala 414:33]
  wire [31:0] csrBruRes_targetPc = csr0_io_out_bits; // @[dut.scala 413:25 415:24]
  wire [31:0] _bruRes_T_targetPc = csrBruRes_valid ? csrBruRes_targetPc : 32'h0; // @[Mux.scala 101:16]
  wire  _bruRes_T_1_valid = typebBruRes_valid ? typebBruRes_valid : csrBruRes_valid; // @[Mux.scala 101:16]
  wire [31:0] _bruRes_T_1_targetPc = typebBruRes_valid ? typebBruRes_targetPc : _bruRes_T_targetPc; // @[Mux.scala 101:16]
  wire  bruRes_valid = jalrBruRes_valid ? jalrBruRes_valid : _bruRes_T_1_valid; // @[Mux.scala 101:16]
  wire [31:0] bruRes_targetPc = jalrBruRes_valid ? jalrBruRes_targetPc : _bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  wire  PredictError = bruRes_targetPc != io_from_isu_bits_cf_next_pc; // @[dut.scala 429:40]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[dut.scala 449:48]
  wire  _io_from_isu_ready_T_1 = io_to_wbu_ready & io_to_wbu_valid; // @[Decoupled.scala 51:35]
  ALU_golden alu0 ( // @[dut.scala 357:22]
    .io_out_bits(alu0_io_out_bits),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_taken(alu0_io_taken)
  );
  LSU_golden lsu0 ( // @[dut.scala 366:22]
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
  CSR_golden csr0 ( // @[dut.scala 380:22]
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
  assign io_from_isu_ready = (~io_from_isu_valid | _io_from_isu_ready_T_1) & ~_T; // @[dut.scala 69:74]
  assign io_to_wbu_valid = io_from_isu_valid; // @[dut.scala 70:40]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[dut.scala 346:17]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[dut.scala 346:17]
  assign io_to_wbu_bits_cf_next_pc = bruRes_valid ? bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[dut.scala 433:31]
  assign io_to_wbu_bits_cf_isBranch = io_from_isu_bits_cf_isBranch; // @[dut.scala 346:17]
  assign io_to_wbu_bits_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_fuSrc1Type = io_from_isu_bits_ctrl_fuSrc1Type; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_fuSrc2Type = io_from_isu_bits_ctrl_fuSrc2Type; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_fuType = io_from_isu_bits_ctrl_fuType; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_rs1 = io_from_isu_bits_ctrl_rs1; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_rs2 = io_from_isu_bits_ctrl_rs2; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[dut.scala 347:19]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[dut.scala 347:19]
  assign io_to_wbu_bits_data_fuSrc1 = io_from_isu_bits_data_fuSrc1; // @[dut.scala 348:19]
  assign io_to_wbu_bits_data_fuSrc2 = io_from_isu_bits_data_fuSrc2; // @[dut.scala 348:19]
  assign io_to_wbu_bits_data_imm = io_from_isu_bits_data_imm; // @[dut.scala 348:19]
  assign io_to_wbu_bits_data_Alu0Res_ready = io_from_isu_bits_data_Alu0Res_ready; // @[dut.scala 348:19]
  assign io_to_wbu_bits_data_Alu0Res_valid = io_from_isu_bits_data_Alu0Res_valid; // @[dut.scala 348:19]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[dut.scala 443:32]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[dut.scala 377:33]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_bits; // @[dut.scala 388:28]
  assign io_to_wbu_bits_data_rfSrc1 = io_from_isu_bits_data_rfSrc1; // @[dut.scala 348:19]
  assign io_to_wbu_bits_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[dut.scala 348:19]
  assign io_to_mem_data = lsu0_io_to_mem_data; // @[dut.scala 372:15]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[dut.scala 372:15]
  assign io_to_mem_Wmask = lsu0_io_to_mem_Wmask; // @[dut.scala 372:15]
  assign io_to_mem_MemWrite = lsu0_io_to_mem_MemWrite; // @[dut.scala 372:15]
  assign io_redirect_target = jalrBruRes_valid ? jalrBruRes_targetPc : _bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  assign io_redirect_valid = io_from_isu_valid & bruRes_valid & PredictError; // @[dut.scala 430:51]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 359:21]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 360:21]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 361:25]
  assign lsu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 367:26]
  assign lsu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 368:26]
  assign lsu0_io_from_mem_data = io_from_mem_data; // @[dut.scala 371:22]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 374:18]
  assign lsu0_io_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 374:18]
  assign lsu0_io_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[dut.scala 375:18]
  assign csr0_clock = clock;
  assign csr0_reset = reset;
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 3'h3; // @[dut.scala 383:16]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 736:15]
  assign csr0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 737:15]
  assign csr0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 738:19]
  assign csr0_io_cfIn_inst = io_from_isu_bits_cf_inst; // @[dut.scala 381:15]
  assign csr0_io_cfIn_pc = io_from_isu_bits_cf_pc; // @[dut.scala 381:15]
endmodule
