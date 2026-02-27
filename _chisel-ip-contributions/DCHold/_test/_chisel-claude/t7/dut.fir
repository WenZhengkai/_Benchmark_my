circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 14:18]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 17:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 17:16]
    io.deq.valid <= pValid @[dut.scala 18:16]
    io.deq.bits <= pData @[dut.scala 19:15]
    node _T = eq(pValid, UInt<1>("h0")) @[dut.scala 22:25]
    node _T_1 = and(io.enq.valid, _T) @[dut.scala 22:22]
    when _T_1 : @[dut.scala 22:34]
      pValid <= UInt<1>("h1") @[dut.scala 23:12]
      pData <= io.enq.bits @[dut.scala 24:11]
    else :
      node _T_2 = and(io.deq.ready, pValid) @[dut.scala 25:28]
      when _T_2 : @[dut.scala 25:39]
        pValid <= UInt<1>("h0") @[dut.scala 26:12]


