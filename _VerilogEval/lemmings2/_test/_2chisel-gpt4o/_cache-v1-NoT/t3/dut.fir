circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, flip reset : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:22]
    reg preservedWalkingDirection : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:42]
    when io.reset : @[dut.scala 23:18]
      state <= UInt<1>("h0") @[dut.scala 24:11]
      preservedWalkingDirection <= UInt<1>("h0") @[dut.scala 25:31]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 29:17]
    node _T_1 = asUInt(state) @[dut.scala 29:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 29:17]
    when _T_2 : @[dut.scala 29:17]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 31:12]
      when _T_3 : @[dut.scala 31:24]
        state <= UInt<2>("h2") @[dut.scala 32:15]
        preservedWalkingDirection <= UInt<1>("h0") @[dut.scala 33:35]
      else :
        node _T_4 = and(io.bump_left, io.bump_right) @[dut.scala 34:31]
        when _T_4 : @[dut.scala 34:49]
          state <= UInt<1>("h1") @[dut.scala 35:15]
        else :
          when io.bump_left : @[dut.scala 36:32]
            state <= UInt<1>("h1") @[dut.scala 37:15]
    else :
      node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 29:17]
      node _T_6 = asUInt(state) @[dut.scala 29:17]
      node _T_7 = eq(_T_5, _T_6) @[dut.scala 29:17]
      when _T_7 : @[dut.scala 29:17]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 41:12]
        when _T_8 : @[dut.scala 41:24]
          state <= UInt<2>("h2") @[dut.scala 42:15]
          preservedWalkingDirection <= UInt<1>("h1") @[dut.scala 43:35]
        else :
          node _T_9 = and(io.bump_left, io.bump_right) @[dut.scala 44:31]
          when _T_9 : @[dut.scala 44:49]
            state <= UInt<1>("h0") @[dut.scala 45:15]
          else :
            when io.bump_right : @[dut.scala 46:33]
              state <= UInt<1>("h0") @[dut.scala 47:15]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 29:17]
        node _T_11 = asUInt(state) @[dut.scala 29:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 29:17]
        when _T_12 : @[dut.scala 29:17]
          when io.ground : @[dut.scala 51:23]
            state <= preservedWalkingDirection @[dut.scala 52:15]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 58:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 58:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 59:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 59:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 60:21]
    io.aaah <= _io_aaah_T @[dut.scala 60:11]

