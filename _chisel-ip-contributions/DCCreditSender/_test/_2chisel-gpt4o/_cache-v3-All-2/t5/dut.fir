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
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 27:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 27:28]
      curCredit <= _curCredit_T_1 @[dut.scala 27:15]
    node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_4 = eq(icredit, UInt<1>("h0")) @[dut.scala 30:24]
    node _T_5 = and(_T_3, _T_4) @[dut.scala 30:21]
    when _T_5 : @[dut.scala 30:34]
      node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 31:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 31:28]
      curCredit <= _curCredit_T_3 @[dut.scala 31:15]
    node _curCredit_T_4 = gt(curCredit, UInt<3>("h5")) @[dut.scala 34:30]
    node _curCredit_T_5 = mux(_curCredit_T_4, UInt<3>("h5"), curCredit) @[dut.scala 34:19]
    curCredit <= _curCredit_T_5 @[dut.scala 34:13]
    io.curCredit <= curCredit @[dut.scala 35:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 38:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 38:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:25]
    validOut <= _validOut_T @[dut.scala 42:25]
    io.deq.valid <= validOut @[dut.scala 45:16]
    io.deq.bits <= dataOut @[dut.scala 46:15]

