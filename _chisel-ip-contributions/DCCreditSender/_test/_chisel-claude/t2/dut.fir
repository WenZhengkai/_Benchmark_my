circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:24]
    icredit <= io.deq.credit @[dut.scala 24:24]
    reg creditCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 27:30]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 30:20]
    node _T_2 = and(icredit, _T_1) @[dut.scala 30:17]
    when _T_2 : @[dut.scala 30:34]
      node _creditCounter_T = eq(creditCounter, UInt<3>("h5")) @[dut.scala 32:40]
      node _creditCounter_T_1 = add(creditCounter, UInt<1>("h1")) @[dut.scala 32:86]
      node _creditCounter_T_2 = tail(_creditCounter_T_1, 1) @[dut.scala 32:86]
      node _creditCounter_T_3 = mux(_creditCounter_T, creditCounter, _creditCounter_T_2) @[dut.scala 32:25]
      creditCounter <= _creditCounter_T_3 @[dut.scala 32:19]
    else :
      node _T_3 = eq(icredit, UInt<1>("h0")) @[dut.scala 33:16]
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 33:25]
      when _T_5 : @[dut.scala 33:41]
        node _creditCounter_T_4 = sub(creditCounter, UInt<1>("h1")) @[dut.scala 35:36]
        node _creditCounter_T_5 = tail(_creditCounter_T_4, 1) @[dut.scala 35:36]
        creditCounter <= _creditCounter_T_5 @[dut.scala 35:19]
    node _io_enq_ready_T = gt(creditCounter, UInt<1>("h0")) @[dut.scala 39:33]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 39:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 45:25]
    validOut <= _validOut_T @[dut.scala 45:25]
    io.deq.valid <= validOut @[dut.scala 48:16]
    io.deq.bits <= dataOut @[dut.scala 49:15]
    io.curCredit <= creditCounter @[dut.scala 50:16]

