circuit DCDemux_UInt8_golden :
  module DCDemux_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sel : UInt<3>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    io.c.ready <= UInt<1>("h0") @[golden.scala 21:14]
    io.p[0].bits <= io.c.bits @[golden.scala 23:18]
    node _T = eq(UInt<1>("h0"), io.sel) @[golden.scala 24:14]
    when _T : @[golden.scala 24:26]
      io.p[0].valid <= io.c.valid @[golden.scala 25:21]
      io.c.ready <= io.p[0].ready @[golden.scala 26:18]
    else :
      io.p[0].valid <= UInt<1>("h0") @[golden.scala 28:21]
    io.p[1].bits <= io.c.bits @[golden.scala 23:18]
    node _T_1 = eq(UInt<1>("h1"), io.sel) @[golden.scala 24:14]
    when _T_1 : @[golden.scala 24:26]
      io.p[1].valid <= io.c.valid @[golden.scala 25:21]
      io.c.ready <= io.p[1].ready @[golden.scala 26:18]
    else :
      io.p[1].valid <= UInt<1>("h0") @[golden.scala 28:21]
    io.p[2].bits <= io.c.bits @[golden.scala 23:18]
    node _T_2 = eq(UInt<2>("h2"), io.sel) @[golden.scala 24:14]
    when _T_2 : @[golden.scala 24:26]
      io.p[2].valid <= io.c.valid @[golden.scala 25:21]
      io.c.ready <= io.p[2].ready @[golden.scala 26:18]
    else :
      io.p[2].valid <= UInt<1>("h0") @[golden.scala 28:21]
    io.p[3].bits <= io.c.bits @[golden.scala 23:18]
    node _T_3 = eq(UInt<2>("h3"), io.sel) @[golden.scala 24:14]
    when _T_3 : @[golden.scala 24:26]
      io.p[3].valid <= io.c.valid @[golden.scala 25:21]
      io.c.ready <= io.p[3].ready @[golden.scala 26:18]
    else :
      io.p[3].valid <= UInt<1>("h0") @[golden.scala 28:21]
    io.p[4].bits <= io.c.bits @[golden.scala 23:18]
    node _T_4 = eq(UInt<3>("h4"), io.sel) @[golden.scala 24:14]
    when _T_4 : @[golden.scala 24:26]
      io.p[4].valid <= io.c.valid @[golden.scala 25:21]
      io.c.ready <= io.p[4].ready @[golden.scala 26:18]
    else :
      io.p[4].valid <= UInt<1>("h0") @[golden.scala 28:21]


