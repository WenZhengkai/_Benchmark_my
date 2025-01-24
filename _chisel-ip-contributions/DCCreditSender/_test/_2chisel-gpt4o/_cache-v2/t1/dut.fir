circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:26]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 24:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:25]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 28:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 28:16]
    io.deq.bits <= dataOut @[dut.scala 31:15]
    io.deq.valid <= validOut @[dut.scala 32:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 35:23]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 37:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 37:28]
      curCredit <= _curCredit_T_1 @[dut.scala 37:15]
      validOut <= UInt<1>("h1") @[dut.scala 38:14]
      dataOut <= io.enq.bits @[dut.scala 39:13]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 41:14]
    node _T_1 = eq(io.enq.ready, UInt<1>("h0")) @[dut.scala 44:25]
    node _T_2 = and(io.deq.credit, _T_1) @[dut.scala 44:22]
    when _T_2 : @[dut.scala 44:40]
      node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 46:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 46:28]
      curCredit <= _curCredit_T_3 @[dut.scala 46:15]
    io.curCredit <= curCredit @[dut.scala 50:16]

