circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 17:27]
    node paddedData = cat(UInt<2>("h0"), io.dataIn.bits) @[Cat.scala 33:92]
    node _dataSelect_T = bits(paddedData, 4, 0) @[dut.scala 24:60]
    node _dataSelect_T_1 = bits(paddedData, 9, 5) @[dut.scala 24:60]
    wire dataSelect : UInt<5>[2] @[dut.scala 24:44]
    dataSelect[0] <= _dataSelect_T @[dut.scala 24:44]
    dataSelect[1] <= _dataSelect_T_1 @[dut.scala 24:44]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 28:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 28:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 28:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 31:20]
    node _io_dataOut_bits_T = bits(cycleCount, 0, 0)
    io.dataOut.bits <= dataSelect[_io_dataOut_bits_T] @[dut.scala 34:19]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 37:25]
      node _cycleCount_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 38:34]
      node _cycleCount_T_1 = add(cycleCount, UInt<1>("h1")) @[dut.scala 38:70]
      node _cycleCount_T_2 = tail(_cycleCount_T_1, 1) @[dut.scala 38:70]
      node _cycleCount_T_3 = mux(_cycleCount_T, UInt<1>("h0"), _cycleCount_T_2) @[dut.scala 38:22]
      cycleCount <= _cycleCount_T_3 @[dut.scala 38:16]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 42:24]
      cycleCount <= UInt<1>("h0") @[dut.scala 43:16]


