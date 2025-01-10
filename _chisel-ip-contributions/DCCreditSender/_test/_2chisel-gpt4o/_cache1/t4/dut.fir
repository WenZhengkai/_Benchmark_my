circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:26]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    icredit <= io.deq.credit @[dut.scala 23:24]
    node _dataOut_T = and(io.enq.valid, io.enq.ready) @[dut.scala 26:53]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.valid, io.enq.ready) @[dut.scala 27:39]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:25]
    validOut <= _validOut_T @[dut.scala 27:25]
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 30:21]
    node _T_1 = eq(icredit, UInt<1>("h0")) @[dut.scala 30:40]
    node _T_2 = and(_T, _T_1) @[dut.scala 30:37]
    when _T_2 : @[dut.scala 30:50]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 31:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 31:28]
      curCredit <= _curCredit_T_1 @[dut.scala 31:15]
    node _T_3 = and(io.enq.valid, io.enq.ready) @[dut.scala 35:40]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 35:25]
    node _T_5 = and(io.deq.credit, _T_4) @[dut.scala 35:22]
    when _T_5 : @[dut.scala 35:58]
      node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 36:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 36:28]
      curCredit <= _curCredit_T_3 @[dut.scala 36:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 40:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 40:16]
    io.deq.valid <= validOut @[dut.scala 43:16]
    io.deq.bits <= dataOut @[dut.scala 46:15]
    io.curCredit <= curCredit @[dut.scala 50:16]

