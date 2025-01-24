circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:26]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    icredit <= io.credit @[dut.scala 22:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 23:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:25]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 27:21]
    node _T_1 = and(io.credit, _T) @[dut.scala 27:18]
    when _T_1 : @[dut.scala 27:36]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 28:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 28:28]
      curCredit <= _curCredit_T_1 @[dut.scala 28:15]
    else :
      node _T_2 = eq(io.credit, UInt<1>("h0")) @[dut.scala 29:30]
      node _T_3 = and(io.deq.valid, _T_2) @[dut.scala 29:27]
      when _T_3 : @[dut.scala 29:42]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 30:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 30:28]
        curCredit <= _curCredit_T_3 @[dut.scala 30:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 34:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 34:16]
    node _T_4 = and(io.enq.valid, io.enq.ready) @[dut.scala 37:21]
    when _T_4 : @[dut.scala 37:38]
      dataOut <= io.enq.bits @[dut.scala 38:13]
      validOut <= UInt<1>("h1") @[dut.scala 39:14]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 41:14]
    io.deq.bits <= dataOut @[dut.scala 45:15]
    io.deq.valid <= validOut @[dut.scala 46:16]
    io.curCredit <= curCredit @[dut.scala 47:16]

