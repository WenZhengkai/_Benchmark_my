circuit dut :
  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : { srca : UInt<64>, srcb : UInt<64>, fuOpType : UInt<1>}}, out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}}

    io.in.ready <= io.out.ready @[dut.scala 145:15]
    io.out.valid <= io.in.valid @[dut.scala 146:16]
    node _io_out_bits_T = add(io.in.bits.srca, io.in.bits.srcb) @[dut.scala 147:34]
    node _io_out_bits_T_1 = tail(_io_out_bits_T, 1) @[dut.scala 147:34]
    io.out.bits <= _io_out_bits_T_1 @[dut.scala 147:15]

  module LSU :
    input clock : Clock
    input reset : Reset
    output io : { flip ctrl : { MemWrite : UInt<1>, ResSrc : UInt<2>, fuSrc1Type : UInt<2>, fuSrc2Type : UInt<2>, fuType : UInt<2>, fuOpType : UInt<1>, rs1 : UInt<5>, rs2 : UInt<5>, rfWen : UInt<1>, rd : UInt<5>}, flip data : { fuSrc1 : UInt<64>, fuSrc2 : UInt<64>, imm : UInt<64>, Alu0Res : { ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, data_from_mem : UInt<64>, csrRdata : UInt<64>, rfSrc1 : UInt<64>, rfSrc2 : UInt<64>}, from_mem : { flip valid : UInt<1>, flip rdata : UInt<64>}, to_mem : { valid : UInt<1>, addr : UInt<64>, wdata : UInt<64>, wmask : UInt<8>, isWr : UInt<1>}, out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}}

    io.to_mem.valid <= UInt<1>("h0") @[dut.scala 160:19]
    io.to_mem.addr <= io.data.fuSrc1 @[dut.scala 161:19]
    io.to_mem.wdata <= io.data.fuSrc2 @[dut.scala 162:19]
    io.to_mem.wmask <= UInt<8>("hff") @[dut.scala 163:19]
    io.to_mem.isWr <= io.ctrl.MemWrite @[dut.scala 164:19]
    io.out.bits <= io.from_mem.rdata @[dut.scala 167:16]
    io.out.valid <= io.from_mem.valid @[dut.scala 168:16]

  module CSR :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : { srca : UInt<64>, srcb : UInt<64>, fuOpType : UInt<1>}}, out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}}

    io.in.ready <= io.out.ready @[dut.scala 176:15]
    io.out.valid <= io.in.valid @[dut.scala 177:16]
    io.out.bits <= io.in.bits.srca @[dut.scala 178:15]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip from_isu : { flip ready : UInt<1>, valid : UInt<1>, bits : { cf : { inst : UInt<32>, pc : UInt<64>, next_pc : UInt<64>, isBranch : UInt<1>}, ctrl : { MemWrite : UInt<1>, ResSrc : UInt<2>, fuSrc1Type : UInt<2>, fuSrc2Type : UInt<2>, fuType : UInt<2>, fuOpType : UInt<1>, rs1 : UInt<5>, rs2 : UInt<5>, rfWen : UInt<1>, rd : UInt<5>}, data : { fuSrc1 : UInt<64>, fuSrc2 : UInt<64>, imm : UInt<64>, Alu0Res : { ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, data_from_mem : UInt<64>, csrRdata : UInt<64>, rfSrc1 : UInt<64>, rfSrc2 : UInt<64>}}}, to_wbu : { flip ready : UInt<1>, valid : UInt<1>, bits : { cf : { inst : UInt<32>, pc : UInt<64>, next_pc : UInt<64>, isBranch : UInt<1>}, ctrl : { MemWrite : UInt<1>, ResSrc : UInt<2>, fuSrc1Type : UInt<2>, fuSrc2Type : UInt<2>, fuType : UInt<2>, fuOpType : UInt<1>, rs1 : UInt<5>, rs2 : UInt<5>, rfWen : UInt<1>, rd : UInt<5>}, data : { fuSrc1 : UInt<64>, fuSrc2 : UInt<64>, imm : UInt<64>, Alu0Res : { ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, data_from_mem : UInt<64>, csrRdata : UInt<64>, rfSrc1 : UInt<64>, rfSrc2 : UInt<64>}}}, to_mem : { valid : UInt<1>, addr : UInt<64>, wdata : UInt<64>, wmask : UInt<8>, isWr : UInt<1>}, from_mem : { flip valid : UInt<1>, flip rdata : UInt<64>}, redirect : { target : UInt<64>, valid : UInt<1>}}

    io.to_wbu.bits.cf <= io.from_isu.bits.cf @[dut.scala 211:23]
    io.to_wbu.bits.ctrl <= io.from_isu.bits.ctrl @[dut.scala 212:23]
    io.to_wbu.bits.data <= io.from_isu.bits.data @[dut.scala 213:23]
    io.to_wbu.bits.data.Alu0Res.valid <= UInt<1>("h0") @[dut.scala 216:37]
    io.to_wbu.bits.data.Alu0Res.bits <= UInt<1>("h0") @[dut.scala 217:37]
    io.to_wbu.bits.data.data_from_mem <= UInt<1>("h0") @[dut.scala 218:37]
    io.to_wbu.bits.data.csrRdata <= UInt<1>("h0") @[dut.scala 219:37]
    inst alu0 of ALU @[dut.scala 224:20]
    alu0.clock <= clock
    alu0.reset <= reset
    inst lsu0 of LSU @[dut.scala 225:20]
    lsu0.clock <= clock
    lsu0.reset <= reset
    inst csr0 of CSR @[dut.scala 226:20]
    csr0.clock <= clock
    csr0.reset <= reset
    alu0.io.in.bits.srca <= io.from_isu.bits.data.fuSrc1 @[dut.scala 229:28]
    alu0.io.in.bits.srcb <= io.from_isu.bits.data.fuSrc2 @[dut.scala 230:28]
    alu0.io.in.bits.fuOpType <= io.from_isu.bits.ctrl.fuOpType @[dut.scala 231:28]
    node _alu0_io_in_valid_T = eq(io.from_isu.bits.ctrl.fuType, UInt<1>("h0")) @[dut.scala 232:82]
    node _alu0_io_in_valid_T_1 = and(io.from_isu.valid, _alu0_io_in_valid_T) @[dut.scala 232:49]
    alu0.io.in.valid <= _alu0_io_in_valid_T_1 @[dut.scala 232:28]
    alu0.io.out.ready <= io.to_wbu.ready @[dut.scala 233:28]
    io.to_wbu.bits.data.Alu0Res.bits <= alu0.io.out.bits @[dut.scala 235:37]
    io.to_wbu.bits.data.Alu0Res.valid <= alu0.io.out.valid @[dut.scala 236:37]
    lsu0.io.from_mem.rdata <= io.from_mem.rdata @[dut.scala 239:20]
    lsu0.io.from_mem.valid <= io.from_mem.valid @[dut.scala 239:20]
    lsu0.io.ctrl.rd <= io.from_isu.bits.ctrl.rd @[dut.scala 240:20]
    lsu0.io.ctrl.rfWen <= io.from_isu.bits.ctrl.rfWen @[dut.scala 240:20]
    lsu0.io.ctrl.rs2 <= io.from_isu.bits.ctrl.rs2 @[dut.scala 240:20]
    lsu0.io.ctrl.rs1 <= io.from_isu.bits.ctrl.rs1 @[dut.scala 240:20]
    lsu0.io.ctrl.fuOpType <= io.from_isu.bits.ctrl.fuOpType @[dut.scala 240:20]
    lsu0.io.ctrl.fuType <= io.from_isu.bits.ctrl.fuType @[dut.scala 240:20]
    lsu0.io.ctrl.fuSrc2Type <= io.from_isu.bits.ctrl.fuSrc2Type @[dut.scala 240:20]
    lsu0.io.ctrl.fuSrc1Type <= io.from_isu.bits.ctrl.fuSrc1Type @[dut.scala 240:20]
    lsu0.io.ctrl.ResSrc <= io.from_isu.bits.ctrl.ResSrc @[dut.scala 240:20]
    lsu0.io.ctrl.MemWrite <= io.from_isu.bits.ctrl.MemWrite @[dut.scala 240:20]
    lsu0.io.data.rfSrc2 <= io.from_isu.bits.data.rfSrc2 @[dut.scala 241:20]
    lsu0.io.data.rfSrc1 <= io.from_isu.bits.data.rfSrc1 @[dut.scala 241:20]
    lsu0.io.data.csrRdata <= io.from_isu.bits.data.csrRdata @[dut.scala 241:20]
    lsu0.io.data.data_from_mem <= io.from_isu.bits.data.data_from_mem @[dut.scala 241:20]
    lsu0.io.data.Alu0Res.bits <= io.from_isu.bits.data.Alu0Res.bits @[dut.scala 241:20]
    lsu0.io.data.Alu0Res.valid <= io.from_isu.bits.data.Alu0Res.valid @[dut.scala 241:20]
    lsu0.io.data.Alu0Res.ready <= io.from_isu.bits.data.Alu0Res.ready @[dut.scala 241:20]
    lsu0.io.data.imm <= io.from_isu.bits.data.imm @[dut.scala 241:20]
    lsu0.io.data.fuSrc2 <= io.from_isu.bits.data.fuSrc2 @[dut.scala 241:20]
    lsu0.io.data.fuSrc1 <= io.from_isu.bits.data.fuSrc1 @[dut.scala 241:20]
    lsu0.io.out.ready <= io.to_wbu.ready @[dut.scala 242:21]
    node isLsu = eq(io.from_isu.bits.ctrl.fuType, UInt<1>("h1")) @[dut.scala 245:44]
    node _io_to_wbu_bits_data_data_from_mem_T = and(lsu0.io.out.valid, isLsu) @[dut.scala 246:62]
    node _io_to_wbu_bits_data_data_from_mem_T_1 = mux(_io_to_wbu_bits_data_data_from_mem_T, lsu0.io.out.bits, UInt<1>("h0")) @[dut.scala 246:43]
    io.to_wbu.bits.data.data_from_mem <= _io_to_wbu_bits_data_data_from_mem_T_1 @[dut.scala 246:37]
    io.to_mem <= lsu0.io.to_mem @[dut.scala 249:13]
    csr0.io.in.bits.srca <= io.from_isu.bits.data.fuSrc1 @[dut.scala 252:28]
    csr0.io.in.bits.srcb <= io.from_isu.bits.data.fuSrc2 @[dut.scala 253:28]
    csr0.io.in.bits.fuOpType <= io.from_isu.bits.ctrl.fuOpType @[dut.scala 254:28]
    node _csr0_io_in_valid_T = eq(io.from_isu.bits.ctrl.fuType, UInt<2>("h2")) @[dut.scala 255:82]
    node _csr0_io_in_valid_T_1 = and(io.from_isu.valid, _csr0_io_in_valid_T) @[dut.scala 255:49]
    csr0.io.in.valid <= _csr0_io_in_valid_T_1 @[dut.scala 255:28]
    csr0.io.out.ready <= io.to_wbu.ready @[dut.scala 256:28]
    node _io_to_wbu_bits_data_csrRdata_T = mux(csr0.io.out.valid, csr0.io.out.bits, UInt<1>("h0")) @[dut.scala 258:38]
    io.to_wbu.bits.data.csrRdata <= _io_to_wbu_bits_data_csrRdata_T @[dut.scala 258:32]
    wire bruRes : { valid : UInt<1>, targetPc : UInt<64>} @[dut.scala 263:20]
    wire bruRes_bruRes : { valid : UInt<1>, targetPc : UInt<64>} @[dut.scala 187:22]
    bruRes_bruRes.valid <= io.from_isu.bits.cf.isBranch @[dut.scala 190:18]
    bruRes_bruRes.targetPc <= alu0.io.out.bits @[dut.scala 191:21]
    bruRes <= bruRes_bruRes @[dut.scala 264:10]
    node _mispredict_T = neq(io.from_isu.bits.cf.next_pc, bruRes.targetPc) @[dut.scala 268:54]
    node mispredict = and(bruRes.valid, _mispredict_T) @[dut.scala 268:36]
    node _io_redirect_valid_T = and(io.from_isu.valid, mispredict) @[dut.scala 270:43]
    io.redirect.valid <= _io_redirect_valid_T @[dut.scala 270:22]
    io.redirect.target <= bruRes.targetPc @[dut.scala 271:22]
    node _io_to_wbu_bits_cf_next_pc_T = mux(mispredict, bruRes.targetPc, io.from_isu.bits.cf.next_pc) @[dut.scala 274:35]
    io.to_wbu.bits.cf.next_pc <= _io_to_wbu_bits_cf_next_pc_T @[dut.scala 274:29]
    node _T = and(io.redirect.valid, io.from_isu.valid) @[dut.scala 283:45]
    node _io_from_isu_ready_T = eq(_T, UInt<1>("h0")) @[dut.scala 124:30]
    node _io_from_isu_ready_T_1 = and(io.to_wbu.ready, _io_from_isu_ready_T) @[dut.scala 124:27]
    io.from_isu.ready <= _io_from_isu_ready_T_1 @[dut.scala 124:14]
    node _io_to_wbu_valid_T = eq(UInt<1>("h0"), UInt<1>("h0")) @[dut.scala 127:30]
    node _io_to_wbu_valid_T_1 = and(io.from_isu.valid, _io_to_wbu_valid_T) @[dut.scala 127:27]
    node _io_to_wbu_valid_T_2 = eq(_T, UInt<1>("h0")) @[dut.scala 127:54]
    node _io_to_wbu_valid_T_3 = and(_io_to_wbu_valid_T_1, _io_to_wbu_valid_T_2) @[dut.scala 127:51]
    io.to_wbu.valid <= _io_to_wbu_valid_T_3 @[dut.scala 127:15]

