circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 11:26]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 12:26]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[dut.scala 13:22]
    wire load : UInt<1> @[dut.scala 14:23]
    wire drain : UInt<1> @[dut.scala 15:23]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 18:21]
    drain <= _drain_T @[dut.scala 18:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 19:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 19:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 19:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 19:35]
    load <= _load_T_3 @[dut.scala 19:8]
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
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 39:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 39:15]
    node _io_deq_valid_T = and(io.enq.valid, ready_r) @[dut.scala 40:45]
    node _io_deq_valid_T_1 = or(occupied, _io_deq_valid_T) @[dut.scala 40:28]
    io.deq.valid <= _io_deq_valid_T_1 @[dut.scala 40:16]
    io.enq.ready <= ready_r @[dut.scala 43:16]
    node _T = and(load, drain) @[dut.scala 46:17]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 46:10]
    node _T_2 = bits(reset, 0, 0) @[dut.scala 46:9]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[dut.scala 46:9]
    when _T_3 : @[dut.scala 46:9]
      node _T_4 = eq(_T_1, UInt<1>("h0")) @[dut.scala 46:9]
      when _T_4 : @[dut.scala 46:9]
        printf(clock, UInt<1>("h1"), "Assertion failed: Simultaneous load-drain undefined behavior\n    at dut.scala:46 assert(!(load && drain), \"Simultaneous load-drain undefined behavior\")\n") : printf @[dut.scala 46:9]
      assert(clock, _T_1, UInt<1>("h1"), "") : assert @[dut.scala 46:9]
    when load : @[dut.scala 50:14]
      node _T_5 = bits(reset, 0, 0) @[dut.scala 51:11]
      node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 51:11]
      when _T_6 : @[dut.scala 51:11]
        printf(clock, UInt<1>("h1"), "[INFO] Load: Data = %d\n", io.enq.bits) : printf_1 @[dut.scala 51:11]
    when drain : @[dut.scala 53:15]
      node _T_7 = bits(reset, 0, 0) @[dut.scala 54:11]
      node _T_8 = eq(_T_7, UInt<1>("h0")) @[dut.scala 54:11]
      when _T_8 : @[dut.scala 54:11]
        printf(clock, UInt<1>("h1"), "[INFO] Drain: Data = %d\n", io.deq.bits) : printf_2 @[dut.scala 54:11]


