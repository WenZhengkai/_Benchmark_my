circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 17:27]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 19:25]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 20:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 20:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 20:16]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 22:24]
      cycleCount <= UInt<1>("h0") @[dut.scala 23:16]
    node paddedData = cat(UInt<2>("h0"), io.dataIn.bits) @[Cat.scala 33:92]
    node _dataSelect_T = bits(paddedData, 4, 0) @[dut.scala 30:15]
    node _dataSelect_T_1 = bits(paddedData, 9, 5) @[dut.scala 30:15]
    wire dataSelect : UInt<5>[2] @[dut.scala 29:44]
    dataSelect[0] <= _dataSelect_T @[dut.scala 29:44]
    dataSelect[1] <= _dataSelect_T_1 @[dut.scala 29:44]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 34:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 34:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 34:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 35:20]
    node _io_dataOut_bits_T = bits(cycleCount, 0, 0)
    io.dataOut.bits <= dataSelect[_io_dataOut_bits_T] @[dut.scala 36:19]

