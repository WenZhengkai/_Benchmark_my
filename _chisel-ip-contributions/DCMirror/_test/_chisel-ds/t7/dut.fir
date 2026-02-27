circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    reg pData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pData) @[dut.scala 12:19]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 13:23]
    wire _pReady_WIRE : UInt<1>[5] @[dut.scala 16:23]
    _pReady_WIRE[0] <= io.p[0].ready @[dut.scala 16:23]
    _pReady_WIRE[1] <= io.p[1].ready @[dut.scala 16:23]
    _pReady_WIRE[2] <= io.p[2].ready @[dut.scala 16:23]
    _pReady_WIRE[3] <= io.p[3].ready @[dut.scala 16:23]
    _pReady_WIRE[4] <= io.p[4].ready @[dut.scala 16:23]
    node pReady_lo = cat(_pReady_WIRE[1], _pReady_WIRE[0]) @[dut.scala 16:43]
    node pReady_hi_hi = cat(_pReady_WIRE[4], _pReady_WIRE[3]) @[dut.scala 16:43]
    node pReady_hi = cat(pReady_hi_hi, _pReady_WIRE[2]) @[dut.scala 16:43]
    node pReady = cat(pReady_hi, pReady_lo) @[dut.scala 16:43]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 19:27]
    node _nxtAccept_T_1 = and(pValid, pReady) @[dut.scala 19:47]
    node _nxtAccept_T_2 = andr(_nxtAccept_T_1) @[dut.scala 19:57]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_2) @[dut.scala 19:36]
    when nxtAccept : @[dut.scala 22:19]
      pData <= io.c.bits @[dut.scala 24:11]
      node _pValid_T = mux(io.c.valid, io.dst, UInt<1>("h0")) @[dut.scala 25:18]
      pValid <= _pValid_T @[dut.scala 25:12]
    else :
      node _pValid_T_1 = not(pReady) @[dut.scala 28:24]
      node _pValid_T_2 = and(pValid, _pValid_T_1) @[dut.scala 28:22]
      pValid <= _pValid_T_2 @[dut.scala 28:12]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[dut.scala 33:28]
    io.p[0].valid <= _io_p_0_valid_T @[dut.scala 33:19]
    io.p[0].bits <= pData @[dut.scala 34:19]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[dut.scala 33:28]
    io.p[1].valid <= _io_p_1_valid_T @[dut.scala 33:19]
    io.p[1].bits <= pData @[dut.scala 34:19]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[dut.scala 33:28]
    io.p[2].valid <= _io_p_2_valid_T @[dut.scala 33:19]
    io.p[2].bits <= pData @[dut.scala 34:19]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[dut.scala 33:28]
    io.p[3].valid <= _io_p_3_valid_T @[dut.scala 33:19]
    io.p[3].bits <= pData @[dut.scala 34:19]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[dut.scala 33:28]
    io.p[4].valid <= _io_p_4_valid_T @[dut.scala 33:19]
    io.p[4].bits <= pData @[dut.scala 34:19]
    io.c.ready <= nxtAccept @[dut.scala 38:14]

