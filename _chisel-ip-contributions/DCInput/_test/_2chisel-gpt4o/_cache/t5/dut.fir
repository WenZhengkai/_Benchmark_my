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
    wire load : UInt<1> @[dut.scala 16:18]
    wire drain : UInt<1> @[dut.scala 17:19]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 21:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 21:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 21:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 21:35]
    load <= _load_T_3 @[dut.scala 21:8]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 24:21]
    drain <= _drain_T @[dut.scala 24:9]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 27:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 27:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 28:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 28:16]
    when load : @[dut.scala 31:14]
      hold <= io.enq.bits @[dut.scala 32:10]
      occupied <= UInt<1>("h1") @[dut.scala 33:14]
    else :
      when drain : @[dut.scala 34:22]
        occupied <= UInt<1>("h0") @[dut.scala 35:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 39:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[dut.scala 39:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[dut.scala 39:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[dut.scala 39:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[dut.scala 39:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[dut.scala 39:35]
    ready_r <= _ready_r_T_5 @[dut.scala 39:11]
    io.enq.ready <= ready_r @[dut.scala 40:16]

