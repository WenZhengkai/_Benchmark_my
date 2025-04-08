circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt_reg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:24]
    when io.din_valid : @[dut.scala 15:22]
      node _T = eq(cnt_reg, UInt<4>("h8")) @[dut.scala 16:18]
      when _T : @[dut.scala 16:27]
        cnt_reg <= UInt<1>("h0") @[dut.scala 17:15]
      else :
        node _cnt_reg_T = add(cnt_reg, UInt<1>("h1")) @[dut.scala 19:26]
        node _cnt_reg_T_1 = tail(_cnt_reg_T, 1) @[dut.scala 19:26]
        cnt_reg <= _cnt_reg_T_1 @[dut.scala 19:15]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 24:26]
    when io.din_valid : @[dut.scala 26:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 27:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 27:15]
    reg dout_parallel_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 31:34]
    node _T_1 = eq(cnt_reg, UInt<4>("h8")) @[dut.scala 33:32]
    node _T_2 = and(io.din_valid, _T_1) @[dut.scala 33:21]
    when _T_2 : @[dut.scala 33:41]
      dout_parallel_reg <= shift_reg @[dut.scala 34:23]
    io.dout_parallel <= dout_parallel_reg @[dut.scala 37:20]
    reg dout_valid_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 40:31]
    node _T_3 = eq(cnt_reg, UInt<4>("h8")) @[dut.scala 42:32]
    node _T_4 = and(io.din_valid, _T_3) @[dut.scala 42:21]
    when _T_4 : @[dut.scala 42:41]
      dout_valid_reg <= UInt<1>("h1") @[dut.scala 43:20]
    else :
      dout_valid_reg <= UInt<1>("h0") @[dut.scala 45:20]
    io.dout_valid <= dout_valid_reg @[dut.scala 48:17]

