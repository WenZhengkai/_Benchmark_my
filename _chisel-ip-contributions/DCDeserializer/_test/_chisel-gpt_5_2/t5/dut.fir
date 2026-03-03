circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 27:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:27]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 32:22]
    node _io_dataIn_ready_T_1 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    node _io_dataIn_ready_T_2 = or(_io_dataIn_ready_T, _io_dataIn_ready_T_1) @[dut.scala 32:33]
    io.dataIn.ready <= _io_dataIn_ready_T_2 @[dut.scala 32:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 35:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 36:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 38:21]
      when _T_1 : @[dut.scala 38:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 39:18]
        dataValid <= UInt<1>("h1") @[dut.scala 40:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 42:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 42:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 42:18]
    node assembled = cat(dataSelect[1], dataSelect[0]) @[Cat.scala 33:92]
    node truncated = bits(assembled, 7, 0) @[dut.scala 48:28]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 49:41]
    _io_dataOut_bits_WIRE <= truncated @[dut.scala 49:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 49:20]
    io.dataOut.valid <= dataValid @[dut.scala 50:20]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 53:25]
      dataValid <= UInt<1>("h0") @[dut.scala 54:15]


