circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    node _T = eq(pValid, UInt<1>("h0")) @[dut.scala 15:24]
    node _T_1 = and(io.enq.valid, _T) @[dut.scala 15:21]
    when _T_1 : @[dut.scala 15:33]
      pData <= io.enq.bits @[dut.scala 17:11]
      pValid <= UInt<1>("h1") @[dut.scala 18:12]
    node _T_2 = and(io.deq.ready, pValid) @[dut.scala 22:21]
    when _T_2 : @[dut.scala 22:32]
      pValid <= UInt<1>("h0") @[dut.scala 24:12]
    io.deq.valid <= pValid @[dut.scala 28:16]
    io.deq.bits <= pData @[dut.scala 29:15]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 30:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 30:16]

