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
      wire intermediates : UInt<64>[7] @[dut.scala 18:29]
      intermediates[0] <= io.in @[dut.scala 21:22]
      node _intermediates_1_T = dshr(intermediates[0], UInt<1>("h1")) @[dut.scala 26:68]
      node _intermediates_1_T_1 = xor(intermediates[0], _intermediates_1_T) @[dut.scala 26:48]
      intermediates[1] <= _intermediates_1_T_1 @[dut.scala 26:28]
      node _intermediates_2_T = dshr(intermediates[1], UInt<2>("h2")) @[dut.scala 26:68]
      node _intermediates_2_T_1 = xor(intermediates[1], _intermediates_2_T) @[dut.scala 26:48]
      intermediates[2] <= _intermediates_2_T_1 @[dut.scala 26:28]
      node _intermediates_3_T = dshr(intermediates[2], UInt<3>("h4")) @[dut.scala 26:68]
      node _intermediates_3_T_1 = xor(intermediates[2], _intermediates_3_T) @[dut.scala 26:48]
      intermediates[3] <= _intermediates_3_T_1 @[dut.scala 26:28]
      node _intermediates_4_T = dshr(intermediates[3], UInt<4>("h8")) @[dut.scala 26:68]
      node _intermediates_4_T_1 = xor(intermediates[3], _intermediates_4_T) @[dut.scala 26:48]
      intermediates[4] <= _intermediates_4_T_1 @[dut.scala 26:28]
      node _intermediates_5_T = dshr(intermediates[4], UInt<5>("h10")) @[dut.scala 26:68]
      node _intermediates_5_T_1 = xor(intermediates[4], _intermediates_5_T) @[dut.scala 26:48]
      intermediates[5] <= _intermediates_5_T_1 @[dut.scala 26:28]
      node _intermediates_6_T = dshr(intermediates[5], UInt<6>("h20")) @[dut.scala 26:68]
      node _intermediates_6_T_1 = xor(intermediates[5], _intermediates_6_T) @[dut.scala 26:48]
      intermediates[6] <= _intermediates_6_T_1 @[dut.scala 26:28]
      io.out <= intermediates[6] @[dut.scala 30:12]


