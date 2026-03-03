circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    node _state_T = asAsyncReset(reset) @[dut.scala 19:31]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<1>("h0")) @[dut.scala 20:12]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 23:17]
    node _T_1 = asUInt(state) @[dut.scala 23:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 23:17]
    when _T_2 : @[dut.scala 23:17]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 25:12]
      when _T_3 : @[dut.scala 25:24]
        state <= UInt<2>("h2") @[dut.scala 27:15]
      else :
        node _T_4 = and(io.bump_left, io.bump_right) @[dut.scala 29:27]
        when _T_4 : @[dut.scala 29:45]
          state <= UInt<1>("h1") @[dut.scala 30:17]
        else :
          when io.bump_left : @[dut.scala 31:34]
            state <= UInt<1>("h1") @[dut.scala 32:17]
          else :
            when io.bump_right : @[dut.scala 33:35]
              state <= UInt<1>("h0") @[dut.scala 34:17]
    else :
      node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 23:17]
      node _T_6 = asUInt(state) @[dut.scala 23:17]
      node _T_7 = eq(_T_5, _T_6) @[dut.scala 23:17]
      when _T_7 : @[dut.scala 23:17]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 40:12]
        when _T_8 : @[dut.scala 40:24]
          state <= UInt<2>("h3") @[dut.scala 42:15]
        else :
          node _T_9 = and(io.bump_left, io.bump_right) @[dut.scala 44:27]
          when _T_9 : @[dut.scala 44:45]
            state <= UInt<1>("h0") @[dut.scala 45:17]
          else :
            when io.bump_right : @[dut.scala 46:35]
              state <= UInt<1>("h0") @[dut.scala 47:17]
            else :
              when io.bump_left : @[dut.scala 48:34]
                state <= UInt<1>("h1") @[dut.scala 49:17]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 23:17]
        node _T_11 = asUInt(state) @[dut.scala 23:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 23:17]
        when _T_12 : @[dut.scala 23:17]
          when io.ground : @[dut.scala 55:23]
            state <= UInt<1>("h0") @[dut.scala 57:15]
        else :
          node _T_13 = asUInt(UInt<2>("h3")) @[dut.scala 23:17]
          node _T_14 = asUInt(state) @[dut.scala 23:17]
          node _T_15 = eq(_T_13, _T_14) @[dut.scala 23:17]
          when _T_15 : @[dut.scala 23:17]
            when io.ground : @[dut.scala 62:23]
              state <= UInt<1>("h1") @[dut.scala 64:15]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 70:27]
    io.walk_left <= _io_walk_left_T @[dut.scala 70:17]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 71:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 71:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 72:27]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 72:57]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 72:47]
    io.aaah <= _io_aaah_T_2 @[dut.scala 72:17]

