module ALU(
  output        io_in_ready,
  input         io_in_valid,
  input  [63:0] io_in_bits_srca,
  input  [63:0] io_in_bits_srcb,
  input  [4:0]  io_in_bits_fuOpType,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  wire [5:0] shamt = io_in_bits_srcb[5:0]; // @[dut.scala 133:16]
  wire [63:0] _res_T_1 = io_in_bits_srca + io_in_bits_srcb; // @[dut.scala 137:34]
  wire [63:0] _res_T_3 = io_in_bits_srca - io_in_bits_srcb; // @[dut.scala 138:34]
  wire [63:0] _res_T_4 = io_in_bits_srca & io_in_bits_srcb; // @[dut.scala 139:34]
  wire [63:0] _res_T_5 = io_in_bits_srca | io_in_bits_srcb; // @[dut.scala 140:34]
  wire [63:0] _res_T_6 = io_in_bits_srca ^ io_in_bits_srcb; // @[dut.scala 141:34]
  wire [126:0] _GEN_10 = {{63'd0}, io_in_bits_srca}; // @[dut.scala 142:34]
  wire [126:0] _res_T_7 = _GEN_10 << shamt; // @[dut.scala 142:34]
  wire [63:0] _res_T_8 = io_in_bits_srca >> shamt; // @[dut.scala 143:34]
  wire [63:0] _res_T_9 = io_in_bits_srca; // @[dut.scala 144:35]
  wire [63:0] _res_T_11 = $signed(io_in_bits_srca) >>> shamt; // @[dut.scala 144:52]
  wire [63:0] _res_T_13 = io_in_bits_srcb; // @[dut.scala 145:46]
  wire [63:0] _GEN_0 = 5'h9 == io_in_bits_fuOpType ? {{63'd0}, io_in_bits_srca < io_in_bits_srcb} : 64'h0; // @[dut.scala 135:24 136:31 146:29]
  wire [63:0] _GEN_1 = 5'h8 == io_in_bits_fuOpType ? {{63'd0}, $signed(_res_T_9) < $signed(_res_T_13)} : _GEN_0; // @[dut.scala 136:31 145:29]
  wire [63:0] _GEN_2 = 5'h7 == io_in_bits_fuOpType ? _res_T_11 : _GEN_1; // @[dut.scala 136:31 144:29]
  wire [63:0] _GEN_3 = 5'h6 == io_in_bits_fuOpType ? _res_T_8 : _GEN_2; // @[dut.scala 136:31 143:29]
  wire [126:0] _GEN_4 = 5'h5 == io_in_bits_fuOpType ? _res_T_7 : {{63'd0}, _GEN_3}; // @[dut.scala 136:31 142:29]
  wire [126:0] _GEN_5 = 5'h4 == io_in_bits_fuOpType ? {{63'd0}, _res_T_6} : _GEN_4; // @[dut.scala 136:31 141:29]
  wire [126:0] _GEN_6 = 5'h3 == io_in_bits_fuOpType ? {{63'd0}, _res_T_5} : _GEN_5; // @[dut.scala 136:31 140:29]
  wire [126:0] _GEN_7 = 5'h2 == io_in_bits_fuOpType ? {{63'd0}, _res_T_4} : _GEN_6; // @[dut.scala 136:31 139:29]
  wire [126:0] _GEN_8 = 5'h1 == io_in_bits_fuOpType ? {{63'd0}, _res_T_3} : _GEN_7; // @[dut.scala 136:31 138:29]
  wire [126:0] _GEN_9 = 5'h0 == io_in_bits_fuOpType ? {{63'd0}, _res_T_1} : _GEN_8; // @[dut.scala 136:31 137:29]
  assign io_in_ready = io_out_ready; // @[dut.scala 128:15]
  assign io_out_valid = io_in_valid; // @[dut.scala 129:16]
  assign io_out_bits = _GEN_9[63:0]; // @[dut.scala 135:24]
