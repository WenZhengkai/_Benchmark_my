circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg ready_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 12:24]
    reg occupied : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:25]
    reg hold : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold) @[dut.scala 16:17]
    wire load : UInt<1> @[dut.scala 19:18]
    wire drain : UInt<1> @[dut.scala 20:19]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 24:21]
    drain <= _drain_T @[dut.scala 24:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 27:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 27:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 27:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 27:35]
    load <= _load_T_3 @[dut.scala 27:8]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 31:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 31:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 34:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 34:16]
    when load : @[dut.scala 38:14]
      occupied <= UInt<1>("h1") @[dut.scala 39:14]
    else :
      when drain : @[dut.scala 40:21]
        occupied <= UInt<1>("h0") @[dut.scala 41:14]
    when load : @[dut.scala 45:14]
      hold <= io.enq.bits @[dut.scala 46:10]
    node _ready_r_T = eq(load, UInt<1>("h0")) @[dut.scala 50:14]
    node _ready_r_T_1 = eq(occupied, UInt<1>("h0")) @[dut.scala 50:24]
    node _ready_r_T_2 = or(_ready_r_T_1, drain) @[dut.scala 50:34]
    node _ready_r_T_3 = and(_ready_r_T, _ready_r_T_2) @[dut.scala 50:20]
    ready_r <= _ready_r_T_3 @[dut.scala 50:11]
    io.enq.ready <= ready_r @[dut.scala 53:16]

