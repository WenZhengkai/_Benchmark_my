circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg rValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 11:23]
    node _io_enq_ready_T = eq(rValid, UInt<1>("h0")) @[dut.scala 14:35]
    node _io_enq_ready_T_1 = or(io.deq.ready, _io_enq_ready_T) @[dut.scala 14:32]
    io.enq.ready <= _io_enq_ready_T_1 @[dut.scala 14:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 17:24]
      rValid <= UInt<1>("h1") @[dut.scala 18:12]
    else :
      when io.deq.ready : @[dut.scala 19:30]
        rValid <= UInt<1>("h0") @[dut.scala 20:12]
    node _io_deq_bits_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg io_deq_bits_r : UInt<8>, clock with :
      reset => (UInt<1>("h0"), io_deq_bits_r) @[Reg.scala 19:16]
    when _io_deq_bits_T : @[Reg.scala 20:18]
      io_deq_bits_r <= io.enq.bits @[Reg.scala 20:22]
    io.deq.bits <= io_deq_bits_r @[dut.scala 24:15]
    io.deq.valid <= rValid @[dut.scala 27:16]

