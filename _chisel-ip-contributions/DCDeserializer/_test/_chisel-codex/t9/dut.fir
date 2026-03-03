circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:27]
    wire _dataSelect_WIRE : UInt<5>[2] @[dut.scala 17:35]
    _dataSelect_WIRE[0] <= UInt<5>("h0") @[dut.scala 17:35]
    _dataSelect_WIRE[1] <= UInt<5>("h0") @[dut.scala 17:35]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (reset, _dataSelect_WIRE) @[dut.scala 17:27]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 21:22]
    io.dataIn.ready <= _io_dataIn_ready_T @[dut.scala 21:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 23:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 24:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 26:21]
      when _T_1 : @[dut.scala 26:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 27:18]
        dataValid <= UInt<1>("h1") @[dut.scala 28:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 30:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 30:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 30:18]
    node packed = cat(dataSelect[1], dataSelect[0]) @[dut.scala 35:27]
    node _io_dataOut_bits_T = bits(packed, 7, 0) @[dut.scala 36:29]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 36:56]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 36:56]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 36:20]
    io.dataOut.valid <= dataValid @[dut.scala 37:20]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 39:25]
      dataValid <= UInt<1>("h0") @[dut.scala 40:15]


