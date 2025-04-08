circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:20]
    when io.din_valid : @[dut.scala 14:23]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 15:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 15:16]
      cnt <= _cnt_T_1 @[dut.scala 15:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 16:15]
      when _T : @[dut.scala 16:24]
        cnt <= UInt<1>("h0") @[dut.scala 17:11]
    reg shift_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 22:26]
    when io.din_valid : @[dut.scala 23:23]
      node _shift_reg_T = bits(shift_reg, 6, 0) @[dut.scala 24:31]
      node _shift_reg_T_1 = cat(_shift_reg_T, io.din_serial) @[Cat.scala 33:92]
      shift_reg <= _shift_reg_T_1 @[dut.scala 24:15]
    wire dout_parallel : UInt<8> @[dut.scala 28:34]
    dout_parallel <= UInt<8>("h0") @[dut.scala 28:34]
    node _T_1 = eq(cnt, UInt<3>("h7")) @[dut.scala 29:13]
    when _T_1 : @[dut.scala 29:22]
      dout_parallel <= shift_reg @[dut.scala 30:19]
    io.dout_parallel <= dout_parallel @[dut.scala 32:20]
    reg dout_valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:27]
    node _T_2 = eq(cnt, UInt<3>("h7")) @[dut.scala 36:13]
    when _T_2 : @[dut.scala 36:22]
      dout_valid <= UInt<1>("h1") @[dut.scala 37:16]
    else :
      dout_valid <= UInt<1>("h0") @[dut.scala 39:16]
    io.dout_valid <= dout_valid @[dut.scala 41:17]

