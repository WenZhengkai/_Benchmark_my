module EXU(
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
  wire [31:0] alu0_io_out_bits; // @[EXU.scala 183:22]
  wire [31:0] alu0_io_in_bits_srca; // @[EXU.scala 183:22]
  wire [31:0] alu0_io_in_bits_srcb; // @[EXU.scala 183:22]
  wire [6:0] alu0_io_in_bits_fuOpType; // @[EXU.scala 183:22]
  wire  alu0_io_taken; // @[EXU.scala 183:22]
  wire [31:0] lsu0_io_out_bits; // @[EXU.scala 192:22]
  wire [31:0] lsu0_io_in_bits_srca; // @[EXU.scala 192:22]
  wire [31:0] lsu0_io_in_bits_srcb; // @[EXU.scala 192:22]
  wire [31:0] lsu0_io_to_mem_data; // @[EXU.scala 192:22]
  wire [31:0] lsu0_io_to_mem_addr; // @[EXU.scala 192:22]
  wire [7:0] lsu0_io_to_mem_Wmask; // @[EXU.scala 192:22]
  wire  lsu0_io_to_mem_MemWrite; // @[EXU.scala 192:22]
  wire [31:0] lsu0_io_from_mem_data; // @[EXU.scala 192:22]
  wire  lsu0_io_ctrl_MemWrite; // @[EXU.scala 192:22]
  wire [6:0] lsu0_io_ctrl_fuOpType; // @[EXU.scala 192:22]
  wire [31:0] lsu0_io_data_rfSrc2; // @[EXU.scala 192:22]
  wire  csr0_clock; // @[EXU.scala 206:22]
  wire  csr0_reset; // @[EXU.scala 206:22]
  wire [31:0] csr0_io_out_bits; // @[EXU.scala 206:22]
  wire  csr0_io_in_valid; // @[EXU.scala 206:22]
  wire [31:0] csr0_io_in_bits_srca; // @[EXU.scala 206:22]
  wire [31:0] csr0_io_in_bits_srcb; // @[EXU.scala 206:22]
  wire [6:0] csr0_io_in_bits_fuOpType; // @[EXU.scala 206:22]
  wire [31:0] csr0_io_cfIn_inst; // @[EXU.scala 206:22]
  wire [31:0] csr0_io_cfIn_pc; // @[EXU.scala 206:22]
  wire  csr0_io_jmp; // @[EXU.scala 206:22]
  wire  _jalrBruRes_valid_T = io_from_isu_valid & io_from_isu_bits_cf_isBranch; // @[EXU.scala 230:34]
  wire  jalrBruRes_valid = io_from_isu_valid & io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h67; // @[EXU.scala 230:56]
  wire [31:0] _jalrBruRes_targetPc_T_1 = io_from_isu_bits_data_rfSrc1 + io_from_isu_bits_data_imm; // @[EXU.scala 232:48]
  wire [31:0] jalrBruRes_targetPc = _jalrBruRes_targetPc_T_1 & 32'hfffffffe; // @[EXU.scala 232:67]
  wire  typebBruRes_valid = _jalrBruRes_valid_T & io_from_isu_bits_cf_inst[6:0] == 7'h63; // @[EXU.scala 235:57]
  wire [31:0] pcIfBranch = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[EXU.scala 236:35]
  wire [31:0] _typebBruRes_targetPc_T_1 = io_from_isu_bits_cf_pc + 32'h4; // @[EXU.scala 237:73]
  wire [31:0] typebBruRes_targetPc = alu0_io_taken ? pcIfBranch : _typebBruRes_targetPc_T_1; // @[EXU.scala 237:32]
  wire  csrBruRes_valid = io_from_isu_valid & csr0_io_jmp; // @[EXU.scala 240:33]
  wire [31:0] csrBruRes_targetPc = csr0_io_out_bits; // @[EXU.scala 239:25 241:24]
  wire [31:0] _bruRes_T_targetPc = csrBruRes_valid ? csrBruRes_targetPc : 32'h0; // @[Mux.scala 101:16]
  wire  _bruRes_T_1_valid = typebBruRes_valid ? typebBruRes_valid : csrBruRes_valid; // @[Mux.scala 101:16]
  wire [31:0] _bruRes_T_1_targetPc = typebBruRes_valid ? typebBruRes_targetPc : _bruRes_T_targetPc; // @[Mux.scala 101:16]
  wire  bruRes_valid = jalrBruRes_valid ? jalrBruRes_valid : _bruRes_T_1_valid; // @[Mux.scala 101:16]
  wire [31:0] bruRes_targetPc = jalrBruRes_valid ? jalrBruRes_targetPc : _bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  wire  PredictError = bruRes_targetPc != io_from_isu_bits_cf_next_pc; // @[EXU.scala 255:40]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[EXU.scala 275:48]
  wire  _io_from_isu_ready_T_1 = io_to_wbu_ready & io_to_wbu_valid; // @[Decoupled.scala 51:35]
  ALU alu0 ( // @[EXU.scala 183:22]
    .io_out_bits(alu0_io_out_bits),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_taken(alu0_io_taken)
  );
  LSU lsu0 ( // @[EXU.scala 192:22]
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
  CSR csr0 ( // @[EXU.scala 206:22]
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
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 172:17]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 172:17]
  assign io_to_wbu_bits_cf_next_pc = bruRes_valid ? bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[EXU.scala 259:31]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[EXU.scala 173:19]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[EXU.scala 173:19]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[EXU.scala 173:19]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[EXU.scala 269:32]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[EXU.scala 203:33]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_bits; // @[EXU.scala 214:28]
  assign io_to_mem_data = lsu0_io_to_mem_data; // @[EXU.scala 198:15]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[EXU.scala 198:15]
  assign io_to_mem_Wmask = lsu0_io_to_mem_Wmask; // @[EXU.scala 198:15]
  assign io_to_mem_MemWrite = lsu0_io_to_mem_MemWrite; // @[EXU.scala 198:15]
  assign io_redirect_target = jalrBruRes_valid ? jalrBruRes_targetPc : _bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  assign io_redirect_valid = io_from_isu_valid & bruRes_valid & PredictError; // @[EXU.scala 256:51]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 185:21]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 186:21]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 187:25]
  assign lsu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 193:26]
  assign lsu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 194:26]
  assign lsu0_io_from_mem_data = io_from_mem_data; // @[EXU.scala 197:22]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[EXU.scala 200:18]
  assign lsu0_io_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 200:18]
  assign lsu0_io_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[EXU.scala 201:18]
  assign csr0_clock = clock;
  assign csr0_reset = reset;
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 3'h3; // @[EXU.scala 209:16]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[CSR.scala 172:15]
  assign csr0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[CSR.scala 173:15]
  assign csr0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[CSR.scala 174:19]
  assign csr0_io_cfIn_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 207:15]
  assign csr0_io_cfIn_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 207:15]
endmodule
