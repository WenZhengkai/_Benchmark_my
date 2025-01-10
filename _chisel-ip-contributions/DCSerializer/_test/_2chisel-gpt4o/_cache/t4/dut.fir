circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 21:24]
    reg active : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:23]
    node _dataSelect_T = bits(dataReg, 4, 0) @[dut.scala 28:12]
    node _dataSelect_T_1 = bits(dataReg, 7, 5) @[dut.scala 28:12]
    wire dataSelect : UInt<5>[2] @[dut.scala 25:45]
    dataSelect[0] <= _dataSelect_T @[dut.scala 25:45]
    dataSelect[1] <= _dataSelect_T_1 @[dut.scala 25:45]
    node _io_dataIn_ready_T = eq(active, UInt<1>("h0")) @[dut.scala 32:22]
    node _io_dataIn_ready_T_1 = and(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 32:30]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 32:19]
    io.dataOut.bits <= dataSelect[cycleCount] @[dut.scala 33:19]
    io.dataOut.valid <= active @[dut.scala 34:20]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 36:24]
      dataReg <= io.dataIn.bits @[dut.scala 38:13]
      cycleCount <= UInt<1>("h0") @[dut.scala 39:16]
      active <= UInt<1>("h1") @[dut.scala 40:12]
    node _T_1 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 43:25]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 45:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 45:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 45:16]
      node _T_2 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 48:21]
      when _T_2 : @[dut.scala 48:41]
        active <= UInt<1>("h0") @[dut.scala 49:14]
        cycleCount <= UInt<1>("h0") @[dut.scala 51:18]


