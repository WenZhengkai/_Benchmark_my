circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    icredit <= io.deq.credit @[dut.scala 23:24]
    reg creditCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 26:30]
    node _io_enq_ready_T = gt(creditCounter, UInt<1>("h0")) @[dut.scala 29:33]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 29:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 33:25]
    validOut <= _validOut_T @[dut.scala 33:25]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 39:19]
    node _T_2 = and(icredit, _T_1) @[dut.scala 39:16]
    when _T_2 : @[dut.scala 39:35]
      node _creditCounter_T = add(creditCounter, UInt<1>("h1")) @[dut.scala 40:36]
      node _creditCounter_T_1 = tail(_creditCounter_T, 1) @[dut.scala 40:36]
      creditCounter <= _creditCounter_T_1 @[dut.scala 40:19]
    else :
      node _T_3 = eq(icredit, UInt<1>("h0")) @[dut.scala 41:14]
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 41:23]
      when _T_5 : @[dut.scala 41:41]
        node _creditCounter_T_2 = sub(creditCounter, UInt<1>("h1")) @[dut.scala 42:36]
        node _creditCounter_T_3 = tail(_creditCounter_T_2, 1) @[dut.scala 42:36]
        creditCounter <= _creditCounter_T_3 @[dut.scala 42:19]
    node _T_6 = gt(creditCounter, UInt<3>("h5")) @[dut.scala 46:22]
    when _T_6 : @[dut.scala 46:37]
      creditCounter <= UInt<3>("h5") @[dut.scala 47:19]
    io.deq.valid <= validOut @[dut.scala 51:16]
    io.deq.bits <= dataOut @[dut.scala 52:15]
    io.curCredit <= creditCounter @[dut.scala 53:16]

