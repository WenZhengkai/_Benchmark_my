circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 16:25]
    reg validReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:25]
    reg parallelReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 22:28]
    validReg <= UInt<1>("h0") @[dut.scala 25:12]
    when io.din_valid : @[dut.scala 27:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 29:29]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 29:14]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 32:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 32:16]
      cnt <= _cnt_T_1 @[dut.scala 32:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 35:14]
      when _T : @[dut.scala 35:23]
        node _parallelReg_T = bits(shiftReg, 6, 0) @[dut.scala 37:34]
        node _parallelReg_T_1 = cat(_parallelReg_T, io.din_serial) @[Cat.scala 33:92]
        parallelReg <= _parallelReg_T_1 @[dut.scala 37:19]
        validReg <= UInt<1>("h1") @[dut.scala 38:16]
        cnt <= UInt<1>("h0") @[dut.scala 39:11]
    io.dout_parallel <= parallelReg @[dut.scala 44:20]
    io.dout_valid <= validReg @[dut.scala 45:17]

