circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 16:26]
    reg valid_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:26]
    when io.din_valid : @[dut.scala 22:22]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 23:14]
      when _T : @[dut.scala 23:23]
        cnt <= UInt<1>("h0") @[dut.scala 24:11]
      else :
        node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 26:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 26:18]
        cnt <= _cnt_T_1 @[dut.scala 26:11]
    when io.din_valid : @[dut.scala 31:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 32:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 32:15]
    node _T_1 = eq(cnt, UInt<3>("h7")) @[dut.scala 36:28]
    node _T_2 = and(io.din_valid, _T_1) @[dut.scala 36:21]
    when _T_2 : @[dut.scala 36:37]
      valid_reg <= UInt<1>("h1") @[dut.scala 37:15]
    else :
      valid_reg <= UInt<1>("h0") @[dut.scala 39:15]
    io.dout_parallel <= shift_reg @[dut.scala 43:20]
    io.dout_valid <= valid_reg @[dut.scala 44:17]

