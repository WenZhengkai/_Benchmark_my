circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d : UInt<4>, valid_out : UInt<1>, dout : UInt<1>}

    reg data : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 12:21]
    reg cnt : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:20]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:22]
    node _T = eq(cnt, UInt<2>("h3")) @[dut.scala 17:12]
    when _T : @[dut.scala 17:21]
      cnt <= UInt<1>("h0") @[dut.scala 18:9]
      data <= io.d @[dut.scala 19:10]
      valid <= UInt<1>("h1") @[dut.scala 20:11]
    else :
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 22:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 22:16]
      cnt <= _cnt_T_1 @[dut.scala 22:9]
      node _data_T = bits(data, 2, 0) @[dut.scala 23:21]
      node _data_T_1 = bits(data, 3, 3) @[dut.scala 23:33]
      node _data_T_2 = cat(_data_T, _data_T_1) @[Cat.scala 33:92]
      data <= _data_T_2 @[dut.scala 23:10]
      valid <= UInt<1>("h0") @[dut.scala 24:11]
    io.valid_out <= valid @[dut.scala 28:16]
    node _io_dout_T = bits(data, 3, 3) @[dut.scala 29:18]
    io.dout <= _io_dout_T @[dut.scala 29:11]

