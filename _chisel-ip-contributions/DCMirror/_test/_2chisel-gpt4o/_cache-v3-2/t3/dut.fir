circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 13:23]
    node pReady_lo = cat(io.p[1].ready, io.p[0].ready) @[Cat.scala 33:92]
    node pReady_hi_hi = cat(io.p[4].ready, io.p[3].ready) @[Cat.scala 33:92]
    node pReady_hi = cat(pReady_hi_hi, io.p[2].ready) @[Cat.scala 33:92]
    node pReady = cat(pReady_hi, pReady_lo) @[Cat.scala 33:92]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 15:26]
    node _nxtAccept_T_1 = not(pReady) @[dut.scala 15:47]
    node _nxtAccept_T_2 = and(pValid, _nxtAccept_T_1) @[dut.scala 15:45]
    node _nxtAccept_T_3 = eq(_nxtAccept_T_2, UInt<1>("h0")) @[dut.scala 15:56]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_3) @[dut.scala 15:34]
    when nxtAccept : @[dut.scala 18:20]
      when io.c.valid : @[dut.scala 19:23]
        pData <= io.c.bits @[dut.scala 20:13]
      node _pValid_T = and(io.c.valid, io.dst) @[dut.scala 22:26]
      pValid <= _pValid_T @[dut.scala 22:12]
    else :
      node _pValid_T_1 = not(pReady) @[dut.scala 24:24]
      node _pValid_T_2 = and(pValid, _pValid_T_1) @[dut.scala 24:22]
      pValid <= _pValid_T_2 @[dut.scala 24:12]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[dut.scala 29:28]
    io.p[0].valid <= _io_p_0_valid_T @[dut.scala 29:19]
    io.p[0].bits <= pData @[dut.scala 30:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[dut.scala 29:28]
    io.p[1].valid <= _io_p_1_valid_T @[dut.scala 29:19]
    io.p[1].bits <= pData @[dut.scala 30:18]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[dut.scala 29:28]
    io.p[2].valid <= _io_p_2_valid_T @[dut.scala 29:19]
    io.p[2].bits <= pData @[dut.scala 30:18]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[dut.scala 29:28]
    io.p[3].valid <= _io_p_3_valid_T @[dut.scala 29:19]
    io.p[3].bits <= pData @[dut.scala 30:18]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[dut.scala 29:28]
    io.p[4].valid <= _io_p_4_valid_T @[dut.scala 29:19]
    io.p[4].bits <= pData @[dut.scala 30:18]
    io.c.ready <= nxtAccept @[dut.scala 34:14]

