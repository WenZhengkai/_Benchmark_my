circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire levelNow : UInt<2> @[dut.scala 14:22]
    node _levelNow_T = bits(io.s, 2, 2) @[dut.scala 15:23]
    node _levelNow_T_1 = bits(io.s, 1, 1) @[dut.scala 15:41]
    node _levelNow_T_2 = bits(io.s, 0, 0) @[dut.scala 15:59]
    node _levelNow_T_3 = mux(_levelNow_T_2, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 15:54]
    node _levelNow_T_4 = mux(_levelNow_T_1, UInt<2>("h2"), _levelNow_T_3) @[dut.scala 15:36]
    node _levelNow_T_5 = mux(_levelNow_T, UInt<2>("h3"), _levelNow_T_4) @[dut.scala 15:18]
    levelNow <= _levelNow_T_5 @[dut.scala 15:12]
    reg currentLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 19:29]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 20:29]
    node _T = neq(levelNow, currentLevel) @[dut.scala 22:17]
    when _T : @[dut.scala 22:35]
      prevLevel <= currentLevel @[dut.scala 23:18]
      currentLevel <= levelNow @[dut.scala 24:18]
    node _io_fr1_T = leq(currentLevel, UInt<2>("h2")) @[dut.scala 28:27]
    io.fr1 <= _io_fr1_T @[dut.scala 28:10]
    node _io_fr2_T = leq(currentLevel, UInt<1>("h1")) @[dut.scala 29:27]
    io.fr2 <= _io_fr2_T @[dut.scala 29:10]
    node _io_fr3_T = eq(currentLevel, UInt<1>("h0")) @[dut.scala 30:27]
    io.fr3 <= _io_fr3_T @[dut.scala 30:10]
    node _io_dfr_T = eq(currentLevel, UInt<1>("h0")) @[dut.scala 37:18]
    node _io_dfr_T_1 = eq(currentLevel, UInt<2>("h3")) @[dut.scala 39:22]
    node _io_dfr_T_2 = lt(prevLevel, currentLevel) @[dut.scala 39:50]
    node _io_dfr_T_3 = mux(_io_dfr_T_1, UInt<1>("h0"), _io_dfr_T_2) @[dut.scala 39:8]
    node _io_dfr_T_4 = mux(_io_dfr_T, UInt<1>("h1"), _io_dfr_T_3) @[dut.scala 36:16]
    io.dfr <= _io_dfr_T_4 @[dut.scala 36:10]

