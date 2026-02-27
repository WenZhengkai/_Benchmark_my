circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 25:18]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 28:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 28:16]
    io.deq.valid <= pValid @[dut.scala 29:16]
    io.deq.bits <= pData @[dut.scala 30:15]
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 33:21]
    when _T : @[dut.scala 33:38]
      pData <= io.enq.bits @[dut.scala 34:11]
      pValid <= UInt<1>("h1") @[dut.scala 35:12]
    node _T_1 = and(io.deq.valid, io.deq.ready) @[dut.scala 39:21]
    when _T_1 : @[dut.scala 39:38]
      pValid <= UInt<1>("h0") @[dut.scala 40:12]


