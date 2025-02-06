circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (UInt<1>("h0"), icredit) @[dut.scala 20:20]
    reg icredit_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:21]
    icredit_REG <= io.deq.credit @[dut.scala 21:21]
    icredit <= icredit_REG @[dut.scala 21:11]
    reg creditCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 24:30]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 26:26]
    node _T_2 = and(io.deq.credit, _T_1) @[dut.scala 26:23]
    when _T_2 : @[dut.scala 26:40]
      node _creditCounter_T = add(creditCounter, UInt<1>("h1")) @[dut.scala 27:36]
      node _creditCounter_T_1 = tail(_creditCounter_T, 1) @[dut.scala 27:36]
      creditCounter <= _creditCounter_T_1 @[dut.scala 27:19]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 28:30]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 28:27]
      when _T_5 : @[dut.scala 28:46]
        node _creditCounter_T_2 = sub(creditCounter, UInt<1>("h1")) @[dut.scala 29:36]
        node _creditCounter_T_3 = tail(_creditCounter_T_2, 1) @[dut.scala 29:36]
        creditCounter <= _creditCounter_T_3 @[dut.scala 29:19]
    io.curCredit <= creditCounter @[dut.scala 32:16]
    node _io_enq_ready_T = gt(creditCounter, UInt<1>("h0")) @[dut.scala 35:33]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 35:16]
    wire _dataOut_WIRE : UInt<8> @[dut.scala 38:52]
    _dataOut_WIRE <= UInt<1>("h0") @[dut.scala 38:52]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt, clock with :
      reset => (reset, _dataOut_WIRE) @[Reg.scala 35:20]
    when _dataOut_T : @[Reg.scala 36:18]
      dataOut <= io.enq.bits @[Reg.scala 36:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:25]
    validOut <= _validOut_T @[dut.scala 39:25]
    io.deq.bits <= dataOut @[dut.scala 42:15]
    io.deq.valid <= validOut @[dut.scala 43:16]
    node _T_6 = eq(validOut, UInt<1>("h0")) @[dut.scala 46:9]
    node _T_7 = and(_T_6, io.deq.credit) @[dut.scala 46:19]
    when _T_7 : @[dut.scala 46:37]
      validOut <= UInt<1>("h0") @[dut.scala 47:14]


