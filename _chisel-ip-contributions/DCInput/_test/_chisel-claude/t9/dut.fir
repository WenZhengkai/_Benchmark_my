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
    wire drain : UInt<1> @[dut.scala 15:19]
    wire load : UInt<1> @[dut.scala 16:18]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 19:21]
    drain <= _drain_T @[dut.scala 19:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 22:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 22:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 22:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 22:35]
    load <= _load_T_3 @[dut.scala 22:8]
    when load : @[dut.scala 25:14]
      occupied <= UInt<1>("h1") @[dut.scala 26:14]
      hold <= io.enq.bits @[dut.scala 27:10]
    else :
      when drain : @[dut.scala 28:21]
        occupied <= UInt<1>("h0") @[dut.scala 29:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 33:14]
    node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 33:24]
    ready_r <= _ready_r_T_1 @[dut.scala 33:11]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 36:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 36:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 37:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 37:16]
    io.enq.ready <= ready_r @[dut.scala 40:16]

