circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 12:25]
    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:25]
    io.dout_parallel <= shiftReg @[dut.scala 16:20]
    io.dout_valid <= UInt<1>("h0") @[dut.scala 17:20]
    when io.din_valid : @[dut.scala 19:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 21:29]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 21:14]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 23:14]
      when _T : @[dut.scala 23:23]
        cnt <= UInt<1>("h0") @[dut.scala 25:11]
        io.dout_valid <= UInt<1>("h1") @[dut.scala 26:21]
        node _io_dout_parallel_T = bits(shiftReg, 6, 0) @[dut.scala 27:39]
        node _io_dout_parallel_T_1 = cat(_io_dout_parallel_T, io.din_serial) @[Cat.scala 33:92]
        io.dout_parallel <= _io_dout_parallel_T_1 @[dut.scala 27:24]
      else :
        node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 29:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 29:18]
        cnt <= _cnt_T_1 @[dut.scala 29:11]


