circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : Clock, flip RST : UInt<1>, CLK_50 : Clock, CLK_10 : Clock, CLK_1 : Clock}

    reg clk50Reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 16:27]
    node _clk50Reg_T = eq(clk50Reg, UInt<1>("h0")) @[dut.scala 17:17]
    clk50Reg <= _clk50Reg_T @[dut.scala 17:14]
    node _io_CLK_50_T = asClock(clk50Reg) @[dut.scala 18:27]
    io.CLK_50 <= _io_CLK_50_T @[dut.scala 18:15]
    reg cnt10 : UInt<3>, io.CLK_in with :
      reset => (io.RST, UInt<3>("h0")) @[dut.scala 21:24]
    reg clk10Reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 22:27]
    node _T = eq(cnt10, UInt<3>("h4")) @[dut.scala 24:16]
    when _T : @[dut.scala 24:25]
      node _clk10Reg_T = eq(clk10Reg, UInt<1>("h0")) @[dut.scala 25:19]
      clk10Reg <= _clk10Reg_T @[dut.scala 25:16]
      cnt10 <= UInt<1>("h0") @[dut.scala 26:13]
    else :
      node _cnt10_T = add(cnt10, UInt<1>("h1")) @[dut.scala 28:22]
      node _cnt10_T_1 = tail(_cnt10_T, 1) @[dut.scala 28:22]
      cnt10 <= _cnt10_T_1 @[dut.scala 28:13]
    node _io_CLK_10_T = asClock(clk10Reg) @[dut.scala 30:27]
    io.CLK_10 <= _io_CLK_10_T @[dut.scala 30:15]
    reg cnt100 : UInt<6>, io.CLK_in with :
      reset => (io.RST, UInt<6>("h0")) @[dut.scala 33:25]
    reg clk1Reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 34:26]
    node _T_1 = eq(cnt100, UInt<6>("h31")) @[dut.scala 36:17]
    when _T_1 : @[dut.scala 36:27]
      node _clk1Reg_T = eq(clk1Reg, UInt<1>("h0")) @[dut.scala 37:18]
      clk1Reg <= _clk1Reg_T @[dut.scala 37:15]
      cnt100 <= UInt<1>("h0") @[dut.scala 38:14]
    else :
      node _cnt100_T = add(cnt100, UInt<1>("h1")) @[dut.scala 40:24]
      node _cnt100_T_1 = tail(_cnt100_T, 1) @[dut.scala 40:24]
      cnt100 <= _cnt100_T_1 @[dut.scala 40:14]
    node _io_CLK_1_T = asClock(clk1Reg) @[dut.scala 42:25]
    io.CLK_1 <= _io_CLK_1_T @[dut.scala 42:14]

