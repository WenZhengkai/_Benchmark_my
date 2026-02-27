circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : UInt<1>, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg CLK_50_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:27]
    reg CLK_10_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:27]
    reg CLK_1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:26]
    reg cnt_10 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:23]
    reg cnt_100 : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[dut.scala 20:24]
    when io.RST : @[dut.scala 23:16]
      CLK_50_reg <= UInt<1>("h0") @[dut.scala 24:16]
    else :
      when io.CLK_in : @[dut.scala 25:26]
        node _CLK_50_reg_T = not(CLK_50_reg) @[dut.scala 26:19]
        CLK_50_reg <= _CLK_50_reg_T @[dut.scala 26:16]
    when io.RST : @[dut.scala 30:16]
      cnt_10 <= UInt<1>("h0") @[dut.scala 31:12]
      CLK_10_reg <= UInt<1>("h0") @[dut.scala 32:16]
    else :
      when io.CLK_in : @[dut.scala 33:26]
        node _T = eq(cnt_10, UInt<3>("h4")) @[dut.scala 34:17]
        when _T : @[dut.scala 34:26]
          node _CLK_10_reg_T = not(CLK_10_reg) @[dut.scala 35:21]
          CLK_10_reg <= _CLK_10_reg_T @[dut.scala 35:18]
          cnt_10 <= UInt<1>("h0") @[dut.scala 36:14]
        else :
          node _cnt_10_T = add(cnt_10, UInt<1>("h1")) @[dut.scala 38:24]
          node _cnt_10_T_1 = tail(_cnt_10_T, 1) @[dut.scala 38:24]
          cnt_10 <= _cnt_10_T_1 @[dut.scala 38:14]
    when io.RST : @[dut.scala 43:16]
      cnt_100 <= UInt<1>("h0") @[dut.scala 44:13]
      CLK_1_reg <= UInt<1>("h0") @[dut.scala 45:15]
    else :
      when io.CLK_in : @[dut.scala 46:26]
        node _T_1 = eq(cnt_100, UInt<6>("h31")) @[dut.scala 47:18]
        when _T_1 : @[dut.scala 47:28]
          node _CLK_1_reg_T = not(CLK_1_reg) @[dut.scala 48:20]
          CLK_1_reg <= _CLK_1_reg_T @[dut.scala 48:17]
          cnt_100 <= UInt<1>("h0") @[dut.scala 49:15]
        else :
          node _cnt_100_T = add(cnt_100, UInt<1>("h1")) @[dut.scala 51:26]
          node _cnt_100_T_1 = tail(_cnt_100_T, 1) @[dut.scala 51:26]
          cnt_100 <= _cnt_100_T_1 @[dut.scala 51:15]
    io.CLK_50 <= CLK_50_reg @[dut.scala 56:13]
    io.CLK_10 <= CLK_10_reg @[dut.scala 57:13]
    io.CLK_1 <= CLK_1_reg @[dut.scala 58:12]

