circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:18]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 13:23]
    wire pReadyVec : UInt<1>[5] @[dut.scala 16:26]
    pReadyVec[0] <= io.p[0].ready @[dut.scala 16:26]
    pReadyVec[1] <= io.p[1].ready @[dut.scala 16:26]
    pReadyVec[2] <= io.p[2].ready @[dut.scala 16:26]
    pReadyVec[3] <= io.p[3].ready @[dut.scala 16:26]
    pReadyVec[4] <= io.p[4].ready @[dut.scala 16:26]
    node pReady_lo = cat(pReadyVec[1], pReadyVec[0]) @[dut.scala 17:32]
    node pReady_hi_hi = cat(pReadyVec[4], pReadyVec[3]) @[dut.scala 17:32]
    node pReady_hi = cat(pReady_hi_hi, pReadyVec[2]) @[dut.scala 17:32]
    node pReady = cat(pReady_hi, pReady_lo) @[dut.scala 17:32]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 20:27]
    node _nxtAccept_T_1 = and(pValid, pReady) @[dut.scala 20:47]
    node _nxtAccept_T_2 = eq(_nxtAccept_T_1, pValid) @[dut.scala 20:57]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_2) @[dut.scala 20:36]
    node _T = and(io.c.valid, nxtAccept) @[dut.scala 23:19]
    when _T : @[dut.scala 23:33]
      pData <= io.c.bits @[dut.scala 24:11]
      node _pValid_T = bits(io.c.valid, 0, 0) @[Bitwise.scala 77:15]
      node _pValid_T_1 = mux(_pValid_T, UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 77:12]
      node _pValid_T_2 = and(io.dst, _pValid_T_1) @[dut.scala 25:22]
      pValid <= _pValid_T_2 @[dut.scala 25:12]
    else :
      node _pValid_T_3 = not(pReady) @[dut.scala 27:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[dut.scala 27:22]
      pValid <= _pValid_T_4 @[dut.scala 27:12]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[dut.scala 32:28]
    io.p[0].valid <= _io_p_0_valid_T @[dut.scala 32:19]
    io.p[0].bits <= pData @[dut.scala 33:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[dut.scala 32:28]
    io.p[1].valid <= _io_p_1_valid_T @[dut.scala 32:19]
    io.p[1].bits <= pData @[dut.scala 33:18]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[dut.scala 32:28]
    io.p[2].valid <= _io_p_2_valid_T @[dut.scala 32:19]
    io.p[2].bits <= pData @[dut.scala 33:18]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[dut.scala 32:28]
    io.p[3].valid <= _io_p_3_valid_T @[dut.scala 32:19]
    io.p[3].bits <= pData @[dut.scala 33:18]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[dut.scala 32:28]
    io.p[4].valid <= _io_p_4_valid_T @[dut.scala 32:19]
    io.p[4].bits <= pData @[dut.scala 33:18]
    io.c.ready <= nxtAccept @[dut.scala 37:14]

