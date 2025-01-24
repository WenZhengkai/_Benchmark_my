circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 24:26]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[dut.scala 27:20]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:25]
    when io.deq.credit : @[dut.scala 31:23]
      icredit <= UInt<1>("h1") @[dut.scala 32:13]
    else :
      icredit <= UInt<1>("h0") @[dut.scala 34:13]
    node _T = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 38:25]
    node _T_1 = and(io.deq.credit, _T) @[dut.scala 38:22]
    when _T_1 : @[dut.scala 38:40]
      node _T_2 = neq(curCredit, UInt<3>("h5")) @[dut.scala 39:20]
      when _T_2 : @[dut.scala 39:37]
        node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 40:30]
        node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 40:30]
        curCredit <= _curCredit_T_1 @[dut.scala 40:17]
    else :
      node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      when _T_3 : @[dut.scala 42:30]
        node _T_4 = neq(curCredit, UInt<1>("h0")) @[dut.scala 43:20]
        when _T_4 : @[dut.scala 43:29]
          node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 44:30]
          node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 44:30]
          curCredit <= _curCredit_T_3 @[dut.scala 44:17]
    node _io_enq_ready_T = neq(curCredit, UInt<1>("h0")) @[dut.scala 49:30]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 49:16]
    node _T_5 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_5 : @[dut.scala 52:23]
      dataOut <= io.enq.bits @[dut.scala 53:13]
      validOut <= UInt<1>("h1") @[dut.scala 54:14]
    else :
      when io.deq.credit : @[dut.scala 55:30]
        validOut <= UInt<1>("h0") @[dut.scala 56:14]
    io.deq.valid <= validOut @[dut.scala 60:16]
    io.deq.bits <= dataOut @[dut.scala 61:15]
    io.curCredit <= curCredit @[dut.scala 64:16]

