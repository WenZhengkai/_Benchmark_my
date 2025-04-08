circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 15:25]
    reg validReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:25]
    io.dout_parallel <= shiftReg @[dut.scala 20:20]
    io.dout_valid <= validReg @[dut.scala 21:17]
    when io.din_valid : @[dut.scala 24:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 26:29]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 26:14]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 28:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 28:16]
      cnt <= _cnt_T_1 @[dut.scala 28:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 31:14]
      when _T : @[dut.scala 31:23]
        validReg <= UInt<1>("h1") @[dut.scala 32:16]
        cnt <= UInt<1>("h0") @[dut.scala 33:11]
      else :
        validReg <= UInt<1>("h0") @[dut.scala 35:16]


