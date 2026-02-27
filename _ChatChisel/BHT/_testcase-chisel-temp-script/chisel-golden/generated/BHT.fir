circuit BHT :
  module BHT :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip target_pc : UInt<32>, matched : UInt<1>, valid : UInt<1>, bht_pred_pc : UInt<32>}

    cmem bhtTable : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} [16] @[dut.scala 24:21]
    node index = bits(io.pc, 5, 2) @[dut.scala 26:20]
    read mport bhtEntry = bhtTable[index], clock @[dut.scala 28:31]
    node _io_matched_T = bits(io.pc, 31, 6) @[dut.scala 30:39]
    node _io_matched_T_1 = eq(bhtEntry.tag, _io_matched_T) @[dut.scala 30:30]
    io.matched <= _io_matched_T_1 @[dut.scala 30:14]
    io.valid <= bhtEntry.valid @[dut.scala 31:12]
    io.bht_pred_pc <= bhtEntry.target_pc @[dut.scala 32:18]
    node _T = eq(io.pcsrc, UInt<1>("h1")) @[dut.scala 34:17]
    when _T : @[dut.scala 34:26]
      wire newEntry : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} @[dut.scala 35:24]
      node _newEntry_tag_T = bits(io.mem_pc, 31, 6) @[dut.scala 36:30]
      newEntry.tag <= _newEntry_tag_T @[dut.scala 36:18]
      newEntry.valid <= UInt<1>("h1") @[dut.scala 37:20]
      newEntry.target_pc <= io.target_pc @[dut.scala 38:24]
      node _T_1 = bits(io.mem_pc, 5, 2) @[dut.scala 39:29]
      write mport MPORT = bhtTable[_T_1], clock
      MPORT <= newEntry


