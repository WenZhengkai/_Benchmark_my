circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _enc_T = shr(io.in, 1) @[dut.scala 15:28]
    node enc = xor(io.in, _enc_T) @[dut.scala 15:19]
    wire decodeVec : UInt<64>[7] @[dut.scala 20:23]
    decodeVec[0] <= io.in @[dut.scala 21:16]
    node _decodeVec_1_T = dshr(decodeVec[0], UInt<1>("h1")) @[dut.scala 25:58]
    node _decodeVec_1_T_1 = xor(decodeVec[0], _decodeVec_1_T) @[dut.scala 25:38]
    decodeVec[1] <= _decodeVec_1_T_1 @[dut.scala 25:18]
    node _decodeVec_2_T = dshr(decodeVec[1], UInt<2>("h2")) @[dut.scala 25:58]
    node _decodeVec_2_T_1 = xor(decodeVec[1], _decodeVec_2_T) @[dut.scala 25:38]
    decodeVec[2] <= _decodeVec_2_T_1 @[dut.scala 25:18]
    node _decodeVec_3_T = dshr(decodeVec[2], UInt<3>("h4")) @[dut.scala 25:58]
    node _decodeVec_3_T_1 = xor(decodeVec[2], _decodeVec_3_T) @[dut.scala 25:38]
    decodeVec[3] <= _decodeVec_3_T_1 @[dut.scala 25:18]
    node _decodeVec_4_T = dshr(decodeVec[3], UInt<4>("h8")) @[dut.scala 25:58]
    node _decodeVec_4_T_1 = xor(decodeVec[3], _decodeVec_4_T) @[dut.scala 25:38]
    decodeVec[4] <= _decodeVec_4_T_1 @[dut.scala 25:18]
    node _decodeVec_5_T = dshr(decodeVec[4], UInt<5>("h10")) @[dut.scala 25:58]
    node _decodeVec_5_T_1 = xor(decodeVec[4], _decodeVec_5_T) @[dut.scala 25:38]
    decodeVec[5] <= _decodeVec_5_T_1 @[dut.scala 25:18]
    node _decodeVec_6_T = dshr(decodeVec[5], UInt<6>("h20")) @[dut.scala 25:58]
    node _decodeVec_6_T_1 = xor(decodeVec[5], _decodeVec_6_T) @[dut.scala 25:38]
    decodeVec[6] <= _decodeVec_6_T_1 @[dut.scala 25:18]
    node _io_out_T = mux(io.encode, enc, decodeVec[6]) @[dut.scala 30:16]
    io.out <= _io_out_T @[dut.scala 30:10]

