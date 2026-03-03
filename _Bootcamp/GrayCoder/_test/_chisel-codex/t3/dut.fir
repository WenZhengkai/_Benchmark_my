circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = shr(io.in, 1) @[dut.scala 15:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 15:27]
    wire decodeChain : UInt<64>[7] @[dut.scala 19:25]
    decodeChain[0] <= io.in @[dut.scala 20:18]
    node _decodeChain_1_T = shr(decodeChain[0], 1) @[dut.scala 24:60]
    node _decodeChain_1_T_1 = xor(decodeChain[0], _decodeChain_1_T) @[dut.scala 24:42]
    decodeChain[1] <= _decodeChain_1_T_1 @[dut.scala 24:24]
    node _decodeChain_2_T = shr(decodeChain[1], 2) @[dut.scala 24:60]
    node _decodeChain_2_T_1 = xor(decodeChain[1], _decodeChain_2_T) @[dut.scala 24:42]
    decodeChain[2] <= _decodeChain_2_T_1 @[dut.scala 24:24]
    node _decodeChain_3_T = shr(decodeChain[2], 4) @[dut.scala 24:60]
    node _decodeChain_3_T_1 = xor(decodeChain[2], _decodeChain_3_T) @[dut.scala 24:42]
    decodeChain[3] <= _decodeChain_3_T_1 @[dut.scala 24:24]
    node _decodeChain_4_T = shr(decodeChain[3], 8) @[dut.scala 24:60]
    node _decodeChain_4_T_1 = xor(decodeChain[3], _decodeChain_4_T) @[dut.scala 24:42]
    decodeChain[4] <= _decodeChain_4_T_1 @[dut.scala 24:24]
    node _decodeChain_5_T = shr(decodeChain[4], 16) @[dut.scala 24:60]
    node _decodeChain_5_T_1 = xor(decodeChain[4], _decodeChain_5_T) @[dut.scala 24:42]
    decodeChain[5] <= _decodeChain_5_T_1 @[dut.scala 24:24]
    node _decodeChain_6_T = shr(decodeChain[5], 32) @[dut.scala 24:60]
    node _decodeChain_6_T_1 = xor(decodeChain[5], _decodeChain_6_T) @[dut.scala 24:42]
    decodeChain[6] <= _decodeChain_6_T_1 @[dut.scala 24:24]
    node _io_out_T = mux(io.encode, grayEncoded, decodeChain[6]) @[dut.scala 29:16]
    io.out <= _io_out_T @[dut.scala 29:10]

