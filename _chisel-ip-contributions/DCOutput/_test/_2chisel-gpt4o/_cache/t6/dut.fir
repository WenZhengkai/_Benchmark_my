circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg rValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    node _io_enq_ready_T = eq(rValid, UInt<1>("h0")) @[dut.scala 15:19]
    node _io_enq_ready_T_1 = or(_io_enq_ready_T, io.deq.ready) @[dut.scala 15:27]
    io.enq.ready <= _io_enq_ready_T_1 @[dut.scala 15:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 19:21]
      rValid <= UInt<1>("h1") @[dut.scala 20:12]
    else :
      when io.deq.ready : @[dut.scala 21:29]
        rValid <= UInt<1>("h0") @[dut.scala 22:12]
    node _rData_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg rData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), rData) @[Reg.scala 19:16]
    when _rData_T : @[Reg.scala 20:18]
      rData <= io.enq.bits @[Reg.scala 20:22]
    io.deq.bits <= rData @[dut.scala 30:15]
    io.deq.valid <= rValid @[dut.scala 31:16]

