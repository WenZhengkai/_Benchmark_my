circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : Clock, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg clk50Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:25]
    reg clk10Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:25]
    reg clk1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:24]
    reg cnt10 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 18:22]
    reg cnt100 : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[dut.scala 19:23]
    when io.RST : @[dut.scala 24:17]
      clk50Reg <= UInt<1>("h0") @[dut.scala 25:14]
    else :
      node _T = asUInt(io.CLK_in) @[dut.scala 26:40]
      node _T_1 = bits(_T, 0, 0) @[dut.scala 26:40]
      reg REG : UInt<1>, clock with :
        reset => (UInt<1>("h0"), REG) @[dut.scala 26:23]
      REG <= _T_1 @[dut.scala 26:23]
      when REG : @[dut.scala 26:45]
        node _clk50Reg_T = not(clk50Reg) @[dut.scala 27:17]
        clk50Reg <= _clk50Reg_T @[dut.scala 27:14]
    when io.RST : @[dut.scala 31:17]
      clk10Reg <= UInt<1>("h0") @[dut.scala 32:14]
      cnt10 <= UInt<1>("h0") @[dut.scala 33:11]
    else :
      node _T_2 = asUInt(io.CLK_in) @[dut.scala 34:40]
      node _T_3 = bits(_T_2, 0, 0) @[dut.scala 34:40]
      reg REG_1 : UInt<1>, clock with :
        reset => (UInt<1>("h0"), REG_1) @[dut.scala 34:23]
      REG_1 <= _T_3 @[dut.scala 34:23]
      when REG_1 : @[dut.scala 34:45]
        node _T_4 = eq(cnt10, UInt<3>("h4")) @[dut.scala 35:17]
        when _T_4 : @[dut.scala 35:26]
          node _clk10Reg_T = not(clk10Reg) @[dut.scala 36:19]
          clk10Reg <= _clk10Reg_T @[dut.scala 36:16]
          cnt10 <= UInt<1>("h0") @[dut.scala 37:13]
        else :
          node _cnt10_T = add(cnt10, UInt<1>("h1")) @[dut.scala 39:22]
          node _cnt10_T_1 = tail(_cnt10_T, 1) @[dut.scala 39:22]
          cnt10 <= _cnt10_T_1 @[dut.scala 39:13]
    when io.RST : @[dut.scala 44:17]
      clk1Reg <= UInt<1>("h0") @[dut.scala 45:13]
      cnt100 <= UInt<1>("h0") @[dut.scala 46:12]
    else :
      node _T_5 = asUInt(io.CLK_in) @[dut.scala 47:40]
      node _T_6 = bits(_T_5, 0, 0) @[dut.scala 47:40]
      reg REG_2 : UInt<1>, clock with :
        reset => (UInt<1>("h0"), REG_2) @[dut.scala 47:23]
      REG_2 <= _T_6 @[dut.scala 47:23]
      when REG_2 : @[dut.scala 47:45]
        node _T_7 = eq(cnt100, UInt<6>("h31")) @[dut.scala 48:18]
        when _T_7 : @[dut.scala 48:28]
          node _clk1Reg_T = not(clk1Reg) @[dut.scala 49:18]
          clk1Reg <= _clk1Reg_T @[dut.scala 49:15]
          cnt100 <= UInt<1>("h0") @[dut.scala 50:14]
        else :
          node _cnt100_T = add(cnt100, UInt<1>("h1")) @[dut.scala 52:24]
          node _cnt100_T_1 = tail(_cnt100_T, 1) @[dut.scala 52:24]
          cnt100 <= _cnt100_T_1 @[dut.scala 52:14]
    io.CLK_50 <= clk50Reg @[dut.scala 57:13]
    io.CLK_10 <= clk10Reg @[dut.scala 58:13]
    io.CLK_1 <= clk1Reg @[dut.scala 59:12]

