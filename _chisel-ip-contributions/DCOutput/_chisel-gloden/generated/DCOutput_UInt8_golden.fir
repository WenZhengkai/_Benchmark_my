circuit DCOutput_UInt8_golden :
  module DCOutput_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg rValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 18:23]
    node _io_enq_ready_T = eq(rValid, UInt<1>("h0")) @[golden.scala 20:35]
    node _io_enq_ready_T_1 = or(io.deq.ready, _io_enq_ready_T) @[golden.scala 20:32]
    io.enq.ready <= _io_enq_ready_T_1 @[golden.scala 20:16]
    node _rValid_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _rValid_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[golden.scala 21:39]
    node _rValid_T_2 = and(rValid, _rValid_T_1) @[golden.scala 21:36]
    node _rValid_T_3 = or(_rValid_T, _rValid_T_2) @[golden.scala 21:25]
    rValid <= _rValid_T_3 @[golden.scala 21:10]
    node _io_deq_bits_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    reg io_deq_bits_r : UInt<8>, clock with :
      reset => (UInt<1>("h0"), io_deq_bits_r) @[Reg.scala 19:16]
    when _io_deq_bits_T : @[Reg.scala 20:18]
      io_deq_bits_r <= io.enq.bits @[Reg.scala 20:22]
    io.deq.bits <= io_deq_bits_r @[golden.scala 22:15]
    io.deq.valid <= rValid @[golden.scala 23:16]

