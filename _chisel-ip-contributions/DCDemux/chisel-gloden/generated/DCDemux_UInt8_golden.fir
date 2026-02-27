circuit DCDemux_UInt8_golden :
  module DCDemux_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sel : UInt<4>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[10]}

    io.c.ready <= UInt<1>("h0") @[golden.scala 23:14]
    io.p[0].bits <= io.c.bits @[golden.scala 26:18]
    node _T = eq(UInt<1>("h0"), io.sel) @[golden.scala 28:14]
    when _T : @[golden.scala 28:26]
      io.p[0].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[0].ready @[golden.scala 30:18]
    else :
      io.p[0].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[1].bits <= io.c.bits @[golden.scala 26:18]
    node _T_1 = eq(UInt<1>("h1"), io.sel) @[golden.scala 28:14]
    when _T_1 : @[golden.scala 28:26]
      io.p[1].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[1].ready @[golden.scala 30:18]
    else :
      io.p[1].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[2].bits <= io.c.bits @[golden.scala 26:18]
    node _T_2 = eq(UInt<2>("h2"), io.sel) @[golden.scala 28:14]
    when _T_2 : @[golden.scala 28:26]
      io.p[2].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[2].ready @[golden.scala 30:18]
    else :
      io.p[2].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[3].bits <= io.c.bits @[golden.scala 26:18]
    node _T_3 = eq(UInt<2>("h3"), io.sel) @[golden.scala 28:14]
    when _T_3 : @[golden.scala 28:26]
      io.p[3].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[3].ready @[golden.scala 30:18]
    else :
      io.p[3].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[4].bits <= io.c.bits @[golden.scala 26:18]
    node _T_4 = eq(UInt<3>("h4"), io.sel) @[golden.scala 28:14]
    when _T_4 : @[golden.scala 28:26]
      io.p[4].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[4].ready @[golden.scala 30:18]
    else :
      io.p[4].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[5].bits <= io.c.bits @[golden.scala 26:18]
    node _T_5 = eq(UInt<3>("h5"), io.sel) @[golden.scala 28:14]
    when _T_5 : @[golden.scala 28:26]
      io.p[5].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[5].ready @[golden.scala 30:18]
    else :
      io.p[5].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[6].bits <= io.c.bits @[golden.scala 26:18]
    node _T_6 = eq(UInt<3>("h6"), io.sel) @[golden.scala 28:14]
    when _T_6 : @[golden.scala 28:26]
      io.p[6].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[6].ready @[golden.scala 30:18]
    else :
      io.p[6].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[7].bits <= io.c.bits @[golden.scala 26:18]
    node _T_7 = eq(UInt<3>("h7"), io.sel) @[golden.scala 28:14]
    when _T_7 : @[golden.scala 28:26]
      io.p[7].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[7].ready @[golden.scala 30:18]
    else :
      io.p[7].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[8].bits <= io.c.bits @[golden.scala 26:18]
    node _T_8 = eq(UInt<4>("h8"), io.sel) @[golden.scala 28:14]
    when _T_8 : @[golden.scala 28:26]
      io.p[8].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[8].ready @[golden.scala 30:18]
    else :
      io.p[8].valid <= UInt<1>("h0") @[golden.scala 33:21]
    io.p[9].bits <= io.c.bits @[golden.scala 26:18]
    node _T_9 = eq(UInt<4>("h9"), io.sel) @[golden.scala 28:14]
    when _T_9 : @[golden.scala 28:26]
      io.p[9].valid <= io.c.valid @[golden.scala 29:21]
      io.c.ready <= io.p[9].ready @[golden.scala 30:18]
    else :
      io.p[9].valid <= UInt<1>("h0") @[golden.scala 33:21]


