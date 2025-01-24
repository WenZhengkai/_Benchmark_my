circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:26]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:24]
    icredit <= io.deq.credit @[dut.scala 21:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 22:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:25]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 26:25]
    node _T_1 = and(io.deq.credit, _T) @[dut.scala 26:22]
    when _T_1 : @[dut.scala 26:40]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 28:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 28:28]
      curCredit <= _curCredit_T_1 @[dut.scala 28:15]
    else :
      node _T_2 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 29:30]
      node _T_3 = and(io.deq.valid, _T_2) @[dut.scala 29:27]
      when _T_3 : @[dut.scala 29:46]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 31:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 31:28]
        curCredit <= _curCredit_T_3 @[dut.scala 31:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 35:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 35:16]
    node _T_4 = and(io.enq.valid, io.enq.ready) @[dut.scala 38:21]
    when _T_4 : @[dut.scala 38:38]
      dataOut <= io.enq.bits @[dut.scala 39:13]
      validOut <= UInt<1>("h1") @[dut.scala 40:14]
    else :
      node _T_5 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 41:30]
      node _T_6 = and(io.deq.valid, _T_5) @[dut.scala 41:27]
      when _T_6 : @[dut.scala 41:46]
        validOut <= UInt<1>("h0") @[dut.scala 42:14]
    io.deq.bits <= dataOut @[dut.scala 46:15]
    io.deq.valid <= validOut @[dut.scala 47:16]
    icredit <= io.deq.credit @[dut.scala 49:11]
    io.curCredit <= curCredit @[dut.scala 52:16]

