circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 13:24]
    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 14:20]
    reg doutValidReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:29]
    io.dout_parallel <= dataReg @[dut.scala 18:20]
    io.dout_valid <= doutValidReg @[dut.scala 19:17]
    when io.din_valid : @[dut.scala 21:22]
      node _dataReg_T = bits(dataReg, 6, 0) @[dut.scala 23:27]
      node _dataReg_T_1 = cat(_dataReg_T, io.din_serial) @[Cat.scala 33:92]
      dataReg <= _dataReg_T_1 @[dut.scala 23:13]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 25:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 25:16]
      cnt <= _cnt_T_1 @[dut.scala 25:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 28:14]
      when _T : @[dut.scala 28:23]
        doutValidReg <= UInt<1>("h1") @[dut.scala 29:20]
        cnt <= UInt<1>("h0") @[dut.scala 30:11]
      else :
        doutValidReg <= UInt<1>("h0") @[dut.scala 32:20]
    else :
      doutValidReg <= UInt<1>("h0") @[dut.scala 35:18]


