circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    io.out.bits <= io.in[3].bits @[dut.scala 14:15]
    io.out.valid <= UInt<1>("h0") @[dut.scala 15:16]
    io.chosen <= UInt<2>("h3") @[dut.scala 16:13]
    node _grants_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 23:72]
    node _grants_T_1 = or(_grants_T, io.in[2].valid) @[dut.scala 23:72]
    node grants_1 = eq(io.in[0].valid, UInt<1>("h0")) @[dut.scala 23:82]
    node grants_2 = eq(_grants_T, UInt<1>("h0")) @[dut.scala 23:82]
    node grants_3 = eq(_grants_T_1, UInt<1>("h0")) @[dut.scala 23:82]
    node _io_in_0_ready_T = and(UInt<1>("h1"), io.out.ready) @[dut.scala 32:33]
    io.in[0].ready <= _io_in_0_ready_T @[dut.scala 32:20]
    node _T = and(io.in[0].valid, UInt<1>("h1")) @[dut.scala 33:25]
    when _T : @[dut.scala 33:39]
      io.out.bits <= io.in[0].bits @[dut.scala 34:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 35:20]
      io.chosen <= UInt<1>("h0") @[dut.scala 36:17]
    node _io_in_1_ready_T = and(grants_1, io.out.ready) @[dut.scala 32:33]
    io.in[1].ready <= _io_in_1_ready_T @[dut.scala 32:20]
    node _T_1 = and(io.in[1].valid, grants_1) @[dut.scala 33:25]
    when _T_1 : @[dut.scala 33:39]
      io.out.bits <= io.in[1].bits @[dut.scala 34:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 35:20]
      io.chosen <= UInt<1>("h1") @[dut.scala 36:17]
    node _io_in_2_ready_T = and(grants_2, io.out.ready) @[dut.scala 32:33]
    io.in[2].ready <= _io_in_2_ready_T @[dut.scala 32:20]
    node _T_2 = and(io.in[2].valid, grants_2) @[dut.scala 33:25]
    when _T_2 : @[dut.scala 33:39]
      io.out.bits <= io.in[2].bits @[dut.scala 34:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 35:20]
      io.chosen <= UInt<2>("h2") @[dut.scala 36:17]
    node _io_in_3_ready_T = and(grants_3, io.out.ready) @[dut.scala 32:33]
    io.in[3].ready <= _io_in_3_ready_T @[dut.scala 32:20]
    node _T_3 = and(io.in[3].valid, grants_3) @[dut.scala 33:25]
    when _T_3 : @[dut.scala 33:39]
      io.out.bits <= io.in[3].bits @[dut.scala 34:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 35:20]
      io.chosen <= UInt<2>("h3") @[dut.scala 36:17]


