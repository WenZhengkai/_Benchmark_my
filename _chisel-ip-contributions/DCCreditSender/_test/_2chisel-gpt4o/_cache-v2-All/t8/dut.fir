circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 22:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:25]
    icredit <= io.deq.credit @[dut.scala 26:11]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 29:19]
    node _T_2 = and(icredit, _T_1) @[dut.scala 29:16]
    when _T_2 : @[dut.scala 29:35]
      node _curCredit_T = eq(curCredit, UInt<3>("h5")) @[dut.scala 30:32]
      node _curCredit_T_1 = add(curCredit, UInt<1>("h1")) @[dut.scala 30:70]
      node _curCredit_T_2 = tail(_curCredit_T_1, 1) @[dut.scala 30:70]
      node _curCredit_T_3 = mux(_curCredit_T, curCredit, _curCredit_T_2) @[dut.scala 30:21]
      curCredit <= _curCredit_T_3 @[dut.scala 30:15]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(icredit, UInt<1>("h0")) @[dut.scala 31:32]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 31:29]
      when _T_5 : @[dut.scala 31:42]
        node _curCredit_T_4 = eq(curCredit, UInt<1>("h0")) @[dut.scala 32:32]
        node _curCredit_T_5 = sub(curCredit, UInt<1>("h1")) @[dut.scala 32:62]
        node _curCredit_T_6 = tail(_curCredit_T_5, 1) @[dut.scala 32:62]
        node _curCredit_T_7 = mux(_curCredit_T_4, curCredit, _curCredit_T_6) @[dut.scala 32:21]
        curCredit <= _curCredit_T_7 @[dut.scala 32:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 36:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 36:16]
    node _T_6 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_6 : @[dut.scala 39:23]
      dataOut <= io.enq.bits @[dut.scala 40:13]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _validOut_T_1 = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 42:33]
    node _validOut_T_2 = and(_validOut_T_1, validOut) @[dut.scala 42:47]
    node _validOut_T_3 = or(_validOut_T, _validOut_T_2) @[dut.scala 42:29]
    validOut <= _validOut_T_3 @[dut.scala 42:12]
    io.deq.valid <= validOut @[dut.scala 45:16]
    io.deq.bits <= dataOut @[dut.scala 46:15]
    io.curCredit <= curCredit @[dut.scala 49:16]

