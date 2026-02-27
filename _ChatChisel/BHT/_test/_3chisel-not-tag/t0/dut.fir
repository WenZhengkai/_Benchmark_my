circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip target_pc : UInt<32>, matched : UInt<1>, valid : UInt<1>, bht_pred_pc : UInt<32>}

    reg bht : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>}[16], clock with :
      reset => (UInt<1>("h0"), bht) @[dut.scala 23:16]
    node idx = bits(io.pc, 5, 2) @[dut.scala 25:18]
    node _tag_match_T = bits(io.pc, 31, 6) @[dut.scala 28:38]
    node tag_match = eq(bht[idx].tag, _tag_match_T) @[dut.scala 28:29]
    io.matched <= tag_match @[dut.scala 29:14]
    io.valid <= bht[idx].valid @[dut.scala 30:12]
    io.bht_pred_pc <= bht[idx].target_pc @[dut.scala 31:18]
    node update_idx = bits(io.mem_pc, 5, 2) @[dut.scala 34:29]
    node do_update = eq(io.pcsrc, UInt<1>("h1")) @[dut.scala 35:28]
    when do_update : @[dut.scala 37:19]
      node _bht_tag_T = bits(io.mem_pc, 31, 6) @[dut.scala 38:37]
      bht[update_idx].tag <= _bht_tag_T @[dut.scala 38:25]
      bht[update_idx].valid <= UInt<1>("h1") @[dut.scala 39:27]
      bht[update_idx].target_pc <= io.target_pc @[dut.scala 40:31]


