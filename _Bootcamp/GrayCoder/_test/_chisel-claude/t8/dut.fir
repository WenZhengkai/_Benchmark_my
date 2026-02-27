circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    when io.encode : @[dut.scala 13:19]
      node _io_out_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 15:30]
      node _io_out_T_1 = xor(io.in, _io_out_T) @[dut.scala 15:21]
      io.out <= _io_out_T_1 @[dut.scala 15:12]
    else :
      wire decodeSteps : UInt<64>[7] @[dut.scala 23:27]
      decodeSteps[0] <= io.in @[dut.scala 24:20]
      node _decodeSteps_1_T = dshr(decodeSteps[0], UInt<1>("h1")) @[dut.scala 29:62]
      node _decodeSteps_1_T_1 = xor(decodeSteps[0], _decodeSteps_1_T) @[dut.scala 29:44]
      decodeSteps[1] <= _decodeSteps_1_T_1 @[dut.scala 29:26]
      node _decodeSteps_2_T = dshr(decodeSteps[1], UInt<2>("h2")) @[dut.scala 29:62]
      node _decodeSteps_2_T_1 = xor(decodeSteps[1], _decodeSteps_2_T) @[dut.scala 29:44]
      decodeSteps[2] <= _decodeSteps_2_T_1 @[dut.scala 29:26]
      node _decodeSteps_3_T = dshr(decodeSteps[2], UInt<3>("h4")) @[dut.scala 29:62]
      node _decodeSteps_3_T_1 = xor(decodeSteps[2], _decodeSteps_3_T) @[dut.scala 29:44]
      decodeSteps[3] <= _decodeSteps_3_T_1 @[dut.scala 29:26]
      node _decodeSteps_4_T = dshr(decodeSteps[3], UInt<4>("h8")) @[dut.scala 29:62]
      node _decodeSteps_4_T_1 = xor(decodeSteps[3], _decodeSteps_4_T) @[dut.scala 29:44]
      decodeSteps[4] <= _decodeSteps_4_T_1 @[dut.scala 29:26]
      node _decodeSteps_5_T = dshr(decodeSteps[4], UInt<5>("h10")) @[dut.scala 29:62]
      node _decodeSteps_5_T_1 = xor(decodeSteps[4], _decodeSteps_5_T) @[dut.scala 29:44]
      decodeSteps[5] <= _decodeSteps_5_T_1 @[dut.scala 29:26]
      node _decodeSteps_6_T = dshr(decodeSteps[5], UInt<6>("h20")) @[dut.scala 29:62]
      node _decodeSteps_6_T_1 = xor(decodeSteps[5], _decodeSteps_6_T) @[dut.scala 29:44]
      decodeSteps[6] <= _decodeSteps_6_T_1 @[dut.scala 29:26]
      io.out <= decodeSteps[6] @[dut.scala 33:12]


