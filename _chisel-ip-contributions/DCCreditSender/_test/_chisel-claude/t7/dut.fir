circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg creditCount : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 24:28]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:24]
    icredit <= io.deq.credit @[dut.scala 27:24]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 33:25]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 34:23]
      validOut <= UInt<1>("h1") @[dut.scala 35:14]
    else :
      when icredit : @[dut.scala 36:23]
        validOut <= UInt<1>("h0") @[dut.scala 37:14]
    node _creditIncr_T = eq(validOut, UInt<1>("h0")) @[dut.scala 41:31]
    node creditIncr = and(icredit, _creditIncr_T) @[dut.scala 41:28]
    node creditDecr = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(creditDecr, UInt<1>("h0")) @[dut.scala 44:22]
    node _T_2 = and(creditIncr, _T_1) @[dut.scala 44:19]
    when _T_2 : @[dut.scala 44:35]
      node _creditCount_T = add(creditCount, UInt<1>("h1")) @[dut.scala 45:32]
      node _creditCount_T_1 = tail(_creditCount_T, 1) @[dut.scala 45:32]
      creditCount <= _creditCount_T_1 @[dut.scala 45:17]
    else :
      node _T_3 = eq(creditIncr, UInt<1>("h0")) @[dut.scala 46:14]
      node _T_4 = and(_T_3, creditDecr) @[dut.scala 46:26]
      when _T_4 : @[dut.scala 46:41]
        node _creditCount_T_2 = sub(creditCount, UInt<1>("h1")) @[dut.scala 47:32]
        node _creditCount_T_3 = tail(_creditCount_T_2, 1) @[dut.scala 47:32]
        creditCount <= _creditCount_T_3 @[dut.scala 47:17]
    node _io_enq_ready_T = gt(creditCount, UInt<1>("h0")) @[dut.scala 51:31]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 51:16]
    io.deq.valid <= validOut @[dut.scala 54:16]
    io.deq.bits <= dataOut @[dut.scala 55:15]
    io.curCredit <= creditCount @[dut.scala 56:16]

