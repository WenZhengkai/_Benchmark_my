circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 16:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 16:27]
    wire decodeIterations : UInt<64>[7] @[dut.scala 23:30]
    decodeIterations[0] <= io.in @[dut.scala 24:23]
    node _decodeIterations_1_T = dshr(decodeIterations[0], UInt<1>("h1")) @[dut.scala 29:75]
    node _decodeIterations_1_T_1 = xor(decodeIterations[0], _decodeIterations_1_T) @[dut.scala 29:52]
    decodeIterations[1] <= _decodeIterations_1_T_1 @[dut.scala 29:29]
    node _decodeIterations_2_T = dshr(decodeIterations[1], UInt<2>("h2")) @[dut.scala 29:75]
    node _decodeIterations_2_T_1 = xor(decodeIterations[1], _decodeIterations_2_T) @[dut.scala 29:52]
    decodeIterations[2] <= _decodeIterations_2_T_1 @[dut.scala 29:29]
    node _decodeIterations_3_T = dshr(decodeIterations[2], UInt<3>("h4")) @[dut.scala 29:75]
    node _decodeIterations_3_T_1 = xor(decodeIterations[2], _decodeIterations_3_T) @[dut.scala 29:52]
    decodeIterations[3] <= _decodeIterations_3_T_1 @[dut.scala 29:29]
    node _decodeIterations_4_T = dshr(decodeIterations[3], UInt<4>("h8")) @[dut.scala 29:75]
    node _decodeIterations_4_T_1 = xor(decodeIterations[3], _decodeIterations_4_T) @[dut.scala 29:52]
    decodeIterations[4] <= _decodeIterations_4_T_1 @[dut.scala 29:29]
    node _decodeIterations_5_T = dshr(decodeIterations[4], UInt<5>("h10")) @[dut.scala 29:75]
    node _decodeIterations_5_T_1 = xor(decodeIterations[4], _decodeIterations_5_T) @[dut.scala 29:52]
    decodeIterations[5] <= _decodeIterations_5_T_1 @[dut.scala 29:29]
    node _decodeIterations_6_T = dshr(decodeIterations[5], UInt<6>("h20")) @[dut.scala 29:75]
    node _decodeIterations_6_T_1 = xor(decodeIterations[5], _decodeIterations_6_T) @[dut.scala 29:52]
    decodeIterations[6] <= _decodeIterations_6_T_1 @[dut.scala 29:29]
    node _io_out_T = mux(io.encode, grayEncoded, decodeIterations[6]) @[dut.scala 36:16]
    io.out <= _io_out_T @[dut.scala 36:10]

