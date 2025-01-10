circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sel : UInt<3>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    io.c.ready <= UInt<1>("h0") @[dut.scala 16:14]
    io.p[0].valid <= UInt<1>("h0") @[dut.scala 20:19]
    io.p[0].bits <= io.c.bits @[dut.scala 21:18]
    node _T = eq(io.sel, UInt<1>("h0")) @[dut.scala 23:18]
    when _T : @[dut.scala 23:27]
      io.p[0].valid <= io.c.valid @[dut.scala 24:21]
      io.c.ready <= io.p[0].ready @[dut.scala 25:18]
    io.p[1].valid <= UInt<1>("h0") @[dut.scala 20:19]
    io.p[1].bits <= io.c.bits @[dut.scala 21:18]
    node _T_1 = eq(io.sel, UInt<1>("h1")) @[dut.scala 23:18]
    when _T_1 : @[dut.scala 23:27]
      io.p[1].valid <= io.c.valid @[dut.scala 24:21]
      io.c.ready <= io.p[1].ready @[dut.scala 25:18]
    io.p[2].valid <= UInt<1>("h0") @[dut.scala 20:19]
    io.p[2].bits <= io.c.bits @[dut.scala 21:18]
    node _T_2 = eq(io.sel, UInt<2>("h2")) @[dut.scala 23:18]
    when _T_2 : @[dut.scala 23:27]
      io.p[2].valid <= io.c.valid @[dut.scala 24:21]
      io.c.ready <= io.p[2].ready @[dut.scala 25:18]
    io.p[3].valid <= UInt<1>("h0") @[dut.scala 20:19]
    io.p[3].bits <= io.c.bits @[dut.scala 21:18]
    node _T_3 = eq(io.sel, UInt<2>("h3")) @[dut.scala 23:18]
    when _T_3 : @[dut.scala 23:27]
      io.p[3].valid <= io.c.valid @[dut.scala 24:21]
      io.c.ready <= io.p[3].ready @[dut.scala 25:18]
    io.p[4].valid <= UInt<1>("h0") @[dut.scala 20:19]
    io.p[4].bits <= io.c.bits @[dut.scala 21:18]
    node _T_4 = eq(io.sel, UInt<3>("h4")) @[dut.scala 23:18]
    when _T_4 : @[dut.scala 23:27]
      io.p[4].valid <= io.c.valid @[dut.scala 24:21]
      io.c.ready <= io.p[4].ready @[dut.scala 25:18]


