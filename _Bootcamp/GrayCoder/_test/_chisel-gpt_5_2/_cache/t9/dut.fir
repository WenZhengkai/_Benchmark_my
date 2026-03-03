circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEnc_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 13:32]
    node grayEnc = xor(io.in, _grayEnc_T) @[dut.scala 13:23]
    wire decVec : UInt<64>[7] @[dut.scala 17:20]
    decVec[0] <= io.in @[dut.scala 18:13]
    node _decVec_1_T = dshr(decVec[0], UInt<1>("h1")) @[dut.scala 22:49]
    node _decVec_1_T_1 = xor(decVec[0], _decVec_1_T) @[dut.scala 22:32]
    decVec[1] <= _decVec_1_T_1 @[dut.scala 22:15]
    node _decVec_2_T = dshr(decVec[1], UInt<2>("h2")) @[dut.scala 22:49]
    node _decVec_2_T_1 = xor(decVec[1], _decVec_2_T) @[dut.scala 22:32]
    decVec[2] <= _decVec_2_T_1 @[dut.scala 22:15]
    node _decVec_3_T = dshr(decVec[2], UInt<3>("h4")) @[dut.scala 22:49]
    node _decVec_3_T_1 = xor(decVec[2], _decVec_3_T) @[dut.scala 22:32]
    decVec[3] <= _decVec_3_T_1 @[dut.scala 22:15]
    node _decVec_4_T = dshr(decVec[3], UInt<4>("h8")) @[dut.scala 22:49]
    node _decVec_4_T_1 = xor(decVec[3], _decVec_4_T) @[dut.scala 22:32]
    decVec[4] <= _decVec_4_T_1 @[dut.scala 22:15]
    node _decVec_5_T = dshr(decVec[4], UInt<5>("h10")) @[dut.scala 22:49]
    node _decVec_5_T_1 = xor(decVec[4], _decVec_5_T) @[dut.scala 22:32]
    decVec[5] <= _decVec_5_T_1 @[dut.scala 22:15]
    node _decVec_6_T = dshr(decVec[5], UInt<6>("h20")) @[dut.scala 22:49]
    node _decVec_6_T_1 = xor(decVec[5], _decVec_6_T) @[dut.scala 22:32]
    decVec[6] <= _decVec_6_T_1 @[dut.scala 22:15]
    node _io_out_T = mux(io.encode, grayEnc, decVec[6]) @[dut.scala 26:16]
    io.out <= _io_out_T @[dut.scala 26:10]

