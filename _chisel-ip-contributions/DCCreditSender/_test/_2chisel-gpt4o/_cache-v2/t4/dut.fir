circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:29]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    icredit <= io.deq.credit @[dut.scala 23:24]
    node _io_enq_ready_T = gt(curCreditReg, UInt<1>("h0")) @[dut.scala 26:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 26:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:25]
    validOut <= _validOut_T @[dut.scala 30:25]
    io.deq.bits <= dataOut @[dut.scala 33:15]
    io.deq.valid <= validOut @[dut.scala 34:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 37:25]
    node _T_2 = and(_T, _T_1) @[dut.scala 37:22]
    when _T_2 : @[dut.scala 37:41]
      node _curCreditReg_T = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 39:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 39:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 39:18]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 40:14]
      node _T_5 = and(_T_4, io.deq.credit) @[dut.scala 40:29]
      when _T_5 : @[dut.scala 40:47]
        node _curCreditReg_T_2 = add(curCreditReg, UInt<1>("h1")) @[dut.scala 42:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 42:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 42:18]
    io.curCredit <= curCreditReg @[dut.scala 46:16]

