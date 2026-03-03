circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:27]
    wire _dataSelect_WIRE : UInt<5>[2] @[dut.scala 18:35]
    _dataSelect_WIRE[0] <= UInt<5>("h0") @[dut.scala 18:35]
    _dataSelect_WIRE[1] <= UInt<5>("h0") @[dut.scala 18:35]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (reset, _dataSelect_WIRE) @[dut.scala 18:27]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:27]
    io.dataOut.valid <= dataValid @[dut.scala 23:20]
    node _io_dataOut_bits_T = cat(dataSelect[1], dataSelect[0]) @[dut.scala 24:40]
    node _io_dataOut_bits_T_1 = bits(_io_dataOut_bits_T, 7, 0) @[dut.scala 24:42]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 24:69]
    _io_dataOut_bits_WIRE <= _io_dataOut_bits_T_1 @[dut.scala 24:69]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 24:20]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 27:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 27:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 27:19]
    node _T = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 30:25]
      dataValid <= UInt<1>("h0") @[dut.scala 31:15]
    node _T_1 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 34:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 35:28]
      node _T_2 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 37:21]
      when _T_2 : @[dut.scala 37:36]
        cycleCount <= UInt<1>("h0") @[dut.scala 38:18]
        dataValid <= UInt<1>("h1") @[dut.scala 39:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 41:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 41:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 41:18]


