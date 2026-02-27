circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    when io.encode : @[dut.scala 14:19]
      node _io_out_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 16:30]
      node _io_out_T_1 = xor(io.in, _io_out_T) @[dut.scala 16:21]
      io.out <= _io_out_T_1 @[dut.scala 16:12]
    else :
      wire intermediateValues : UInt<64>[7] @[dut.scala 23:34]
      intermediateValues[0] <= io.in @[dut.scala 24:27]
      node _intermediateValues_1_T = dshr(intermediateValues[0], UInt<1>("h1")) @[dut.scala 29:83]
      node _intermediateValues_1_T_1 = xor(intermediateValues[0], _intermediateValues_1_T) @[dut.scala 29:58]
      intermediateValues[1] <= _intermediateValues_1_T_1 @[dut.scala 29:33]
      node _intermediateValues_2_T = dshr(intermediateValues[1], UInt<2>("h2")) @[dut.scala 29:83]
      node _intermediateValues_2_T_1 = xor(intermediateValues[1], _intermediateValues_2_T) @[dut.scala 29:58]
      intermediateValues[2] <= _intermediateValues_2_T_1 @[dut.scala 29:33]
      node _intermediateValues_3_T = dshr(intermediateValues[2], UInt<3>("h4")) @[dut.scala 29:83]
      node _intermediateValues_3_T_1 = xor(intermediateValues[2], _intermediateValues_3_T) @[dut.scala 29:58]
      intermediateValues[3] <= _intermediateValues_3_T_1 @[dut.scala 29:33]
      node _intermediateValues_4_T = dshr(intermediateValues[3], UInt<4>("h8")) @[dut.scala 29:83]
      node _intermediateValues_4_T_1 = xor(intermediateValues[3], _intermediateValues_4_T) @[dut.scala 29:58]
      intermediateValues[4] <= _intermediateValues_4_T_1 @[dut.scala 29:33]
      node _intermediateValues_5_T = dshr(intermediateValues[4], UInt<5>("h10")) @[dut.scala 29:83]
      node _intermediateValues_5_T_1 = xor(intermediateValues[4], _intermediateValues_5_T) @[dut.scala 29:58]
      intermediateValues[5] <= _intermediateValues_5_T_1 @[dut.scala 29:33]
      node _intermediateValues_6_T = dshr(intermediateValues[5], UInt<6>("h20")) @[dut.scala 29:83]
      node _intermediateValues_6_T_1 = xor(intermediateValues[5], _intermediateValues_6_T) @[dut.scala 29:58]
      intermediateValues[6] <= _intermediateValues_6_T_1 @[dut.scala 29:33]
      io.out <= intermediateValues[6] @[dut.scala 33:12]


