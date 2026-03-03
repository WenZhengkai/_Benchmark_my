circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip rst : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 18:26]
    reg trendUp : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:26]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 22:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 23:23]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 24:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 25:23]
    wire level : UInt<2> @[dut.scala 29:19]
    node _level_T = bits(io.s, 2, 2) @[dut.scala 30:20]
    node _level_T_1 = bits(io.s, 1, 1) @[dut.scala 31:20]
    node _level_T_2 = bits(io.s, 0, 0) @[dut.scala 32:20]
    node _level_T_3 = mux(_level_T_2, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 32:15]
    node _level_T_4 = mux(_level_T_1, UInt<2>("h2"), _level_T_3) @[dut.scala 31:15]
    node _level_T_5 = mux(_level_T, UInt<2>("h3"), _level_T_4) @[dut.scala 30:15]
    level <= _level_T_5 @[dut.scala 30:9]
    node levelChanged = neq(level, prevLevel) @[dut.scala 34:28]
    node _trendNow_T = gt(level, prevLevel) @[dut.scala 35:46]
    node trendNow = mux(levelChanged, _trendNow_T, trendUp) @[dut.scala 35:25]
    node fr1Next = neq(level, UInt<2>("h3")) @[dut.scala 38:23]
    node _fr2Next_T = eq(level, UInt<1>("h1")) @[dut.scala 39:24]
    node _fr2Next_T_1 = eq(level, UInt<1>("h0")) @[dut.scala 39:43]
    node fr2Next = or(_fr2Next_T, _fr2Next_T_1) @[dut.scala 39:33]
    node fr3Next = eq(level, UInt<1>("h0")) @[dut.scala 40:23]
    node _dfrNext_T = eq(level, UInt<1>("h0")) @[dut.scala 46:27]
    node _dfrNext_T_1 = eq(level, UInt<2>("h3")) @[dut.scala 47:27]
    node _dfrNext_T_2 = mux(_dfrNext_T_1, UInt<1>("h0"), trendNow) @[dut.scala 47:20]
    node dfrNext = mux(_dfrNext_T, UInt<1>("h1"), _dfrNext_T_2) @[dut.scala 46:20]
    when io.rst : @[dut.scala 49:16]
      prevLevel <= UInt<1>("h0") @[dut.scala 51:15]
      trendUp <= UInt<1>("h1") @[dut.scala 52:15]
      fr1Reg <= UInt<1>("h1") @[dut.scala 53:15]
      fr2Reg <= UInt<1>("h1") @[dut.scala 54:15]
      fr3Reg <= UInt<1>("h1") @[dut.scala 55:15]
      dfrReg <= UInt<1>("h1") @[dut.scala 56:15]
    else :
      when levelChanged : @[dut.scala 58:24]
        node _trendUp_T = gt(level, prevLevel) @[dut.scala 59:26]
        trendUp <= _trendUp_T @[dut.scala 59:17]
        prevLevel <= level @[dut.scala 60:17]
      fr1Reg <= fr1Next @[dut.scala 63:12]
      fr2Reg <= fr2Next @[dut.scala 64:12]
      fr3Reg <= fr3Next @[dut.scala 65:12]
      dfrReg <= dfrNext @[dut.scala 66:12]
    io.fr1 <= fr1Reg @[dut.scala 69:10]
    io.fr2 <= fr2Reg @[dut.scala 70:10]
    io.fr3 <= fr3Reg @[dut.scala 71:10]
    io.dfr <= dfrReg @[dut.scala 72:10]

