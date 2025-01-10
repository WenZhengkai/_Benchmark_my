circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    reg active : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:23]
    wire dataVec : UInt<5>[2] @[dut.scala 22:21]
    reg inputData : UInt<8>, clock with :
      reset => (UInt<1>("h0"), inputData) @[dut.scala 23:22]
    node _dataVec_0_T = bits(inputData, 4, 0) @[dut.scala 29:37]
    dataVec[0] <= _dataVec_0_T @[dut.scala 29:16]
    node _dataVec_1_T = bits(inputData, 7, 5) @[dut.scala 29:37]
    dataVec[1] <= _dataVec_1_T @[dut.scala 29:16]
    node _io_dataIn_ready_T = eq(active, UInt<1>("h0")) @[dut.scala 33:22]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 33:30]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 33:19]
    io.dataOut.valid <= active @[dut.scala 34:20]
    io.dataOut.bits <= dataVec[cycleCount] @[dut.scala 35:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 37:24]
      inputData <= io.dataIn.bits @[dut.scala 39:15]
      cycleCount <= UInt<1>("h0") @[dut.scala 40:16]
      active <= UInt<1>("h1") @[dut.scala 41:12]
    else :
      node _T_1 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
      node _T_2 = and(_T_1, active) @[dut.scala 42:30]
      when _T_2 : @[dut.scala 42:41]
        node _T_3 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 44:21]
        when _T_3 : @[dut.scala 44:41]
          active <= UInt<1>("h0") @[dut.scala 45:14]
        else :
          node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 47:32]
          node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 47:32]
          cycleCount <= _cycleCount_T_1 @[dut.scala 47:18]


