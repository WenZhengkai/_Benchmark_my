circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, flip reset : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:22]
    reg preservedDirection : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:35]
    when io.reset : @[dut.scala 25:18]
      state <= UInt<1>("h0") @[dut.scala 26:11]
      preservedDirection <= UInt<1>("h0") @[dut.scala 27:24]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 31:17]
    node _T_1 = asUInt(state) @[dut.scala 31:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 31:17]
    when _T_2 : @[dut.scala 31:17]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 33:12]
      when _T_3 : @[dut.scala 33:24]
        state <= UInt<2>("h2") @[dut.scala 34:15]
        preservedDirection <= UInt<1>("h0") @[dut.scala 35:28]
      else :
        node _T_4 = and(io.bump_left, io.bump_right) @[dut.scala 36:49]
        node _T_5 = or(io.bump_left, _T_4) @[dut.scala 36:32]
        when _T_5 : @[dut.scala 36:68]
          state <= UInt<1>("h1") @[dut.scala 37:15]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 31:17]
      node _T_7 = asUInt(state) @[dut.scala 31:17]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 31:17]
      when _T_8 : @[dut.scala 31:17]
        node _T_9 = eq(io.ground, UInt<1>("h0")) @[dut.scala 42:12]
        when _T_9 : @[dut.scala 42:24]
          state <= UInt<2>("h2") @[dut.scala 43:15]
          preservedDirection <= UInt<1>("h1") @[dut.scala 44:28]
        else :
          node _T_10 = and(io.bump_left, io.bump_right) @[dut.scala 45:50]
          node _T_11 = or(io.bump_right, _T_10) @[dut.scala 45:33]
          when _T_11 : @[dut.scala 45:69]
            state <= UInt<1>("h0") @[dut.scala 46:15]
      else :
        node _T_12 = asUInt(UInt<2>("h2")) @[dut.scala 31:17]
        node _T_13 = asUInt(state) @[dut.scala 31:17]
        node _T_14 = eq(_T_12, _T_13) @[dut.scala 31:17]
        when _T_14 : @[dut.scala 31:17]
          when io.ground : @[dut.scala 52:23]
            state <= preservedDirection @[dut.scala 53:15]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 59:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 59:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 60:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 60:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 61:21]
    io.aaah <= _io_aaah_T @[dut.scala 61:11]

