circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:26]
    io.curCredit <= curCredit @[dut.scala 21:16]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 27:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:25]
    io.deq.valid <= validOut @[dut.scala 31:16]
    io.deq.bits <= dataOut @[dut.scala 32:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 35:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 35:16]
    icredit <= io.deq.credit @[dut.scala 38:11]
    node _T = eq(validOut, UInt<1>("h0")) @[dut.scala 41:25]
    node _T_1 = and(io.deq.credit, _T) @[dut.scala 41:22]
    when _T_1 : @[dut.scala 41:36]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 42:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 42:28]
      curCredit <= _curCredit_T_1 @[dut.scala 42:15]
    node _T_2 = and(io.enq.valid, io.enq.ready) @[dut.scala 44:21]
    when _T_2 : @[dut.scala 44:38]
      node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 45:28]
      node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 45:28]
      curCredit <= _curCredit_T_3 @[dut.scala 45:15]
    node _T_3 = and(io.enq.valid, io.enq.ready) @[dut.scala 49:21]
    when _T_3 : @[dut.scala 49:38]
      dataOut <= io.enq.bits @[dut.scala 50:13]
      validOut <= UInt<1>("h1") @[dut.scala 51:14]
    else :
      when io.deq.credit : @[dut.scala 52:29]
        validOut <= UInt<1>("h0") @[dut.scala 53:14]


