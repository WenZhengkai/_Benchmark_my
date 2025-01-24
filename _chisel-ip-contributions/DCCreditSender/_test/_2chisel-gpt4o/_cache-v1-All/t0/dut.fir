circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 22:29]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 23:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:25]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:24]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 28:22]
    node _T_1 = and(io.credit, _T) @[dut.scala 28:19]
    when _T_1 : @[dut.scala 28:37]
      node _curCreditReg_T = add(curCreditReg, UInt<1>("h1")) @[dut.scala 29:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 29:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 29:18]
    else :
      node _T_2 = eq(io.credit, UInt<1>("h0")) @[dut.scala 30:16]
      node _T_3 = and(_T_2, io.deq.valid) @[dut.scala 30:27]
      when _T_3 : @[dut.scala 30:44]
        node _curCreditReg_T_2 = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 31:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 31:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 31:18]
    node _io_enq_ready_T = gt(curCreditReg, UInt<1>("h0")) @[dut.scala 35:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 35:16]
    node _T_4 = and(io.enq.valid, io.enq.ready) @[dut.scala 38:22]
    when _T_4 : @[dut.scala 38:39]
      dataOut <= io.enq.bits @[dut.scala 39:13]
      validOut <= UInt<1>("h1") @[dut.scala 40:14]
    else :
      node _T_5 = eq(validOut, UInt<1>("h0")) @[dut.scala 41:16]
      node _T_6 = or(_T_5, io.credit) @[dut.scala 41:26]
      when _T_6 : @[dut.scala 41:40]
        validOut <= UInt<1>("h0") @[dut.scala 42:14]
    io.deq.bits <= dataOut @[dut.scala 46:15]
    io.deq.valid <= validOut @[dut.scala 47:16]
    icredit <= io.credit @[dut.scala 48:11]
    io.curCredit <= curCreditReg @[dut.scala 49:16]

