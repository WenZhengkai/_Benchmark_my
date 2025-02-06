circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    io.chosen <= UInt<2>("h3") @[dut.scala 12:13]
    io.out.bits <= io.in[3].bits @[dut.scala 13:15]
    node _grant_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 39:68]
    node _grant_T_1 = or(_grant_T, io.in[2].valid) @[dut.scala 39:68]
    node grant_1 = eq(io.in[0].valid, UInt<1>("h0")) @[dut.scala 39:78]
    node grant_2 = eq(_grant_T, UInt<1>("h0")) @[dut.scala 39:78]
    node grant_3 = eq(_grant_T_1, UInt<1>("h0")) @[dut.scala 39:78]
    when grant_3 : @[dut.scala 21:20]
      io.chosen <= UInt<2>("h3") @[dut.scala 22:17]
      io.out.bits <= io.in[3].bits @[dut.scala 23:19]
    when grant_2 : @[dut.scala 21:20]
      io.chosen <= UInt<2>("h2") @[dut.scala 22:17]
      io.out.bits <= io.in[2].bits @[dut.scala 23:19]
    when grant_1 : @[dut.scala 21:20]
      io.chosen <= UInt<1>("h1") @[dut.scala 22:17]
      io.out.bits <= io.in[1].bits @[dut.scala 23:19]
    when UInt<1>("h1") : @[dut.scala 21:20]
      io.chosen <= UInt<1>("h0") @[dut.scala 22:17]
      io.out.bits <= io.in[0].bits @[dut.scala 23:19]
    node _io_out_valid_T = or(UInt<1>("h1"), grant_1) @[dut.scala 28:34]
    node _io_out_valid_T_1 = or(_io_out_valid_T, grant_2) @[dut.scala 28:34]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, grant_3) @[dut.scala 28:34]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 28:16]
    node _io_in_0_ready_T = and(UInt<1>("h1"), io.out.ready) @[dut.scala 30:19]
    io.in[0].ready <= _io_in_0_ready_T @[dut.scala 30:14]
    node _io_in_1_ready_T = and(grant_1, io.out.ready) @[dut.scala 30:19]
    io.in[1].ready <= _io_in_1_ready_T @[dut.scala 30:14]
    node _io_in_2_ready_T = and(grant_2, io.out.ready) @[dut.scala 30:19]
    io.in[2].ready <= _io_in_2_ready_T @[dut.scala 30:14]
    node _io_in_3_ready_T = and(grant_3, io.out.ready) @[dut.scala 30:19]
    io.in[3].ready <= _io_in_3_ready_T @[dut.scala 30:14]

