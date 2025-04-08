circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg parallelData : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 13:29]
    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 16:20]
    reg outputValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:28]
    io.dout_parallel <= parallelData @[dut.scala 22:20]
    io.dout_valid <= outputValid @[dut.scala 23:17]
    when io.din_valid : @[dut.scala 26:22]
      node _parallelData_T = bits(parallelData, 6, 0) @[dut.scala 28:37]
      node _parallelData_T_1 = cat(_parallelData_T, io.din_serial) @[Cat.scala 33:92]
      parallelData <= _parallelData_T_1 @[dut.scala 28:18]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 29:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 29:16]
      cnt <= _cnt_T_1 @[dut.scala 29:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 32:14]
      when _T : @[dut.scala 32:23]
        outputValid <= UInt<1>("h1") @[dut.scala 33:19]
        cnt <= UInt<1>("h0") @[dut.scala 34:11]
      else :
        outputValid <= UInt<1>("h0") @[dut.scala 36:19]
    else :
      outputValid <= UInt<1>("h0") @[dut.scala 40:17]


