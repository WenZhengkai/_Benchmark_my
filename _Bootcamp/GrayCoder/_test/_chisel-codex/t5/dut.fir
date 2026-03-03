circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = shr(io.in, 1) @[dut.scala 15:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 15:27]
    node _T = shr(io.in, 1) @[dut.scala 21:46]
    node _T_1 = xor(io.in, _T) @[dut.scala 21:31]
    node _T_2 = shr(_T_1, 2) @[dut.scala 21:46]
    node _T_3 = xor(_T_1, _T_2) @[dut.scala 21:31]
    node _T_4 = shr(_T_3, 4) @[dut.scala 21:46]
    node _T_5 = xor(_T_3, _T_4) @[dut.scala 21:31]
    node _T_6 = shr(_T_5, 8) @[dut.scala 21:46]
    node _T_7 = xor(_T_5, _T_6) @[dut.scala 21:31]
    node _T_8 = shr(_T_7, 16) @[dut.scala 21:46]
    node _T_9 = xor(_T_7, _T_8) @[dut.scala 21:31]
    node _T_10 = shr(_T_9, 32) @[dut.scala 21:46]
    node grayDecoded = xor(_T_9, _T_10) @[dut.scala 21:31]
    node _io_out_T = mux(io.encode, grayEncoded, grayDecoded) @[dut.scala 24:16]
    io.out <= _io_out_T @[dut.scala 24:10]

