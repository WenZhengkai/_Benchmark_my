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
    node _io_dataIn_ready_T_1 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    node _io_dataIn_ready_T_2 = or(_io_dataIn_ready_T, _io_dataIn_ready_T_1) @[dut.scala 20:33]
    io.dataIn.ready <= _io_dataIn_ready_T_2 @[dut.scala 20:19]
    io.dataOut.valid <= dataValid @[dut.scala 21:20]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 24:25]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 25:28]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 26:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 26:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 26:16]
    node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 30:20]
    when _T_1 : @[dut.scala 30:40]
      dataValid <= UInt<1>("h1") @[dut.scala 31:15]
      cycleCount <= UInt<1>("h0") @[dut.scala 32:16]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 36:33]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 36:48]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 36:48]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 36:19]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 39:26]
      dataValid <= UInt<1>("h0") @[dut.scala 40:15]


