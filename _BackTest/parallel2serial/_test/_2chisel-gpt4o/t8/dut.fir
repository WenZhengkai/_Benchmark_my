circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d : UInt<4>, valid_out : UInt<1>, dout : UInt<1>}

    reg data : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 12:21]
    reg cnt : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:21]
    io.valid_out <= UInt<1>("h0") @[dut.scala 16:16]
    io.dout <= UInt<1>("h0") @[dut.scala 17:11]
    node _T = eq(cnt, UInt<2>("h3")) @[dut.scala 20:12]
    when _T : @[dut.scala 20:21]
      io.valid_out <= UInt<1>("h1") @[dut.scala 22:18]
      node _io_dout_T = bits(data, 3, 3) @[dut.scala 23:20]
      io.dout <= _io_dout_T @[dut.scala 23:13]
      data <= io.d @[dut.scala 24:10]
      cnt <= UInt<1>("h0") @[dut.scala 25:9]
    else :
      node _io_dout_T_1 = bits(data, 3, 3) @[dut.scala 27:20]
      io.dout <= _io_dout_T_1 @[dut.scala 27:13]
      io.valid_out <= UInt<1>("h0") @[dut.scala 28:18]
      node _data_T = shl(data, 1) @[dut.scala 29:18]
      data <= _data_T @[dut.scala 29:10]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 30:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 30:16]
      cnt <= _cnt_T_1 @[dut.scala 30:9]


