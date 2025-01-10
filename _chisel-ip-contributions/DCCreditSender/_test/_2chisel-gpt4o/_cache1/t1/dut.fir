circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 18:26]
    io.curCredit <= curCredit @[dut.scala 19:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 22:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 22:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:25]
    validOut <= _validOut_T @[dut.scala 26:25]
    io.deq.bits <= dataOut @[dut.scala 29:15]
    io.deq.valid <= validOut @[dut.scala 30:16]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 33:21]
    node _T_1 = and(io.credit, _T) @[dut.scala 33:18]
    when _T_1 : @[dut.scala 33:36]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 34:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 34:28]
      curCredit <= _curCredit_T_1 @[dut.scala 34:15]
    node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_3 = eq(io.credit, UInt<1>("h0")) @[dut.scala 37:25]
    node _T_4 = and(_T_2, _T_3) @[dut.scala 37:22]
    when _T_4 : @[dut.scala 37:37]
      node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 38:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 38:28]
      curCredit <= _curCredit_T_3 @[dut.scala 38:15]
    icredit <= io.credit @[dut.scala 42:11]
    node _T_5 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 45:24]
    node _T_6 = and(io.deq.valid, _T_5) @[dut.scala 45:21]
    when _T_6 : @[dut.scala 45:40]
      validOut <= UInt<1>("h0") @[dut.scala 46:14]


