circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : Clock, flip RST : UInt<1>, CLK_50 : Clock, CLK_10 : Clock, CLK_1 : Clock}

    reg clk_50_reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 16:29]
    node _clk_50_reg_T = eq(clk_50_reg, UInt<1>("h0")) @[dut.scala 17:19]
    clk_50_reg <= _clk_50_reg_T @[dut.scala 17:16]
    node _io_CLK_50_T = asClock(clk_50_reg) @[dut.scala 18:29]
    io.CLK_50 <= _io_CLK_50_T @[dut.scala 18:15]
    reg cnt_10 : UInt<3>, io.CLK_in with :
      reset => (io.RST, UInt<3>("h0")) @[dut.scala 21:25]
    reg clk_10_reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 22:29]
    node _T = eq(cnt_10, UInt<3>("h4")) @[dut.scala 24:17]
    when _T : @[dut.scala 24:26]
      node _clk_10_reg_T = eq(clk_10_reg, UInt<1>("h0")) @[dut.scala 25:21]
      clk_10_reg <= _clk_10_reg_T @[dut.scala 25:18]
      cnt_10 <= UInt<1>("h0") @[dut.scala 26:14]
    else :
      node _cnt_10_T = add(cnt_10, UInt<1>("h1")) @[dut.scala 28:24]
      node _cnt_10_T_1 = tail(_cnt_10_T, 1) @[dut.scala 28:24]
      cnt_10 <= _cnt_10_T_1 @[dut.scala 28:14]
    node _io_CLK_10_T = asClock(clk_10_reg) @[dut.scala 30:29]
    io.CLK_10 <= _io_CLK_10_T @[dut.scala 30:15]
    reg cnt_100 : UInt<7>, io.CLK_in with :
      reset => (io.RST, UInt<7>("h0")) @[dut.scala 33:26]
    reg clk_1_reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 34:28]
    node _T_1 = eq(cnt_100, UInt<6>("h31")) @[dut.scala 36:18]
    when _T_1 : @[dut.scala 36:28]
      node _clk_1_reg_T = eq(clk_1_reg, UInt<1>("h0")) @[dut.scala 37:20]
      clk_1_reg <= _clk_1_reg_T @[dut.scala 37:17]
      cnt_100 <= UInt<1>("h0") @[dut.scala 38:15]
    else :
      node _cnt_100_T = add(cnt_100, UInt<1>("h1")) @[dut.scala 40:26]
      node _cnt_100_T_1 = tail(_cnt_100_T, 1) @[dut.scala 40:26]
      cnt_100 <= _cnt_100_T_1 @[dut.scala 40:15]
    node _io_CLK_1_T = asClock(clk_1_reg) @[dut.scala 42:27]
    io.CLK_1 <= _io_CLK_1_T @[dut.scala 42:14]

