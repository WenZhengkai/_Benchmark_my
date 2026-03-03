circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:27]
    wire _dataSelect_WIRE : UInt<5>[2] @[dut.scala 23:35]
    _dataSelect_WIRE[0] <= UInt<5>("h0") @[dut.scala 23:35]
    _dataSelect_WIRE[1] <= UInt<5>("h0") @[dut.scala 23:35]
    reg dataSelect : UInt<5>[2], clock with :
      reset => (reset, _dataSelect_WIRE) @[dut.scala 23:27]
    reg dataValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:27]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 29:22]
    io.dataIn.ready <= _io_dataIn_ready_T @[dut.scala 29:19]
    node assembled = cat(dataSelect[1], dataSelect[0]) @[dut.scala 34:30]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 35:41]
    _io_dataOut_bits_WIRE <= assembled @[dut.scala 35:41]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 35:20]
    io.dataOut.valid <= dataValid @[dut.scala 36:20]
    node _T = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 38:24]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 39:28]
      node _T_1 = eq(cycleCount, UInt<1>("h1")) @[dut.scala 41:21]
      when _T_1 : @[dut.scala 41:41]
        cycleCount <= UInt<1>("h0") @[dut.scala 42:18]
        dataValid <= UInt<1>("h1") @[dut.scala 43:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 45:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 45:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 45:18]
    node _T_2 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 49:25]
      dataValid <= UInt<1>("h0") @[dut.scala 50:15]


