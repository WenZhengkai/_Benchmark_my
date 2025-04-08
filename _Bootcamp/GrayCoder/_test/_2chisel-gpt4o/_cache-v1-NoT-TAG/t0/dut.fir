circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    wire encoded : UInt<64> @[dut.scala 19:23]
    node _encoded_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 20:31]
    node _encoded_T_1 = xor(io.in, _encoded_T) @[dut.scala 20:22]
    encoded <= _encoded_T_1 @[dut.scala 20:13]
    wire decoded : UInt<64> @[dut.scala 24:23]
    node _T = dshr(io.in, UInt<1>("h1")) @[dut.scala 30:36]
    node _T_1 = xor(io.in, _T) @[dut.scala 30:25]
    node _T_2 = dshr(_T_1, UInt<2>("h2")) @[dut.scala 30:36]
    node _T_3 = xor(_T_1, _T_2) @[dut.scala 30:25]
    node _T_4 = dshr(_T_3, UInt<3>("h4")) @[dut.scala 30:36]
    node _T_5 = xor(_T_3, _T_4) @[dut.scala 30:25]
    node _T_6 = dshr(_T_5, UInt<4>("h8")) @[dut.scala 30:36]
    node _T_7 = xor(_T_5, _T_6) @[dut.scala 30:25]
    node _T_8 = dshr(_T_7, UInt<5>("h10")) @[dut.scala 30:36]
    node _T_9 = xor(_T_7, _T_8) @[dut.scala 30:25]
    node _T_10 = dshr(_T_9, UInt<6>("h20")) @[dut.scala 30:36]
    node _T_11 = xor(_T_9, _T_10) @[dut.scala 30:25]
    decoded <= _T_11 @[dut.scala 32:13]
    node _io_out_T = mux(io.encode, encoded, decoded) @[dut.scala 35:18]
    io.out <= _io_out_T @[dut.scala 35:12]