endmodule
module LSU(
  output        io_in_ready,
  input         io_in_valid,
  input         io_in_bits_ctrl_MemWrite,
  input  [1:0]  io_in_bits_ctrl_fuType,
  input  [63:0] io_in_bits_data_fuSrc1,
  input  [63:0] io_in_bits_data_fuSrc2,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits,
  output        io_to_mem_valid,
  output [63:0] io_to_mem_addr,
  output [63:0] io_to_mem_wdata,
  output        io_to_mem_isWr,
  input  [63:0] io_from_mem_rdata
);
  wire  isLsu = io_in_bits_ctrl_fuType == 2'h1; // @[dut.scala 164:38]
  assign io_in_ready = io_out_ready; // @[dut.scala 173:15]
  assign io_out_valid = io_in_valid & isLsu; // @[dut.scala 175:31]
  assign io_out_bits = io_in_bits_ctrl_MemWrite ? 64'h0 : io_from_mem_rdata; // @[dut.scala 176:22]
  assign io_to_mem_valid = io_in_valid & isLsu; // @[dut.scala 167:34]
  assign io_to_mem_addr = io_in_bits_data_fuSrc1; // @[dut.scala 168:19]
  assign io_to_mem_wdata = io_in_bits_data_fuSrc2; // @[dut.scala 169:19]
  assign io_to_mem_isWr = io_in_bits_ctrl_MemWrite; // @[dut.scala 171:19]
