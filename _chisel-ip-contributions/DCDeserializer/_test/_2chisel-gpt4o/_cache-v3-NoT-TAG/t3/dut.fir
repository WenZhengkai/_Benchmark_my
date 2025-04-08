circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 17:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 21:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 22:28]
      node _cycleCount_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 23:34]
      node _cycleCount_T_1 = add(cycleCount, UInt<1>("h1")) @[dut.scala 23:70]
      node _cycleCount_T_2 = tail(_cycleCount_T_1, 1) @[dut.scala 23:70]
      node _cycleCount_T_3 = mux(_cycleCount_T, UInt<1>("h0"), _cycleCount_T_2) @[dut.scala 23:22]
      cycleCount <= _cycleCount_T_3 @[dut.scala 23:16]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    node _T_2 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 27:38]
    node _T_3 = and(_T_1, _T_2) @[dut.scala 27:23]
    when _T_3 : @[dut.scala 27:59]
      dataValid <= UInt<1>("h1") @[dut.scala 28:15]
    node _T_4 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_4 : @[dut.scala 32:25]
      dataValid <= UInt<1>("h0") @[dut.scala 33:15]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 37:41]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 37:41]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 37:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 37:19]
    io.dataOut.valid <= dataValid @[dut.scala 40:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 41:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 41:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 41:19]

