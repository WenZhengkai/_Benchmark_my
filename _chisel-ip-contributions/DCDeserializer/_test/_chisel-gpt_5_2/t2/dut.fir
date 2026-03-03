circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[dut.scala 24:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:26]
    node outFire = and(io.dataOut.valid, io.dataOut.ready) @[dut.scala 32:34]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 33:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, outFire) @[dut.scala 33:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 33:19]
    io.dataOut.valid <= dataValid @[dut.scala 36:20]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 37:42]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 37:42]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 37:42]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 37:20]
    node inFire = and(io.dataIn.valid, io.dataIn.ready) @[dut.scala 40:32]
    when inFire : @[dut.scala 41:16]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 42:28]
      node _T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 44:21]
      when _T : @[dut.scala 44:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 45:18]
        dataValid <= UInt<1>("h1") @[dut.scala 46:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 48:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 48:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 48:18]
    when outFire : @[dut.scala 53:17]
      dataValid <= UInt<1>("h0") @[dut.scala 54:15]


