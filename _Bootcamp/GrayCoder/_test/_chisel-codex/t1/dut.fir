circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = shr(io.in, 1) @[dut.scala 15:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 15:27]
    wire decodeVec : UInt<64>[7] @[dut.scala 19:23]
    decodeVec[0] <= io.in @[dut.scala 20:16]
    node _decodeVec_1_T = shr(decodeVec[0], 1) @[dut.scala 23:54]
    node _decodeVec_1_T_1 = xor(decodeVec[0], _decodeVec_1_T) @[dut.scala 23:38]
    decodeVec[1] <= _decodeVec_1_T_1 @[dut.scala 23:22]
    node _decodeVec_2_T = shr(decodeVec[1], 2) @[dut.scala 23:54]
    node _decodeVec_2_T_1 = xor(decodeVec[1], _decodeVec_2_T) @[dut.scala 23:38]
    decodeVec[2] <= _decodeVec_2_T_1 @[dut.scala 23:22]
    node _decodeVec_3_T = shr(decodeVec[2], 4) @[dut.scala 23:54]
    node _decodeVec_3_T_1 = xor(decodeVec[2], _decodeVec_3_T) @[dut.scala 23:38]
    decodeVec[3] <= _decodeVec_3_T_1 @[dut.scala 23:22]
    node _decodeVec_4_T = shr(decodeVec[3], 8) @[dut.scala 23:54]
    node _decodeVec_4_T_1 = xor(decodeVec[3], _decodeVec_4_T) @[dut.scala 23:38]
    decodeVec[4] <= _decodeVec_4_T_1 @[dut.scala 23:22]
    node _decodeVec_5_T = shr(decodeVec[4], 16) @[dut.scala 23:54]
    node _decodeVec_5_T_1 = xor(decodeVec[4], _decodeVec_5_T) @[dut.scala 23:38]
    decodeVec[5] <= _decodeVec_5_T_1 @[dut.scala 23:22]
    node _decodeVec_6_T = shr(decodeVec[5], 32) @[dut.scala 23:54]
    node _decodeVec_6_T_1 = xor(decodeVec[5], _decodeVec_6_T) @[dut.scala 23:38]
    decodeVec[6] <= _decodeVec_6_T_1 @[dut.scala 23:22]
    node _io_out_T = mux(io.encode, grayEncoded, decodeVec[6]) @[dut.scala 27:16]
    io.out <= _io_out_T @[dut.scala 27:10]

