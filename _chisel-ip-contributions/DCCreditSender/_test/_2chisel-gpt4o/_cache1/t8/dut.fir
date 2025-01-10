circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:29]
    io.curCredit <= curCreditReg @[dut.scala 22:16]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 25:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:25]
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 29:21]
    when _T : @[dut.scala 29:38]
      dataOut <= io.enq.bits @[dut.scala 30:13]
      validOut <= UInt<1>("h1") @[dut.scala 31:14]
    else :
      when io.deq.credit : @[dut.scala 32:29]
        validOut <= UInt<1>("h0") @[dut.scala 33:14]
    node _io_enq_ready_T = neq(curCreditReg, UInt<1>("h0")) @[dut.scala 37:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 37:16]
    io.deq.bits <= dataOut @[dut.scala 38:15]
    io.deq.valid <= validOut @[dut.scala 39:16]
    node _T_1 = eq(validOut, UInt<1>("h0")) @[dut.scala 42:21]
    node _T_2 = and(io.credit, _T_1) @[dut.scala 42:18]
    when _T_2 : @[dut.scala 42:32]
      node _curCreditReg_T = add(curCreditReg, UInt<1>("h1")) @[dut.scala 44:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 44:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 44:18]
    else :
      node _T_3 = eq(io.credit, UInt<1>("h0")) @[dut.scala 45:26]
      node _T_4 = and(validOut, _T_3) @[dut.scala 45:23]
      when _T_4 : @[dut.scala 45:38]
        node _curCreditReg_T_2 = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 47:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 47:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 47:18]


