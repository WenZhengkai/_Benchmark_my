circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d : UInt<4>, valid_out : UInt<1>, dout : UInt<1>}

    reg cnt : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    reg data : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:22]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:22]
    io.valid_out <= valid @[dut.scala 17:16]
    node _io_dout_T = bits(data, 3, 3) @[dut.scala 18:18]
    io.dout <= _io_dout_T @[dut.scala 18:11]
    node _T = eq(cnt, UInt<2>("h3")) @[dut.scala 20:12]
    when _T : @[dut.scala 20:21]
      data <= io.d @[dut.scala 22:10]
      cnt <= UInt<1>("h0") @[dut.scala 23:9]
      valid <= UInt<1>("h1") @[dut.scala 24:11]
    else :
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 27:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 27:16]
      cnt <= _cnt_T_1 @[dut.scala 27:9]
      valid <= UInt<1>("h0") @[dut.scala 28:11]
      node _data_T = dshl(data, UInt<1>("h1")) @[dut.scala 29:18]
      data <= _data_T @[dut.scala 29:10]


