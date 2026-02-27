circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 16:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 16:27]
    wire decodeIters : UInt<64>[7] @[dut.scala 21:25]
    decodeIters[0] <= io.in @[dut.scala 24:18]
    node _decodeIters_1_T = dshr(decodeIters[0], UInt<1>("h1")) @[dut.scala 29:60]
    node _decodeIters_1_T_1 = xor(decodeIters[0], _decodeIters_1_T) @[dut.scala 29:42]
    decodeIters[1] <= _decodeIters_1_T_1 @[dut.scala 29:24]
    node _decodeIters_2_T = dshr(decodeIters[1], UInt<2>("h2")) @[dut.scala 29:60]
    node _decodeIters_2_T_1 = xor(decodeIters[1], _decodeIters_2_T) @[dut.scala 29:42]
    decodeIters[2] <= _decodeIters_2_T_1 @[dut.scala 29:24]
    node _decodeIters_3_T = dshr(decodeIters[2], UInt<3>("h4")) @[dut.scala 29:60]
    node _decodeIters_3_T_1 = xor(decodeIters[2], _decodeIters_3_T) @[dut.scala 29:42]
    decodeIters[3] <= _decodeIters_3_T_1 @[dut.scala 29:24]
    node _decodeIters_4_T = dshr(decodeIters[3], UInt<4>("h8")) @[dut.scala 29:60]
    node _decodeIters_4_T_1 = xor(decodeIters[3], _decodeIters_4_T) @[dut.scala 29:42]
    decodeIters[4] <= _decodeIters_4_T_1 @[dut.scala 29:24]
    node _decodeIters_5_T = dshr(decodeIters[4], UInt<5>("h10")) @[dut.scala 29:60]
    node _decodeIters_5_T_1 = xor(decodeIters[4], _decodeIters_5_T) @[dut.scala 29:42]
    decodeIters[5] <= _decodeIters_5_T_1 @[dut.scala 29:24]
    node _decodeIters_6_T = dshr(decodeIters[5], UInt<6>("h20")) @[dut.scala 29:60]
    node _decodeIters_6_T_1 = xor(decodeIters[5], _decodeIters_6_T) @[dut.scala 29:42]
    decodeIters[6] <= _decodeIters_6_T_1 @[dut.scala 29:24]
    node _io_out_T = mux(io.encode, grayEncoded, decodeIters[6]) @[dut.scala 36:16]
    io.out <= _io_out_T @[dut.scala 36:10]

