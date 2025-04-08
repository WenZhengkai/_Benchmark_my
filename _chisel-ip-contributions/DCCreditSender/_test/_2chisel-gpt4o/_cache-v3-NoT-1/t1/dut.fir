circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    icredit <= io.deq.credit @[dut.scala 21:11]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 24:26]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 26:20]
    node _T_2 = and(icredit, _T_1) @[dut.scala 26:17]
    when _T_2 : @[dut.scala 26:34]
      node _T_3 = lt(curCredit, UInt<3>("h5")) @[dut.scala 27:20]
      when _T_3 : @[dut.scala 27:35]
        node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 27:60]
        node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 27:60]
        curCredit <= _curCredit_T_1 @[dut.scala 27:47]
    else :
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = eq(icredit, UInt<1>("h0")) @[dut.scala 28:30]
      node _T_6 = and(_T_4, _T_5) @[dut.scala 28:27]
      when _T_6 : @[dut.scala 28:40]
        node _T_7 = gt(curCredit, UInt<1>("h0")) @[dut.scala 29:20]
        when _T_7 : @[dut.scala 29:27]
          node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 29:52]
          node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 29:52]
          curCredit <= _curCredit_T_3 @[dut.scala 29:39]
    io.curCredit <= curCredit @[dut.scala 32:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 35:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 35:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:25]
    validOut <= _validOut_T @[dut.scala 39:25]
    io.deq.valid <= validOut @[dut.scala 42:16]
    io.deq.bits <= dataOut @[dut.scala 43:15]

