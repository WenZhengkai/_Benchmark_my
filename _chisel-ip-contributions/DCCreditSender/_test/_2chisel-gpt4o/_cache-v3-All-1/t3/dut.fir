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
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 25:21]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 26:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 26:28]
      curCredit <= _curCredit_T_1 @[dut.scala 26:15]
    else :
      when icredit : @[dut.scala 27:23]
        node _curCredit_T_2 = eq(curCredit, UInt<3>("h5")) @[dut.scala 28:32]
        node _curCredit_T_3 = add(curCredit, UInt<1>("h1")) @[dut.scala 28:70]
        node _curCredit_T_4 = tail(_curCredit_T_3, 1) @[dut.scala 28:70]
        node _curCredit_T_5 = mux(_curCredit_T_2, curCredit, _curCredit_T_4) @[dut.scala 28:21]
        curCredit <= _curCredit_T_5 @[dut.scala 28:15]
    io.curCredit <= curCredit @[dut.scala 31:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 34:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 34:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 38:25]
    validOut <= _validOut_T @[dut.scala 38:25]
    io.deq.valid <= validOut @[dut.scala 41:16]
    io.deq.bits <= dataOut @[dut.scala 42:15]

