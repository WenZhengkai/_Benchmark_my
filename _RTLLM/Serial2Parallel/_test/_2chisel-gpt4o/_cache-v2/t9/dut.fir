circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 13:25]
    reg counter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 14:25]
    reg doutValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    io.dout_parallel <= shiftReg @[dut.scala 18:20]
    io.dout_valid <= doutValid @[dut.scala 19:17]
    when io.din_valid : @[dut.scala 22:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 24:29]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 24:14]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 25:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 25:24]
      counter <= _counter_T_1 @[dut.scala 25:13]
      node _T = eq(counter, UInt<3>("h7")) @[dut.scala 28:18]
      when _T : @[dut.scala 28:27]
        doutValid <= UInt<1>("h1") @[dut.scala 29:17]
        counter <= UInt<1>("h0") @[dut.scala 30:15]
      else :
        doutValid <= UInt<1>("h0") @[dut.scala 32:17]
    else :
      doutValid <= UInt<1>("h0") @[dut.scala 35:15]


