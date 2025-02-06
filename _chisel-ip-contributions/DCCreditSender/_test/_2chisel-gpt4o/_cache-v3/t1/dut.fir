circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 23:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 26:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:25]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 30:30]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 30:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 33:23]
      dataOut <= io.enq.bits @[dut.scala 34:13]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _validOut_T_1 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 38:45]
    node _validOut_T_2 = and(validOut, _validOut_T_1) @[dut.scala 38:42]
    node _validOut_T_3 = or(_validOut_T, _validOut_T_2) @[dut.scala 38:29]
    validOut <= _validOut_T_3 @[dut.scala 38:12]
    io.deq.valid <= validOut @[dut.scala 41:16]
    io.deq.bits <= dataOut @[dut.scala 42:15]
    icredit <= io.deq.credit @[dut.scala 45:11]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_2 = eq(_T_1, UInt<1>("h0")) @[dut.scala 46:25]
    node _T_3 = and(io.deq.credit, _T_2) @[dut.scala 46:22]
    when _T_3 : @[dut.scala 46:41]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 48:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 48:28]
      curCredit <= _curCredit_T_1 @[dut.scala 48:15]
    else :
      node _T_4 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 49:14]
      node _T_5 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_6 = and(_T_4, _T_5) @[dut.scala 49:29]
      when _T_6 : @[dut.scala 49:47]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 51:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 51:28]
        curCredit <= _curCredit_T_3 @[dut.scala 51:15]
    io.curCredit <= curCredit @[dut.scala 55:16]

