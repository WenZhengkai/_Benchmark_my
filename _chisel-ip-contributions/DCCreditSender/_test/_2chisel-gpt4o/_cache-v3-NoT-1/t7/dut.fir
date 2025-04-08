circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    icredit <= io.deq.credit @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 23:26]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(icredit, UInt<1>("h0")) @[dut.scala 25:25]
    node _T_2 = and(_T, _T_1) @[dut.scala 25:22]
    when _T_2 : @[dut.scala 25:35]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 26:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 26:28]
      curCredit <= _curCredit_T_1 @[dut.scala 26:15]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 27:25]
      node _T_5 = and(icredit, _T_4) @[dut.scala 27:22]
      when _T_5 : @[dut.scala 27:41]
        node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 28:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 28:28]
        curCredit <= _curCredit_T_3 @[dut.scala 28:15]
    node _T_6 = leq(curCredit, UInt<3>("h5")) @[dut.scala 31:20]
    node _T_7 = geq(curCredit, UInt<1>("h0")) @[dut.scala 31:48]
    node _T_8 = and(_T_6, _T_7) @[dut.scala 31:35]
    node _T_9 = bits(reset, 0, 0) @[dut.scala 31:9]
    node _T_10 = eq(_T_9, UInt<1>("h0")) @[dut.scala 31:9]
    when _T_10 : @[dut.scala 31:9]
      node _T_11 = eq(_T_8, UInt<1>("h0")) @[dut.scala 31:9]
      when _T_11 : @[dut.scala 31:9]
        printf(clock, UInt<1>("h1"), "Assertion failed: curCredit out of bounds\n    at dut.scala:31 assert(curCredit <= maxCredit.U && curCredit >= 0.U, \"curCredit out of bounds\")\n") : printf @[dut.scala 31:9]
      assert(clock, _T_8, UInt<1>("h1"), "") : assert @[dut.scala 31:9]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 34:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 34:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 38:25]
    validOut <= _validOut_T @[dut.scala 38:25]
    io.deq.valid <= validOut @[dut.scala 41:16]
    io.deq.bits <= dataOut @[dut.scala 42:15]
    io.curCredit <= curCredit @[dut.scala 45:16]

