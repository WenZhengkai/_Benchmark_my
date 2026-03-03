circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rst : UInt<1>, flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node _sensorLevel_T = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node _sensorLevel_T_1 = mux(_sensorLevel_T, UInt<2>("h0"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _sensorLevel_T_2 = eq(UInt<3>("h4"), io.s) @[Mux.scala 81:61]
    node _sensorLevel_T_3 = mux(_sensorLevel_T_2, UInt<2>("h1"), _sensorLevel_T_1) @[Mux.scala 81:58]
    node _sensorLevel_T_4 = eq(UInt<3>("h6"), io.s) @[Mux.scala 81:61]
    node _sensorLevel_T_5 = mux(_sensorLevel_T_4, UInt<2>("h2"), _sensorLevel_T_3) @[Mux.scala 81:58]
    node _sensorLevel_T_6 = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node sensorLevel = mux(_sensorLevel_T_6, UInt<2>("h3"), _sensorLevel_T_5) @[Mux.scala 81:58]
    reg currLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 36:26]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 37:26]
    when io.rst : @[dut.scala 39:16]
      currLevel <= UInt<1>("h0") @[dut.scala 42:15]
      prevLevel <= UInt<1>("h0") @[dut.scala 43:15]
    else :
      node _T = neq(sensorLevel, currLevel) @[dut.scala 45:22]
      when _T : @[dut.scala 45:37]
        prevLevel <= currLevel @[dut.scala 46:17]
        currLevel <= sensorLevel @[dut.scala 47:17]
    node _io_fr1_T = leq(currLevel, UInt<2>("h2")) @[dut.scala 52:24]
    io.fr1 <= _io_fr1_T @[dut.scala 52:10]
    node _io_fr2_T = leq(currLevel, UInt<1>("h1")) @[dut.scala 53:24]
    io.fr2 <= _io_fr2_T @[dut.scala 53:10]
    node _io_fr3_T = eq(currLevel, UInt<1>("h0")) @[dut.scala 54:24]
    io.fr3 <= _io_fr3_T @[dut.scala 54:10]
    node roseSinceLastChange = lt(prevLevel, currLevel) @[dut.scala 60:39]
    node _io_dfr_T = eq(currLevel, UInt<1>("h0")) @[dut.scala 61:27]
    node _io_dfr_T_1 = eq(currLevel, UInt<2>("h3")) @[dut.scala 62:27]
    node _io_dfr_T_2 = mux(_io_dfr_T_1, UInt<1>("h0"), roseSinceLastChange) @[dut.scala 62:16]
    node _io_dfr_T_3 = mux(_io_dfr_T, UInt<1>("h1"), _io_dfr_T_2) @[dut.scala 61:16]
    io.dfr <= _io_dfr_T_3 @[dut.scala 61:10]

