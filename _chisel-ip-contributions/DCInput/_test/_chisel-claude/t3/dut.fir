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
    wire drain : UInt<1> @[dut.scala 16:19]
    wire load : UInt<1> @[dut.scala 17:18]
    node _drain_T = and(occupied, io.deq.ready) @[dut.scala 20:21]
    drain <= _drain_T @[dut.scala 20:9]
    node _load_T = and(io.enq.valid, ready_r) @[dut.scala 24:24]
    node _load_T_1 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 24:39]
    node _load_T_2 = or(_load_T_1, drain) @[dut.scala 24:53]
    node _load_T_3 = and(_load_T, _load_T_2) @[dut.scala 24:35]
    load <= _load_T_3 @[dut.scala 24:8]
    node _io_deq_bits_T = mux(occupied, hold, io.enq.bits) @[dut.scala 28:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 28:15]
    node _io_deq_valid_T = eq(load, UInt<1>("h0")) @[dut.scala 31:48]
    node _io_deq_valid_T_1 = and(io.enq.valid, _io_deq_valid_T) @[dut.scala 31:45]
    node _io_deq_valid_T_2 = or(occupied, _io_deq_valid_T_1) @[dut.scala 31:28]
    io.deq.valid <= _io_deq_valid_T_2 @[dut.scala 31:16]
    io.enq.ready <= ready_r @[dut.scala 34:16]
    when load : @[dut.scala 37:14]
      hold <= io.enq.bits @[dut.scala 38:10]
      occupied <= UInt<1>("h1") @[dut.scala 39:14]
    else :
      when drain : @[dut.scala 40:21]
        occupied <= UInt<1>("h0") @[dut.scala 41:14]
    node _ready_r_T = eq(occupied, UInt<1>("h0")) @[dut.scala 45:14]
    node _ready_r_T_1 = or(_ready_r_T, drain) @[dut.scala 45:24]
    ready_r <= _ready_r_T_1 @[dut.scala 45:11]

