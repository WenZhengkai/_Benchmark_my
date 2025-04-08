circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 14:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 14:27]
    node _T = dshr(io.in, UInt<1>("h1")) @[dut.scala 22:31]
    node _T_1 = xor(io.in, _T) @[dut.scala 22:21]
    node _T_2 = dshr(_T_1, UInt<2>("h2")) @[dut.scala 22:31]
    node _T_3 = xor(_T_1, _T_2) @[dut.scala 22:21]
    node _T_4 = dshr(_T_3, UInt<3>("h4")) @[dut.scala 22:31]
    node _T_5 = xor(_T_3, _T_4) @[dut.scala 22:21]
    node _T_6 = dshr(_T_5, UInt<4>("h8")) @[dut.scala 22:31]
    node _T_7 = xor(_T_5, _T_6) @[dut.scala 22:21]
    node _T_8 = dshr(_T_7, UInt<5>("h10")) @[dut.scala 22:31]
    node _T_9 = xor(_T_7, _T_8) @[dut.scala 22:21]
    node _T_10 = dshr(_T_9, UInt<6>("h20")) @[dut.scala 22:31]
    node result = xor(_T_9, _T_10) @[dut.scala 22:21]
    when io.encode : @[dut.scala 26:19]
      io.out <= grayEncoded @[dut.scala 27:12]
    else :
      io.out <= result @[dut.scala 29:12]


