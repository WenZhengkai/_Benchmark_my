circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : UInt<1>, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg clk_50 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:23]
    reg clk_10 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:23]
    reg clk_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:22]
    reg cnt_10 : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 18:23]
    reg cnt_100 : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[dut.scala 19:24]
    when io.RST : @[dut.scala 22:16]
      clk_50 <= UInt<1>("h0") @[dut.scala 23:12]
    else :
      when io.CLK_in : @[dut.scala 24:26]
        node _clk_50_T = not(clk_50) @[dut.scala 25:15]
        clk_50 <= _clk_50_T @[dut.scala 25:12]
    when io.RST : @[dut.scala 29:16]
      clk_10 <= UInt<1>("h0") @[dut.scala 30:12]
      cnt_10 <= UInt<1>("h0") @[dut.scala 31:12]
    else :
      when io.CLK_in : @[dut.scala 32:26]
        node _T = eq(cnt_10, UInt<3>("h4")) @[dut.scala 33:17]
        when _T : @[dut.scala 33:26]
          node _clk_10_T = not(clk_10) @[dut.scala 34:17]
          clk_10 <= _clk_10_T @[dut.scala 34:14]
          cnt_10 <= UInt<1>("h0") @[dut.scala 35:14]
        else :
          node _cnt_10_T = add(cnt_10, UInt<1>("h1")) @[dut.scala 37:24]
          node _cnt_10_T_1 = tail(_cnt_10_T, 1) @[dut.scala 37:24]
          cnt_10 <= _cnt_10_T_1 @[dut.scala 37:14]
    when io.RST : @[dut.scala 42:16]
      clk_1 <= UInt<1>("h0") @[dut.scala 43:11]
      cnt_100 <= UInt<1>("h0") @[dut.scala 44:13]
    else :
      when io.CLK_in : @[dut.scala 45:26]
        node _T_1 = eq(cnt_100, UInt<6>("h31")) @[dut.scala 46:18]
        when _T_1 : @[dut.scala 46:28]
          node _clk_1_T = not(clk_1) @[dut.scala 47:16]
          clk_1 <= _clk_1_T @[dut.scala 47:13]
          cnt_100 <= UInt<1>("h0") @[dut.scala 48:15]
        else :
          node _cnt_100_T = add(cnt_100, UInt<1>("h1")) @[dut.scala 50:26]
          node _cnt_100_T_1 = tail(_cnt_100_T, 1) @[dut.scala 50:26]
          cnt_100 <= _cnt_100_T_1 @[dut.scala 50:15]
    io.CLK_50 <= clk_50 @[dut.scala 55:13]
    io.CLK_10 <= clk_10 @[dut.scala 56:13]
    io.CLK_1 <= clk_1 @[dut.scala 57:12]

