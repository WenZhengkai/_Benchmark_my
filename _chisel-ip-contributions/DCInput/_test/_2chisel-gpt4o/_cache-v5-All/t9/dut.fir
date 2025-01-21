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
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 18:21]
    drain <= _drain_T @[dut.scala 18:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 19:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 19:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 19:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 19:35]
    load <= _load_T_3 @[dut.scala 19:8]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 22:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 22:15]
    node _io_deq_valid_T = or(io.enq.valid, occupied) @[dut.scala 23:32]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 23:16]
    when load : @[dut.scala 26:14]
      hold <= io.enq.bits @[dut.scala 27:10]
    node _occupied_T = mux(drain, UInt<1>("h0"), occupied) @[dut.scala 30:36]
    node _occupied_T_1 = mux(load, UInt<1>("h1"), _occupied_T) @[dut.scala 30:18]
    occupied <= _occupied_T_1 @[dut.scala 30:12]
    node _ready_r_T = eq(load, UInt<1>("h0")) @[dut.scala 31:14]
    node _ready_r_T_1 = eq(occupied, UInt<1>("h0")) @[dut.scala 31:24]
    node _ready_r_T_2 = or(_ready_r_T_1, drain) @[dut.scala 31:34]
    node _ready_r_T_3 = and(_ready_r_T, _ready_r_T_2) @[dut.scala 31:20]
    ready_r <= _ready_r_T_3 @[dut.scala 31:11]
    io.enq.ready <= ready_r @[dut.scala 34:16]

