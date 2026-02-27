circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 18:25]
    reg counter : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:24]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:25]
    io.dout_parallel <= shiftReg @[dut.scala 23:20]
    io.dout_valid <= validOut @[dut.scala 24:17]
    when io.din_valid : @[dut.scala 27:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 29:29]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 29:14]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 32:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 32:24]
      counter <= _counter_T_1 @[dut.scala 32:13]
      node _T = eq(counter, UInt<3>("h7")) @[dut.scala 35:18]
      when _T : @[dut.scala 35:27]
        validOut <= UInt<1>("h1") @[dut.scala 36:16]
        counter <= UInt<1>("h0") @[dut.scala 37:15]
      else :
        validOut <= UInt<1>("h0") @[dut.scala 39:16]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 42:14]


