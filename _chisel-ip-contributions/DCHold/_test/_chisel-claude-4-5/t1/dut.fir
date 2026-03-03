circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg pValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(pValid, UInt<1>("h0")) @[dut.scala 15:23]
    node _T_2 = and(_T, _T_1) @[dut.scala 15:20]
    when _T_2 : @[dut.scala 15:32]
      pData <= io.enq.bits @[dut.scala 17:11]
      pValid <= UInt<1>("h1") @[dut.scala 18:12]
    else :
      node _T_3 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
      node _T_4 = and(_T_3, pValid) @[dut.scala 19:26]
      when _T_4 : @[dut.scala 19:37]
        pValid <= UInt<1>("h0") @[dut.scala 21:12]
    node _T_5 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_6 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    node _T_7 = and(_T_5, _T_6) @[dut.scala 25:20]
    when _T_7 : @[dut.scala 25:36]
      pData <= io.enq.bits @[dut.scala 27:11]
      pValid <= UInt<1>("h1") @[dut.scala 28:12]
    io.deq.valid <= pValid @[dut.scala 32:16]
    io.deq.bits <= pData @[dut.scala 33:15]
    node _io_enq_ready_T = eq(pValid, UInt<1>("h0")) @[dut.scala 34:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 34:16]

