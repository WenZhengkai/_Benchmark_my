circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 11:25]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 12:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[dut.scala 13:21]
    wire load : UInt<1> @[dut.scala 14:18]
    wire drain : UInt<1> @[dut.scala 15:19]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 18:21]
    drain <= _drain_T @[dut.scala 18:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 19:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 19:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 19:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 19:35]
    load <= _load_T_3 @[dut.scala 19:8]
    when occupied : @[dut.scala 22:19]
      io.deq.bits <= hold @[dut.scala 23:17]
    else :
      io.deq.bits <= io.enq.bits @[dut.scala 25:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 28:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 28:16]
    when load : @[dut.scala 31:15]
      hold <= io.enq.bits @[dut.scala 32:10]
    node _T = eq(drain, UInt<1>("h0")) @[dut.scala 35:17]
    node _T_1 = and(load, _T) @[dut.scala 35:14]
    when _T_1 : @[dut.scala 35:25]
      occupied <= UInt<1>("h1") @[dut.scala 36:14]
    else :
      when drain : @[dut.scala 37:23]
        occupied <= UInt<1>("h0") @[dut.scala 38:14]
    node _ready_r_T = eq(load, UInt<1>("h0")) @[dut.scala 41:14]
    node _ready_r_T_1 = eq(occupied, UInt<1>("h0")) @[dut.scala 41:24]
    node _ready_r_T_2 = or(_ready_r_T_1, drain) @[dut.scala 41:34]
    node _ready_r_T_3 = and(_ready_r_T, _ready_r_T_2) @[dut.scala 41:20]
    ready_r <= _ready_r_T_3 @[dut.scala 41:11]
    io.enq.ready <= ready_r @[dut.scala 43:16]

