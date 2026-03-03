circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 24:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:26]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 32:22]
    io.dataIn.ready <= _io_dataIn_ready_T @[dut.scala 32:19]
    io.dataOut.valid <= dataValid @[dut.scala 35:20]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 40:33]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 40:48]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 40:48]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 40:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 43:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 44:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 46:21]
      when _T_1 : @[dut.scala 46:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 47:18]
        dataValid <= UInt<1>("h1") @[dut.scala 48:17]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 50:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 50:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 50:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 55:25]
      dataValid <= UInt<1>("h0") @[dut.scala 56:15]


