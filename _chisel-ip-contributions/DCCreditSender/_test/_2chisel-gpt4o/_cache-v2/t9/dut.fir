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
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:25]
    validOut <= _validOut_T @[dut.scala 28:25]
    io.deq.valid <= validOut @[dut.scala 31:16]
    io.deq.bits <= dataOut @[dut.scala 32:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 35:30]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 35:16]
    when io.deq.credit : @[dut.scala 38:24]
      icredit <= UInt<1>("h1") @[dut.scala 39:13]
    else :
      icredit <= UInt<1>("h0") @[dut.scala 41:13]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = and(_T, icredit) @[dut.scala 44:22]
    when _T_1 : @[dut.scala 44:34]
      curCredit <= curCredit @[dut.scala 46:15]
    else :
      node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      when _T_2 : @[dut.scala 47:29]
        node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 49:28]
        node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 49:28]
        curCredit <= _curCredit_T_1 @[dut.scala 49:15]
      else :
        when icredit : @[dut.scala 50:23]
          node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 52:28]
          node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 52:28]
          curCredit <= _curCredit_T_3 @[dut.scala 52:15]
    node _T_3 = eq(curCredit, UInt<3>("h5")) @[dut.scala 56:18]
    node _T_4 = and(_T_3, icredit) @[dut.scala 56:34]
    when _T_4 : @[dut.scala 56:46]
      curCredit <= curCredit @[dut.scala 57:15]
    else :
      node _T_5 = eq(curCredit, UInt<1>("h0")) @[dut.scala 58:24]
      node _T_6 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_7 = and(_T_5, _T_6) @[dut.scala 58:32]
      when _T_7 : @[dut.scala 58:50]
        curCredit <= curCredit @[dut.scala 59:15]


