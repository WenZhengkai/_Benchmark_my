circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg creditReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:26]
    creditReg <= io.deq.credit @[dut.scala 22:26]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 25:26]
    node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 27:25]
    node _T_1 = and(io.deq.credit, _T) @[dut.scala 27:22]
    when _T_1 : @[dut.scala 27:40]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 29:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 29:28]
      curCredit <= _curCredit_T_1 @[dut.scala 29:15]
    else :
      node _T_2 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 30:30]
      node _T_3 = and(io.deq.valid, _T_2) @[dut.scala 30:27]
      when _T_3 : @[dut.scala 30:46]
        node _T_4 = gt(curCredit, UInt<1>("h0")) @[dut.scala 32:20]
        when _T_4 : @[dut.scala 32:27]
          node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 33:30]
          node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 33:30]
          curCredit <= _curCredit_T_3 @[dut.scala 33:17]
    io.curCredit <= curCredit @[dut.scala 37:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 40:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 40:16]
    wire _dataOut_WIRE : UInt<8> @[dut.scala 43:52]
    _dataOut_WIRE <= UInt<1>("h0") @[dut.scala 43:52]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt, clock with :
      reset => (reset, _dataOut_WIRE) @[Reg.scala 35:20]
    when _dataOut_T : @[Reg.scala 36:18]
      dataOut <= io.enq.bits @[Reg.scala 36:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 44:25]
    validOut <= _validOut_T @[dut.scala 44:25]
    io.deq.bits <= dataOut @[dut.scala 47:15]
    io.deq.valid <= validOut @[dut.scala 48:16]
    node _T_5 = and(io.deq.valid, io.deq.credit) @[dut.scala 51:21]
    when _T_5 : @[dut.scala 51:39]
      node _curCredit_T_4 = add(curCredit, UInt<1>("h1")) @[dut.scala 52:28]
      node _curCredit_T_5 = tail(_curCredit_T_4, 1) @[dut.scala 52:28]
      curCredit <= _curCredit_T_5 @[dut.scala 52:15]
    node _T_6 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_7 = neq(curCredit, UInt<1>("h0")) @[dut.scala 56:35]
    node _T_8 = and(_T_6, _T_7) @[dut.scala 56:22]
    when _T_8 : @[dut.scala 56:44]
      node _curCredit_T_6 = sub(curCredit, UInt<1>("h1")) @[dut.scala 57:28]
      node _curCredit_T_7 = tail(_curCredit_T_6, 1) @[dut.scala 57:28]
      curCredit <= _curCredit_T_7 @[dut.scala 57:15]


