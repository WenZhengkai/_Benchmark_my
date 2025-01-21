circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:27]
    reg activeData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), activeData) @[dut.scala 21:23]
    reg activeTransaction : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:34]
    wire dataVec : UInt<5>[2] @[dut.scala 25:21]
    node _dataVec_0_T = bits(activeData, 4, 0) @[dut.scala 29:38]
    dataVec[0] <= _dataVec_0_T @[dut.scala 29:16]
    node _dataVec_1_T = bits(activeData, 7, 5) @[dut.scala 29:38]
    dataVec[1] <= _dataVec_1_T @[dut.scala 29:16]
    io.dataOut.bits <= dataVec[cycleCount] @[dut.scala 33:19]
    io.dataOut.valid <= activeTransaction @[dut.scala 34:20]
    node _io_dataIn_ready_T = eq(activeTransaction, UInt<1>("h0")) @[dut.scala 37:22]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 37:41]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 37:19]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 40:25]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 41:21]
      when _T_1 : @[dut.scala 41:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 42:18]
        activeTransaction <= UInt<1>("h0") @[dut.scala 43:25]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 45:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 45:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 45:18]
    else :
      node _T_2 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
      when _T_2 : @[dut.scala 48:26]
        activeData <= io.dataIn.bits @[dut.scala 49:18]
        activeTransaction <= UInt<1>("h1") @[dut.scala 50:25]
        cycleCount <= UInt<1>("h0") @[dut.scala 51:18]


