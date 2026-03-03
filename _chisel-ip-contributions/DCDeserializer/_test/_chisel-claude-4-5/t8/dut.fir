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
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 20:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 21:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 23:21]
      when _T_1 : @[dut.scala 23:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 24:18]
        dataValid <= UInt<1>("h1") @[dut.scala 25:17]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 27:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 27:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 27:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 31:25]
      dataValid <= UInt<1>("h0") @[dut.scala 32:15]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 36:41]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 36:41]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 36:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 36:19]
    io.dataOut.valid <= dataValid @[dut.scala 37:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 41:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 41:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 41:19]

