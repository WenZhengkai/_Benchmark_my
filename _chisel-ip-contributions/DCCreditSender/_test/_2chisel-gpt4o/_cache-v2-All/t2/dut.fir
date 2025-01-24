circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 23:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 24:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:25]
    icredit <= io.deq.credit @[dut.scala 28:11]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 31:25]
    node _T_2 = and(io.deq.credit, _T_1) @[dut.scala 31:22]
    when _T_2 : @[dut.scala 31:41]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 33:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 33:28]
      curCredit <= _curCredit_T_1 @[dut.scala 33:15]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 34:31]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 34:28]
      when _T_5 : @[dut.scala 34:47]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 36:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 36:28]
        curCredit <= _curCredit_T_3 @[dut.scala 36:15]
    node _T_6 = gt(curCredit, UInt<3>("h5")) @[dut.scala 40:18]
    when _T_6 : @[dut.scala 40:33]
      curCredit <= UInt<3>("h5") @[dut.scala 41:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 45:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 45:16]
    node _T_7 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_7 : @[dut.scala 48:23]
      dataOut <= io.enq.bits @[dut.scala 49:13]
      validOut <= UInt<1>("h1") @[dut.scala 50:14]
    else :
      node _T_8 = and(io.deq.credit, validOut) @[dut.scala 51:28]
      when _T_8 : @[dut.scala 51:41]
        validOut <= UInt<1>("h0") @[dut.scala 53:14]
    io.deq.valid <= validOut @[dut.scala 57:16]
    io.deq.bits <= dataOut @[dut.scala 58:15]
    io.curCredit <= curCredit @[dut.scala 61:16]

