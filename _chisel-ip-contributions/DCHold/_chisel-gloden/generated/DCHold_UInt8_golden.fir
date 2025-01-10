circuit DCHold_UInt8_golden :
  module DCHold_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 23:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[golden.scala 24:18]
    node _T = eq(pValid, UInt<1>("h0")) @[golden.scala 26:24]
    node _T_1 = and(io.enq.valid, _T) @[golden.scala 26:21]
    when _T_1 : @[golden.scala 26:33]
      pValid <= io.enq.valid @[golden.scala 27:12]
      pData <= io.enq.bits @[golden.scala 28:11]
    else :
      node _T_2 = and(pValid, io.deq.ready) @[golden.scala 29:22]
      node _T_3 = eq(_T_2, UInt<1>("h1")) @[golden.scala 29:38]
      when _T_3 : @[golden.scala 29:47]
        pValid <= UInt<1>("h0") @[golden.scala 30:12]
    io.deq.valid <= pValid @[golden.scala 32:16]
    io.deq.bits <= pData @[golden.scala 33:15]
    node _io_enq_ready_T = not(pValid) @[golden.scala 34:19]
    io.enq.ready <= _io_enq_ready_T @[golden.scala 34:16]

