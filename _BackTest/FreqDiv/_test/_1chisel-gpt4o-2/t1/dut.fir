circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : Clock, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg clk50Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:25]
    reg clk10Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:25]
    reg clk1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:24]
    reg cnt10 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:22]
    reg cnt100 : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[dut.scala 20:23]
    node _clk50Reg_T = not(clk50Reg) @[dut.scala 24:38]
    node _clk50Reg_T_1 = mux(io.RST, UInt<1>("h0"), _clk50Reg_T) @[dut.scala 24:20]
    clk50Reg <= _clk50Reg_T_1 @[dut.scala 24:14]
    when io.RST : @[dut.scala 29:18]
      clk10Reg <= UInt<1>("h0") @[dut.scala 30:16]
      cnt10 <= UInt<1>("h0") @[dut.scala 31:13]
    else :
      node _T = eq(cnt10, UInt<3>("h4")) @[dut.scala 33:18]
      when _T : @[dut.scala 33:27]
        node _clk10Reg_T = not(clk10Reg) @[dut.scala 34:21]
        clk10Reg <= _clk10Reg_T @[dut.scala 34:18]
        cnt10 <= UInt<1>("h0") @[dut.scala 35:15]
      else :
        node _cnt10_T = add(cnt10, UInt<1>("h1")) @[dut.scala 37:24]
        node _cnt10_T_1 = tail(_cnt10_T, 1) @[dut.scala 37:24]
        cnt10 <= _cnt10_T_1 @[dut.scala 37:15]
    when io.RST : @[dut.scala 44:18]
      clk1Reg <= UInt<1>("h0") @[dut.scala 45:15]
      cnt100 <= UInt<1>("h0") @[dut.scala 46:14]
    else :
      node _T_1 = eq(cnt100, UInt<6>("h31")) @[dut.scala 48:19]
      when _T_1 : @[dut.scala 48:29]
        node _clk1Reg_T = not(clk1Reg) @[dut.scala 49:20]
        clk1Reg <= _clk1Reg_T @[dut.scala 49:17]
        cnt100 <= UInt<1>("h0") @[dut.scala 50:16]
      else :
        node _cnt100_T = add(cnt100, UInt<1>("h1")) @[dut.scala 52:26]
        node _cnt100_T_1 = tail(_cnt100_T, 1) @[dut.scala 52:26]
        cnt100 <= _cnt100_T_1 @[dut.scala 52:16]
    io.CLK_50 <= clk50Reg @[dut.scala 58:13]
    io.CLK_10 <= clk10Reg @[dut.scala 59:13]
    io.CLK_1 <= clk1Reg @[dut.scala 60:12]

