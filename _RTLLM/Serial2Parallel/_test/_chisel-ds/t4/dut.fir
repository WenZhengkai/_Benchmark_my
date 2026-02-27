circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 14:25]
    io.dout_parallel <= UInt<1>("h0") @[dut.scala 17:20]
    io.dout_valid <= UInt<1>("h0") @[dut.scala 18:17]
    when io.din_valid : @[dut.scala 21:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 22:25]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[dut.scala 22:32]
      shiftReg <= _shiftReg_T_1 @[dut.scala 22:14]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 23:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 23:16]
      cnt <= _cnt_T_1 @[dut.scala 23:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 25:14]
      when _T : @[dut.scala 25:23]
        node _io_dout_parallel_T = bits(shiftReg, 6, 0) @[dut.scala 26:35]
        node _io_dout_parallel_T_1 = cat(_io_dout_parallel_T, io.din_serial) @[dut.scala 26:42]
        io.dout_parallel <= _io_dout_parallel_T_1 @[dut.scala 26:24]
        io.dout_valid <= UInt<1>("h1") @[dut.scala 27:21]
        cnt <= UInt<1>("h0") @[dut.scala 28:11]
      else :
        io.dout_valid <= UInt<1>("h0") @[dut.scala 30:21]
    else :
      io.dout_valid <= UInt<1>("h0") @[dut.scala 33:19]


