circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg rValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    node _rData_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg rData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), rData) @[Reg.scala 19:16]
    when _rData_T : @[Reg.scala 20:18]
      rData <= io.enq.bits @[Reg.scala 20:22]
    node _io_enq_ready_T = eq(rValid, UInt<1>("h0")) @[dut.scala 17:35]
    node _io_enq_ready_T_1 = or(io.deq.ready, _io_enq_ready_T) @[dut.scala 17:32]
    io.enq.ready <= _io_enq_ready_T_1 @[dut.scala 17:16]
    when io.deq.ready : @[dut.scala 20:22]
      node _rValid_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _rValid_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 21:40]
      node _rValid_T_2 = and(rValid, _rValid_T_1) @[dut.scala 21:37]
      node _rValid_T_3 = or(_rValid_T, _rValid_T_2) @[dut.scala 21:27]
      rValid <= _rValid_T_3 @[dut.scala 21:12]
    else :
      node _rValid_T_4 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      node _rValid_T_5 = or(rValid, _rValid_T_4) @[dut.scala 23:22]
      rValid <= _rValid_T_5 @[dut.scala 23:12]
    io.deq.valid <= rValid @[dut.scala 27:16]
    io.deq.bits <= rData @[dut.scala 28:15]

