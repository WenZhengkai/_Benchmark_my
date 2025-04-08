circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 17:27]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 19:24]
      cycleCount <= UInt<1>("h0") @[dut.scala 20:16]
    else :
      node _T_1 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
      when _T_1 : @[dut.scala 21:31]
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 22:30]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 22:30]
        cycleCount <= _cycleCount_T_1 @[dut.scala 22:16]
    node paddedData = cat(UInt<2>("h0"), io.dataIn.bits) @[Cat.scala 33:92]
    node _dataChunks_T = bits(paddedData, 4, 0) @[dut.scala 29:60]
    node _dataChunks_T_1 = bits(paddedData, 9, 5) @[dut.scala 29:60]
    wire dataChunks : UInt<5>[2] @[dut.scala 29:44]
    dataChunks[0] <= _dataChunks_T @[dut.scala 29:44]
    dataChunks[1] <= _dataChunks_T_1 @[dut.scala 29:44]
    node _io_dataOut_bits_T = bits(cycleCount, 0, 0)
    io.dataOut.bits <= dataChunks[_io_dataOut_bits_T] @[dut.scala 33:19]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 37:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 37:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 37:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 41:20]

