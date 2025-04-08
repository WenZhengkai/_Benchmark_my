circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    when io.din_valid : @[dut.scala 15:22]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 16:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 16:16]
      cnt <= _cnt_T_1 @[dut.scala 16:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 17:14]
      when _T : @[dut.scala 17:23]
        cnt <= UInt<1>("h0") @[dut.scala 18:11]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 23:26]
    when io.din_valid : @[dut.scala 24:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 25:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 25:15]
    reg dout_parallel_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 29:34]
    node _T_1 = eq(cnt, UInt<3>("h7")) @[dut.scala 30:12]
    node _T_2 = and(_T_1, io.din_valid) @[dut.scala 30:20]
    when _T_2 : @[dut.scala 30:37]
      dout_parallel_reg <= shift_reg @[dut.scala 31:23]
    reg dout_valid_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:31]
    node _T_3 = eq(cnt, UInt<3>("h7")) @[dut.scala 36:12]
    node _T_4 = and(_T_3, io.din_valid) @[dut.scala 36:20]
    when _T_4 : @[dut.scala 36:37]
      dout_valid_reg <= UInt<1>("h1") @[dut.scala 37:20]
    else :
      dout_valid_reg <= UInt<1>("h0") @[dut.scala 39:20]
    io.dout_parallel <= dout_parallel_reg @[dut.scala 43:20]
    io.dout_valid <= dout_valid_reg @[dut.scala 44:17]

