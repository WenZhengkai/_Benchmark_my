circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 18:27]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 20:25]
      node _cycleCount_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 21:34]
      node _cycleCount_T_1 = add(cycleCount, UInt<1>("h1")) @[dut.scala 21:70]
      node _cycleCount_T_2 = tail(_cycleCount_T_1, 1) @[dut.scala 21:70]
      node _cycleCount_T_3 = mux(_cycleCount_T, UInt<1>("h0"), _cycleCount_T_2) @[dut.scala 21:22]
      cycleCount <= _cycleCount_T_3 @[dut.scala 21:16]
    else :
      node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
      when _T_1 : @[dut.scala 22:30]
        cycleCount <= UInt<1>("h0") @[dut.scala 23:16]
    node paddedData = cat(UInt<2>("h0"), io.dataIn.bits) @[Cat.scala 33:92]
    node _dataSelect_T = bits(paddedData, 4, 0) @[dut.scala 30:61]
    node _dataSelect_T_1 = bits(paddedData, 9, 5) @[dut.scala 30:61]
    wire dataSelect : UInt<5>[2] @[dut.scala 30:45]
    dataSelect[0] <= _dataSelect_T @[dut.scala 30:45]
    dataSelect[1] <= _dataSelect_T_1 @[dut.scala 30:45]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 33:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 33:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 33:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 34:20]
    node _io_dataOut_bits_T = bits(cycleCount, 0, 0)
    io.dataOut.bits <= dataSelect[_io_dataOut_bits_T] @[dut.scala 35:19]

