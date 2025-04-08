circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg dout : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 14:21]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:22]
    io.dout_parallel <= dout @[dut.scala 18:20]
    io.dout_valid <= valid @[dut.scala 19:17]
    when io.din_valid : @[dut.scala 22:22]
      node _dout_T = bits(dout, 6, 0) @[dut.scala 24:21]
      node _dout_T_1 = cat(_dout_T, io.din_serial) @[Cat.scala 33:92]
      dout <= _dout_T_1 @[dut.scala 24:10]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 25:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 25:16]
      cnt <= _cnt_T_1 @[dut.scala 25:9]
      node _valid_T = eq(cnt, UInt<3>("h7")) @[dut.scala 28:18]
      valid <= _valid_T @[dut.scala 28:11]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 29:14]
      when _T : @[dut.scala 29:23]
        cnt <= UInt<1>("h0") @[dut.scala 30:11]
    else :
      valid <= UInt<1>("h0") @[dut.scala 34:11]


