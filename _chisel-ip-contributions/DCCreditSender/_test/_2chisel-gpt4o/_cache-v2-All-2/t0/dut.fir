circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    icredit <= io.deq.credit @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 23:26]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 25:19]
    node _T_1 = and(icredit, _T) @[dut.scala 25:16]
    when _T_1 : @[dut.scala 25:34]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 26:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 26:28]
      curCredit <= _curCredit_T_1 @[dut.scala 26:15]
    else :
      node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_3 = eq(icredit, UInt<1>("h0")) @[dut.scala 27:30]
      node _T_4 = and(_T_2, _T_3) @[dut.scala 27:27]
      when _T_4 : @[dut.scala 27:40]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 28:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 28:28]
        curCredit <= _curCredit_T_3 @[dut.scala 28:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 32:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 32:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), validOut) @[dut.scala 36:25]
    validOut <= _validOut_T @[dut.scala 36:25]
    io.deq.bits <= dataOut @[dut.scala 39:15]
    io.deq.valid <= validOut @[dut.scala 40:16]
    io.curCredit <= curCredit @[dut.scala 41:16]

