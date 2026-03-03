circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire curLevel : UInt<2> @[dut.scala 36:22]
    curLevel <= UInt<2>("h3") @[dut.scala 37:12]
    node _T = eq(UInt<3>("h7"), io.s) @[dut.scala 38:16]
    when _T : @[dut.scala 38:16]
      curLevel <= UInt<2>("h0") @[dut.scala 39:29]
    else :
      node _T_1 = eq(UInt<2>("h3"), io.s) @[dut.scala 38:16]
      when _T_1 : @[dut.scala 38:16]
        curLevel <= UInt<2>("h1") @[dut.scala 40:29]
      else :
        node _T_2 = eq(UInt<1>("h1"), io.s) @[dut.scala 38:16]
        when _T_2 : @[dut.scala 38:16]
          curLevel <= UInt<2>("h2") @[dut.scala 41:29]
        else :
          node _T_3 = eq(UInt<1>("h0"), io.s) @[dut.scala 38:16]
          when _T_3 : @[dut.scala 38:16]
            curLevel <= UInt<2>("h3") @[dut.scala 42:29]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 46:26]
    node dfrNext = lt(curLevel, prevLevel) @[dut.scala 49:25]
    wire fr1Nom : UInt<1> @[dut.scala 52:27]
    fr1Nom <= UInt<1>("h0") @[dut.scala 52:27]
    wire fr2Nom : UInt<1> @[dut.scala 53:27]
    fr2Nom <= UInt<1>("h0") @[dut.scala 53:27]
    wire fr3Nom : UInt<1> @[dut.scala 54:27]
    fr3Nom <= UInt<1>("h0") @[dut.scala 54:27]
    node _T_4 = eq(UInt<2>("h0"), curLevel) @[dut.scala 56:20]
    when _T_4 : @[dut.scala 56:20]
      fr1Nom <= UInt<1>("h0") @[dut.scala 58:14]
      fr2Nom <= UInt<1>("h0") @[dut.scala 58:33]
      fr3Nom <= UInt<1>("h0") @[dut.scala 58:52]
    else :
      node _T_5 = eq(UInt<2>("h1"), curLevel) @[dut.scala 56:20]
      when _T_5 : @[dut.scala 56:20]
        fr1Nom <= UInt<1>("h1") @[dut.scala 61:14]
        fr2Nom <= UInt<1>("h0") @[dut.scala 61:33]
        fr3Nom <= UInt<1>("h0") @[dut.scala 61:52]
      else :
        node _T_6 = eq(UInt<2>("h2"), curLevel) @[dut.scala 56:20]
        when _T_6 : @[dut.scala 56:20]
          fr1Nom <= UInt<1>("h1") @[dut.scala 64:14]
          fr2Nom <= UInt<1>("h1") @[dut.scala 64:33]
          fr3Nom <= UInt<1>("h0") @[dut.scala 64:52]
        else :
          node _T_7 = eq(UInt<2>("h3"), curLevel) @[dut.scala 56:20]
          when _T_7 : @[dut.scala 56:20]
            fr1Nom <= UInt<1>("h1") @[dut.scala 67:14]
            fr2Nom <= UInt<1>("h1") @[dut.scala 67:33]
            fr3Nom <= UInt<1>("h1") @[dut.scala 67:52]
    node _T_8 = bits(reset, 0, 0) @[dut.scala 77:14]
    when _T_8 : @[dut.scala 77:22]
      prevLevel <= UInt<2>("h3") @[dut.scala 78:15]
      io.fr1 <= UInt<1>("h1") @[dut.scala 79:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 80:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 81:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 82:12]
    else :
      prevLevel <= curLevel @[dut.scala 85:15]
      io.fr1 <= fr1Nom @[dut.scala 87:12]
      io.fr2 <= fr2Nom @[dut.scala 88:12]
      io.fr3 <= fr3Nom @[dut.scala 89:12]
      io.dfr <= dfrNext @[dut.scala 90:12]


