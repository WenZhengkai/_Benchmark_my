circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 13:23]
    wire pReady : UInt<5> @[dut.scala 16:20]
    node pReady_lo = cat(io.p[1].ready, io.p[0].ready) @[Cat.scala 33:92]
    node pReady_hi_hi = cat(io.p[4].ready, io.p[3].ready) @[Cat.scala 33:92]
    node pReady_hi = cat(pReady_hi_hi, io.p[2].ready) @[Cat.scala 33:92]
    node _pReady_T = cat(pReady_hi, pReady_lo) @[Cat.scala 33:92]
    pReady <= _pReady_T @[dut.scala 17:10]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 20:27]
    node _nxtAccept_T_1 = and(pValid, pReady) @[dut.scala 20:48]
    node _nxtAccept_T_2 = eq(_nxtAccept_T_1, pValid) @[dut.scala 20:58]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_2) @[dut.scala 20:36]
    when nxtAccept : @[dut.scala 23:19]
      pData <= io.c.bits @[dut.scala 24:11]
      when io.c.valid : @[dut.scala 25:22]
        node _pValid_T = bits(io.c.valid, 0, 0) @[Bitwise.scala 77:15]
        node _pValid_T_1 = mux(_pValid_T, UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 77:12]
        node _pValid_T_2 = and(io.dst, _pValid_T_1) @[dut.scala 26:24]
        pValid <= _pValid_T_2 @[dut.scala 26:14]
      else :
        pValid <= UInt<1>("h0") @[dut.scala 28:14]
    else :
      node _pValid_T_3 = not(pReady) @[dut.scala 31:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[dut.scala 31:22]
      pValid <= _pValid_T_4 @[dut.scala 31:12]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[dut.scala 36:29]
    io.p[0].valid <= _io_p_0_valid_T @[dut.scala 36:19]
    io.p[0].bits <= pData @[dut.scala 37:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[dut.scala 36:29]
    io.p[1].valid <= _io_p_1_valid_T @[dut.scala 36:19]
    io.p[1].bits <= pData @[dut.scala 37:18]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[dut.scala 36:29]
    io.p[2].valid <= _io_p_2_valid_T @[dut.scala 36:19]
    io.p[2].bits <= pData @[dut.scala 37:18]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[dut.scala 36:29]
    io.p[3].valid <= _io_p_3_valid_T @[dut.scala 36:19]
    io.p[3].bits <= pData @[dut.scala 37:18]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[dut.scala 36:29]
    io.p[4].valid <= _io_p_4_valid_T @[dut.scala 36:19]
    io.p[4].bits <= pData @[dut.scala 37:18]
    io.c.ready <= nxtAccept @[dut.scala 41:14]

