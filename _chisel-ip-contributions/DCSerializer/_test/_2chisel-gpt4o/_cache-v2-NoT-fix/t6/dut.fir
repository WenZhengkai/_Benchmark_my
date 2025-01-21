circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:27]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 18:27]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 19:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 19:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 19:16]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 22:26]
      cycleCount <= UInt<1>("h0") @[dut.scala 23:16]
    wire dataSelect : UInt<5>[2] @[dut.scala 27:24]
    node _dataSelect_0_T = bits(io.dataIn.bits, 4, 0) @[dut.scala 32:45]
    dataSelect[0] <= _dataSelect_0_T @[dut.scala 32:19]
    node _dataSelect_1_T = bits(io.dataIn.bits, 7, 5) @[dut.scala 32:45]
    dataSelect[1] <= _dataSelect_1_T @[dut.scala 32:19]
    io.dataOut.bits <= dataSelect[cycleCount] @[dut.scala 35:19]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 38:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 38:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 38:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 41:20]

