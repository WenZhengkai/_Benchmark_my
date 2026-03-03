circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = shr(io.in, 1) @[dut.scala 15:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 15:27]
    wire stages : UInt<64>[7] @[dut.scala 18:20]
    stages[0] <= io.in @[dut.scala 19:13]
    node _stages_1_T = shr(stages[0], 1) @[dut.scala 22:45]
    node _stages_1_T_1 = xor(stages[0], _stages_1_T) @[dut.scala 22:32]
    stages[1] <= _stages_1_T_1 @[dut.scala 22:19]
    node _stages_2_T = shr(stages[1], 2) @[dut.scala 22:45]
    node _stages_2_T_1 = xor(stages[1], _stages_2_T) @[dut.scala 22:32]
    stages[2] <= _stages_2_T_1 @[dut.scala 22:19]
    node _stages_3_T = shr(stages[2], 4) @[dut.scala 22:45]
    node _stages_3_T_1 = xor(stages[2], _stages_3_T) @[dut.scala 22:32]
    stages[3] <= _stages_3_T_1 @[dut.scala 22:19]
    node _stages_4_T = shr(stages[3], 8) @[dut.scala 22:45]
    node _stages_4_T_1 = xor(stages[3], _stages_4_T) @[dut.scala 22:32]
    stages[4] <= _stages_4_T_1 @[dut.scala 22:19]
    node _stages_5_T = shr(stages[4], 16) @[dut.scala 22:45]
    node _stages_5_T_1 = xor(stages[4], _stages_5_T) @[dut.scala 22:32]
    stages[5] <= _stages_5_T_1 @[dut.scala 22:19]
    node _stages_6_T = shr(stages[5], 32) @[dut.scala 22:45]
    node _stages_6_T_1 = xor(stages[5], _stages_6_T) @[dut.scala 22:32]
    stages[6] <= _stages_6_T_1 @[dut.scala 22:19]
    node _io_out_T = mux(io.encode, grayEncoded, stages[6]) @[dut.scala 26:16]
    io.out <= _io_out_T @[dut.scala 26:10]

