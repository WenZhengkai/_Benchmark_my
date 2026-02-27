circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 15:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 15:16]
    io.deq.valid <= pValid @[dut.scala 16:16]
    io.deq.bits <= pData @[dut.scala 17:15]
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 20:21]
    when _T : @[dut.scala 20:38]
      pValid <= UInt<1>("h1") @[dut.scala 21:12]
      pData <= io.enq.bits @[dut.scala 22:11]
    else :
      node _T_1 = and(io.deq.valid, io.deq.ready) @[dut.scala 23:27]
      when _T_1 : @[dut.scala 23:44]
        pValid <= UInt<1>("h0") @[dut.scala 24:12]


