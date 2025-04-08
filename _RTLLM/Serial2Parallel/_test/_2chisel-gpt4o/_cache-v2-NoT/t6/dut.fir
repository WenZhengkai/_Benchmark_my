circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 15:20]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 18:26]
    reg dout_valid_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:31]
    io.dout_parallel <= UInt<1>("h0") @[dut.scala 24:20]
    io.dout_valid <= UInt<1>("h0") @[dut.scala 25:17]
    when io.din_valid : @[dut.scala 28:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 30:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 30:15]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 33:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 33:16]
      cnt <= _cnt_T_1 @[dut.scala 33:9]
      node _T = eq(cnt, UInt<4>("h8")) @[dut.scala 36:14]
      when _T : @[dut.scala 36:23]
        io.dout_parallel <= shift_reg @[dut.scala 38:24]
        io.dout_valid <= UInt<1>("h1") @[dut.scala 39:21]
        cnt <= UInt<1>("h0") @[dut.scala 42:11]
        dout_valid_reg <= UInt<1>("h1") @[dut.scala 45:22]
      else :
        dout_valid_reg <= UInt<1>("h0") @[dut.scala 48:22]
    else :
      dout_valid_reg <= UInt<1>("h0") @[dut.scala 52:20]
    io.dout_parallel <= shift_reg @[dut.scala 56:20]
    io.dout_valid <= dout_valid_reg @[dut.scala 57:17]

