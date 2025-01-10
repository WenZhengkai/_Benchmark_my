circuit DCSerializer :
  module DCSerializer :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, dataOut : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<5>}}

    reg cycleCount : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 20:27]
    wire dataSelect : UInt<5>[2] @[golden.scala 21:24]
    wire _WIRE : UInt<5>[2] @[golden.scala 23:40]
    wire _WIRE_1 : UInt<10> @[golden.scala 23:40]
    _WIRE_1 <= io.dataIn.bits @[golden.scala 23:40]
    node _T = bits(_WIRE_1, 4, 0) @[golden.scala 23:40]
    _WIRE[0] <= _T @[golden.scala 23:40]
    node _T_1 = bits(_WIRE_1, 9, 5) @[golden.scala 23:40]
    _WIRE[1] <= _T_1 @[golden.scala 23:40]
    dataSelect <= _WIRE @[golden.scala 23:14]
    io.dataOut.bits <= dataSelect[cycleCount] @[golden.scala 25:19]
    io.dataOut.valid <= io.dataIn.valid @[golden.scala 26:20]
    node _io_dataIn_ready_T = eq(cycleCount, UInt<1>("h1")) @[golden.scala 27:53]
    node _io_dataIn_ready_T_1 = and(io.dataOut.ready, _io_dataIn_ready_T) @[golden.scala 27:39]
    io.dataIn.ready <= _io_dataIn_ready_T_1 @[golden.scala 27:19]
    node _T_2 = and(io.dataIn.ready, io.dataIn.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[golden.scala 29:24]
      cycleCount <= UInt<1>("h0") @[golden.scala 30:16]
    else :
      node _T_3 = and(io.dataOut.ready, io.dataOut.valid) @[Decoupled.scala 51:35]
      when _T_3 : @[golden.scala 31:31]
        node _cycleCount_T = add(cycleCount, UInt<1>("h1")) @[golden.scala 32:30]
        node _cycleCount_T_1 = tail(_cycleCount_T, 1) @[golden.scala 32:30]
        cycleCount <= _cycleCount_T_1 @[golden.scala 32:16]


