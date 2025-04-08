circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt_reg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 14:24]
    when io.din_valid : @[dut.scala 15:22]
      node _cnt_reg_T = add(cnt_reg, UInt<1>("h1")) @[dut.scala 16:24]
      node _cnt_reg_T_1 = tail(_cnt_reg_T, 1) @[dut.scala 16:24]
      cnt_reg <= _cnt_reg_T_1 @[dut.scala 16:13]
      node _T = eq(cnt_reg, UInt<4>("h8")) @[dut.scala 17:18]
      when _T : @[dut.scala 17:27]
        cnt_reg <= UInt<1>("h0") @[dut.scala 18:15]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 24:26]
    when io.din_valid : @[dut.scala 25:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 26:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 26:15]
    reg dout_parallel_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 31:34]
    node _T_1 = eq(cnt_reg, UInt<4>("h8")) @[dut.scala 32:32]
    node _T_2 = and(io.din_valid, _T_1) @[dut.scala 32:21]
    when _T_2 : @[dut.scala 32:41]
      dout_parallel_reg <= shift_reg @[dut.scala 33:23]
    io.dout_parallel <= dout_parallel_reg @[dut.scala 35:20]
    reg dout_valid_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:31]
    node _dout_valid_reg_T = eq(cnt_reg, UInt<4>("h8")) @[dut.scala 40:45]
    node _dout_valid_reg_T_1 = and(io.din_valid, _dout_valid_reg_T) @[dut.scala 40:34]
    dout_valid_reg <= _dout_valid_reg_T_1 @[dut.scala 40:18]
    io.dout_valid <= dout_valid_reg @[dut.scala 41:17]

