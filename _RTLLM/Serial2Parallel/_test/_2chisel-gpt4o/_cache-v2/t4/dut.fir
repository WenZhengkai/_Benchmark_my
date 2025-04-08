circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg parallelData : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 13:29]
    reg counter : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 16:24]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:25]
    io.dout_parallel <= parallelData @[dut.scala 22:20]
    io.dout_valid <= validOut @[dut.scala 23:17]
    when io.din_valid : @[dut.scala 26:22]
      node _parallelData_T = bits(parallelData, 6, 0) @[dut.scala 28:37]
      node _parallelData_T_1 = cat(_parallelData_T, io.din_serial) @[Cat.scala 33:92]
      parallelData <= _parallelData_T_1 @[dut.scala 28:18]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 31:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 31:24]
      counter <= _counter_T_1 @[dut.scala 31:13]
      node _T = eq(counter, UInt<3>("h7")) @[dut.scala 34:18]
      when _T : @[dut.scala 34:27]
        validOut <= UInt<1>("h1") @[dut.scala 35:16]
        counter <= UInt<1>("h0") @[dut.scala 36:15]
      else :
        validOut <= UInt<1>("h0") @[dut.scala 38:16]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 41:14]


