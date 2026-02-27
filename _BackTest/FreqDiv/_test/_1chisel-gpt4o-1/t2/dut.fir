circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CLK_in : UInt<1>, flip RST : UInt<1>, CLK_50 : UInt<1>, CLK_10 : UInt<1>, CLK_1 : UInt<1>}

    reg CLK_50 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:23]
    reg CLK_10 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:23]
    reg CLK_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:22]
    reg cnt_10 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 17:23]
    reg cnt_100 : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[dut.scala 18:24]
    when io.RST : @[dut.scala 21:16]
      CLK_50 <= UInt<1>("h0") @[dut.scala 22:12]
    else :
      node _CLK_50_T = not(CLK_50) @[dut.scala 24:15]
      CLK_50 <= _CLK_50_T @[dut.scala 24:12]
    when io.RST : @[dut.scala 28:16]
      CLK_10 <= UInt<1>("h0") @[dut.scala 29:12]
      cnt_10 <= UInt<1>("h0") @[dut.scala 30:12]
    else :
      node _T = eq(cnt_10, UInt<3>("h4")) @[dut.scala 32:17]
      when _T : @[dut.scala 32:26]
        node _CLK_10_T = not(CLK_10) @[dut.scala 33:17]
        CLK_10 <= _CLK_10_T @[dut.scala 33:14]
        cnt_10 <= UInt<1>("h0") @[dut.scala 34:14]
      else :
        node _cnt_10_T = add(cnt_10, UInt<1>("h1")) @[dut.scala 36:24]
        node _cnt_10_T_1 = tail(_cnt_10_T, 1) @[dut.scala 36:24]
        cnt_10 <= _cnt_10_T_1 @[dut.scala 36:14]
    when io.RST : @[dut.scala 41:16]
      CLK_1 <= UInt<1>("h0") @[dut.scala 42:11]
      cnt_100 <= UInt<1>("h0") @[dut.scala 43:13]
    else :
      node _T_1 = eq(cnt_100, UInt<6>("h31")) @[dut.scala 45:18]
      when _T_1 : @[dut.scala 45:28]
        node _CLK_1_T = not(CLK_1) @[dut.scala 46:16]
        CLK_1 <= _CLK_1_T @[dut.scala 46:13]
        cnt_100 <= UInt<1>("h0") @[dut.scala 47:15]
      else :
        node _cnt_100_T = add(cnt_100, UInt<1>("h1")) @[dut.scala 49:26]
        node _cnt_100_T_1 = tail(_cnt_100_T, 1) @[dut.scala 49:26]
        cnt_100 <= _cnt_100_T_1 @[dut.scala 49:15]
    io.CLK_50 <= CLK_50 @[dut.scala 54:13]
    io.CLK_10 <= CLK_10 @[dut.scala 55:13]
    io.CLK_1 <= CLK_1 @[dut.scala 56:12]

