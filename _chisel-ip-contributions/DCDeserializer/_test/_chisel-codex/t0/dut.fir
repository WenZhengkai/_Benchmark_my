circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    wire _dataSelect_WIRE : UInt<5>[2] @[dut.scala 19:35]
    _dataSelect_WIRE[0] <= UInt<5>("h0") @[dut.scala 19:35]
    _dataSelect_WIRE[1] <= UInt<5>("h0") @[dut.scala 19:35]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (reset, _dataSelect_WIRE) @[dut.scala 19:27]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:27]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 23:23]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 23:34]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 23:20]
    io.dataOut.valid <= dataValid @[dut.scala 24:20]
    node packed = cat(dataSelect[1], dataSelect[0]) @[dut.scala 27:27]
    node _io_dataOut_bits_T = bits(packed, 7, 0) @[dut.scala 28:28]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 28:55]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 28:55]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 28:19]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 31:25]
      dataValid <= UInt<1>("h0") @[dut.scala 32:15]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 35:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 36:28]
      node _T_2 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 42:23]
      when _T_2 : @[dut.scala 42:43]
        dataValid <= UInt<1>("h1") @[dut.scala 43:20]
        cycleCount <= UInt<1>("h0") @[dut.scala 44:20]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 46:34]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 46:34]
        cycleCount <= _cycleCount_T_1 @[dut.scala 46:20]


