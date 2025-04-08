circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg parallelReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 16:28]
    reg validReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:25]
    io.dout_parallel <= parallelReg @[dut.scala 22:20]
    io.dout_valid <= validReg @[dut.scala 23:17]
    when io.din_valid : @[dut.scala 26:22]
      node _parallelReg_T = bits(parallelReg, 6, 0) @[dut.scala 28:35]
      node _parallelReg_T_1 = cat(_parallelReg_T, io.din_serial) @[Cat.scala 33:92]
      parallelReg <= _parallelReg_T_1 @[dut.scala 28:17]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 30:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 30:16]
      cnt <= _cnt_T_1 @[dut.scala 30:9]
    node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 34:12]
    node _T_1 = and(_T, io.din_valid) @[dut.scala 34:20]
    when _T_1 : @[dut.scala 34:37]
      validReg <= UInt<1>("h1") @[dut.scala 35:14]
      cnt <= UInt<1>("h0") @[dut.scala 36:9]
    else :
      validReg <= UInt<1>("h0") @[dut.scala 38:14]


