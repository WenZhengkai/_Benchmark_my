circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node _currLevel_T = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_1 = mux(_currLevel_T, UInt<2>("h0"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _currLevel_T_2 = eq(UInt<1>("h1"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_3 = mux(_currLevel_T_2, UInt<2>("h1"), _currLevel_T_1) @[Mux.scala 81:58]
    node _currLevel_T_4 = eq(UInt<2>("h3"), io.s) @[Mux.scala 81:61]
    node _currLevel_T_5 = mux(_currLevel_T_4, UInt<2>("h2"), _currLevel_T_3) @[Mux.scala 81:58]
    node _currLevel_T_6 = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node currLevel = mux(_currLevel_T_6, UInt<2>("h3"), _currLevel_T_5) @[Mux.scala 81:58]
    reg lastLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 32:30]
    reg cameFromLower : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 33:30]
    node _T = neq(currLevel, lastLevel) @[dut.scala 35:18]
    when _T : @[dut.scala 35:33]
      node _cameFromLower_T = lt(lastLevel, currLevel) @[dut.scala 36:32]
      cameFromLower <= _cameFromLower_T @[dut.scala 36:19]
      lastLevel <= currLevel @[dut.scala 37:15]
    io.fr1 <= UInt<1>("h0") @[dut.scala 41:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 42:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 43:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 44:10]
    node _T_1 = eq(UInt<1>("h0"), currLevel) @[dut.scala 47:21]
    when _T_1 : @[dut.scala 47:21]
      io.fr1 <= UInt<1>("h1") @[dut.scala 49:14]
      io.fr2 <= UInt<1>("h1") @[dut.scala 50:14]
      io.fr3 <= UInt<1>("h1") @[dut.scala 51:14]
      io.dfr <= UInt<1>("h1") @[dut.scala 52:14]
    else :
      node _T_2 = eq(UInt<1>("h1"), currLevel) @[dut.scala 47:21]
      when _T_2 : @[dut.scala 47:21]
        io.fr1 <= UInt<1>("h1") @[dut.scala 55:14]
        io.fr2 <= UInt<1>("h1") @[dut.scala 56:14]
        io.dfr <= cameFromLower @[dut.scala 57:14]
      else :
        node _T_3 = eq(UInt<2>("h2"), currLevel) @[dut.scala 47:21]
        when _T_3 : @[dut.scala 47:21]
          io.fr1 <= UInt<1>("h1") @[dut.scala 60:14]
          io.dfr <= cameFromLower @[dut.scala 61:14]
        else :
          node _T_4 = eq(UInt<2>("h3"), currLevel) @[dut.scala 47:21]
          when _T_4 : @[dut.scala 47:21]
            skip
    node _T_5 = bits(reset, 0, 0) @[dut.scala 70:14]
    when _T_5 : @[dut.scala 70:22]
      io.fr1 <= UInt<1>("h1") @[dut.scala 71:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 72:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 73:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 74:12]


