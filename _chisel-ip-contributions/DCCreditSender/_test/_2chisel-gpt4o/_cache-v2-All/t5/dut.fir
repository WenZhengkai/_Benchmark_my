circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg curCredit : UInt<3>, clock with :
      reset => (reset, UInt<3>("h5")) @[dut.scala 21:26]
    wire _dataOut_WIRE : UInt<8> @[dut.scala 22:37]
    _dataOut_WIRE <= UInt<1>("h0") @[dut.scala 22:37]
    reg dataOut : UInt, clock with :
      reset => (reset, _dataOut_WIRE) @[dut.scala 22:24]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:25]
    icredit <= io.deq.credit @[dut.scala 26:11]
    node _T = eq(io.enq.ready, UInt<1>("h0")) @[dut.scala 29:25]
    node _T_1 = and(io.deq.credit, _T) @[dut.scala 29:22]
    when _T_1 : @[dut.scala 29:40]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[dut.scala 31:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[dut.scala 31:28]
      curCredit <= _curCredit_T_1 @[dut.scala 31:15]
    else :
      node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      when _T_2 : @[dut.scala 32:30]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[dut.scala 34:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[dut.scala 34:28]
        curCredit <= _curCredit_T_3 @[dut.scala 34:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[dut.scala 38:29]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 38:16]
    node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T_3 : @[dut.scala 41:23]
      dataOut <= io.enq.bits @[dut.scala 42:13]
      validOut <= UInt<1>("h1") @[dut.scala 43:14]
    else :
      when io.deq.credit : @[dut.scala 44:30]
        validOut <= UInt<1>("h0") @[dut.scala 45:14]
    io.deq.valid <= validOut @[dut.scala 49:16]
    io.deq.bits <= dataOut @[dut.scala 50:15]
    io.curCredit <= curCredit @[dut.scala 53:16]

