circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sel : UInt<3>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    io.c.ready <= UInt<1>("h0") @[dut.scala 14:14]
    io.p[0].bits <= io.c.bits @[dut.scala 16:18]
    io.p[0].valid <= UInt<1>("h0") @[dut.scala 17:19]
    io.p[1].bits <= io.c.bits @[dut.scala 16:18]
    io.p[1].valid <= UInt<1>("h0") @[dut.scala 17:19]
    io.p[2].bits <= io.c.bits @[dut.scala 16:18]
    io.p[2].valid <= UInt<1>("h0") @[dut.scala 17:19]
    io.p[3].bits <= io.c.bits @[dut.scala 16:18]
    io.p[3].valid <= UInt<1>("h0") @[dut.scala 17:19]
    io.p[4].bits <= io.c.bits @[dut.scala 16:18]
    io.p[4].valid <= UInt<1>("h0") @[dut.scala 17:19]
    when io.c.valid : @[dut.scala 21:20]
      io.p[io.sel].valid <= UInt<1>("h1") @[dut.scala 23:24]
      io.c.ready <= io.p[io.sel].ready @[dut.scala 25:16]
    node _T = eq(UInt<1>("h0"), io.sel) @[dut.scala 30:14]
    when _T : @[dut.scala 30:26]
      io.p[0].valid <= io.c.valid @[dut.scala 31:21]
    else :
      io.p[0].valid <= UInt<1>("h0") @[dut.scala 33:21]
    node _T_1 = eq(UInt<1>("h1"), io.sel) @[dut.scala 30:14]
    when _T_1 : @[dut.scala 30:26]
      io.p[1].valid <= io.c.valid @[dut.scala 31:21]
    else :
      io.p[1].valid <= UInt<1>("h0") @[dut.scala 33:21]
    node _T_2 = eq(UInt<2>("h2"), io.sel) @[dut.scala 30:14]
    when _T_2 : @[dut.scala 30:26]
      io.p[2].valid <= io.c.valid @[dut.scala 31:21]
    else :
      io.p[2].valid <= UInt<1>("h0") @[dut.scala 33:21]
    node _T_3 = eq(UInt<2>("h3"), io.sel) @[dut.scala 30:14]
    when _T_3 : @[dut.scala 30:26]
      io.p[3].valid <= io.c.valid @[dut.scala 31:21]
    else :
      io.p[3].valid <= UInt<1>("h0") @[dut.scala 33:21]
    node _T_4 = eq(UInt<3>("h4"), io.sel) @[dut.scala 30:14]
    when _T_4 : @[dut.scala 30:26]
      io.p[4].valid <= io.c.valid @[dut.scala 31:21]
    else :
      io.p[4].valid <= UInt<1>("h0") @[dut.scala 33:21]


