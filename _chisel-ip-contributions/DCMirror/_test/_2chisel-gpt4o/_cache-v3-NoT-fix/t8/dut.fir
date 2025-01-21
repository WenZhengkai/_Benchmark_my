circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 13:23]
    wire pReady : UInt<1>[5] @[dut.scala 16:20]
    pReady[0] <= io.p[0].ready @[dut.scala 18:15]
    pReady[1] <= io.p[1].ready @[dut.scala 18:15]
    pReady[2] <= io.p[2].ready @[dut.scala 18:15]
    pReady[3] <= io.p[3].ready @[dut.scala 18:15]
    pReady[4] <= io.p[4].ready @[dut.scala 18:15]
    node pReadyVec_lo = cat(pReady[1], pReady[0]) @[dut.scala 22:26]
    node pReadyVec_hi_hi = cat(pReady[4], pReady[3]) @[dut.scala 22:26]
    node pReadyVec_hi = cat(pReadyVec_hi_hi, pReady[2]) @[dut.scala 22:26]
    node pReadyVec = cat(pReadyVec_hi, pReadyVec_lo) @[dut.scala 22:26]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 23:27]
    node _nxtAccept_T_1 = and(pValid, pReadyVec) @[dut.scala 23:47]
    node _nxtAccept_T_2 = eq(_nxtAccept_T_1, pValid) @[dut.scala 23:60]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_2) @[dut.scala 23:36]
    when nxtAccept : @[dut.scala 26:20]
      pData <= io.c.bits @[dut.scala 27:11]
      when io.c.valid : @[dut.scala 28:23]
        node _pValid_T = bits(io.c.valid, 0, 0) @[Bitwise.scala 77:15]
        node _pValid_T_1 = mux(_pValid_T, UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 77:12]
        node _pValid_T_2 = and(io.dst, _pValid_T_1) @[dut.scala 29:24]
        pValid <= _pValid_T_2 @[dut.scala 29:14]
      else :
        pValid <= UInt<1>("h0") @[dut.scala 31:14]
    else :
      node _pValid_T_3 = not(pReadyVec) @[dut.scala 35:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[dut.scala 35:22]
      pValid <= _pValid_T_4 @[dut.scala 35:12]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[dut.scala 40:28]
    io.p[0].valid <= _io_p_0_valid_T @[dut.scala 40:19]
    io.p[0].bits <= pData @[dut.scala 41:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[dut.scala 40:28]
    io.p[1].valid <= _io_p_1_valid_T @[dut.scala 40:19]
    io.p[1].bits <= pData @[dut.scala 41:18]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[dut.scala 40:28]
    io.p[2].valid <= _io_p_2_valid_T @[dut.scala 40:19]
    io.p[2].bits <= pData @[dut.scala 41:18]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[dut.scala 40:28]
    io.p[3].valid <= _io_p_3_valid_T @[dut.scala 40:19]
    io.p[3].bits <= pData @[dut.scala 41:18]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[dut.scala 40:28]
    io.p[4].valid <= _io_p_4_valid_T @[dut.scala 40:19]
    io.p[4].bits <= pData @[dut.scala 41:18]
    io.c.ready <= nxtAccept @[dut.scala 45:14]

