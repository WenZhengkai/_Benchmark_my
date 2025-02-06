circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:29]
    node _T = or(icredit, io.deq.credit) @[dut.scala 24:17]
    when _T : @[dut.scala 24:35]
      icredit <= io.deq.credit @[dut.scala 25:13]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_2 = eq(icredit, UInt<1>("h0")) @[dut.scala 29:23]
    node _T_3 = and(_T_1, _T_2) @[dut.scala 29:20]
    when _T_3 : @[dut.scala 29:33]
      node _curCreditReg_T = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 31:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 31:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 31:18]
    else :
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = eq(_T_4, UInt<1>("h0")) @[dut.scala 32:26]
      node _T_6 = and(icredit, _T_5) @[dut.scala 32:23]
      when _T_6 : @[dut.scala 32:40]
        node _curCreditReg_T_2 = add(curCreditReg, UInt<1>("h1")) @[dut.scala 34:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 34:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 34:18]
    io.curCredit <= curCreditReg @[dut.scala 38:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:25]
    validOut <= _validOut_T @[dut.scala 42:25]
    io.deq.bits <= dataOut @[dut.scala 45:15]
    io.deq.valid <= validOut @[dut.scala 46:16]
    node _io_enq_ready_T = gt(curCreditReg, UInt<1>("h0")) @[dut.scala 49:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 49:16]

