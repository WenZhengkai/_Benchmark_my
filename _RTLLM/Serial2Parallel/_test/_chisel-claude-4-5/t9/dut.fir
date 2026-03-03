circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 16:26]
    reg dout_parallel_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 19:34]
    reg dout_valid_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:31]
    dout_valid_reg <= UInt<1>("h0") @[dut.scala 25:18]
    when io.din_valid : @[dut.scala 27:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 29:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 29:15]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 32:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 32:16]
      cnt <= _cnt_T_1 @[dut.scala 32:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 35:14]
      when _T : @[dut.scala 35:23]
        node _dout_parallel_reg_T = bits(shift_reg, 6, 0) @[dut.scala 37:41]
        node _dout_parallel_reg_T_1 = cat(_dout_parallel_reg_T, io.din_serial) @[Cat.scala 33:92]
        dout_parallel_reg <= _dout_parallel_reg_T_1 @[dut.scala 37:25]
        dout_valid_reg <= UInt<1>("h1") @[dut.scala 38:22]
        cnt <= UInt<1>("h0") @[dut.scala 40:11]
    io.dout_parallel <= dout_parallel_reg @[dut.scala 45:20]
    io.dout_valid <= dout_valid_reg @[dut.scala 46:17]

