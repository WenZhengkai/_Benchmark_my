circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 11:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[dut.scala 15:17]
    wire load : UInt<1> @[dut.scala 18:18]
    wire drain : UInt<1> @[dut.scala 20:19]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 23:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 23:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 23:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 23:35]
    load <= _load_T_3 @[dut.scala 23:8]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 26:21]
    drain <= _drain_T @[dut.scala 26:9]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 29:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 29:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 30:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 30:16]
    when load : @[dut.scala 33:14]
      hold <= io.enq.bits @[dut.scala 34:10]
      occupied <= UInt<1>("h1") @[dut.scala 35:14]
    when drain : @[dut.scala 37:15]
      occupied <= UInt<1>("h0") @[dut.scala 38:14]
    node _T = eq(load, UInt<1>("h0")) @[dut.scala 42:8]
    when _T : @[dut.scala 42:15]
      node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 43:16]
      node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 43:26]
      ready_r <= _ready_r_T_1 @[dut.scala 43:13]
    io.enq.ready <= ready_r @[dut.scala 47:16]

