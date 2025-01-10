circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:27]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[dut.scala 18:20]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 21:34]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 21:54]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 21:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 24:26]
      dataReg <= io.dataIn.bits @[dut.scala 25:13]
      cycleCount <= UInt<1>("h0") @[dut.scala 26:16]
    io.dataOut.valid <= io.dataIn.valid @[dut.scala 30:20]
    node _dataVec_T = bits(dataReg, 4, 0) @[dut.scala 36:21]
    node _dataVec_T_1 = bits(dataReg, 7, 5) @[dut.scala 36:21]
    wire dataVec : UInt<5>[2] @[dut.scala 33:24]
    dataVec[0] <= _dataVec_T @[dut.scala 33:24]
    dataVec[1] <= _dataVec_T_1 @[dut.scala 33:24]
    io.dataOut.bits <= dataVec[cycleCount] @[dut.scala 40:19]
    node _T_1 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 43:27]
      node _T_2 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 44:21]
      when _T_2 : @[dut.scala 44:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 45:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 47:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 47:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 47:18]


