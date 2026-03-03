circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 23:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:27]
    io.dataOut.valid <= dataValid @[dut.scala 27:20]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 28:42]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 28:42]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 28:42]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 28:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 32:22]
    io.dataIn.ready <= _io_dataIn_ready_T @[dut.scala 32:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 35:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 36:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 38:21]
      when _T_1 : @[dut.scala 38:41]
        dataValid <= UInt<1>("h1") @[dut.scala 39:18]
        cycleCount <= UInt<1>("h0") @[dut.scala 40:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 42:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 42:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 42:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 47:25]
      dataValid <= UInt<1>("h0") @[dut.scala 48:15]


