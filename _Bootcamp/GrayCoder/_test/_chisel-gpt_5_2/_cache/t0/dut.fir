circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _gray_T = shr(io.in, 1) @[dut.scala 14:29]
    node gray = xor(io.in, _gray_T) @[dut.scala 14:20]
    wire decVec : UInt<64>[7] @[dut.scala 18:20]
    decVec[0] <= io.in @[dut.scala 19:13]
    node _decVec_1_T = shr(decVec[0], 1) @[dut.scala 21:49]
    node _decVec_1_T_1 = xor(decVec[0], _decVec_1_T) @[dut.scala 21:32]
    decVec[1] <= _decVec_1_T_1 @[dut.scala 21:15]
    node _decVec_2_T = shr(decVec[1], 2) @[dut.scala 21:49]
    node _decVec_2_T_1 = xor(decVec[1], _decVec_2_T) @[dut.scala 21:32]
    decVec[2] <= _decVec_2_T_1 @[dut.scala 21:15]
    node _decVec_3_T = shr(decVec[2], 4) @[dut.scala 21:49]
    node _decVec_3_T_1 = xor(decVec[2], _decVec_3_T) @[dut.scala 21:32]
    decVec[3] <= _decVec_3_T_1 @[dut.scala 21:15]
    node _decVec_4_T = shr(decVec[3], 8) @[dut.scala 21:49]
    node _decVec_4_T_1 = xor(decVec[3], _decVec_4_T) @[dut.scala 21:32]
    decVec[4] <= _decVec_4_T_1 @[dut.scala 21:15]
    node _decVec_5_T = shr(decVec[4], 16) @[dut.scala 21:49]
    node _decVec_5_T_1 = xor(decVec[4], _decVec_5_T) @[dut.scala 21:32]
    decVec[5] <= _decVec_5_T_1 @[dut.scala 21:15]
    node _decVec_6_T = shr(decVec[5], 32) @[dut.scala 21:49]
    node _decVec_6_T_1 = xor(decVec[5], _decVec_6_T) @[dut.scala 21:32]
    decVec[6] <= _decVec_6_T_1 @[dut.scala 21:15]
    node _io_out_T = mux(io.encode, gray, decVec[6]) @[dut.scala 25:16]
    io.out <= _io_out_T @[dut.scala 25:10]

