circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : UInt<1>, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg reg_CLK_50 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:27]
    reg reg_CLK_10 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:27]
    reg reg_CLK_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    reg cnt_10 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 18:23]
    reg cnt_100 : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[dut.scala 19:24]
    when io.RST : @[dut.scala 22:17]
      reg_CLK_50 <= UInt<1>("h0") @[dut.scala 23:16]
    else :
      node _reg_CLK_50_T = not(reg_CLK_50) @[dut.scala 25:19]
      reg_CLK_50 <= _reg_CLK_50_T @[dut.scala 25:16]
    when io.RST : @[dut.scala 29:17]
      reg_CLK_10 <= UInt<1>("h0") @[dut.scala 30:16]
      cnt_10 <= UInt<1>("h0") @[dut.scala 31:12]
    else :
      node _T = eq(cnt_10, UInt<3>("h4")) @[dut.scala 33:18]
      when _T : @[dut.scala 33:27]
        node _reg_CLK_10_T = not(reg_CLK_10) @[dut.scala 34:21]
        reg_CLK_10 <= _reg_CLK_10_T @[dut.scala 34:18]
        cnt_10 <= UInt<1>("h0") @[dut.scala 35:14]
      else :
        node _cnt_10_T = add(cnt_10, UInt<1>("h1")) @[dut.scala 37:24]
        node _cnt_10_T_1 = tail(_cnt_10_T, 1) @[dut.scala 37:24]
        cnt_10 <= _cnt_10_T_1 @[dut.scala 37:14]
    when io.RST : @[dut.scala 42:17]
      reg_CLK_1 <= UInt<1>("h0") @[dut.scala 43:15]
      cnt_100 <= UInt<1>("h0") @[dut.scala 44:13]
    else :
      node _T_1 = eq(cnt_100, UInt<6>("h31")) @[dut.scala 46:19]
      when _T_1 : @[dut.scala 46:29]
        node _reg_CLK_1_T = not(reg_CLK_1) @[dut.scala 47:20]
        reg_CLK_1 <= _reg_CLK_1_T @[dut.scala 47:17]
        cnt_100 <= UInt<1>("h0") @[dut.scala 48:15]
      else :
        node _cnt_100_T = add(cnt_100, UInt<1>("h1")) @[dut.scala 50:26]
        node _cnt_100_T_1 = tail(_cnt_100_T, 1) @[dut.scala 50:26]
        cnt_100 <= _cnt_100_T_1 @[dut.scala 50:15]
    io.CLK_50 <= reg_CLK_50 @[dut.scala 55:13]
    io.CLK_10 <= reg_CLK_10 @[dut.scala 56:13]
    io.CLK_1 <= reg_CLK_1 @[dut.scala 57:12]

