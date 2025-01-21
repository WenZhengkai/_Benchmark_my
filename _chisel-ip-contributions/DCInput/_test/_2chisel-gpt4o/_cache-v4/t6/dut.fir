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
    wire load : UInt<1> @[dut.scala 14:18]
    wire drain : UInt<1> @[dut.scala 15:19]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 18:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 18:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 18:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 18:35]
    load <= _load_T_3 @[dut.scala 18:8]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 21:21]
    drain <= _drain_T @[dut.scala 21:9]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 24:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 24:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 25:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 25:16]
    when load : @[dut.scala 28:15]
      hold <= io.enq.bits @[dut.scala 29:10]
      occupied <= UInt<1>("h1") @[dut.scala 30:14]
    when drain : @[dut.scala 33:16]
      occupied <= UInt<1>("h0") @[dut.scala 34:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 38:14]
    node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 38:24]
    node _ready_r_T_2 = eq(load, UInt<1>("h0")) @[dut.scala 38:36]
    node _ready_r_T_3 = or(_ready_r_T_1, _ready_r_T_2) @[dut.scala 38:33]
    ready_r <= _ready_r_T_3 @[dut.scala 38:11]
    io.enq.ready <= ready_r @[dut.scala 39:16]

