circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    wire _pData_WIRE : UInt<8> @[dut.scala 22:35]
    _pData_WIRE <= UInt<1>("h0") @[dut.scala 22:35]
    reg pData : UInt, clock with :
      reset => (reset, _pData_WIRE) @[dut.scala 22:22]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 25:23]
    wire _pReady_WIRE : UInt<1>[5] @[dut.scala 28:23]
    _pReady_WIRE[0] <= io.p[0].ready @[dut.scala 28:23]
    _pReady_WIRE[1] <= io.p[1].ready @[dut.scala 28:23]
    _pReady_WIRE[2] <= io.p[2].ready @[dut.scala 28:23]
    _pReady_WIRE[3] <= io.p[3].ready @[dut.scala 28:23]
    _pReady_WIRE[4] <= io.p[4].ready @[dut.scala 28:23]
    node pReady_lo = cat(_pReady_WIRE[1], _pReady_WIRE[0]) @[dut.scala 28:43]
    node pReady_hi_hi = cat(_pReady_WIRE[4], _pReady_WIRE[3]) @[dut.scala 28:43]
    node pReady_hi = cat(pReady_hi_hi, _pReady_WIRE[2]) @[dut.scala 28:43]
    node pReady = cat(pReady_hi, pReady_lo) @[dut.scala 28:43]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 32:27]
    node _nxtAccept_T_1 = not(pReady) @[dut.scala 32:50]
    node _nxtAccept_T_2 = and(pValid, _nxtAccept_T_1) @[dut.scala 32:48]
    node _nxtAccept_T_3 = eq(_nxtAccept_T_2, UInt<1>("h0")) @[dut.scala 32:59]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_3) @[dut.scala 32:36]
    when nxtAccept : @[dut.scala 35:19]
      node _pValid_T = mux(UInt<1>("h1"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 77:12]
      node _pValid_T_1 = and(io.dst, _pValid_T) @[dut.scala 36:38]
      node _pValid_T_2 = mux(io.c.valid, _pValid_T_1, UInt<1>("h0")) @[dut.scala 36:18]
      pValid <= _pValid_T_2 @[dut.scala 36:12]
      pData <= io.c.bits @[dut.scala 37:11]
    else :
      node _pValid_T_3 = not(pReady) @[dut.scala 39:24]
      node _pValid_T_4 = and(pValid, _pValid_T_3) @[dut.scala 39:22]
      pValid <= _pValid_T_4 @[dut.scala 39:12]
    io.p[0].bits <= pData @[dut.scala 44:18]
    node _io_p_0_valid_T = bits(pValid, 0, 0) @[dut.scala 45:28]
    io.p[0].valid <= _io_p_0_valid_T @[dut.scala 45:19]
    io.p[1].bits <= pData @[dut.scala 44:18]
    node _io_p_1_valid_T = bits(pValid, 1, 1) @[dut.scala 45:28]
    io.p[1].valid <= _io_p_1_valid_T @[dut.scala 45:19]
    io.p[2].bits <= pData @[dut.scala 44:18]
    node _io_p_2_valid_T = bits(pValid, 2, 2) @[dut.scala 45:28]
    io.p[2].valid <= _io_p_2_valid_T @[dut.scala 45:19]
    io.p[3].bits <= pData @[dut.scala 44:18]
    node _io_p_3_valid_T = bits(pValid, 3, 3) @[dut.scala 45:28]
    io.p[3].valid <= _io_p_3_valid_T @[dut.scala 45:19]
    io.p[4].bits <= pData @[dut.scala 44:18]
    node _io_p_4_valid_T = bits(pValid, 4, 4) @[dut.scala 45:28]
    io.p[4].valid <= _io_p_4_valid_T @[dut.scala 45:19]
    io.c.ready <= nxtAccept @[dut.scala 49:14]

