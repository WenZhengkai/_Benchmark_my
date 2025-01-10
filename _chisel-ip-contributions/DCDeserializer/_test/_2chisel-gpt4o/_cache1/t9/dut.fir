circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 16:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:26]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 20:22]
    io.dataIn.ready <= _io_dataIn_ready_T @[dut.scala 20:19]
    io.dataOut.valid <= dataValid @[dut.scala 21:20]
    wire reconstructedData : UInt<8> @[dut.scala 24:31]
    node _reconstructedData_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 25:35]
    wire _reconstructedData_WIRE : UInt<8> @[dut.scala 25:50]
    _reconstructedData_WIRE <= _reconstructedData_T @[dut.scala 25:50]
    reconstructedData <= _reconstructedData_WIRE @[dut.scala 25:21]
    io.dataOut.bits <= reconstructedData @[dut.scala 27:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 30:26]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 32:28]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 33:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 33:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 33:16]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 36:21]
      when _T_1 : @[dut.scala 36:41]
        dataValid <= UInt<1>("h1") @[dut.scala 37:17]
        cycleCount <= UInt<1>("h0") @[dut.scala 38:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 43:27]
      dataValid <= UInt<1>("h0") @[dut.scala 44:15]


