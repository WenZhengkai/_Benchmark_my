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
    wire load : UInt<1> @[dut.scala 15:18]
    wire drain : UInt<1> @[dut.scala 16:19]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 19:21]
    drain <= _drain_T @[dut.scala 19:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 20:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 20:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 20:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 20:35]
    load <= _load_T_3 @[dut.scala 20:8]
    when load : @[dut.scala 23:14]
      hold <= io.enq.bits @[dut.scala 24:10]
    when drain : @[dut.scala 28:15]
      occupied <= UInt<1>("h0") @[dut.scala 29:14]
    else :
      when load : @[dut.scala 30:20]
        occupied <= UInt<1>("h1") @[dut.scala 31:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 35:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[dut.scala 35:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[dut.scala 35:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[dut.scala 35:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[dut.scala 35:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[dut.scala 35:35]
    ready_r <= _ready_r_T_5 @[dut.scala 35:11]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 38:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 38:15]
    node _io_deq_valid_T = and(io.enq.valid, ready_r) @[dut.scala 39:45]
    node _io_deq_valid_T_1 = or(occupied, _io_deq_valid_T) @[dut.scala 39:28]
    io.deq.valid <= _io_deq_valid_T_1 @[dut.scala 39:16]
    io.enq.ready <= ready_r @[dut.scala 42:16]
    node _T = and(load, drain) @[dut.scala 45:17]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 45:10]
    node _T_2 = bits(reset, 0, 0) @[dut.scala 45:9]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[dut.scala 45:9]
    when _T_3 : @[dut.scala 45:9]
      node _T_4 = eq(_T_1, UInt<1>("h0")) @[dut.scala 45:9]
      when _T_4 : @[dut.scala 45:9]
        printf(clock, UInt<1>("h1"), "Assertion failed: Simultaneous load and drain detected, undefined behavior\n    at dut.scala:45 assert(!(load && drain), \"Simultaneous load and drain detected, undefined behavior\") // Ensure no simultaneous load and drain\n") : printf @[dut.scala 45:9]
      assert(clock, _T_1, UInt<1>("h1"), "") : assert @[dut.scala 45:9]


