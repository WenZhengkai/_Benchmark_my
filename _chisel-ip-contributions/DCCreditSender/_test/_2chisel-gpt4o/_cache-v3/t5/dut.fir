circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 22:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:25]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = neq(curCredit, UInt<1>("h0")) @[dut.scala 26:35]
    node _T_2 = and(_T, _T_1) @[dut.scala 26:22]
    when _T_2 : @[dut.scala 26:44]
      dataOut <= io.enq.bits @[dut.scala 27:13]
      validOut <= UInt<1>("h1") @[dut.scala 28:14]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 29:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 29:28]
      curCredit <= _curCredit_T_1 @[dut.scala 29:15]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 31:14]
    node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 34:25]
    node _T_5 = and(io.deq.credit, _T_4) @[dut.scala 34:22]
    when _T_5 : @[dut.scala 34:41]
      node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 35:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 35:28]
      curCredit <= _curCredit_T_3 @[dut.scala 35:15]
    io.deq.bits <= dataOut @[dut.scala 39:15]
    io.deq.valid <= validOut @[dut.scala 40:16]
    node _io_enq_ready_T = neq(curCredit, UInt<1>("h0")) @[dut.scala 41:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 41:16]
    icredit <= io.deq.credit @[dut.scala 44:11]
    io.curCredit <= curCredit @[dut.scala 47:16]

