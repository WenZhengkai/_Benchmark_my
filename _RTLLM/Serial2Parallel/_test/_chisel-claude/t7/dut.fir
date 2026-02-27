circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 15:20]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 18:25]
    io.dout_valid <= UInt<1>("h0") @[dut.scala 21:17]
    io.dout_parallel <= shiftReg @[dut.scala 24:20]
    when io.din_valid : @[dut.scala 26:22]
      node _shiftReg_T = bits(shiftReg, 7, 1) @[dut.scala 28:44]
      node _shiftReg_T_1 = cat(io.din_serial, _shiftReg_T) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 28:14]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 31:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 31:16]
      cnt <= _cnt_T_1 @[dut.scala 31:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 34:14]
      when _T : @[dut.scala 34:23]
        cnt <= UInt<1>("h0") @[dut.scala 36:11]
        io.dout_valid <= UInt<1>("h1") @[dut.scala 39:21]


