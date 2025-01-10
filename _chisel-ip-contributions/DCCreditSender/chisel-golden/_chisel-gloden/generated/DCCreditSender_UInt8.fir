circuit DCCreditSender_UInt8 :
  module DCCreditSender_UInt8 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, curCredit : UInt<3>}

    reg icredit : UInt<1>, clock with :
      reset => (UInt<1>("h0"), icredit) @[golden.scala 27:24]
    icredit <= io.deq.credit @[golden.scala 27:24]
    reg curCredit : UInt, clock with :
      reset => (reset, UInt<3>("h5")) @[golden.scala 28:26]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[golden.scala 29:19]
    node _T_2 = and(icredit, _T_1) @[golden.scala 29:16]
    when _T_2 : @[golden.scala 29:33]
      node _curCredit_T = add(curCredit, UInt<1>("h1")) @[golden.scala 30:28]
      node _curCredit_T_1 = tail(_curCredit_T, 1) @[golden.scala 30:28]
      curCredit <= _curCredit_T_1 @[golden.scala 30:15]
    else :
      node _T_3 = eq(icredit, UInt<1>("h0")) @[golden.scala 31:14]
      node _T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _T_5 = and(_T_3, _T_4) @[golden.scala 31:23]
      when _T_5 : @[golden.scala 31:39]
        node _curCredit_T_2 = sub(curCredit, UInt<1>("h1")) @[golden.scala 32:28]
        node _curCredit_T_3 = tail(_curCredit_T_2, 1) @[golden.scala 32:28]
        curCredit <= _curCredit_T_3 @[golden.scala 32:15]
    node _io_enq_ready_T = gt(curCredit, UInt<1>("h0")) @[golden.scala 34:29]
    io.enq.ready <= _io_enq_ready_T @[golden.scala 34:16]
    node _dataOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg dataOut : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[Reg.scala 19:16]
    when _dataOut_T : @[Reg.scala 20:18]
      dataOut <= io.enq.bits @[Reg.scala 20:22]
    node _validOut_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 36:25]
    validOut <= _validOut_T @[golden.scala 36:25]
    io.deq.valid <= validOut @[golden.scala 37:16]
    io.deq.bits <= dataOut @[golden.scala 38:15]
    io.curCredit <= curCredit @[golden.scala 39:16]

