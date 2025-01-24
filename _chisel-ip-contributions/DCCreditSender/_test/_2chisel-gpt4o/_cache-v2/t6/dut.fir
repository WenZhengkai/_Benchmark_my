circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:26]
    io.curCredit <= curCredit @[dut.scala 24:16]
    node _dataOut_T = and(io.enq.valid, io.enq.ready) @[dut.scala 27:53]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.valid, io.enq.ready) @[dut.scala 28:39]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:25]
    validOut <= _validOut_T @[dut.scala 28:25]
    node _icredit_T = or(icredit, io.deq.credit) @[dut.scala 31:22]
    icredit <= _icredit_T @[dut.scala 31:11]
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 34:22]
    node _T_1 = eq(icredit, UInt<1>("h0")) @[dut.scala 34:41]
    node _T_2 = and(_T, _T_1) @[dut.scala 34:38]
    when _T_2 : @[dut.scala 34:51]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 35:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 35:28]
      curCredit <= _curCredit_T_1 @[dut.scala 35:15]
    else :
      node _T_3 = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 36:16]
      node _T_4 = and(_T_3, icredit) @[dut.scala 36:30]
      when _T_4 : @[dut.scala 36:42]
        node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 37:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 37:28]
        curCredit <= _curCredit_T_3 @[dut.scala 37:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 41:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 41:16]
    io.deq.bits <= dataOut @[dut.scala 44:15]
    io.deq.valid <= validOut @[dut.scala 45:16]
    node _T_5 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 48:21]
    node _T_6 = and(validOut, _T_5) @[dut.scala 48:18]
    when _T_6 : @[dut.scala 48:37]
      icredit <= UInt<1>("h0") @[dut.scala 49:13]


