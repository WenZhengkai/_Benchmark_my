circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:26]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:25]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 23:20]
    icredit <= io.deq.credit @[dut.scala 27:11]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 30:19]
    node _T_2 = and(icredit, _T_1) @[dut.scala 30:16]
    when _T_2 : @[dut.scala 30:35]
      node _curCredit_T = lt(curCredit, UInt<3>("h5")) @[dut.scala 32:32]
      node _curCredit_T_1 = add(curCredit, UInt<1>("h1")) @[dut.scala 32:57]
      node _curCredit_T_2 = tail(_curCredit_T_1, 1) @[dut.scala 32:57]
      node _curCredit_T_3 = mux(_curCredit_T, _curCredit_T_2, curCredit) @[dut.scala 32:21]
      curCredit <= _curCredit_T_3 @[dut.scala 32:15]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(icredit, UInt<1>("h0")) @[dut.scala 33:31]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 33:28]
      when _T_5 : @[dut.scala 33:41]
        node _curCredit_T_4 = gt(curCredit, UInt<1>("h0")) @[dut.scala 35:32]
        node _curCredit_T_5 = sub(curCredit, UInt<1>("h1")) @[dut.scala 35:49]
        node _curCredit_T_6 = tail(_curCredit_T_5, 1) @[dut.scala 35:49]
        node _curCredit_T_7 = mux(_curCredit_T_4, _curCredit_T_6, curCredit) @[dut.scala 35:21]
        curCredit <= _curCredit_T_7 @[dut.scala 35:15]
    io.curCredit <= curCredit @[dut.scala 39:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 43:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 43:16]
    node _T_6 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_6 : @[dut.scala 47:23]
      dataOut <= io.enq.bits @[dut.scala 48:13]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 50:22]
    validOut_REG <= _validOut_T @[dut.scala 50:22]
    validOut <= validOut_REG @[dut.scala 50:12]
    io.deq.valid <= validOut @[dut.scala 53:16]
    io.deq.bits <= dataOut @[dut.scala 54:15]