endmodule
module CSR(
  output       io_in_ready,
  input        io_in_valid,
  input  [1:0] io_in_bits_ctrl_fuType,
  input        io_out_ready,
  output       io_out_valid
);
  wire  isCsr = io_in_bits_ctrl_fuType == 2'h2; // @[dut.scala 185:38]
  assign io_in_ready = io_out_ready; // @[dut.scala 186:15]
  assign io_out_valid = io_in_valid & isCsr; // @[dut.scala 187:31]
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
  input  [2:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [1:0]  io_from_isu_bits_ctrl_fuSrc1Type,
  input  [1:0]  io_from_isu_bits_ctrl_fuSrc2Type,
  input  [1:0]  io_from_isu_bits_ctrl_fuType,
  input  [4:0]  io_from_isu_bits_ctrl_fuOpType,
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
  output [2:0]  io_to_wbu_bits_ctrl_ResSrc,
  output [1:0]  io_to_wbu_bits_ctrl_fuSrc1Type,
  output [1:0]  io_to_wbu_bits_ctrl_fuSrc2Type,
  output [1:0]  io_to_wbu_bits_ctrl_fuType,
  output [4:0]  io_to_wbu_bits_ctrl_fuOpType,
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
  input  [63:0] io_from_mem_rdata,
  input         io_from_mem_ready,
  output [63:0] io_redirect_target,
  output        io_redirect_valid
);
  wire  alu0_io_in_ready; // @[dut.scala 274:20]
  wire  alu0_io_in_valid; // @[dut.scala 274:20]
  wire [63:0] alu0_io_in_bits_srca; // @[dut.scala 274:20]
  wire [63:0] alu0_io_in_bits_srcb; // @[dut.scala 274:20]
  wire [4:0] alu0_io_in_bits_fuOpType; // @[dut.scala 274:20]
  wire  alu0_io_out_ready; // @[dut.scala 274:20]
  wire  alu0_io_out_valid; // @[dut.scala 274:20]
  wire [63:0] alu0_io_out_bits; // @[dut.scala 274:20]
  wire  lsu0_io_in_ready; // @[dut.scala 275:20]
  wire  lsu0_io_in_valid; // @[dut.scala 275:20]
  wire  lsu0_io_in_bits_ctrl_MemWrite; // @[dut.scala 275:20]
  wire [1:0] lsu0_io_in_bits_ctrl_fuType; // @[dut.scala 275:20]
  wire [63:0] lsu0_io_in_bits_data_fuSrc1; // @[dut.scala 275:20]
  wire [63:0] lsu0_io_in_bits_data_fuSrc2; // @[dut.scala 275:20]
  wire  lsu0_io_out_ready; // @[dut.scala 275:20]
  wire  lsu0_io_out_valid; // @[dut.scala 275:20]
  wire [63:0] lsu0_io_out_bits; // @[dut.scala 275:20]
  wire  lsu0_io_to_mem_valid; // @[dut.scala 275:20]
  wire [63:0] lsu0_io_to_mem_addr; // @[dut.scala 275:20]
  wire [63:0] lsu0_io_to_mem_wdata; // @[dut.scala 275:20]
  wire  lsu0_io_to_mem_isWr; // @[dut.scala 275:20]
  wire [63:0] lsu0_io_from_mem_rdata; // @[dut.scala 275:20]
  wire  csr0_io_in_ready; // @[dut.scala 276:20]
  wire  csr0_io_in_valid; // @[dut.scala 276:20]
  wire [1:0] csr0_io_in_bits_ctrl_fuType; // @[dut.scala 276:20]
  wire  csr0_io_out_ready; // @[dut.scala 276:20]
  wire  csr0_io_out_valid; // @[dut.scala 276:20]
  wire  isAlu = io_from_isu_bits_ctrl_fuType == 2'h0; // @[dut.scala 291:44]
  wire  isLsu = io_from_isu_bits_ctrl_fuType == 2'h1; // @[dut.scala 292:44]
  wire  isCsr = io_from_isu_bits_ctrl_fuType == 2'h2; // @[dut.scala 293:44]
  wire  _GEN_1 = 5'h10 == io_from_isu_bits_ctrl_fuOpType | 5'h11 == io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 225:16 232:33]
  wire  _GEN_2 = 5'hf == io_from_isu_bits_ctrl_fuOpType ? io_from_isu_bits_data_fuSrc1 >= io_from_isu_bits_data_fuSrc2
     : _GEN_1; // @[dut.scala 225:16 231:33]
  wire  _GEN_3 = 5'he == io_from_isu_bits_ctrl_fuOpType ? io_from_isu_bits_data_fuSrc1 < io_from_isu_bits_data_fuSrc2 :
    _GEN_2; // @[dut.scala 225:16 230:33]
  wire  _GEN_4 = 5'hd == io_from_isu_bits_ctrl_fuOpType ? $signed(io_from_isu_bits_data_fuSrc1) >= $signed(
    io_from_isu_bits_data_fuSrc2) : _GEN_3; // @[dut.scala 225:16 229:33]
  wire  _GEN_5 = 5'hc == io_from_isu_bits_ctrl_fuOpType ? $signed(io_from_isu_bits_data_fuSrc1) < $signed(
    io_from_isu_bits_data_fuSrc2) : _GEN_4; // @[dut.scala 225:16 228:33]
  wire  _GEN_6 = 5'hb == io_from_isu_bits_ctrl_fuOpType ? io_from_isu_bits_data_fuSrc1 != io_from_isu_bits_data_fuSrc2
     : _GEN_5; // @[dut.scala 225:16 227:33]
  wire  bruRes_taken = 5'ha == io_from_isu_bits_ctrl_fuOpType ? io_from_isu_bits_data_fuSrc1 ==
    io_from_isu_bits_data_fuSrc2 : _GEN_6; // @[dut.scala 225:16 226:33]
  wire  bruRes_isJal = io_from_isu_bits_ctrl_fuOpType == 5'h10; // @[dut.scala 236:21]
  wire  bruRes_isJalr = io_from_isu_bits_ctrl_fuOpType == 5'h11; // @[dut.scala 237:21]
  wire [63:0] _bruRes_target_T_1 = io_from_isu_bits_data_fuSrc1 + io_from_isu_bits_data_imm; // @[dut.scala 241:33]
  wire [63:0] _bruRes_target_T_3 = _bruRes_target_T_1 & 64'hfffffffffffffffe; // @[dut.scala 241:40]
  wire [63:0] _bruRes_target_T_5 = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[dut.scala 241:68]
  wire [63:0] bruRes_target = bruRes_isJalr ? _bruRes_target_T_3 : _bruRes_target_T_5; // @[dut.scala 241:18]
  wire [63:0] _bruRes_r_targetPc_T_1 = io_from_isu_bits_cf_pc + 64'h4; // @[dut.scala 249:24]
  wire  bruRes_r_valid = io_from_isu_bits_cf_isBranch & ~bruRes_taken | (io_from_isu_bits_cf_isBranch | bruRes_isJal |
    bruRes_isJalr) & bruRes_taken; // @[dut.scala 243:13 247:26 248:15]
  wire [63:0] bruRes_r_targetPc = io_from_isu_bits_cf_isBranch & ~bruRes_taken ? _bruRes_r_targetPc_T_1 : bruRes_target; // @[dut.scala 244:16 247:26 249:18]
  wire  misPred = bruRes_r_valid & io_from_isu_bits_cf_next_pc != bruRes_r_targetPc; // @[dut.scala 324:31]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[dut.scala 340:45]
  wire  _io_to_wbu_valid_T_2 = ~_T; // @[dut.scala 202:54]
  wire  fuOutValid = isAlu & alu0_io_out_valid | isLsu & lsu0_io_out_valid | isCsr & csr0_io_out_valid; // @[Mux.scala 27:73]
  wire  fuInReady = isAlu & alu0_io_in_ready | isLsu & lsu0_io_in_ready | isCsr & csr0_io_in_ready; // @[Mux.scala 27:73]
  ALU alu0 ( // @[dut.scala 274:20]
    .io_in_ready(alu0_io_in_ready),
    .io_in_valid(alu0_io_in_valid),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_out_ready(alu0_io_out_ready),
    .io_out_valid(alu0_io_out_valid),
    .io_out_bits(alu0_io_out_bits)
  );
  LSU lsu0 ( // @[dut.scala 275:20]
    .io_in_ready(lsu0_io_in_ready),
    .io_in_valid(lsu0_io_in_valid),
    .io_in_bits_ctrl_MemWrite(lsu0_io_in_bits_ctrl_MemWrite),
    .io_in_bits_ctrl_fuType(lsu0_io_in_bits_ctrl_fuType),
    .io_in_bits_data_fuSrc1(lsu0_io_in_bits_data_fuSrc1),
    .io_in_bits_data_fuSrc2(lsu0_io_in_bits_data_fuSrc2),
    .io_out_ready(lsu0_io_out_ready),
    .io_out_valid(lsu0_io_out_valid),
    .io_out_bits(lsu0_io_out_bits),
    .io_to_mem_valid(lsu0_io_to_mem_valid),
    .io_to_mem_addr(lsu0_io_to_mem_addr),
    .io_to_mem_wdata(lsu0_io_to_mem_wdata),
    .io_to_mem_isWr(lsu0_io_to_mem_isWr),
    .io_from_mem_rdata(lsu0_io_from_mem_rdata)
  );
  CSR csr0 ( // @[dut.scala 276:20]
    .io_in_ready(csr0_io_in_ready),
    .io_in_valid(csr0_io_in_valid),
    .io_in_bits_ctrl_fuType(csr0_io_in_bits_ctrl_fuType),
    .io_out_ready(csr0_io_out_ready),
    .io_out_valid(csr0_io_out_valid)
  );
  assign io_from_isu_ready = io_to_wbu_ready & fuInReady & _io_to_wbu_valid_T_2; // @[dut.scala 361:53]
  assign io_to_wbu_valid = io_from_isu_valid & fuOutValid & _io_to_wbu_valid_T_2; // @[dut.scala 352:54]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[dut.scala 269:23]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[dut.scala 269:23]
  assign io_to_wbu_bits_cf_next_pc = misPred ? bruRes_r_targetPc : io_from_isu_bits_cf_next_pc; // @[dut.scala 330:17 269:23 331:31]
  assign io_to_wbu_bits_cf_isBranch = io_from_isu_bits_cf_isBranch; // @[dut.scala 269:23]
  assign io_to_wbu_bits_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_fuSrc1Type = io_from_isu_bits_ctrl_fuSrc1Type; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_fuSrc2Type = io_from_isu_bits_ctrl_fuSrc2Type; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_fuType = io_from_isu_bits_ctrl_fuType; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_rs1 = io_from_isu_bits_ctrl_rs1; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_rs2 = io_from_isu_bits_ctrl_rs2; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[dut.scala 270:23]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[dut.scala 270:23]
  assign io_to_wbu_bits_data_fuSrc1 = io_from_isu_bits_data_fuSrc1; // @[dut.scala 271:23]
  assign io_to_wbu_bits_data_fuSrc2 = io_from_isu_bits_data_fuSrc2; // @[dut.scala 271:23]
  assign io_to_wbu_bits_data_imm = io_from_isu_bits_data_imm; // @[dut.scala 271:23]
  assign io_to_wbu_bits_data_Alu0Res_ready = io_to_wbu_ready & io_to_wbu_valid; // @[dut.scala 310:56]
  assign io_to_wbu_bits_data_Alu0Res_valid = alu0_io_out_valid; // @[dut.scala 308:37]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[dut.scala 307:37]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[dut.scala 312:37]
  assign io_to_wbu_bits_data_csrRdata = 64'h0; // @[dut.scala 313:37]
  assign io_to_wbu_bits_data_rfSrc1 = io_from_isu_bits_data_rfSrc1; // @[dut.scala 271:23]
  assign io_to_wbu_bits_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[dut.scala 271:23]
  assign io_to_mem_valid = lsu0_io_to_mem_valid; // @[dut.scala 316:13]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[dut.scala 316:13]
  assign io_to_mem_wdata = lsu0_io_to_mem_wdata; // @[dut.scala 316:13]
  assign io_to_mem_wmask = 8'hff; // @[dut.scala 316:13]
  assign io_to_mem_isWr = lsu0_io_to_mem_isWr; // @[dut.scala 316:13]
  assign io_redirect_target = io_from_isu_bits_cf_isBranch & ~bruRes_taken ? _bruRes_r_targetPc_T_1 : bruRes_target; // @[dut.scala 244:16 247:26 249:18]
  assign io_redirect_valid = io_from_isu_valid & bruRes_r_valid & misPred; // @[dut.scala 326:59]
  assign alu0_io_in_valid = io_from_isu_valid & isAlu; // @[dut.scala 296:41]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 279:28]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 280:28]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 281:28]
  assign alu0_io_out_ready = io_to_wbu_ready & io_to_wbu_valid; // @[dut.scala 309:55]
  assign lsu0_io_in_valid = io_from_isu_valid & isLsu; // @[dut.scala 297:41]
  assign lsu0_io_in_bits_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 285:21]
  assign lsu0_io_in_bits_ctrl_fuType = io_from_isu_bits_ctrl_fuType; // @[dut.scala 285:21]
  assign lsu0_io_in_bits_data_fuSrc1 = io_from_isu_bits_data_fuSrc1; // @[dut.scala 285:21]
  assign lsu0_io_in_bits_data_fuSrc2 = io_from_isu_bits_data_fuSrc2; // @[dut.scala 285:21]
  assign lsu0_io_out_ready = io_to_wbu_ready; // @[dut.scala 302:21]
  assign lsu0_io_from_mem_rdata = io_from_mem_rdata; // @[dut.scala 284:20]
  assign csr0_io_in_valid = io_from_isu_valid & isCsr; // @[dut.scala 298:41]
  assign csr0_io_in_bits_ctrl_fuType = io_from_isu_bits_ctrl_fuType; // @[dut.scala 288:19]
  assign csr0_io_out_ready = io_to_wbu_ready; // @[dut.scala 303:21]
endmodule
