circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 18:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:27]
    node packed = cat(dataSelect[1], dataSelect[0]) @[dut.scala 22:27]
    node _io_dataOut_bits_T = bits(packed, 7, 0) @[dut.scala 23:29]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 23:56]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 23:56]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 23:20]
    io.dataOut.valid <= dataValid @[dut.scala 24:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 27:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 27:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 27:19]
    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 37:29]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 40:26]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 41:30]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 42:23]
      when _T_1 : @[dut.scala 42:36]
        cycleCount <= UInt<1>("h0") @[dut.scala 43:20]
        dataValid <= UInt<1>("h1") @[dut.scala 44:19]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 46:34]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 46:34]
        cycleCount <= _cycleCount_T_1 @[dut.scala 46:20]
        dataValid <= UInt<1>("h0") @[dut.scala 47:19]
    else :
      node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
      when _T_2 : @[dut.scala 49:33]
        dataValid <= UInt<1>("h0") @[dut.scala 50:17]


