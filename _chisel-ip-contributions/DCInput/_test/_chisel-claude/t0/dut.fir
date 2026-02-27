circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 11:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[dut.scala 17:17]
    wire load : UInt<1> @[dut.scala 20:18]
    wire drain : UInt<1> @[dut.scala 23:19]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 26:21]
    drain <= _drain_T @[dut.scala 26:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 30:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 30:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 30:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 30:35]
    load <= _load_T_3 @[dut.scala 30:8]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 33:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 33:15]
    node _io_deq_valid_T = eq(load, UInt<1>("h0")) @[dut.scala 36:48]
    node _io_deq_valid_T_1 = and(io.enq.valid, _io_deq_valid_T) @[dut.scala 36:45]
    node _io_deq_valid_T_2 = or(occupied, _io_deq_valid_T_1) @[dut.scala 36:28]
    io.deq.valid <= _io_deq_valid_T_2 @[dut.scala 36:16]
    io.enq.ready <= ready_r @[dut.scala 39:16]
    when load : @[dut.scala 42:14]
      hold <= io.enq.bits @[dut.scala 43:10]
      occupied <= UInt<1>("h1") @[dut.scala 44:14]
    else :
      when drain : @[dut.scala 45:21]
        occupied <= UInt<1>("h0") @[dut.scala 46:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 50:14]
    node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 50:24]
    ready_r <= _ready_r_T_1 @[dut.scala 50:11]

