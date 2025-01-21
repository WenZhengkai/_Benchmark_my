circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:27]
    wire dataVec : UInt<5>[2] @[dut.scala 18:21]
    node _dataVec_0_T = bits(io.dataIn.bits, 4, 0) @[dut.scala 24:42]
    dataVec[0] <= _dataVec_0_T @[dut.scala 24:16]
    node _dataVec_1_T = bits(io.dataIn.bits, 7, 5) @[dut.scala 24:42]
    dataVec[1] <= _dataVec_1_T @[dut.scala 24:16]
    io.dataOut.bits <= dataVec[cycleCount] @[dut.scala 28:19]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 31:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 31:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 31:19]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 32:20]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 34:25]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 35:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 35:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 35:16]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 38:24]
      cycleCount <= UInt<1>("h0") @[dut.scala 39:16]


