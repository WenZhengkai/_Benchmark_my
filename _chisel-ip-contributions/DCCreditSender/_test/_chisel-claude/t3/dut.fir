circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg creditCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 23:30]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:24]
    icredit <= io.deq.credit @[dut.scala 26:24]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:25]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 36:19]
    node _T_2 = and(icredit, _T_1) @[dut.scala 36:16]
    when _T_2 : @[dut.scala 36:35]
      node _creditCounter_T = add(creditCounter, UInt<1>("h1")) @[dut.scala 37:36]
      node _creditCounter_T_1 = tail(_creditCounter_T, 1) @[dut.scala 37:36]
      creditCounter <= _creditCounter_T_1 @[dut.scala 37:19]
    else :
      node _T_3 = eq(icredit, UInt<1>("h0")) @[dut.scala 38:14]
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 38:23]
      when _T_5 : @[dut.scala 38:41]
        node _creditCounter_T_2 = sub(creditCounter, UInt<1>("h1")) @[dut.scala 39:36]
        node _creditCounter_T_3 = tail(_creditCounter_T_2, 1) @[dut.scala 39:36]
        creditCounter <= _creditCounter_T_3 @[dut.scala 39:19]
    node _T_6 = gt(creditCounter, UInt<3>("h5")) @[dut.scala 43:22]
    when _T_6 : @[dut.scala 43:37]
      creditCounter <= UInt<3>("h5") @[dut.scala 44:19]
    node _io_enq_ready_T = gt(creditCounter, UInt<1>("h0")) @[dut.scala 48:33]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 48:16]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _validOut_T_1 = mux(icredit, UInt<1>("h0"), validOut) @[dut.scala 52:22]
    node _validOut_T_2 = mux(_validOut_T, UInt<1>("h1"), _validOut_T_1) @[dut.scala 51:18]
    validOut <= _validOut_T_2 @[dut.scala 51:12]
    io.deq.valid <= validOut @[dut.scala 55:16]
    io.deq.bits <= dataOut @[dut.scala 56:15]
    io.curCredit <= creditCounter @[dut.scala 57:16]

