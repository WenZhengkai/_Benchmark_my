circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 24:18]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 27:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 27:16]
    io.deq.valid <= pValid @[dut.scala 30:16]
    io.deq.bits <= pData @[dut.scala 31:15]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 34:21]
      pData <= io.enq.bits @[dut.scala 36:11]
      pValid <= UInt<1>("h1") @[dut.scala 37:12]
    else :
      node _T_1 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
      when _T_1 : @[dut.scala 38:27]
        pValid <= UInt<1>("h0") @[dut.scala 40:12]


