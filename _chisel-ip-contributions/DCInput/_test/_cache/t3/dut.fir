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
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 19:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 19:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 19:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 19:35]
    load <= _load_T_3 @[dut.scala 19:8]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 22:21]
    drain <= _drain_T @[dut.scala 22:9]
    when occupied : @[dut.scala 25:19]
      io.deq.bits <= hold @[dut.scala 26:17]
    else :
      io.deq.bits <= io.enq.bits @[dut.scala 28:17]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 32:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 32:16]
    when load : @[dut.scala 35:15]
      hold <= io.enq.bits @[dut.scala 36:10]
      occupied <= UInt<1>("h1") @[dut.scala 37:14]
    else :
      when drain : @[dut.scala 38:23]
        occupied <= UInt<1>("h0") @[dut.scala 39:14]
    node _ready_r_T = eq(load, UInt<1>("h0")) @[dut.scala 43:14]
    node _ready_r_T_1 = eq(occupied, UInt<1>("h0")) @[dut.scala 43:24]
    node _ready_r_T_2 = or(_ready_r_T_1, drain) @[dut.scala 43:34]
    node _ready_r_T_3 = and(_ready_r_T, _ready_r_T_2) @[dut.scala 43:20]
    ready_r <= _ready_r_T_3 @[dut.scala 43:11]
    io.enq.ready <= ready_r @[dut.scala 44:16]

