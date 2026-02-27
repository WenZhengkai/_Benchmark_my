circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    when pValid : @[dut.scala 15:16]
      when io.deq.ready : @[dut.scala 17:24]
        pValid <= UInt<1>("h0") @[dut.scala 18:14]
    else :
      when io.enq.valid : @[dut.scala 22:24]
        pValid <= UInt<1>("h1") @[dut.scala 23:14]
        pData <= io.enq.bits @[dut.scala 24:13]
    io.deq.valid <= pValid @[dut.scala 29:16]
    io.deq.bits <= pData @[dut.scala 30:15]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 31:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 31:16]

