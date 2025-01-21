circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    wire dataSelect : UInt<5>[2] @[dut.scala 19:24]
    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:27]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 24:27]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 25:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 25:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 25:16]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 27:21]
      when _T_1 : @[dut.scala 27:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 28:18]
    node _dataSelect_0_T = dshr(io.dataIn.bits, UInt<1>("h0")) @[dut.scala 34:45]
    node _dataSelect_0_T_1 = and(_dataSelect_0_T, UInt<5>("h1f")) @[dut.scala 34:63]
    dataSelect[0] <= _dataSelect_0_T_1 @[dut.scala 34:19]
    node _dataSelect_1_T = dshr(io.dataIn.bits, UInt<3>("h5")) @[dut.scala 34:45]
    node _dataSelect_1_T_1 = and(_dataSelect_1_T, UInt<5>("h1f")) @[dut.scala 34:63]
    dataSelect[1] <= _dataSelect_1_T_1 @[dut.scala 34:19]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 38:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 38:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 38:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 39:20]
    io.dataOut.bits <= dataSelect[cycleCount] @[dut.scala 40:19]
    node _T_2 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 42:26]
      cycleCount <= UInt<1>("h0") @[dut.scala 43:16]


