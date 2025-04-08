circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 16:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:26]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 20:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 21:28]
      node _cycleCount_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 22:34]
      node _cycleCount_T_1 = add(cycleCount, UInt<1>("h1")) @[dut.scala 22:70]
      node _cycleCount_T_2 = tail(_cycleCount_T_1, 1) @[dut.scala 22:70]
      node _cycleCount_T_3 = mux(_cycleCount_T, UInt<1>("h0"), _cycleCount_T_2) @[dut.scala 22:22]
      cycleCount <= _cycleCount_T_3 @[dut.scala 22:16]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    node _T_2 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 26:38]
    node _T_3 = and(_T_1, _T_2) @[dut.scala 26:23]
    when _T_3 : @[dut.scala 26:59]
      dataValid <= UInt<1>("h1") @[dut.scala 27:15]
    node _T_4 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_4 : @[dut.scala 31:25]
      dataValid <= UInt<1>("h0") @[dut.scala 32:15]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 36:41]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 36:41]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 36:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 36:19]
    io.dataOut.valid <= dataValid @[dut.scala 39:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 40:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 40:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 40:19]

