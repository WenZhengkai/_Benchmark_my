circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 16:20]
    when io.din_valid : @[dut.scala 17:22]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 18:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 18:16]
      cnt <= _cnt_T_1 @[dut.scala 18:9]
      node _T = eq(cnt, UInt<4>("h8")) @[dut.scala 19:14]
      when _T : @[dut.scala 19:23]
        cnt <= UInt<1>("h0") @[dut.scala 20:11]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 25:26]
    when io.din_valid : @[dut.scala 26:22]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 27:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 27:15]
    wire dout_parallel : UInt<8> @[dut.scala 31:34]
    dout_parallel <= UInt<8>("h0") @[dut.scala 31:34]
    node _T_1 = eq(cnt, UInt<4>("h8")) @[dut.scala 32:12]
    node _T_2 = and(_T_1, io.din_valid) @[dut.scala 32:20]
    when _T_2 : @[dut.scala 32:37]
      dout_parallel <= shift_reg @[dut.scala 33:19]
    io.dout_parallel <= dout_parallel @[dut.scala 35:20]
    reg dout_valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 38:27]
    node _dout_valid_T = eq(cnt, UInt<4>("h8")) @[dut.scala 39:22]
    node _dout_valid_T_1 = and(_dout_valid_T, io.din_valid) @[dut.scala 39:30]
    dout_valid <= _dout_valid_T_1 @[dut.scala 39:14]
    io.dout_valid <= dout_valid @[dut.scala 40:17]

