circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 20:27]
      node _cycleCount_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 21:34]
      node _cycleCount_T_1 = add(cycleCount, UInt<1>("h1")) @[dut.scala 21:70]
      node _cycleCount_T_2 = tail(_cycleCount_T_1, 1) @[dut.scala 21:70]
      node _cycleCount_T_3 = mux(_cycleCount_T, UInt<1>("h0"), _cycleCount_T_2) @[dut.scala 21:22]
      cycleCount <= _cycleCount_T_3 @[dut.scala 21:16]
    wire dataSelect : UInt<5>[2] @[dut.scala 25:24]
    node _dataSelect_0_T = bits(io.dataIn.bits, 4, 0) @[dut.scala 29:45]
    dataSelect[0] <= _dataSelect_0_T @[dut.scala 29:19]
    node _dataSelect_1_T = bits(io.dataIn.bits, 7, 5) @[dut.scala 29:45]
    dataSelect[1] <= _dataSelect_1_T @[dut.scala 29:19]
    io.dataOut.bits <= dataSelect[cycleCount] @[dut.scala 31:19]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 34:35]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 34:55]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 34:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 37:20]

