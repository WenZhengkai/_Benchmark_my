circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 24:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 25:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:25]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:24]
    icredit <= io.credit @[dut.scala 29:24]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 32:29]
    node _io_enq_ready_T_1 = eq(validOut, UInt<1>("h0")) @[dut.scala 32:38]
    node _io_enq_ready_T_2 = and(_io_enq_ready_T, _io_enq_ready_T_1) @[dut.scala 32:35]
    io.enq.ready <= _io_enq_ready_T_2 @[dut.scala 32:16]
    node _T = eq(icredit, UInt<1>("h0")) @[dut.scala 35:21]
    node _T_1 = and(io.credit, _T) @[dut.scala 35:18]
    when _T_1 : @[dut.scala 35:31]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 36:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 36:28]
      curCredit <= _curCredit_T_1 @[dut.scala 36:15]
    node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 39:23]
      node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 40:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 40:28]
      curCredit <= _curCredit_T_3 @[dut.scala 40:15]
    node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_3 : @[dut.scala 44:23]
      dataOut <= io.enq.bits @[dut.scala 45:13]
      validOut <= UInt<1>("h1") @[dut.scala 46:14]
    else :
      when io.deq.credit : @[dut.scala 47:29]
        validOut <= UInt<1>("h0") @[dut.scala 48:14]
    io.deq.valid <= validOut @[dut.scala 52:16]
    io.deq.bits <= dataOut @[dut.scala 53:15]
    io.curCredit <= curCredit @[dut.scala 56:16]

