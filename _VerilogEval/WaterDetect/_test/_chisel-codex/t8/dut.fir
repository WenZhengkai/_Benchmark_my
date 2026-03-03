circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire curLevel : UInt<2> @[dut.scala 18:30]
    curLevel <= UInt<1>("h0") @[dut.scala 19:12]
    node _T = eq(UInt<1>("h0"), io.s) @[dut.scala 20:16]
    when _T : @[dut.scala 20:16]
      curLevel <= UInt<1>("h0") @[dut.scala 21:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.s) @[dut.scala 20:16]
      when _T_1 : @[dut.scala 20:16]
        curLevel <= UInt<1>("h1") @[dut.scala 22:29]
      else :
        node _T_2 = eq(UInt<2>("h3"), io.s) @[dut.scala 20:16]
        when _T_2 : @[dut.scala 20:16]
          curLevel <= UInt<2>("h2") @[dut.scala 23:29]
        else :
          node _T_3 = eq(UInt<3>("h7"), io.s) @[dut.scala 20:16]
          when _T_3 : @[dut.scala 20:16]
            curLevel <= UInt<2>("h3") @[dut.scala 24:29]
    reg lastLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 28:30]
    reg lastChangeUp : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 29:30]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 32:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 33:23]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 34:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 35:23]
    io.fr1 <= fr1Reg @[dut.scala 37:10]
    io.fr2 <= fr2Reg @[dut.scala 38:10]
    io.fr3 <= fr3Reg @[dut.scala 39:10]
    io.dfr <= dfrReg @[dut.scala 40:10]
    node levelChanged = neq(curLevel, lastLevel) @[dut.scala 42:31]
    node changeIsUp = gt(curLevel, lastLevel) @[dut.scala 43:31]
    node midDfr = mux(levelChanged, changeIsUp, lastChangeUp) @[dut.scala 44:25]
    node _T_4 = bits(reset, 0, 0) @[dut.scala 46:14]
    when _T_4 : @[dut.scala 46:22]
      lastLevel <= UInt<1>("h0") @[dut.scala 49:18]
      lastChangeUp <= UInt<1>("h1") @[dut.scala 50:18]
      fr1Reg <= UInt<1>("h1") @[dut.scala 52:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 53:12]
      fr3Reg <= UInt<1>("h1") @[dut.scala 54:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 55:12]
    else :
      when levelChanged : @[dut.scala 57:24]
        lastLevel <= curLevel @[dut.scala 58:20]
        lastChangeUp <= changeIsUp @[dut.scala 59:20]
      node _T_5 = eq(UInt<2>("h3"), curLevel) @[dut.scala 62:22]
      when _T_5 : @[dut.scala 62:22]
        fr1Reg <= UInt<1>("h0") @[dut.scala 64:16]
        fr2Reg <= UInt<1>("h0") @[dut.scala 65:16]
        fr3Reg <= UInt<1>("h0") @[dut.scala 66:16]
        dfrReg <= UInt<1>("h0") @[dut.scala 67:16]
      else :
        node _T_6 = eq(UInt<2>("h2"), curLevel) @[dut.scala 62:22]
        when _T_6 : @[dut.scala 62:22]
          fr1Reg <= UInt<1>("h1") @[dut.scala 70:16]
          fr2Reg <= UInt<1>("h0") @[dut.scala 71:16]
          fr3Reg <= UInt<1>("h0") @[dut.scala 72:16]
          dfrReg <= midDfr @[dut.scala 73:16]
        else :
          node _T_7 = eq(UInt<1>("h1"), curLevel) @[dut.scala 62:22]
          when _T_7 : @[dut.scala 62:22]
            fr1Reg <= UInt<1>("h1") @[dut.scala 76:16]
            fr2Reg <= UInt<1>("h1") @[dut.scala 77:16]
            fr3Reg <= UInt<1>("h0") @[dut.scala 78:16]
            dfrReg <= midDfr @[dut.scala 79:16]
          else :
            node _T_8 = eq(UInt<1>("h0"), curLevel) @[dut.scala 62:22]
            when _T_8 : @[dut.scala 62:22]
              fr1Reg <= UInt<1>("h1") @[dut.scala 82:16]
              fr2Reg <= UInt<1>("h1") @[dut.scala 83:16]
              fr3Reg <= UInt<1>("h1") @[dut.scala 84:16]
              dfrReg <= UInt<1>("h1") @[dut.scala 85:16]


