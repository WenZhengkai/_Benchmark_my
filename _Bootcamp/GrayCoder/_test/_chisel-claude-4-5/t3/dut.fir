circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    when io.encode : @[dut.scala 12:19]
      node _io_out_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 14:30]
      node _io_out_T_1 = xor(io.in, _io_out_T) @[dut.scala 14:21]
      io.out <= _io_out_T_1 @[dut.scala 14:12]
    else :
      wire intermediate : UInt<64>[7] @[dut.scala 18:28]
      intermediate[0] <= io.in @[dut.scala 21:21]
      node _intermediate_1_T = dshr(intermediate[0], UInt<1>("h1")) @[dut.scala 26:65]
      node _intermediate_1_T_1 = xor(intermediate[0], _intermediate_1_T) @[dut.scala 26:46]
      intermediate[1] <= _intermediate_1_T_1 @[dut.scala 26:27]
      node _intermediate_2_T = dshr(intermediate[1], UInt<2>("h2")) @[dut.scala 26:65]
      node _intermediate_2_T_1 = xor(intermediate[1], _intermediate_2_T) @[dut.scala 26:46]
      intermediate[2] <= _intermediate_2_T_1 @[dut.scala 26:27]
      node _intermediate_3_T = dshr(intermediate[2], UInt<3>("h4")) @[dut.scala 26:65]
      node _intermediate_3_T_1 = xor(intermediate[2], _intermediate_3_T) @[dut.scala 26:46]
      intermediate[3] <= _intermediate_3_T_1 @[dut.scala 26:27]
      node _intermediate_4_T = dshr(intermediate[3], UInt<4>("h8")) @[dut.scala 26:65]
      node _intermediate_4_T_1 = xor(intermediate[3], _intermediate_4_T) @[dut.scala 26:46]
      intermediate[4] <= _intermediate_4_T_1 @[dut.scala 26:27]
      node _intermediate_5_T = dshr(intermediate[4], UInt<5>("h10")) @[dut.scala 26:65]
      node _intermediate_5_T_1 = xor(intermediate[4], _intermediate_5_T) @[dut.scala 26:46]
      intermediate[5] <= _intermediate_5_T_1 @[dut.scala 26:27]
      node _intermediate_6_T = dshr(intermediate[5], UInt<6>("h20")) @[dut.scala 26:65]
      node _intermediate_6_T_1 = xor(intermediate[5], _intermediate_6_T) @[dut.scala 26:46]
      intermediate[6] <= _intermediate_6_T_1 @[dut.scala 26:27]
      io.out <= intermediate[6] @[dut.scala 30:12]


