circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:26]
    when io.reset : @[dut.scala 19:18]
      io.fr3 <= UInt<1>("h1") @[dut.scala 21:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 22:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 23:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 24:12]
      prevLevel <= UInt<1>("h0") @[dut.scala 25:15]
    else :
      wire currentLevel : UInt<2> @[dut.scala 28:28]
      node _currentLevel_T = eq(io.s, UInt<1>("h0")) @[dut.scala 32:15]
      node _currentLevel_T_1 = eq(io.s, UInt<1>("h1")) @[dut.scala 33:15]
      node _currentLevel_T_2 = eq(io.s, UInt<2>("h3")) @[dut.scala 34:15]
      node _currentLevel_T_3 = mux(_currentLevel_T_2, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 101:16]
      node _currentLevel_T_4 = mux(_currentLevel_T_1, UInt<1>("h1"), _currentLevel_T_3) @[Mux.scala 101:16]
      node _currentLevel_T_5 = mux(_currentLevel_T, UInt<1>("h0"), _currentLevel_T_4) @[Mux.scala 101:16]
      currentLevel <= _currentLevel_T_5 @[dut.scala 29:18]
      node _io_fr3_T = eq(currentLevel, UInt<1>("h0")) @[dut.scala 39:28]
      io.fr3 <= _io_fr3_T @[dut.scala 39:12]
      node _io_fr2_T = leq(currentLevel, UInt<1>("h1")) @[dut.scala 40:28]
      io.fr2 <= _io_fr2_T @[dut.scala 40:12]
      node _io_fr1_T = leq(currentLevel, UInt<2>("h2")) @[dut.scala 41:28]
      io.fr1 <= _io_fr1_T @[dut.scala 41:12]
      node _io_dfr_T = lt(prevLevel, currentLevel) @[dut.scala 44:25]
      io.dfr <= _io_dfr_T @[dut.scala 44:12]
      prevLevel <= currentLevel @[dut.scala 47:15]


