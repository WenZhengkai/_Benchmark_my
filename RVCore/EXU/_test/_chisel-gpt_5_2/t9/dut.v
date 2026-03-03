module ALU(
  input         io_in_valid,
  input  [63:0] io_in_bits_srca,
  input  [63:0] io_in_bits_srcb,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  assign io_out_valid = io_in_valid; // @[dut.scala 146:16]
  assign io_out_bits = io_in_bits_srca + io_in_bits_srcb; // @[dut.scala 147:34]
endmodule
module LSU(
  input         io_ctrl_MemWrite,
  input  [63:0] io_data_fuSrc1,
  input  [63:0] io_data_fuSrc2,
  input         io_from_mem_valid,
  input  [63:0] io_from_mem_rdata,
  output [63:0] io_to_mem_addr,
  output [63:0] io_to_mem_wdata,
  output        io_to_mem_isWr,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  assign io_to_mem_addr = io_data_fuSrc1; // @[dut.scala 161:19]
  assign io_to_mem_wdata = io_data_fuSrc2; // @[dut.scala 162:19]
  assign io_to_mem_isWr = io_ctrl_MemWrite; // @[dut.scala 164:19]
  assign io_out_valid = io_from_mem_valid; // @[dut.scala 168:16]
  assign io_out_bits = io_from_mem_rdata; // @[dut.scala 167:16]
endmodule
module CSR(
  input         io_in_valid,
  input  [63:0] io_in_bits_srca,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  assign io_out_valid = io_in_valid; // @[dut.scala 177:16]
  assign io_out_bits = io_in_bits_srca; // @[dut.scala 178:15]
endmodule
module dut(
  input         clock,
  input         reset,
  output        io_from_isu_ready,
  input         io_from_isu_valid,
  input  [31:0] io_from_isu_bits_cf_inst,
  input  [63:0] io_from_isu_bits_cf_pc,
  input  [63:0] io_from_isu_bits_cf_next_pc,
  input         io_from_isu_bits_cf_isBranch,
  input         io_from_isu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [1:0]  io_from_isu_bits_ctrl_fuSrc1Type,
  input  [1:0]  io_from_isu_bits_ctrl_fuSrc2Type,
  input  [1:0]  io_from_isu_bits_ctrl_fuType,
  input         io_from_isu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_isu_bits_ctrl_rs1,
  input  [4:0]  io_from_isu_bits_ctrl_rs2,
  input         io_from_isu_bits_ctrl_rfWen,
  input  [4:0]  io_from_isu_bits_ctrl_rd,
  input  [63:0] io_from_isu_bits_data_fuSrc1,
  input  [63:0] io_from_isu_bits_data_fuSrc2,
  input  [63:0] io_from_isu_bits_data_imm,
  input         io_from_isu_bits_data_Alu0Res_ready,
  input         io_from_isu_bits_data_Alu0Res_valid,
  input  [63:0] io_from_isu_bits_data_Alu0Res_bits,
  input  [63:0] io_from_isu_bits_data_data_from_mem,
  input  [63:0] io_from_isu_bits_data_csrRdata,
  input  [63:0] io_from_isu_bits_data_rfSrc1,
  input  [63:0] io_from_isu_bits_data_rfSrc2,
  input         io_to_wbu_ready,
  output        io_to_wbu_valid,
  output [31:0] io_to_wbu_bits_cf_inst,
  output [63:0] io_to_wbu_bits_cf_pc,
  output [63:0] io_to_wbu_bits_cf_next_pc,
  output        io_to_wbu_bits_cf_isBranch,
  output        io_to_wbu_bits_ctrl_MemWrite,
  output [1:0]  io_to_wbu_bits_ctrl_ResSrc,
  output [1:0]  io_to_wbu_bits_ctrl_fuSrc1Type,
  output [1:0]  io_to_wbu_bits_ctrl_fuSrc2Type,
  output [1:0]  io_to_wbu_bits_ctrl_fuType,
  output        io_to_wbu_bits_ctrl_fuOpType,
  output [4:0]  io_to_wbu_bits_ctrl_rs1,
  output [4:0]  io_to_wbu_bits_ctrl_rs2,
  output        io_to_wbu_bits_ctrl_rfWen,
  output [4:0]  io_to_wbu_bits_ctrl_rd,
  output [63:0] io_to_wbu_bits_data_fuSrc1,
  output [63:0] io_to_wbu_bits_data_fuSrc2,
  output [63:0] io_to_wbu_bits_data_imm,
  output        io_to_wbu_bits_data_Alu0Res_ready,
  output        io_to_wbu_bits_data_Alu0Res_valid,
  output [63:0] io_to_wbu_bits_data_Alu0Res_bits,
  output [63:0] io_to_wbu_bits_data_data_from_mem,
  output [63:0] io_to_wbu_bits_data_csrRdata,
  output [63:0] io_to_wbu_bits_data_rfSrc1,
  output [63:0] io_to_wbu_bits_data_rfSrc2,
  output        io_to_mem_valid,
  output [63:0] io_to_mem_addr,
  output [63:0] io_to_mem_wdata,
  output [7:0]  io_to_mem_wmask,
  output        io_to_mem_isWr,
  input         io_from_mem_valid,
  input  [63:0] io_from_mem_rdata,
  output [63:0] io_redirect_target,
  output        io_redirect_valid
);
  wire  alu0_io_in_valid; // @[dut.scala 224:20]
  wire [63:0] alu0_io_in_bits_srca; // @[dut.scala 224:20]
  wire [63:0] alu0_io_in_bits_srcb; // @[dut.scala 224:20]
  wire  alu0_io_out_valid; // @[dut.scala 224:20]
  wire [63:0] alu0_io_out_bits; // @[dut.scala 224:20]
  wire  lsu0_io_ctrl_MemWrite; // @[dut.scala 225:20]
  wire [63:0] lsu0_io_data_fuSrc1; // @[dut.scala 225:20]
  wire [63:0] lsu0_io_data_fuSrc2; // @[dut.scala 225:20]
  wire  lsu0_io_from_mem_valid; // @[dut.scala 225:20]
  wire [63:0] lsu0_io_from_mem_rdata; // @[dut.scala 225:20]
  wire [63:0] lsu0_io_to_mem_addr; // @[dut.scala 225:20]
  wire [63:0] lsu0_io_to_mem_wdata; // @[dut.scala 225:20]
  wire  lsu0_io_to_mem_isWr; // @[dut.scala 225:20]
  wire  lsu0_io_out_valid; // @[dut.scala 225:20]
  wire [63:0] lsu0_io_out_bits; // @[dut.scala 225:20]
  wire  csr0_io_in_valid; // @[dut.scala 226:20]
  wire [63:0] csr0_io_in_bits_srca; // @[dut.scala 226:20]
  wire  csr0_io_out_valid; // @[dut.scala 226:20]
  wire [63:0] csr0_io_out_bits; // @[dut.scala 226:20]
  wire  isLsu = io_from_isu_bits_ctrl_fuType == 2'h1; // @[dut.scala 245:44]
  wire [63:0] bruRes_bruRes_targetPc = alu0_io_out_bits; // @[dut.scala 187:22 191:21]
  wire  mispredict = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_next_pc != bruRes_bruRes_targetPc; // @[dut.scala 268:36]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[dut.scala 283:45]
  wire  _io_from_isu_ready_T = ~_T; // @[dut.scala 124:30]
  ALU alu0 ( // @[dut.scala 224:20]
    .io_in_valid(alu0_io_in_valid),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_out_valid(alu0_io_out_valid),
    .io_out_bits(alu0_io_out_bits)
  );
  LSU lsu0 ( // @[dut.scala 225:20]
    .io_ctrl_MemWrite(lsu0_io_ctrl_MemWrite),
    .io_data_fuSrc1(lsu0_io_data_fuSrc1),
    .io_data_fuSrc2(lsu0_io_data_fuSrc2),
    .io_from_mem_valid(lsu0_io_from_mem_valid),
    .io_from_mem_rdata(lsu0_io_from_mem_rdata),
    .io_to_mem_addr(lsu0_io_to_mem_addr),
    .io_to_mem_wdata(lsu0_io_to_mem_wdata),
    .io_to_mem_isWr(lsu0_io_to_mem_isWr),
    .io_out_valid(lsu0_io_out_valid),
    .io_out_bits(lsu0_io_out_bits)
  );
  CSR csr0 ( // @[dut.scala 226:20]
    .io_in_valid(csr0_io_in_valid),
    .io_in_bits_srca(csr0_io_in_bits_srca),
    .io_out_valid(csr0_io_out_valid),
    .io_out_bits(csr0_io_out_bits)
  );
  assign io_from_isu_ready = io_to_wbu_ready & ~_T; // @[dut.scala 124:27]
  assign io_to_wbu_valid = io_from_isu_valid & _io_from_isu_ready_T; // @[dut.scala 127:51]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[dut.scala 211:23]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[dut.scala 211:23]
  assign io_to_wbu_bits_cf_next_pc = mispredict ? bruRes_bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[dut.scala 274:35]
  assign io_to_wbu_bits_cf_isBranch = io_from_isu_bits_cf_isBranch; // @[dut.scala 211:23]
  assign io_to_wbu_bits_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_fuSrc1Type = io_from_isu_bits_ctrl_fuSrc1Type; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_fuSrc2Type = io_from_isu_bits_ctrl_fuSrc2Type; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_fuType = io_from_isu_bits_ctrl_fuType; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_rs1 = io_from_isu_bits_ctrl_rs1; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_rs2 = io_from_isu_bits_ctrl_rs2; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[dut.scala 212:23]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[dut.scala 212:23]
  assign io_to_wbu_bits_data_fuSrc1 = io_from_isu_bits_data_fuSrc1; // @[dut.scala 213:23]
  assign io_to_wbu_bits_data_fuSrc2 = io_from_isu_bits_data_fuSrc2; // @[dut.scala 213:23]
  assign io_to_wbu_bits_data_imm = io_from_isu_bits_data_imm; // @[dut.scala 213:23]
  assign io_to_wbu_bits_data_Alu0Res_ready = io_from_isu_bits_data_Alu0Res_ready; // @[dut.scala 213:23]
  assign io_to_wbu_bits_data_Alu0Res_valid = alu0_io_out_valid; // @[dut.scala 236:37]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[dut.scala 235:37]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_valid & isLsu ? lsu0_io_out_bits : 64'h0; // @[dut.scala 246:43]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_valid ? csr0_io_out_bits : 64'h0; // @[dut.scala 258:38]
  assign io_to_wbu_bits_data_rfSrc1 = io_from_isu_bits_data_rfSrc1; // @[dut.scala 213:23]
  assign io_to_wbu_bits_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[dut.scala 213:23]
  assign io_to_mem_valid = 1'h0; // @[dut.scala 249:13]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[dut.scala 249:13]
  assign io_to_mem_wdata = lsu0_io_to_mem_wdata; // @[dut.scala 249:13]
  assign io_to_mem_wmask = 8'hff; // @[dut.scala 249:13]
  assign io_to_mem_isWr = lsu0_io_to_mem_isWr; // @[dut.scala 249:13]
  assign io_redirect_target = alu0_io_out_bits; // @[dut.scala 187:22 191:21]
  assign io_redirect_valid = io_from_isu_valid & mispredict; // @[dut.scala 270:43]
  assign alu0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 2'h0; // @[dut.scala 232:49]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 229:28]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 230:28]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 240:20]
  assign lsu0_io_data_fuSrc1 = io_from_isu_bits_data_fuSrc1; // @[dut.scala 241:20]
  assign lsu0_io_data_fuSrc2 = io_from_isu_bits_data_fuSrc2; // @[dut.scala 241:20]
  assign lsu0_io_from_mem_valid = io_from_mem_valid; // @[dut.scala 239:20]
  assign lsu0_io_from_mem_rdata = io_from_mem_rdata; // @[dut.scala 239:20]
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 2'h2; // @[dut.scala 255:49]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 252:28]
endmodule
