circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 20:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 23:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:25]
    wire iCredit : UInt<1> @[dut.scala 27:21]
    iCredit <= io.deq.credit @[dut.scala 28:11]
    io.deq.bits <= dataOut @[dut.scala 31:15]
    io.deq.valid <= validOut @[dut.scala 32:16]
    io.curCredit <= curCredit @[dut.scala 33:16]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 36:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 36:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 38:23]
      node _curCredit_T = sub(curCredit, UInt<1>("h1")) @[dut.scala 40:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 40:28]
      curCredit <= _curCredit_T_1 @[dut.scala 40:15]
      dataOut <= io.enq.bits @[dut.scala 41:13]
      validOut <= UInt<1>("h1") @[dut.scala 42:14]
    else :
      node _T_1 = eq(validOut, UInt<1>("h0")) @[dut.scala 43:25]
      node _T_2 = and(iCredit, _T_1) @[dut.scala 43:22]
      when _T_2 : @[dut.scala 43:36]
        node _curCredit_T_2 = add(curCredit, UInt<1>("h1")) @[dut.scala 45:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 45:28]
        curCredit <= _curCredit_T_3 @[dut.scala 45:15]
    node _T_3 = and(io.deq.credit, validOut) @[dut.scala 49:22]
    when _T_3 : @[dut.scala 49:35]
      validOut <= UInt<1>("h0") @[dut.scala 51:14]


