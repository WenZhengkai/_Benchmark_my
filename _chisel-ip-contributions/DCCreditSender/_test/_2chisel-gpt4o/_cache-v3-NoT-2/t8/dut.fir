circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    icredit <= io.deq.credit @[dut.scala 24:11]
    reg curCreditReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 28:29]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(icredit, UInt<1>("h0")) @[dut.scala 31:24]
    node _T_2 = and(_T, _T_1) @[dut.scala 31:21]
    when _T_2 : @[dut.scala 31:34]
      node _curCreditReg_T = sub(curCreditReg, UInt<1>("h1")) @[dut.scala 33:34]
      node _curCreditReg_T_1 = tail(_curCreditReg_T, 1) @[dut.scala 33:34]
      curCreditReg <= _curCreditReg_T_1 @[dut.scala 33:18]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 34:27]
      node _T_5 = and(icredit, _T_4) @[dut.scala 34:24]
      when _T_5 : @[dut.scala 34:41]
        node _curCreditReg_T_2 = add(curCreditReg, UInt<1>("h1")) @[dut.scala 36:34]
        node _curCreditReg_T_3 = tail(_curCreditReg_T_2, 1) @[dut.scala 36:34]
        curCreditReg <= _curCreditReg_T_3 @[dut.scala 36:18]
    node _curCreditReg_T_4 = lt(curCreditReg, UInt<1>("h0")) @[dut.scala 40:35]
    node _curCreditReg_T_5 = mux(_curCreditReg_T_4, UInt<1>("h0"), curCreditReg) @[dut.scala 40:35]
    node _curCreditReg_T_6 = lt(_curCreditReg_T_5, UInt<3>("h5")) @[dut.scala 40:44]
    node _curCreditReg_T_7 = mux(_curCreditReg_T_6, _curCreditReg_T_5, UInt<3>("h5")) @[dut.scala 40:44]
    curCreditReg <= _curCreditReg_T_7 @[dut.scala 40:16]
    io.curCredit <= curCreditReg @[dut.scala 41:16]
    node _io_enq_ready_T = gt(curCreditReg, UInt<1>("h0")) @[dut.scala 45:32]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 45:16]
    wire _dataOut_WIRE : UInt<8> @[dut.scala 49:52]
    _dataOut_WIRE <= UInt<1>("h0") @[dut.scala 49:52]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt, clock with :
      reset => (reset, _dataOut_WIRE) @[Reg.scala 35:20]
    when _dataOut_T : @[Reg.scala 36:18]
      dataOut <= io.enq.bits @[Reg.scala 36:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 50:25]
    validOut <= _validOut_T @[dut.scala 50:25]
    io.deq.valid <= validOut @[dut.scala 53:16]
    io.deq.bits <= dataOut @[dut.scala 54:15]

