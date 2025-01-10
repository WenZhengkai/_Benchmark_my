circuit DCInput_UInt8_golden :
  module DCInput_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[golden.scala 22:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 23:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[golden.scala 24:17]
    wire load : UInt<1> @[golden.scala 25:18]
    wire drain : UInt<1> @[golden.scala 26:19]
    node _drain_T = and(occupied, io.deq.ready) @[golden.scala 28:21]
    drain <= _drain_T @[golden.scala 28:9]
    node _load_T = and(io.enq.valid, ready_r) @[golden.scala 29:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[golden.scala 29:39]
    node _load_T_2 = or(_load_T_1, drain) @[golden.scala 29:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[golden.scala 29:35]
    load <= _load_T_3 @[golden.scala 29:8]
    when occupied : @[golden.scala 31:18]
      io.deq.bits <= hold @[golden.scala 32:17]
    else :
      io.deq.bits <= io.enq.bits @[golden.scala 34:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[golden.scala 37:32]
    io.deq.valid <= _io_deq_valid_T @[golden.scala 37:16]
    when load : @[golden.scala 38:14]
      occupied <= UInt<1>("h1") @[golden.scala 39:14]
      hold <= io.enq.bits @[golden.scala 40:10]
    else :
      when drain : @[golden.scala 41:21]
        occupied <= UInt<1>("h0") @[golden.scala 42:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[golden.scala 45:15]
    node _ready_r_T_1 = eq(load, UInt<1>("h0")) @[golden.scala 45:28]
    node _ready_r_T_2 = and(_ready_r_T, _ready_r_T_1) @[golden.scala 45:25]
    node _ready_r_T_3 = eq(load, UInt<1>("h0")) @[golden.scala 45:48]
    node _ready_r_T_4 = and(drain, _ready_r_T_3) @[golden.scala 45:45]
    node _ready_r_T_5 = or(_ready_r_T_2, _ready_r_T_4) @[golden.scala 45:35]
    ready_r <= _ready_r_T_5 @[golden.scala 45:11]
    io.enq.ready <= ready_r @[golden.scala 46:16]

