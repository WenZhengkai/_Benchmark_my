circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = shr(io.in, 1) @[dut.scala 15:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 15:27]
    wire decodeSteps : UInt<64>[7] @[dut.scala 19:25]
    decodeSteps[0] <= io.in @[dut.scala 20:18]
    node _decodeSteps_1_T = shr(decodeSteps[0], 1) @[dut.scala 23:60]
    node _decodeSteps_1_T_1 = xor(decodeSteps[0], _decodeSteps_1_T) @[dut.scala 23:42]
    decodeSteps[1] <= _decodeSteps_1_T_1 @[dut.scala 23:24]
    node _decodeSteps_2_T = shr(decodeSteps[1], 2) @[dut.scala 23:60]
    node _decodeSteps_2_T_1 = xor(decodeSteps[1], _decodeSteps_2_T) @[dut.scala 23:42]
    decodeSteps[2] <= _decodeSteps_2_T_1 @[dut.scala 23:24]
    node _decodeSteps_3_T = shr(decodeSteps[2], 4) @[dut.scala 23:60]
    node _decodeSteps_3_T_1 = xor(decodeSteps[2], _decodeSteps_3_T) @[dut.scala 23:42]
    decodeSteps[3] <= _decodeSteps_3_T_1 @[dut.scala 23:24]
    node _decodeSteps_4_T = shr(decodeSteps[3], 8) @[dut.scala 23:60]
    node _decodeSteps_4_T_1 = xor(decodeSteps[3], _decodeSteps_4_T) @[dut.scala 23:42]
    decodeSteps[4] <= _decodeSteps_4_T_1 @[dut.scala 23:24]
    node _decodeSteps_5_T = shr(decodeSteps[4], 16) @[dut.scala 23:60]
    node _decodeSteps_5_T_1 = xor(decodeSteps[4], _decodeSteps_5_T) @[dut.scala 23:42]
    decodeSteps[5] <= _decodeSteps_5_T_1 @[dut.scala 23:24]
    node _decodeSteps_6_T = shr(decodeSteps[5], 32) @[dut.scala 23:60]
    node _decodeSteps_6_T_1 = xor(decodeSteps[5], _decodeSteps_6_T) @[dut.scala 23:42]
    decodeSteps[6] <= _decodeSteps_6_T_1 @[dut.scala 23:24]
    node _io_out_T = mux(io.encode, grayEncoded, decodeSteps[6]) @[dut.scala 27:16]
    io.out <= _io_out_T @[dut.scala 27:10]

