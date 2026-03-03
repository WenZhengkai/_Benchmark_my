circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEnc_T = shr(io.in, 1) @[dut.scala 14:32]
    node grayEnc = xor(io.in, _grayEnc_T) @[dut.scala 14:23]
    wire dec : UInt<64>[7] @[dut.scala 20:17]
    dec[0] <= io.in @[dut.scala 21:10]
    node _dec_1_T = shr(dec[0], 1) @[dut.scala 24:36]
    node _dec_1_T_1 = xor(dec[0], _dec_1_T) @[dut.scala 24:26]
    dec[1] <= _dec_1_T_1 @[dut.scala 24:16]
    node _dec_2_T = shr(dec[1], 2) @[dut.scala 24:36]
    node _dec_2_T_1 = xor(dec[1], _dec_2_T) @[dut.scala 24:26]
    dec[2] <= _dec_2_T_1 @[dut.scala 24:16]
    node _dec_3_T = shr(dec[2], 4) @[dut.scala 24:36]
    node _dec_3_T_1 = xor(dec[2], _dec_3_T) @[dut.scala 24:26]
    dec[3] <= _dec_3_T_1 @[dut.scala 24:16]
    node _dec_4_T = shr(dec[3], 8) @[dut.scala 24:36]
    node _dec_4_T_1 = xor(dec[3], _dec_4_T) @[dut.scala 24:26]
    dec[4] <= _dec_4_T_1 @[dut.scala 24:16]
    node _dec_5_T = shr(dec[4], 16) @[dut.scala 24:36]
    node _dec_5_T_1 = xor(dec[4], _dec_5_T) @[dut.scala 24:26]
    dec[5] <= _dec_5_T_1 @[dut.scala 24:16]
    node _dec_6_T = shr(dec[5], 32) @[dut.scala 24:36]
    node _dec_6_T_1 = xor(dec[5], _dec_6_T) @[dut.scala 24:26]
    dec[6] <= _dec_6_T_1 @[dut.scala 24:16]
    node _io_out_T = mux(io.encode, grayEnc, dec[6]) @[dut.scala 28:16]
    io.out <= _io_out_T @[dut.scala 28:10]

