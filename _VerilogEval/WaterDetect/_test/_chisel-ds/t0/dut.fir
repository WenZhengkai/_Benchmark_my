circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:26]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 20:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 21:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 22:23]
    io.fr3 <= fr3Reg @[dut.scala 25:10]
    io.fr2 <= fr2Reg @[dut.scala 26:10]
    io.fr1 <= fr1Reg @[dut.scala 27:10]
    io.dfr <= dfrReg @[dut.scala 28:10]
    wire currentLevel : UInt<2> @[dut.scala 31:26]
    node _currentLevel_T = eq(io.s, UInt<3>("h7")) @[dut.scala 33:11]
    node _currentLevel_T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 34:11]
    node _currentLevel_T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 35:11]
    node _currentLevel_T_3 = eq(io.s, UInt<1>("h0")) @[dut.scala 36:11]
    node _currentLevel_T_4 = mux(_currentLevel_T_3, UInt<1>("h0"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _currentLevel_T_5 = mux(_currentLevel_T_2, UInt<1>("h1"), _currentLevel_T_4) @[Mux.scala 101:16]
    node _currentLevel_T_6 = mux(_currentLevel_T_1, UInt<2>("h2"), _currentLevel_T_5) @[Mux.scala 101:16]
    node _currentLevel_T_7 = mux(_currentLevel_T, UInt<2>("h3"), _currentLevel_T_6) @[Mux.scala 101:16]
    currentLevel <= _currentLevel_T_7 @[dut.scala 32:16]
    when io.reset : @[dut.scala 40:18]
      fr3Reg <= UInt<1>("h1") @[dut.scala 42:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 43:12]
      fr1Reg <= UInt<1>("h1") @[dut.scala 44:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 45:12]
      prevLevel <= UInt<1>("h0") @[dut.scala 46:15]
    else :
      node _T = eq(UInt<2>("h3"), currentLevel) @[dut.scala 49:26]
      when _T : @[dut.scala 49:26]
        fr3Reg <= UInt<1>("h0") @[dut.scala 51:16]
        fr2Reg <= UInt<1>("h0") @[dut.scala 52:16]
        fr1Reg <= UInt<1>("h0") @[dut.scala 53:16]
        dfrReg <= UInt<1>("h0") @[dut.scala 54:16]
      else :
        node _T_1 = eq(UInt<2>("h2"), currentLevel) @[dut.scala 49:26]
        when _T_1 : @[dut.scala 49:26]
          fr3Reg <= UInt<1>("h0") @[dut.scala 57:16]
          fr2Reg <= UInt<1>("h0") @[dut.scala 58:16]
          fr1Reg <= UInt<1>("h1") @[dut.scala 59:16]
          node _dfrReg_T = lt(prevLevel, currentLevel) @[dut.scala 60:30]
          dfrReg <= _dfrReg_T @[dut.scala 60:16]
        else :
          node _T_2 = eq(UInt<1>("h1"), currentLevel) @[dut.scala 49:26]
          when _T_2 : @[dut.scala 49:26]
            fr3Reg <= UInt<1>("h0") @[dut.scala 63:16]
            fr2Reg <= UInt<1>("h1") @[dut.scala 64:16]
            fr1Reg <= UInt<1>("h1") @[dut.scala 65:16]
            node _dfrReg_T_1 = lt(prevLevel, currentLevel) @[dut.scala 66:30]
            dfrReg <= _dfrReg_T_1 @[dut.scala 66:16]
          else :
            node _T_3 = eq(UInt<1>("h0"), currentLevel) @[dut.scala 49:26]
            when _T_3 : @[dut.scala 49:26]
              fr3Reg <= UInt<1>("h1") @[dut.scala 69:16]
              fr2Reg <= UInt<1>("h1") @[dut.scala 70:16]
              fr1Reg <= UInt<1>("h1") @[dut.scala 71:16]
              dfrReg <= UInt<1>("h1") @[dut.scala 72:16]
      prevLevel <= currentLevel @[dut.scala 76:15]


