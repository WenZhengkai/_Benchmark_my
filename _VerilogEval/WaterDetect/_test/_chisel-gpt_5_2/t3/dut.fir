circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    node _currLevel_T = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_1 = mux(_currLevel_T, UInt<2>("h3"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _currLevel_T_2 = eq(UInt<2>("h3"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_3 = mux(_currLevel_T_2, UInt<2>("h2"), _currLevel_T_1) @[Mux.scala 81:58]
    node _currLevel_T_4 = eq(UInt<1>("h1"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_5 = mux(_currLevel_T_4, UInt<2>("h1"), _currLevel_T_3) @[Mux.scala 81:58]
    node _currLevel_T_6 = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node currLevel = mux(_currLevel_T_6, UInt<2>("h0"), _currLevel_T_5) @[Mux.scala 81:58]
    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 45:22]
    when io.reset : @[dut.scala 48:19]
      prevS <= UInt<1>("h0") @[dut.scala 49:11]
    else :
      node _T = neq(io.s, prevS) @[dut.scala 50:21]
      when _T : @[dut.scala 50:32]
        prevS <= io.s @[dut.scala 51:11]
    node _prevLevel_T = eq(UInt<3>("h7"), prevS) @[Mux.scala 81:61]
    node _prevLevel_T_1 = mux(_prevLevel_T, UInt<2>("h3"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _prevLevel_T_2 = eq(UInt<2>("h3"), prevS) @[Mux.scala 81:61]
    node _prevLevel_T_3 = mux(_prevLevel_T_2, UInt<2>("h2"), _prevLevel_T_1) @[Mux.scala 81:58]
    node _prevLevel_T_4 = eq(UInt<1>("h1"), prevS) @[Mux.scala 81:61]
    node _prevLevel_T_5 = mux(_prevLevel_T_4, UInt<2>("h1"), _prevLevel_T_3) @[Mux.scala 81:58]
    node _prevLevel_T_6 = eq(UInt<1>("h0"), prevS) @[Mux.scala 81:61]
    node prevLevel = mux(_prevLevel_T_6, UInt<2>("h0"), _prevLevel_T_5) @[Mux.scala 81:58]
    wire nom_fr1 : UInt<1> @[dut.scala 57:28]
    nom_fr1 <= UInt<1>("h0") @[dut.scala 57:28]
    wire nom_fr2 : UInt<1> @[dut.scala 58:28]
    nom_fr2 <= UInt<1>("h0") @[dut.scala 58:28]
    wire nom_fr3 : UInt<1> @[dut.scala 59:28]
    nom_fr3 <= UInt<1>("h0") @[dut.scala 59:28]
    node _T_1 = eq(UInt<2>("h3"), currLevel) @[dut.scala 61:21]
    when _T_1 : @[dut.scala 61:21]
      nom_fr1 <= UInt<1>("h0") @[dut.scala 63:15]
      nom_fr2 <= UInt<1>("h0") @[dut.scala 63:35]
      nom_fr3 <= UInt<1>("h0") @[dut.scala 63:55]
    else :
      node _T_2 = eq(UInt<2>("h2"), currLevel) @[dut.scala 61:21]
      when _T_2 : @[dut.scala 61:21]
        nom_fr1 <= UInt<1>("h1") @[dut.scala 66:15]
        nom_fr2 <= UInt<1>("h0") @[dut.scala 66:35]
        nom_fr3 <= UInt<1>("h0") @[dut.scala 66:55]
      else :
        node _T_3 = eq(UInt<1>("h1"), currLevel) @[dut.scala 61:21]
        when _T_3 : @[dut.scala 61:21]
          nom_fr1 <= UInt<1>("h1") @[dut.scala 69:15]
          nom_fr2 <= UInt<1>("h1") @[dut.scala 69:35]
          nom_fr3 <= UInt<1>("h0") @[dut.scala 69:55]
        else :
          node _T_4 = eq(UInt<1>("h0"), currLevel) @[dut.scala 61:21]
          when _T_4 : @[dut.scala 61:21]
            nom_fr1 <= UInt<1>("h1") @[dut.scala 72:15]
            nom_fr2 <= UInt<1>("h1") @[dut.scala 72:35]
            nom_fr3 <= UInt<1>("h1") @[dut.scala 72:55]
    node dfrComb = gt(currLevel, prevLevel) @[dut.scala 79:41]
    reg fr1_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 83:22]
    reg fr2_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 84:22]
    reg fr3_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 85:22]
    reg dfr_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 86:22]
    when io.reset : @[dut.scala 88:19]
      fr1_r <= UInt<1>("h1") @[dut.scala 90:11]
      fr2_r <= UInt<1>("h1") @[dut.scala 91:11]
      fr3_r <= UInt<1>("h1") @[dut.scala 92:11]
      dfr_r <= UInt<1>("h1") @[dut.scala 93:11]
    else :
      fr1_r <= nom_fr1 @[dut.scala 95:11]
      fr2_r <= nom_fr2 @[dut.scala 96:11]
      fr3_r <= nom_fr3 @[dut.scala 97:11]
      dfr_r <= dfrComb @[dut.scala 98:11]
    io.fr1 <= fr1_r @[dut.scala 101:10]
    io.fr2 <= fr2_r @[dut.scala 102:10]
    io.fr3 <= fr3_r @[dut.scala 103:10]
    io.dfr <= dfr_r @[dut.scala 104:10]

