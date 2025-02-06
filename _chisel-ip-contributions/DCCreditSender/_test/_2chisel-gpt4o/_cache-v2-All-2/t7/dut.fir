circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:24]
    icredit <= io.deq.credit @[dut.scala 21:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 25:26]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 28:20]
    node _T_1 = and(icredit, _T) @[dut.scala 28:17]
    when _T_1 : @[dut.scala 28:35]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 29:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 29:28]
      curCredit <= _curCredit_T_1 @[dut.scala 29:15]
    else :
      node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_3 = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 30:45]
      node _T_4 = and(icredit, _T_3) @[dut.scala 30:42]
      node _T_5 = eq(_T_4, UInt<1>("h0")) @[dut.scala 30:32]
      node _T_6 = and(_T_2, _T_5) @[dut.scala 30:29]
      when _T_6 : @[dut.scala 30:61]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 31:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 31:28]
        curCredit <= _curCredit_T_3 @[dut.scala 31:15]
    io.curCredit <= curCredit @[dut.scala 34:16]
    node _io_enq_ready_T = neq(curCredit, UInt<1>("h0")) @[dut.scala 38:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 38:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 43:25]
    validOut <= _validOut_T @[dut.scala 43:25]
    io.deq.bits <= dataOut @[dut.scala 47:15]
    io.deq.valid <= validOut @[dut.scala 48:16]
    node _T_7 = and(io.deq.credit, io.deq.valid) @[dut.scala 51:23]
    when _T_7 : @[dut.scala 51:40]
      validOut <= UInt<1>("h0") @[dut.scala 52:14]
    when io.deq.credit : @[dut.scala 56:24]
      node _curCredit_T_4 = add(curCredit, UInt<1>("h1")) @[dut.scala 57:28]
      node _curCredit_T_5 = tail(_curCredit_T_4, 1) @[dut.scala 57:28]
      curCredit <= _curCredit_T_5 @[dut.scala 57:15]


