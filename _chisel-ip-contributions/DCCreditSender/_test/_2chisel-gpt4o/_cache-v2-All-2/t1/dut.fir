circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    icredit <= io.deq.credit @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 23:26]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 24:19]
    node _T_2 = and(icredit, _T_1) @[dut.scala 24:16]
    when _T_2 : @[dut.scala 24:35]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 25:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 25:28]
      curCredit <= _curCredit_T_1 @[dut.scala 25:15]
    else :
      node _T_3 = eq(icredit, UInt<1>("h0")) @[dut.scala 26:15]
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = and(_T_3, _T_4) @[dut.scala 26:24]
      when _T_5 : @[dut.scala 26:42]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 27:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 27:28]
        curCredit <= _curCredit_T_3 @[dut.scala 27:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 31:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 31:16]
    wire _dataOut_WIRE : UInt<8> @[dut.scala 34:52]
    _dataOut_WIRE <= UInt<1>("h0") @[dut.scala 34:52]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt, clock with :
      reset => (reset, _dataOut_WIRE) @[Reg.scala 35:20]
    when _dataOut_T : @[Reg.scala 36:18]
      dataOut <= io.enq.bits @[Reg.scala 36:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:25]
    validOut <= _validOut_T @[dut.scala 35:25]
    io.deq.bits <= dataOut @[dut.scala 38:15]
    io.deq.valid <= validOut @[dut.scala 39:16]
    io.curCredit <= curCredit @[dut.scala 42:16]

