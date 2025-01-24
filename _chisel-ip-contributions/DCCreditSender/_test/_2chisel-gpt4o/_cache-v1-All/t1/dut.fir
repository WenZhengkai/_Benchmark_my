circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:29]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 23:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:25]
    node _T = eq(validOut, UInt<1>("h0")) @[dut.scala 27:21]
    node _T_1 = and(io.credit, _T) @[dut.scala 27:18]
    when _T_1 : @[dut.scala 27:32]
      node _curCreditReg_T = add(curCreditReg, UInt<1>("h1")) @[dut.scala 29:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 29:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 29:18]
    else :
      node _T_2 = eq(io.credit, UInt<1>("h0")) @[dut.scala 30:27]
      node _T_3 = and(validOut, _T_2) @[dut.scala 30:24]
      when _T_3 : @[dut.scala 30:39]
        node _curCreditReg_T_2 = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 32:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 32:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 32:18]
    node _io_enq_ready_T = gt(curCreditReg, UInt<1>("h0")) @[dut.scala 36:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 36:16]
    node _T_4 = and(io.enq.valid, io.enq.ready) @[dut.scala 39:21]
    when _T_4 : @[dut.scala 39:38]
      dataOut <= io.enq.bits @[dut.scala 40:13]
      validOut <= UInt<1>("h1") @[dut.scala 41:14]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 43:14]
    io.deq.bits <= dataOut @[dut.scala 47:15]
    io.deq.valid <= validOut @[dut.scala 48:16]
    io.curCredit <= curCreditReg @[dut.scala 49:16]
    icredit <= io.credit @[dut.scala 52:11]

