circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _encoded_T = shr(io.in, 1) @[dut.scala 14:32]
    node encoded = xor(io.in, _encoded_T) @[dut.scala 14:23]
    wire decVec : UInt<64>[8] @[dut.scala 19:20]
    decVec[0] <= io.in @[dut.scala 20:13]
    node _decVec_1_T = shr(decVec[0], 1) @[dut.scala 23:45]
    node _decVec_1_T_1 = xor(decVec[0], _decVec_1_T) @[dut.scala 23:32]
    decVec[1] <= _decVec_1_T_1 @[dut.scala 23:19]
    node _decVec_2_T = shr(decVec[1], 2) @[dut.scala 23:45]
    node _decVec_2_T_1 = xor(decVec[1], _decVec_2_T) @[dut.scala 23:32]
    decVec[2] <= _decVec_2_T_1 @[dut.scala 23:19]
    node _decVec_3_T = shr(decVec[2], 4) @[dut.scala 23:45]
    node _decVec_3_T_1 = xor(decVec[2], _decVec_3_T) @[dut.scala 23:32]
    decVec[3] <= _decVec_3_T_1 @[dut.scala 23:19]
    node _decVec_4_T = shr(decVec[3], 8) @[dut.scala 23:45]
    node _decVec_4_T_1 = xor(decVec[3], _decVec_4_T) @[dut.scala 23:32]
    decVec[4] <= _decVec_4_T_1 @[dut.scala 23:19]
    node _decVec_5_T = shr(decVec[4], 16) @[dut.scala 23:45]
    node _decVec_5_T_1 = xor(decVec[4], _decVec_5_T) @[dut.scala 23:32]
    decVec[5] <= _decVec_5_T_1 @[dut.scala 23:19]
    node _decVec_6_T = shr(decVec[5], 32) @[dut.scala 23:45]
    node _decVec_6_T_1 = xor(decVec[5], _decVec_6_T) @[dut.scala 23:32]
    decVec[6] <= _decVec_6_T_1 @[dut.scala 23:19]
    node _decVec_7_T = shr(decVec[6], 64) @[dut.scala 23:45]
    node _decVec_7_T_1 = xor(decVec[6], _decVec_7_T) @[dut.scala 23:32]
    decVec[7] <= _decVec_7_T_1 @[dut.scala 23:19]
    node _io_out_T = mux(io.encode, encoded, decVec[7]) @[dut.scala 27:16]
    io.out <= _io_out_T @[dut.scala 27:10]

