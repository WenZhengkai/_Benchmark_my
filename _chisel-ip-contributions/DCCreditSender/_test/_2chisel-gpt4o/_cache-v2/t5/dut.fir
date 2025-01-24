circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    reg curCredit : UInt, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 24:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 25:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:25]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 29:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 29:16]
    when io.deq.credit : @[dut.scala 32:24]
      icredit <= UInt<1>("h1") @[dut.scala 33:13]
    else :
      icredit <= UInt<1>("h0") @[dut.scala 35:13]
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 39:22]
    when _T : @[dut.scala 39:39]
      dataOut <= io.enq.bits @[dut.scala 40:13]
      validOut <= UInt<1>("h1") @[dut.scala 41:14]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 42:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 42:28]
      curCredit <= _curCredit_T_1 @[dut.scala 42:15]
    node _T_1 = and(io.deq.credit, validOut) @[dut.scala 45:23]
    when _T_1 : @[dut.scala 45:36]
      validOut <= UInt<1>("h0") @[dut.scala 46:14]
      node _T_2 = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 47:11]
      node _T_3 = eq(io.enq.ready, UInt<1>("h0")) @[dut.scala 47:28]
      node _T_4 = or(_T_2, _T_3) @[dut.scala 47:25]
      when _T_4 : @[dut.scala 47:43]
        node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 48:30]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 48:30]
        curCredit <= _curCredit_T_3 @[dut.scala 48:17]
    io.deq.valid <= validOut @[dut.scala 53:16]
    io.deq.bits <= dataOut @[dut.scala 54:15]
    io.curCredit <= curCredit @[dut.scala 55:16]

