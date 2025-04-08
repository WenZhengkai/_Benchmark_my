circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 15:20]
    when io.din_valid : @[dut.scala 18:22]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 19:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 19:16]
      cnt <= _cnt_T_1 @[dut.scala 19:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 20:14]
      when _T : @[dut.scala 20:23]
        cnt <= UInt<1>("h0") @[dut.scala 21:11]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 26:26]
    when io.din_valid : @[dut.scala 29:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 30:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 30:15]
    io.dout_parallel <= UInt<1>("h0") @[dut.scala 34:20]
    node _T_1 = eq(cnt, UInt<3>("h7")) @[dut.scala 35:12]
    when _T_1 : @[dut.scala 35:21]
      io.dout_parallel <= shift_reg @[dut.scala 36:22]
    reg dout_valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 40:27]
    node _T_2 = eq(cnt, UInt<3>("h7")) @[dut.scala 43:12]
    node _T_3 = and(_T_2, io.din_valid) @[dut.scala 43:20]
    when _T_3 : @[dut.scala 43:37]
      dout_valid <= UInt<1>("h1") @[dut.scala 44:16]
    else :
      dout_valid <= UInt<1>("h0") @[dut.scala 46:16]
    io.dout_valid <= dout_valid @[dut.scala 48:17]

