circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<4>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node s1 = bits(io.s, 1, 1) @[dut.scala 14:16]
    node s2 = bits(io.s, 2, 2) @[dut.scala 15:16]
    node s3 = bits(io.s, 3, 3) @[dut.scala 16:16]
    wire currentLevel : UInt<3> @[dut.scala 19:33]
    currentLevel <= UInt<3>("h0") @[dut.scala 19:33]
    node _T = and(s3, s2) @[dut.scala 20:11]
    node _T_1 = and(_T, s1) @[dut.scala 20:17]
    when _T_1 : @[dut.scala 20:24]
      currentLevel <= UInt<2>("h3") @[dut.scala 21:18]
    else :
      node _T_2 = and(s2, s1) @[dut.scala 22:17]
      node _T_3 = eq(s3, UInt<1>("h0")) @[dut.scala 22:26]
      node _T_4 = and(_T_2, _T_3) @[dut.scala 22:23]
      when _T_4 : @[dut.scala 22:31]
        currentLevel <= UInt<2>("h2") @[dut.scala 23:18]
      else :
        node _T_5 = eq(s2, UInt<1>("h0")) @[dut.scala 24:20]
        node _T_6 = and(s1, _T_5) @[dut.scala 24:17]
        node _T_7 = eq(s3, UInt<1>("h0")) @[dut.scala 24:27]
        node _T_8 = and(_T_6, _T_7) @[dut.scala 24:24]
        when _T_8 : @[dut.scala 24:32]
          currentLevel <= UInt<1>("h1") @[dut.scala 25:18]
        else :
          currentLevel <= UInt<1>("h0") @[dut.scala 27:18]
    reg prevLevel : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 31:26]
    prevLevel <= currentLevel @[dut.scala 35:13]
    node isRising = lt(prevLevel, currentLevel) @[dut.scala 38:28]
    wire nominalFr1 : UInt<1> @[dut.scala 41:31]
    nominalFr1 <= UInt<1>("h0") @[dut.scala 41:31]
    wire nominalFr2 : UInt<1> @[dut.scala 42:31]
    nominalFr2 <= UInt<1>("h0") @[dut.scala 42:31]
    wire nominalFr3 : UInt<1> @[dut.scala 43:31]
    nominalFr3 <= UInt<1>("h0") @[dut.scala 43:31]
    node _T_9 = eq(UInt<1>("h0"), currentLevel) @[dut.scala 45:24]
    when _T_9 : @[dut.scala 45:24]
      nominalFr1 <= UInt<1>("h1") @[dut.scala 47:18]
      nominalFr2 <= UInt<1>("h1") @[dut.scala 48:18]
      nominalFr3 <= UInt<1>("h1") @[dut.scala 49:18]
    else :
      node _T_10 = eq(UInt<1>("h1"), currentLevel) @[dut.scala 45:24]
      when _T_10 : @[dut.scala 45:24]
        nominalFr1 <= UInt<1>("h1") @[dut.scala 52:18]
        nominalFr2 <= UInt<1>("h1") @[dut.scala 53:18]
        nominalFr3 <= UInt<1>("h0") @[dut.scala 54:18]
      else :
        node _T_11 = eq(UInt<2>("h2"), currentLevel) @[dut.scala 45:24]
        when _T_11 : @[dut.scala 45:24]
          nominalFr1 <= UInt<1>("h1") @[dut.scala 57:18]
          nominalFr2 <= UInt<1>("h0") @[dut.scala 58:18]
          nominalFr3 <= UInt<1>("h0") @[dut.scala 59:18]
        else :
          node _T_12 = eq(UInt<2>("h3"), currentLevel) @[dut.scala 45:24]
          when _T_12 : @[dut.scala 45:24]
            nominalFr1 <= UInt<1>("h0") @[dut.scala 62:18]
            nominalFr2 <= UInt<1>("h0") @[dut.scala 63:18]
            nominalFr3 <= UInt<1>("h0") @[dut.scala 64:18]
    node _supplementalFlow_T = neq(currentLevel, UInt<2>("h3")) @[dut.scala 70:52]
    node supplementalFlow = and(isRising, _supplementalFlow_T) @[dut.scala 70:35]
    io.fr1 <= nominalFr1 @[dut.scala 73:10]
    io.fr2 <= nominalFr2 @[dut.scala 74:10]
    io.fr3 <= nominalFr3 @[dut.scala 75:10]
    io.dfr <= supplementalFlow @[dut.scala 76:10]
    node _T_13 = bits(reset, 0, 0) @[dut.scala 83:14]
    when _T_13 : @[dut.scala 83:22]
      io.fr1 <= UInt<1>("h1") @[dut.scala 84:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 85:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 86:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 87:12]


