circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    when io.encode : @[dut.scala 12:20]
      node _io_out_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 14:30]
      node _io_out_T_1 = xor(io.in, _io_out_T) @[dut.scala 14:21]
      io.out <= _io_out_T_1 @[dut.scala 14:12]
    else :
      wire decodingSteps : UInt<64>[7] @[dut.scala 21:29]
      decodingSteps[0] <= io.in @[dut.scala 22:22]
      node _decodingSteps_1_T = dshr(decodingSteps[0], UInt<1>("h1")) @[dut.scala 27:68]
      node _decodingSteps_1_T_1 = xor(decodingSteps[0], _decodingSteps_1_T) @[dut.scala 27:48]
      decodingSteps[1] <= _decodingSteps_1_T_1 @[dut.scala 27:28]
      node _decodingSteps_2_T = dshr(decodingSteps[1], UInt<2>("h2")) @[dut.scala 27:68]
      node _decodingSteps_2_T_1 = xor(decodingSteps[1], _decodingSteps_2_T) @[dut.scala 27:48]
      decodingSteps[2] <= _decodingSteps_2_T_1 @[dut.scala 27:28]
      node _decodingSteps_3_T = dshr(decodingSteps[2], UInt<3>("h4")) @[dut.scala 27:68]
      node _decodingSteps_3_T_1 = xor(decodingSteps[2], _decodingSteps_3_T) @[dut.scala 27:48]
      decodingSteps[3] <= _decodingSteps_3_T_1 @[dut.scala 27:28]
      node _decodingSteps_4_T = dshr(decodingSteps[3], UInt<4>("h8")) @[dut.scala 27:68]
      node _decodingSteps_4_T_1 = xor(decodingSteps[3], _decodingSteps_4_T) @[dut.scala 27:48]
      decodingSteps[4] <= _decodingSteps_4_T_1 @[dut.scala 27:28]
      node _decodingSteps_5_T = dshr(decodingSteps[4], UInt<5>("h10")) @[dut.scala 27:68]
      node _decodingSteps_5_T_1 = xor(decodingSteps[4], _decodingSteps_5_T) @[dut.scala 27:48]
      decodingSteps[5] <= _decodingSteps_5_T_1 @[dut.scala 27:28]
      node _decodingSteps_6_T = dshr(decodingSteps[5], UInt<6>("h20")) @[dut.scala 27:68]
      node _decodingSteps_6_T_1 = xor(decodingSteps[5], _decodingSteps_6_T) @[dut.scala 27:48]
      decodingSteps[6] <= _decodingSteps_6_T_1 @[dut.scala 27:28]
      io.out <= decodingSteps[6] @[dut.scala 31:12]


