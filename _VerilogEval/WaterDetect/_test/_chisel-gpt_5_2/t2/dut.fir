circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset_sync : UInt<1>}

    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 57:22]
    wire nominal_fr1 : UInt<1> @[dut.scala 60:32]
    nominal_fr1 <= UInt<1>("h0") @[dut.scala 60:32]
    wire nominal_fr2 : UInt<1> @[dut.scala 61:32]
    nominal_fr2 <= UInt<1>("h0") @[dut.scala 61:32]
    wire nominal_fr3 : UInt<1> @[dut.scala 62:32]
    nominal_fr3 <= UInt<1>("h0") @[dut.scala 62:32]
    node _T = eq(UInt<3>("h7"), io.s) @[dut.scala 64:16]
    when _T : @[dut.scala 64:16]
      nominal_fr1 <= UInt<1>("h0") @[dut.scala 66:19]
      nominal_fr2 <= UInt<1>("h0") @[dut.scala 67:19]
      nominal_fr3 <= UInt<1>("h0") @[dut.scala 68:19]
    else :
      node _T_1 = eq(UInt<3>("h3"), io.s) @[dut.scala 64:16]
      when _T_1 : @[dut.scala 64:16]
        nominal_fr1 <= UInt<1>("h1") @[dut.scala 71:19]
        nominal_fr2 <= UInt<1>("h0") @[dut.scala 72:19]
        nominal_fr3 <= UInt<1>("h0") @[dut.scala 73:19]
      else :
        node _T_2 = eq(UInt<3>("h1"), io.s) @[dut.scala 64:16]
        when _T_2 : @[dut.scala 64:16]
          nominal_fr1 <= UInt<1>("h1") @[dut.scala 76:19]
          nominal_fr2 <= UInt<1>("h1") @[dut.scala 77:19]
          nominal_fr3 <= UInt<1>("h0") @[dut.scala 78:19]
        else :
          node _T_3 = eq(UInt<3>("h0"), io.s) @[dut.scala 64:16]
          when _T_3 : @[dut.scala 64:16]
            nominal_fr1 <= UInt<1>("h1") @[dut.scala 81:19]
            nominal_fr2 <= UInt<1>("h1") @[dut.scala 82:19]
            nominal_fr3 <= UInt<1>("h1") @[dut.scala 83:19]
    node sensorsChanged = neq(io.s, prevS) @[dut.scala 88:29]
    node _prevRank_T = eq(UInt<3>("h0"), prevS) @[Mux.scala 81:61]
    node _prevRank_T_1 = mux(_prevRank_T, UInt<2>("h0"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _prevRank_T_2 = eq(UInt<3>("h1"), prevS) @[Mux.scala 81:61]
    node _prevRank_T_3 = mux(_prevRank_T_2, UInt<2>("h1"), _prevRank_T_1) @[Mux.scala 81:58]
    node _prevRank_T_4 = eq(UInt<3>("h3"), prevS) @[Mux.scala 81:61]
    node _prevRank_T_5 = mux(_prevRank_T_4, UInt<2>("h2"), _prevRank_T_3) @[Mux.scala 81:58]
    node _prevRank_T_6 = eq(UInt<3>("h7"), prevS) @[Mux.scala 81:61]
    node prevRank = mux(_prevRank_T_6, UInt<2>("h3"), _prevRank_T_5) @[Mux.scala 81:58]
    node _currRank_T = eq(UInt<3>("h0"), io.s) @[Mux.scala 81:61]
    node _currRank_T_1 = mux(_currRank_T, UInt<2>("h0"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _currRank_T_2 = eq(UInt<3>("h1"), io.s) @[Mux.scala 81:61]
    node _currRank_T_3 = mux(_currRank_T_2, UInt<2>("h1"), _currRank_T_1) @[Mux.scala 81:58]
    node _currRank_T_4 = eq(UInt<3>("h3"), io.s) @[Mux.scala 81:61]
    node _currRank_T_5 = mux(_currRank_T_4, UInt<2>("h2"), _currRank_T_3) @[Mux.scala 81:58]
    node _currRank_T_6 = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node currRank = mux(_currRank_T_6, UInt<2>("h3"), _currRank_T_5) @[Mux.scala 81:58]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 95:23]
    when io.reset_sync : @[dut.scala 96:23]
      prevS <= UInt<3>("h0") @[dut.scala 97:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 98:12]
    else :
      when sensorsChanged : @[dut.scala 100:26]
        node _dfrReg_T = lt(prevRank, currRank) @[dut.scala 101:26]
        dfrReg <= _dfrReg_T @[dut.scala 101:14]
        prevS <= io.s @[dut.scala 102:14]
    io.fr1 <= nominal_fr1 @[dut.scala 107:10]
    io.fr2 <= nominal_fr2 @[dut.scala 108:10]
    io.fr3 <= nominal_fr3 @[dut.scala 109:10]
    io.dfr <= dfrReg @[dut.scala 110:10]

