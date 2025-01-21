circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 11:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 12:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[dut.scala 13:17]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 16:27]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 16:42]
    node _load_T_2 = or(_load_T_1, occupied) @[dut.scala 16:56]
    node load = and(_load_T, _load_T_2) @[dut.scala 16:38]
    node drain = and(occupied, io.deq.ready) @[dut.scala 17:24]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 20:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 20:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 21:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 21:16]
    when load : @[dut.scala 24:14]
      ready_r <= UInt<1>("h0") @[dut.scala 25:13]
      occupied <= UInt<1>("h1") @[dut.scala 26:14]
      hold <= io.enq.bits @[dut.scala 27:10]
    else :
      when drain : @[dut.scala 28:21]
        occupied <= UInt<1>("h0") @[dut.scala 29:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 32:14]
    node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 32:24]
    ready_r <= _ready_r_T_1 @[dut.scala 32:11]
    io.enq.ready <= ready_r @[dut.scala 33:16]

