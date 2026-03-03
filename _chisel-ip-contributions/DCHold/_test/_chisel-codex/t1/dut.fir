circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 10:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 11:19]
    io.deq.valid <= pValid @[dut.scala 14:16]
    io.deq.bits <= pData @[dut.scala 15:16]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 18:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 18:16]
    node _T = eq(pValid, UInt<1>("h0")) @[dut.scala 21:8]
    node _T_1 = and(_T, io.enq.valid) @[dut.scala 21:16]
    when _T_1 : @[dut.scala 21:33]
      pData <= io.enq.bits @[dut.scala 22:11]
      pValid <= UInt<1>("h1") @[dut.scala 23:12]
    node _T_2 = and(pValid, io.deq.ready) @[dut.scala 27:15]
    when _T_2 : @[dut.scala 27:32]
      pValid <= UInt<1>("h0") @[dut.scala 28:12]


