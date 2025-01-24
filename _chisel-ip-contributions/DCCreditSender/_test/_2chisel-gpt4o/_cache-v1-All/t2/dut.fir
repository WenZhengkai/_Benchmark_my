circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 22:29]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:24]
    icredit <= io.credit @[dut.scala 24:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 26:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:25]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 34:21]
    node _T_1 = and(io.credit, _T) @[dut.scala 34:18]
    when _T_1 : @[dut.scala 34:36]
      node _curCreditReg_T = add(curCreditReg, UInt<1>("h1")) @[dut.scala 35:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 35:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 35:18]
    else :
      node _T_2 = eq(io.credit, UInt<1>("h0")) @[dut.scala 36:30]
      node _T_3 = and(io.deq.valid, _T_2) @[dut.scala 36:27]
      when _T_3 : @[dut.scala 36:42]
        node _curCreditReg_T_2 = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 37:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 37:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 37:18]
    node _io_enq_ready_T = gt(curCreditReg, UInt<1>("h0")) @[dut.scala 42:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 42:16]
    node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_4 : @[dut.scala 47:23]
      dataOut <= io.enq.bits @[dut.scala 48:13]
      validOut <= UInt<1>("h1") @[dut.scala 49:14]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 51:14]
    io.deq.bits <= dataOut @[dut.scala 59:15]
    io.deq.valid <= validOut @[dut.scala 60:16]
    io.curCredit <= curCreditReg @[dut.scala 61:16]

