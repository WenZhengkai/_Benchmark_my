circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dst : UInt<5>, flip c : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, p : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[5]}

    wire _pData_WIRE : UInt<8> @[dut.scala 12:35]
    _pData_WIRE <= UInt<1>("h0") @[dut.scala 12:35]
    reg pData : UInt, clock with :
      reset => (reset, _pData_WIRE) @[dut.scala 12:22]
    reg pValid : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 15:23]
    node pReady_lo = cat(io.p[1].ready, io.p[0].ready) @[Cat.scala 33:92]
    node pReady_hi_hi = cat(io.p[4].ready, io.p[3].ready) @[Cat.scala 33:92]
    node pReady_hi = cat(pReady_hi_hi, io.p[2].ready) @[Cat.scala 33:92]
    node pReady = cat(pReady_hi, pReady_lo) @[Cat.scala 33:92]
    node _nxtAccept_T = eq(pValid, UInt<1>("h0")) @[dut.scala 21:27]
    node _nxtAccept_T_1 = and(pValid, pReady) @[dut.scala 21:48]
    node _nxtAccept_T_2 = eq(_nxtAccept_T_1, pValid) @[dut.scala 21:58]
    node nxtAccept = or(_nxtAccept_T, _nxtAccept_T_2) @[dut.scala 21:36]
    when nxtAccept : @[dut.scala 24:19]
      pData <= io.c.bits @[dut.scala 25:11]
      when io.c.valid : @[dut.scala 26:22]
        pValid <= io.dst @[dut.scala 27:14]
      else :
        pValid <= UInt<1>("h0") @[dut.scala 29:14]
    else :
      node _pValid_T = not(pReady) @[dut.scala 32:24]
      node _pValid_T_1 = and(pValid, _pValid_T) @[dut.scala 32:22]
      pValid <= _pValid_T_1 @[dut.scala 32:12]
    io.c.ready <= nxtAccept @[dut.scala 36:14]
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

