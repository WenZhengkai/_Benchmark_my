circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, flip credit : UInt<1>, curCredit : UInt<3>}

    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:26]
    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 24:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:25]
    when io.credit : @[dut.scala 28:19]
      node _T = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 29:10]
      node _T_1 = and(io.deq.valid, io.deq.credit) @[dut.scala 29:41]
      node _T_2 = or(_T, _T_1) @[dut.scala 29:24]
      when _T_2 : @[dut.scala 29:60]
        node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 30:30]
        node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 30:30]
        curCredit <= _curCredit_T_1 @[dut.scala 30:17]
      else :
        node _T_3 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 31:32]
        node _T_4 = and(io.deq.valid, _T_3) @[dut.scala 31:29]
        when _T_4 : @[dut.scala 31:48]
          curCredit <= curCredit @[dut.scala 32:17]
    else :
      node _T_5 = eq(io.deq.credit, UInt<1>("h0")) @[dut.scala 35:26]
      node _T_6 = and(io.deq.valid, _T_5) @[dut.scala 35:23]
      when _T_6 : @[dut.scala 35:42]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 36:30]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 36:30]
        curCredit <= _curCredit_T_3 @[dut.scala 36:17]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 41:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 41:16]
    node _T_7 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_7 : @[dut.scala 44:23]
      dataOut <= io.enq.bits @[dut.scala 45:13]
      validOut <= UInt<1>("h1") @[dut.scala 46:14]
    else :
      when io.deq.credit : @[dut.scala 48:25]
        validOut <= UInt<1>("h0") @[dut.scala 49:16]
    io.deq.bits <= dataOut @[dut.scala 54:15]
    io.deq.valid <= validOut @[dut.scala 55:16]
    icredit <= io.credit @[dut.scala 56:11]
    io.curCredit <= curCredit @[dut.scala 59:16]

