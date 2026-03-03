circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip srst : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node _sensedLevel_T = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node _sensedLevel_T_1 = mux(_sensedLevel_T, UInt<2>("h3"), UInt<2>("h0")) @[Mux.scala 81:58]
    node _sensedLevel_T_2 = eq(UInt<3>("h6"), io.s) @[Mux.scala 81:61]
    node _sensedLevel_T_3 = mux(_sensedLevel_T_2, UInt<2>("h2"), _sensedLevel_T_1) @[Mux.scala 81:58]
    node _sensedLevel_T_4 = eq(UInt<3>("h4"), io.s) @[Mux.scala 81:61]
    node _sensedLevel_T_5 = mux(_sensedLevel_T_4, UInt<2>("h1"), _sensedLevel_T_3) @[Mux.scala 81:58]
    node _sensedLevel_T_6 = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node sensedLevel = mux(_sensedLevel_T_6, UInt<2>("h0"), _sensedLevel_T_5) @[Mux.scala 81:58]
    reg currentLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 28:29]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 29:29]
    when io.srst : @[dut.scala 31:17]
      currentLevel <= UInt<1>("h0") @[dut.scala 33:18]
      prevLevel <= UInt<1>("h0") @[dut.scala 34:18]
    else :
      node _T = neq(sensedLevel, currentLevel) @[dut.scala 35:26]
      when _T : @[dut.scala 35:44]
        prevLevel <= currentLevel @[dut.scala 36:18]
        currentLevel <= sensedLevel @[dut.scala 37:18]
    node _io_fr1_T = neq(currentLevel, UInt<2>("h3")) @[dut.scala 41:26]
    io.fr1 <= _io_fr1_T @[dut.scala 41:10]
    node _io_fr2_T = leq(currentLevel, UInt<1>("h1")) @[dut.scala 42:26]
    io.fr2 <= _io_fr2_T @[dut.scala 42:10]
    node _io_fr3_T = eq(currentLevel, UInt<1>("h0")) @[dut.scala 43:26]
    io.fr3 <= _io_fr3_T @[dut.scala 43:10]
    node _io_dfr_T = eq(currentLevel, UInt<1>("h0")) @[dut.scala 48:27]
    node _io_dfr_T_1 = eq(currentLevel, UInt<1>("h1")) @[dut.scala 49:29]
    node _io_dfr_T_2 = eq(currentLevel, UInt<2>("h2")) @[dut.scala 49:55]
    node _io_dfr_T_3 = or(_io_dfr_T_1, _io_dfr_T_2) @[dut.scala 49:38]
    node _io_dfr_T_4 = lt(prevLevel, currentLevel) @[dut.scala 49:79]
    node _io_dfr_T_5 = and(_io_dfr_T_3, _io_dfr_T_4) @[dut.scala 49:65]
    node _io_dfr_T_6 = or(_io_dfr_T, _io_dfr_T_5) @[dut.scala 48:36]
    io.dfr <= _io_dfr_T_6 @[dut.scala 48:10]

