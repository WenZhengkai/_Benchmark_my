circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    io.out.bits <= io.in[3].bits @[dut.scala 12:15]
    io.out.valid <= io.in[3].valid @[dut.scala 13:16]
    io.chosen <= UInt<2>("h3") @[dut.scala 14:13]
    when io.in[2].valid : @[dut.scala 18:26]
      io.out.bits <= io.in[2].bits @[dut.scala 19:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 20:20]
      io.chosen <= UInt<2>("h2") @[dut.scala 21:17]
    when io.in[1].valid : @[dut.scala 18:26]
      io.out.bits <= io.in[1].bits @[dut.scala 19:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 20:20]
      io.chosen <= UInt<1>("h1") @[dut.scala 21:17]
    when io.in[0].valid : @[dut.scala 18:26]
      io.out.bits <= io.in[0].bits @[dut.scala 19:19]
      io.out.valid <= UInt<1>("h1") @[dut.scala 20:20]
      io.chosen <= UInt<1>("h0") @[dut.scala 21:17]
    node _grant_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 38:68]
    node _grant_T_1 = or(_grant_T, io.in[2].valid) @[dut.scala 38:68]
    node grant_1 = eq(io.in[0].valid, UInt<1>("h0")) @[dut.scala 38:78]
    node grant_2 = eq(_grant_T, UInt<1>("h0")) @[dut.scala 38:78]
    node grant_3 = eq(_grant_T_1, UInt<1>("h0")) @[dut.scala 38:78]
    node _io_in_0_ready_T = and(UInt<1>("h1"), io.out.ready) @[dut.scala 30:32]
    io.in[0].ready <= _io_in_0_ready_T @[dut.scala 30:20]
    node _io_in_1_ready_T = and(grant_1, io.out.ready) @[dut.scala 30:32]
    io.in[1].ready <= _io_in_1_ready_T @[dut.scala 30:20]
    node _io_in_2_ready_T = and(grant_2, io.out.ready) @[dut.scala 30:32]
    io.in[2].ready <= _io_in_2_ready_T @[dut.scala 30:20]
    node _io_in_3_ready_T = and(grant_3, io.out.ready) @[dut.scala 30:32]
    io.in[3].ready <= _io_in_3_ready_T @[dut.scala 30:20]

