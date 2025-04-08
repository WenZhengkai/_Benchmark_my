circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 15:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:26]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 19:27]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 20:28]
      node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 21:30]
      node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 21:30]
      cycleCount <= _cycleCount_T_1 @[dut.scala 21:16]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 23:22]
      when _T_1 : @[dut.scala 23:42]
        dataValid <= UInt<1>("h1") @[dut.scala 24:17]
        cycleCount <= UInt<1>("h0") @[dut.scala 25:18]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 30:41]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 30:41]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 30:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 30:19]
    io.dataOut.valid <= dataValid @[dut.scala 31:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 34:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 34:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 34:19]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 36:28]
      dataValid <= UInt<1>("h0") @[dut.scala 37:15]


