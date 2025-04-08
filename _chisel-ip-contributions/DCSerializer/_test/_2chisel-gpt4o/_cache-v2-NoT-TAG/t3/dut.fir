circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    node paddedData = cat(UInt<2>("h0"), io.dataIn.bits) @[Cat.scala 33:92]
    node _dataSelect_T = bits(paddedData, 4, 0) @[dut.scala 21:60]
    node _dataSelect_T_1 = bits(paddedData, 9, 5) @[dut.scala 21:60]
    wire dataSelect : UInt<5>[2] @[dut.scala 21:44]
    dataSelect[0] <= _dataSelect_T @[dut.scala 21:44]
    dataSelect[1] <= _dataSelect_T_1 @[dut.scala 21:44]
    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:27]
    node isLastCycle = eq(cycleCount, UInt<1>("h1")) @[dut.scala 25:33]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 28:20]
    io.dataOut.bits <= dataSelect[cycleCount] @[dut.scala 29:19]
    node _io_dataIn_ready_T = and(isLastCycle, io.dataOut.ready) @[dut.scala 30:34]
    io.dataIn.ready <= _io_dataIn_ready_T @[dut.scala 30:19]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 33:27]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 34:52]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 34:52]
      node _cycleCount_T_2 = mux(isLastCycle, UInt<1>("h0"), _cycleCount_T_1) @[dut.scala 34:22]
      cycleCount <= _cycleCount_T_2 @[dut.scala 34:16]


