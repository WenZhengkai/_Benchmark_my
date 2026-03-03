circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node _currLevel_T = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_1 = mux(_currLevel_T, UInt<2>("h3"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _currLevel_T_2 = eq(UInt<2>("h3"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_3 = mux(_currLevel_T_2, UInt<2>("h2"), _currLevel_T_1) @[Mux.scala 81:58]
    node _currLevel_T_4 = eq(UInt<1>("h1"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_5 = mux(_currLevel_T_4, UInt<2>("h1"), _currLevel_T_3) @[Mux.scala 81:58]
    node _currLevel_T_6 = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node currLevel = mux(_currLevel_T_6, UInt<2>("h0"), _currLevel_T_5) @[Mux.scala 81:58]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 45:26]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 49:23]
    node _T = bits(reset, 0, 0) @[dut.scala 52:15]
    when _T : @[dut.scala 52:23]
      prevLevel <= UInt<1>("h0") @[dut.scala 53:15]
      dfrReg <= UInt<1>("h1") @[dut.scala 54:15]
    else :
      node _T_1 = neq(currLevel, prevLevel) @[dut.scala 56:21]
      when _T_1 : @[dut.scala 56:36]
        node _T_2 = gt(currLevel, prevLevel) @[dut.scala 57:23]
        when _T_2 : @[dut.scala 57:36]
          dfrReg <= UInt<1>("h1") @[dut.scala 59:16]
        else :
          dfrReg <= UInt<1>("h0") @[dut.scala 62:16]
        prevLevel <= currLevel @[dut.scala 64:17]
    wire fr1Nom : UInt<1> @[dut.scala 69:27]
    fr1Nom <= UInt<1>("h0") @[dut.scala 69:27]
    wire fr2Nom : UInt<1> @[dut.scala 70:27]
    fr2Nom <= UInt<1>("h0") @[dut.scala 70:27]
    wire fr3Nom : UInt<1> @[dut.scala 71:27]
    fr3Nom <= UInt<1>("h0") @[dut.scala 71:27]
    node _T_3 = eq(UInt<2>("h3"), currLevel) @[dut.scala 73:21]
    when _T_3 : @[dut.scala 73:21]
      fr1Nom <= UInt<1>("h0") @[dut.scala 75:14]
      fr2Nom <= UInt<1>("h0") @[dut.scala 75:33]
      fr3Nom <= UInt<1>("h0") @[dut.scala 75:52]
    else :
      node _T_4 = eq(UInt<2>("h2"), currLevel) @[dut.scala 73:21]
      when _T_4 : @[dut.scala 73:21]
        fr1Nom <= UInt<1>("h1") @[dut.scala 78:14]
        fr2Nom <= UInt<1>("h0") @[dut.scala 78:33]
        fr3Nom <= UInt<1>("h0") @[dut.scala 78:52]
      else :
        node _T_5 = eq(UInt<1>("h1"), currLevel) @[dut.scala 73:21]
        when _T_5 : @[dut.scala 73:21]
          fr1Nom <= UInt<1>("h1") @[dut.scala 81:14]
          fr2Nom <= UInt<1>("h1") @[dut.scala 81:33]
          fr3Nom <= UInt<1>("h0") @[dut.scala 81:52]
        else :
          node _T_6 = eq(UInt<1>("h0"), currLevel) @[dut.scala 73:21]
          when _T_6 : @[dut.scala 73:21]
            fr1Nom <= UInt<1>("h1") @[dut.scala 84:14]
            fr2Nom <= UInt<1>("h1") @[dut.scala 84:33]
            fr3Nom <= UInt<1>("h1") @[dut.scala 84:52]
    io.fr1 <= fr1Nom @[dut.scala 88:10]
    io.fr2 <= fr2Nom @[dut.scala 89:10]
    io.fr3 <= fr3Nom @[dut.scala 90:10]
    io.dfr <= dfrReg @[dut.scala 91:10]

