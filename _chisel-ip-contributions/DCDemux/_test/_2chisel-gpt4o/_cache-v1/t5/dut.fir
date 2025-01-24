circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sel : UInt<3>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    io.p[0].valid <= UInt<1>("h0") @[dut.scala 13:19]
    io.p[0].bits <= io.c.bits @[dut.scala 14:18]
    io.c.ready <= UInt<1>("h0") @[dut.scala 15:16]
    io.p[1].valid <= UInt<1>("h0") @[dut.scala 13:19]
    io.p[1].bits <= io.c.bits @[dut.scala 14:18]
    io.c.ready <= UInt<1>("h0") @[dut.scala 15:16]
    io.p[2].valid <= UInt<1>("h0") @[dut.scala 13:19]
    io.p[2].bits <= io.c.bits @[dut.scala 14:18]
    io.c.ready <= UInt<1>("h0") @[dut.scala 15:16]
    io.p[3].valid <= UInt<1>("h0") @[dut.scala 13:19]
    io.p[3].bits <= io.c.bits @[dut.scala 14:18]
    io.c.ready <= UInt<1>("h0") @[dut.scala 15:16]
    io.p[4].valid <= UInt<1>("h0") @[dut.scala 13:19]
    io.p[4].bits <= io.c.bits @[dut.scala 14:18]
    io.c.ready <= UInt<1>("h0") @[dut.scala 15:16]
    when io.c.valid : @[dut.scala 19:20]
      node _T = eq(io.sel, UInt<1>("h0")) @[dut.scala 21:19]
      when _T : @[dut.scala 21:28]
        io.p[0].valid <= io.c.valid @[dut.scala 22:23]
        io.c.ready <= io.p[0].ready @[dut.scala 23:20]
      node _T_1 = eq(io.sel, UInt<1>("h1")) @[dut.scala 21:19]
      when _T_1 : @[dut.scala 21:28]
        io.p[1].valid <= io.c.valid @[dut.scala 22:23]
        io.c.ready <= io.p[1].ready @[dut.scala 23:20]
      node _T_2 = eq(io.sel, UInt<2>("h2")) @[dut.scala 21:19]
      when _T_2 : @[dut.scala 21:28]
        io.p[2].valid <= io.c.valid @[dut.scala 22:23]
        io.c.ready <= io.p[2].ready @[dut.scala 23:20]
      node _T_3 = eq(io.sel, UInt<2>("h3")) @[dut.scala 21:19]
      when _T_3 : @[dut.scala 21:28]
        io.p[3].valid <= io.c.valid @[dut.scala 22:23]
        io.c.ready <= io.p[3].ready @[dut.scala 23:20]
      node _T_4 = eq(io.sel, UInt<3>("h4")) @[dut.scala 21:19]
      when _T_4 : @[dut.scala 21:28]
        io.p[4].valid <= io.c.valid @[dut.scala 22:23]
        io.c.ready <= io.p[4].ready @[dut.scala 23:20]


