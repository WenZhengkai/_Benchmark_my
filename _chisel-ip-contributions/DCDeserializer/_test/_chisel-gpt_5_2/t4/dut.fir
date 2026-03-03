circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:35]
    wire _dataSelect_WIRE : UInt<5>[2] @[dut.scala 31:43]
    _dataSelect_WIRE[0] <= UInt<5>("h0") @[dut.scala 31:43]
    _dataSelect_WIRE[1] <= UInt<5>("h0") @[dut.scala 31:43]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (reset, _dataSelect_WIRE) @[dut.scala 31:35]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 34:34]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 39:23]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 39:34]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 39:20]
    io.dataOut.valid <= dataValid @[dut.scala 40:20]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 44:33]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 44:48]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T @[dut.scala 44:48]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 44:19]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 47:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 48:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 50:21]
      when _T_1 : @[dut.scala 50:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 51:18]
        dataValid <= UInt<1>("h1") @[dut.scala 52:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 54:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 54:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 54:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 59:25]
      dataValid <= UInt<1>("h0") @[dut.scala 60:15]


