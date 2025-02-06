circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg creditCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:30]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    icredit <= io.deq.credit @[dut.scala 23:24]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 26:24]
    node _T_2 = and(_T, _T_1) @[dut.scala 26:21]
    when _T_2 : @[dut.scala 26:40]
      node _creditCounter_T = sub(creditCounter, UInt<1>("h1")) @[dut.scala 27:36]
      node _creditCounter_T_1 = tail(_creditCounter_T, 1) @[dut.scala 27:36]
      creditCounter <= _creditCounter_T_1 @[dut.scala 27:19]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 28:16]
      node _T_5 = and(_T_4, io.deq.credit) @[dut.scala 28:29]
      when _T_5 : @[dut.scala 28:47]
        node _creditCounter_T_2 = add(creditCounter, UInt<1>("h1")) @[dut.scala 29:36]
        node _creditCounter_T_3 = tail(_creditCounter_T_2, 1) @[dut.scala 29:36]
        creditCounter <= _creditCounter_T_3 @[dut.scala 29:19]
    node _io_enq_ready_T = gt(creditCounter, UInt<1>("h0")) @[dut.scala 33:33]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 33:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 37:25]
    validOut <= _validOut_T @[dut.scala 37:25]
    io.deq.bits <= dataOut @[dut.scala 40:15]
    io.deq.valid <= validOut @[dut.scala 41:16]
    io.curCredit <= creditCounter @[dut.scala 42:16]

