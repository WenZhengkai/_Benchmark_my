circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<64>, flip encode : UInt<1>, out : UInt<64>}

    node _grayEncoded_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 13:36]
    node grayEncoded = xor(io.in, _grayEncoded_T) @[dut.scala 13:27]
    node _io_out_T = dshr(io.in, UInt<1>("h1")) @[dut.scala 20:33]
    node _io_out_T_1 = xor(io.in, _io_out_T) @[dut.scala 20:23]
    node _io_out_T_2 = dshr(_io_out_T_1, UInt<2>("h2")) @[dut.scala 20:33]
    node _io_out_T_3 = xor(_io_out_T_1, _io_out_T_2) @[dut.scala 20:23]
    node _io_out_T_4 = dshr(_io_out_T_3, UInt<3>("h4")) @[dut.scala 20:33]
    node _io_out_T_5 = xor(_io_out_T_3, _io_out_T_4) @[dut.scala 20:23]
    node _io_out_T_6 = dshr(_io_out_T_5, UInt<4>("h8")) @[dut.scala 20:33]
    node _io_out_T_7 = xor(_io_out_T_5, _io_out_T_6) @[dut.scala 20:23]
    node _io_out_T_8 = dshr(_io_out_T_7, UInt<5>("h10")) @[dut.scala 20:33]
    node _io_out_T_9 = xor(_io_out_T_7, _io_out_T_8) @[dut.scala 20:23]
    node _io_out_T_10 = dshr(_io_out_T_9, UInt<6>("h20")) @[dut.scala 20:33]
    node _io_out_T_11 = xor(_io_out_T_9, _io_out_T_10) @[dut.scala 20:23]
    node _io_out_T_12 = mux(io.encode, grayEncoded, _io_out_T_11) @[dut.scala 26:16]
    io.out <= _io_out_T_12 @[dut.scala 26:10]

