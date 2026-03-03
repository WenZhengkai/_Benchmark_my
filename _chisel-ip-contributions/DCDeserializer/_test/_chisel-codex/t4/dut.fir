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
    io.dataOut.valid <= dataValid @[dut.scala 23:20]
    node assembled = cat(dataSelect[1], dataSelect[0]) @[Cat.scala 33:92]
    node trimmed = bits(assembled, 7, 0) @[dut.scala 27:19]
    wire _io_dataOut_bits_WIRE : UInt<8> @[dut.scala 28:38]
    _io_dataOut_bits_WIRE <= trimmed @[dut.scala 28:38]
    io.dataOut.bits <= _io_dataOut_bits_WIRE @[dut.scala 28:19]
    node _io_dataIn_ready_T = eq(dataValid, UInt<1>("h0")) @[dut.scala 31:22]
    node _io_dataIn_ready_T_1 = or(_io_dataIn_ready_T, io.dataOut.ready) @[dut.scala 31:33]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[dut.scala 31:19]
    node inFire = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    node outFire = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
    when outFire : @[dut.scala 37:17]
      dataValid <= UInt<1>("h0") @[dut.scala 38:15]
    when inFire : @[dut.scala 42:16]
      dataSelect[cycleCount] <= io.dataIn.bits @[dut.scala 43:28]
      node _T = eq(cycleCount, UInt<1>("h1")) @[dut.scala 44:21]
      when _T : @[dut.scala 44:41]
        dataValid <= UInt<1>("h1") @[dut.scala 45:17]
        cycleCount <= UInt<1>("h0") @[dut.scala 46:18]
      else :
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[dut.scala 48:32]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[dut.scala 48:32]
        cycleCount <= _cycleCount_T_1 @[dut.scala 48:18]


