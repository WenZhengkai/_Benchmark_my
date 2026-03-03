circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<4>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node s1 = bits(io.s, 1, 1) @[dut.scala 14:16]
    node s2 = bits(io.s, 2, 2) @[dut.scala 15:16]
    node s3 = bits(io.s, 3, 3) @[dut.scala 16:16]
    node currentLevel_hi = cat(s3, s2) @[Cat.scala 33:92]
    node currentLevel = cat(currentLevel_hi, s1) @[Cat.scala 33:92]
    reg prevLevel : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 22:26]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 25:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 26:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 27:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 28:23]
    prevLevel <= currentLevel @[dut.scala 31:13]
    node isRising = gt(currentLevel, prevLevel) @[dut.scala 35:31]
    node _T = eq(currentLevel, UInt<3>("h7")) @[dut.scala 38:21]
    when _T : @[dut.scala 38:35]
      fr3Reg <= UInt<1>("h0") @[dut.scala 40:12]
      fr2Reg <= UInt<1>("h0") @[dut.scala 41:12]
      fr1Reg <= UInt<1>("h0") @[dut.scala 42:12]
      dfrReg <= UInt<1>("h0") @[dut.scala 43:12]
    else :
      node _T_1 = eq(currentLevel, UInt<2>("h3")) @[dut.scala 44:27]
      when _T_1 : @[dut.scala 44:41]
        fr3Reg <= UInt<1>("h0") @[dut.scala 46:12]
        fr2Reg <= UInt<1>("h0") @[dut.scala 47:12]
        fr1Reg <= UInt<1>("h1") @[dut.scala 48:12]
        dfrReg <= isRising @[dut.scala 49:12]
      else :
        node _T_2 = eq(currentLevel, UInt<1>("h1")) @[dut.scala 50:27]
        when _T_2 : @[dut.scala 50:41]
          fr3Reg <= UInt<1>("h0") @[dut.scala 52:12]
          fr2Reg <= UInt<1>("h1") @[dut.scala 53:12]
          fr1Reg <= UInt<1>("h1") @[dut.scala 54:12]
          dfrReg <= isRising @[dut.scala 55:12]
        else :
          node _T_3 = eq(currentLevel, UInt<1>("h0")) @[dut.scala 56:27]
          when _T_3 : @[dut.scala 56:41]
            fr3Reg <= UInt<1>("h1") @[dut.scala 58:12]
            fr2Reg <= UInt<1>("h1") @[dut.scala 59:12]
            fr1Reg <= UInt<1>("h1") @[dut.scala 60:12]
            dfrReg <= UInt<1>("h1") @[dut.scala 61:12]
          else :
            skip
    io.fr3 <= fr3Reg @[dut.scala 69:10]
    io.fr2 <= fr2Reg @[dut.scala 70:10]
    io.fr1 <= fr1Reg @[dut.scala 71:10]
    io.dfr <= dfrReg @[dut.scala 72:10]

