circuit DCMirror_UInt8_N5_golden :
  module DCMirror_UInt8_N5_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[golden.scala 23:18]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[golden.scala 24:23]
    node pReady_lo = cat(io.p[1].ready, io.p[0].ready) @[Cat.scala 33:92]
    node pReady_hi_hi = cat(io.p[4].ready, io.p[3].ready) @[Cat.scala 33:92]
    node pReady_hi = cat(pReady_hi_hi, io.p[2].ready) @[Cat.scala 33:92]
    node pReady = cat(pReady_hi, pReady_lo) @[Cat.scala 33:92]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[golden.scala 26:27]
    node _nxtAccept_T_1 = neq(pValid, UInt<1>("h0")) @[golden.scala 26:48]
    node _nxtAccept_T_2 = and(pValid, pReady) @[golden.scala 26:69]
    node _nxtAccept_T_3 = eq(_nxtAccept_T_2, pValid) @[golden.scala 26:79]
    node _nxtAccept_T_4 = and(_nxtAccept_T_1, _nxtAccept_T_3) @[golden.scala 26:57]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_4) @[golden.scala 26:36]
    when nxtAccept : @[golden.scala 28:19]
      node _pValid_T = bits(io.c.valid, 0, 0) @[Bitwise.scala 77:15]
      node _pValid_T_1 = mux(_pValid_T, UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 77:12]
      node _pValid_T_2 = and(_pValid_T_1, io.dst) @[golden.scala 29:35]
      pValid <= _pValid_T_2 @[golden.scala 29:12]
      pData <= io.c.bits @[golden.scala 30:11]
    else :
      node _pValid_T_3 = not(pReady) @[golden.scala 32:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[golden.scala 32:22]
      pValid <= _pValid_T_4 @[golden.scala 32:12]
    io.c.ready <= nxtAccept @[golden.scala 34:14]
    io.p[0].bits <= pData @[golden.scala 37:18]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[golden.scala 38:28]
    io.p[0].valid <= _io_p_0_valid_T @[golden.scala 38:19]
    io.p[1].bits <= pData @[golden.scala 37:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[golden.scala 38:28]
    io.p[1].valid <= _io_p_1_valid_T @[golden.scala 38:19]
    io.p[2].bits <= pData @[golden.scala 37:18]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[golden.scala 38:28]
    io.p[2].valid <= _io_p_2_valid_T @[golden.scala 38:19]
    io.p[3].bits <= pData @[golden.scala 37:18]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[golden.scala 38:28]
    io.p[3].valid <= _io_p_3_valid_T @[golden.scala 38:19]
    io.p[4].bits <= pData @[golden.scala 37:18]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[golden.scala 38:28]
    io.p[4].valid <= _io_p_4_valid_T @[golden.scala 38:19]

