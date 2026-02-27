circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 16:20]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 19:26]
    io.dout_valid <= UInt<1>("h0") @[dut.scala 22:17]
    io.dout_parallel <= UInt<1>("h0") @[dut.scala 23:20]
    when io.din_valid : @[dut.scala 25:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 27:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 27:15]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 30:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 30:16]
      cnt <= _cnt_T_1 @[dut.scala 30:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 33:14]
      when _T : @[dut.scala 33:23]
        io.dout_valid <= UInt<1>("h1") @[dut.scala 34:21]
        node _io_dout_parallel_T = bits(shift_reg, 6, 0) @[dut.scala 35:40]
        node _io_dout_parallel_T_1 = cat(_io_dout_parallel_T, io.din_serial) @[Cat.scala 33:92]
        io.dout_parallel <= _io_dout_parallel_T_1 @[dut.scala 35:24]
        cnt <= UInt<1>("h0") @[dut.scala 36:11]


