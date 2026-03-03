circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _gray_T = shr(io.in, 1) @[dut.scala 15:29]
    node gray = xor(io.in, _gray_T) @[dut.scala 15:20]
    wire decodeStages : UInt<64>[7] @[dut.scala 19:26]
    decodeStages[0] <= io.in @[dut.scala 20:19]
    node _decodeStages_1_T = shr(decodeStages[0], 1) @[dut.scala 23:67]
    node _decodeStages_1_T_1 = xor(decodeStages[0], _decodeStages_1_T) @[dut.scala 23:44]
    decodeStages[1] <= _decodeStages_1_T_1 @[dut.scala 23:21]
    node _decodeStages_2_T = shr(decodeStages[1], 2) @[dut.scala 23:67]
    node _decodeStages_2_T_1 = xor(decodeStages[1], _decodeStages_2_T) @[dut.scala 23:44]
    decodeStages[2] <= _decodeStages_2_T_1 @[dut.scala 23:21]
    node _decodeStages_3_T = shr(decodeStages[2], 4) @[dut.scala 23:67]
    node _decodeStages_3_T_1 = xor(decodeStages[2], _decodeStages_3_T) @[dut.scala 23:44]
    decodeStages[3] <= _decodeStages_3_T_1 @[dut.scala 23:21]
    node _decodeStages_4_T = shr(decodeStages[3], 8) @[dut.scala 23:67]
    node _decodeStages_4_T_1 = xor(decodeStages[3], _decodeStages_4_T) @[dut.scala 23:44]
    decodeStages[4] <= _decodeStages_4_T_1 @[dut.scala 23:21]
    node _decodeStages_5_T = shr(decodeStages[4], 16) @[dut.scala 23:67]
    node _decodeStages_5_T_1 = xor(decodeStages[4], _decodeStages_5_T) @[dut.scala 23:44]
    decodeStages[5] <= _decodeStages_5_T_1 @[dut.scala 23:21]
    node _decodeStages_6_T = shr(decodeStages[5], 32) @[dut.scala 23:67]
    node _decodeStages_6_T_1 = xor(decodeStages[5], _decodeStages_6_T) @[dut.scala 23:44]
    decodeStages[6] <= _decodeStages_6_T_1 @[dut.scala 23:21]
    node _io_out_T = mux(io.encode, gray, decodeStages[6]) @[dut.scala 27:16]
    io.out <= _io_out_T @[dut.scala 27:10]

