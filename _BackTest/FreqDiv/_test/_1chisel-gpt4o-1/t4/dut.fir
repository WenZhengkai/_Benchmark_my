circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : UInt<1>, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg clk50 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:22]
    reg clk10 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:22]
    reg clk1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:22]
    reg cnt10 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:22]
    reg cnt100 : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[dut.scala 20:23]
    when io.RST : @[dut.scala 23:16]
      clk50 <= UInt<1>("h0") @[dut.scala 24:11]
    else :
      node _clk50_T = not(clk50) @[dut.scala 26:14]
      clk50 <= _clk50_T @[dut.scala 26:11]
    when io.RST : @[dut.scala 30:16]
      clk10 <= UInt<1>("h0") @[dut.scala 31:11]
      cnt10 <= UInt<1>("h0") @[dut.scala 32:11]
    else :
      node _T = eq(cnt10, UInt<3>("h4")) @[dut.scala 33:21]
      when _T : @[dut.scala 33:30]
        node _clk10_T = not(clk10) @[dut.scala 34:14]
        clk10 <= _clk10_T @[dut.scala 34:11]
        cnt10 <= UInt<1>("h0") @[dut.scala 35:11]
      else :
        node _cnt10_T = add(cnt10, UInt<1>("h1")) @[dut.scala 37:20]
        node _cnt10_T_1 = tail(_cnt10_T, 1) @[dut.scala 37:20]
        cnt10 <= _cnt10_T_1 @[dut.scala 37:11]
    when io.RST : @[dut.scala 41:16]
      clk1 <= UInt<1>("h0") @[dut.scala 42:10]
      cnt100 <= UInt<1>("h0") @[dut.scala 43:12]
    else :
      node _T_1 = eq(cnt100, UInt<6>("h31")) @[dut.scala 44:22]
      when _T_1 : @[dut.scala 44:32]
        node _clk1_T = not(clk1) @[dut.scala 45:13]
        clk1 <= _clk1_T @[dut.scala 45:10]
        cnt100 <= UInt<1>("h0") @[dut.scala 46:12]
      else :
        node _cnt100_T = add(cnt100, UInt<1>("h1")) @[dut.scala 48:22]
        node _cnt100_T_1 = tail(_cnt100_T, 1) @[dut.scala 48:22]
        cnt100 <= _cnt100_T_1 @[dut.scala 48:12]
    io.CLK_50 <= clk50 @[dut.scala 52:13]
    io.CLK_10 <= clk10 @[dut.scala 53:13]
    io.CLK_1 <= clk1 @[dut.scala 54:12]

