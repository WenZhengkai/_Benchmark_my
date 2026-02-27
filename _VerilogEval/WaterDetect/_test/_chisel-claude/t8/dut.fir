circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg state : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 16:22]
    reg prevSensor : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 19:27]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 22:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 23:23]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 24:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 25:23]
    node isRising = gt(io.s, prevSensor) @[dut.scala 28:23]
    node isFalling = lt(io.s, prevSensor) @[dut.scala 29:24]
    when io.reset : @[dut.scala 32:18]
      state <= UInt<1>("h1") @[dut.scala 34:11]
      fr1Reg <= UInt<1>("h1") @[dut.scala 35:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 36:12]
      fr3Reg <= UInt<1>("h1") @[dut.scala 37:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 38:12]
      prevSensor <= UInt<1>("h0") @[dut.scala 39:16]
    else :
      node _T = or(isRising, isFalling) @[dut.scala 40:23]
      when _T : @[dut.scala 40:37]
        node _state_T = mux(isRising, UInt<1>("h0"), UInt<1>("h1")) @[dut.scala 42:17]
        state <= _state_T @[dut.scala 42:11]
        prevSensor <= io.s @[dut.scala 43:16]
        node _T_1 = eq(io.s, UInt<3>("h7")) @[dut.scala 46:15]
        when _T_1 : @[dut.scala 46:24]
          fr1Reg <= UInt<1>("h0") @[dut.scala 47:14]
          fr2Reg <= UInt<1>("h0") @[dut.scala 48:14]
          fr3Reg <= UInt<1>("h0") @[dut.scala 49:14]
        else :
          node _T_2 = eq(io.s, UInt<3>("h6")) @[dut.scala 50:21]
          node _T_3 = eq(io.s, UInt<2>("h3")) @[dut.scala 50:37]
          node _T_4 = or(_T_2, _T_3) @[dut.scala 50:29]
          when _T_4 : @[dut.scala 50:46]
            fr1Reg <= UInt<1>("h1") @[dut.scala 51:14]
            fr2Reg <= UInt<1>("h0") @[dut.scala 52:14]
            fr3Reg <= UInt<1>("h0") @[dut.scala 53:14]
          else :
            node _T_5 = eq(io.s, UInt<2>("h2")) @[dut.scala 54:21]
            node _T_6 = eq(io.s, UInt<1>("h1")) @[dut.scala 54:37]
            node _T_7 = or(_T_5, _T_6) @[dut.scala 54:29]
            when _T_7 : @[dut.scala 54:46]
              fr1Reg <= UInt<1>("h1") @[dut.scala 55:14]
              fr2Reg <= UInt<1>("h1") @[dut.scala 56:14]
              fr3Reg <= UInt<1>("h0") @[dut.scala 57:14]
            else :
              fr1Reg <= UInt<1>("h1") @[dut.scala 59:14]
              fr2Reg <= UInt<1>("h1") @[dut.scala 60:14]
              fr3Reg <= UInt<1>("h1") @[dut.scala 61:14]
        dfrReg <= isRising @[dut.scala 65:12]
    io.fr1 <= fr1Reg @[dut.scala 69:10]
    io.fr2 <= fr2Reg @[dut.scala 70:10]
    io.fr3 <= fr3Reg @[dut.scala 71:10]
    io.dfr <= dfrReg @[dut.scala 72:10]

