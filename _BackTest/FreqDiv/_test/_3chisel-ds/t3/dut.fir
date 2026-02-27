circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : Clock, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg clk50Reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 15:27]
    node _clk50Reg_T = eq(clk50Reg, UInt<1>("h0")) @[dut.scala 16:17]
    clk50Reg <= _clk50Reg_T @[dut.scala 16:14]
    io.CLK_50 <= clk50Reg @[dut.scala 17:15]
    reg clk10Reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 20:27]
    reg cnt10 : UInt<3>, io.CLK_in with :
      reset => (io.RST, UInt<3>("h0")) @[dut.scala 21:24]
    node _T = eq(cnt10, UInt<3>("h4")) @[dut.scala 23:16]
    when _T : @[dut.scala 23:25]
      node _clk10Reg_T = eq(clk10Reg, UInt<1>("h0")) @[dut.scala 24:19]
      clk10Reg <= _clk10Reg_T @[dut.scala 24:16]
      cnt10 <= UInt<1>("h0") @[dut.scala 25:13]
    else :
      node _cnt10_T = add(cnt10, UInt<1>("h1")) @[dut.scala 27:22]
      node _cnt10_T_1 = tail(_cnt10_T, 1) @[dut.scala 27:22]
      cnt10 <= _cnt10_T_1 @[dut.scala 27:13]
    io.CLK_10 <= clk10Reg @[dut.scala 29:15]
    reg clk1Reg : UInt<1>, io.CLK_in with :
      reset => (io.RST, UInt<1>("h0")) @[dut.scala 32:26]
    reg cnt100 : UInt<6>, io.CLK_in with :
      reset => (io.RST, UInt<6>("h0")) @[dut.scala 33:25]
    node _T_1 = eq(cnt100, UInt<6>("h31")) @[dut.scala 35:17]
    when _T_1 : @[dut.scala 35:27]
      node _clk1Reg_T = eq(clk1Reg, UInt<1>("h0")) @[dut.scala 36:18]
      clk1Reg <= _clk1Reg_T @[dut.scala 36:15]
      cnt100 <= UInt<1>("h0") @[dut.scala 37:14]
    else :
      node _cnt100_T = add(cnt100, UInt<1>("h1")) @[dut.scala 39:24]
      node _cnt100_T_1 = tail(_cnt100_T, 1) @[dut.scala 39:24]
      cnt100 <= _cnt100_T_1 @[dut.scala 39:14]
    io.CLK_1 <= clk1Reg @[dut.scala 41:14]

