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
    node drain = and(io.deq.ready, occupied) @[dut.scala 15:28]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 16:27]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 16:42]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 16:56]
    node load = and(_load_T, _load_T_2) @[dut.scala 16:38]
    when drain : @[dut.scala 19:15]
      occupied <= UInt<1>("h0") @[dut.scala 20:14]
    else :
      when load : @[dut.scala 21:20]
        occupied <= UInt<1>("h1") @[dut.scala 22:14]
        hold <= io.enq.bits @[dut.scala 23:10]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 26:14]
    node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 26:24]
    node _ready_r_T_2 = or(_ready_r_T_1, load) @[dut.scala 26:33]
    ready_r <= _ready_r_T_2 @[dut.scala 26:11]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 29:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 29:15]
    node _io_deq_valid_T = or(occupied, io.enq.valid) @[dut.scala 30:28]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 30:16]
    io.enq.ready <= ready_r @[dut.scala 33:16]

