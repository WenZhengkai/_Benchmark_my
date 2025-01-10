circuit DCDeserializer :
  module DCDeserializer :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 25:27]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (UInt<1>("h0"), dataSelect) @[golden.scala 26:23]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 27:26]
    wire _io_dataOut_bits_WIRE : UInt<8> @[golden.scala 29:41]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[golden.scala 29:41]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[golden.scala 29:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[golden.scala 29:19]
    io.dataOut.valid <= dataValid @[golden.scala 30:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[golden.scala 31:22]
    node _io_dataIn_ready_T_1 = and(dataValid, io.dataOut.ready) @[golden.scala 31:45]
    node _io_dataIn_ready_T_2 = or(_io_dataIn_ready_T, _io_dataIn_ready_T_1) @[golden.scala 31:33]
    io.dataIn.ready <= _io_dataIn_ready_T_2 @[golden.scala 31:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[golden.scala 33:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[golden.scala 34:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[golden.scala 35:21]
      when _T_1 : @[golden.scala 35:41]
        dataValid <= UInt<1>("h1") @[golden.scala 36:17]
        cycleCount <= UInt<1>("h0") @[golden.scala 37:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[golden.scala 39:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[golden.scala 39:32]
        cycleCount <= _cycleCount_T_1 @[golden.scala 39:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[golden.scala 42:25]
      dataValid <= UInt<1>("h0") @[golden.scala 43:15]


