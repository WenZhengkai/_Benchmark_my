circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 18:22]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 21:17]
    when _T : @[dut.scala 21:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 23:12]
      when _T_1 : @[dut.scala 23:24]
        state <= UInt<2>("h2") @[dut.scala 24:15]
      else :
        node _T_2 = eq(io.bump_right, UInt<1>("h0")) @[dut.scala 25:34]
        node _T_3 = and(io.bump_left, _T_2) @[dut.scala 25:31]
        when _T_3 : @[dut.scala 25:50]
          state <= UInt<2>("h1") @[dut.scala 26:15]
        else :
          node _T_4 = eq(io.bump_left, UInt<1>("h0")) @[dut.scala 27:18]
          node _T_5 = and(_T_4, io.bump_right) @[dut.scala 27:32]
          when _T_5 : @[dut.scala 27:50]
            state <= UInt<2>("h0") @[dut.scala 28:15]
          else :
            node _T_6 = and(io.bump_left, io.bump_right) @[dut.scala 29:31]
            when _T_6 : @[dut.scala 29:49]
              state <= UInt<2>("h1") @[dut.scala 30:15]
    else :
      node _T_7 = eq(UInt<2>("h1"), state) @[dut.scala 21:17]
      when _T_7 : @[dut.scala 21:17]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 34:12]
        when _T_8 : @[dut.scala 34:24]
          state <= UInt<2>("h3") @[dut.scala 35:15]
        else :
          node _T_9 = eq(io.bump_right, UInt<1>("h0")) @[dut.scala 36:34]
          node _T_10 = and(io.bump_left, _T_9) @[dut.scala 36:31]
          when _T_10 : @[dut.scala 36:50]
            state <= UInt<2>("h1") @[dut.scala 37:15]
          else :
            node _T_11 = eq(io.bump_left, UInt<1>("h0")) @[dut.scala 38:18]
            node _T_12 = and(_T_11, io.bump_right) @[dut.scala 38:32]
            when _T_12 : @[dut.scala 38:50]
              state <= UInt<2>("h0") @[dut.scala 39:15]
            else :
              node _T_13 = and(io.bump_left, io.bump_right) @[dut.scala 40:31]
              when _T_13 : @[dut.scala 40:49]
                state <= UInt<2>("h0") @[dut.scala 41:15]
      else :
        node _T_14 = eq(UInt<2>("h2"), state) @[dut.scala 21:17]
        when _T_14 : @[dut.scala 21:17]
          when io.ground : @[dut.scala 45:23]
            state <= UInt<2>("h0") @[dut.scala 46:15]
        else :
          node _T_15 = eq(UInt<2>("h3"), state) @[dut.scala 21:17]
          when _T_15 : @[dut.scala 21:17]
            when io.ground : @[dut.scala 50:23]
              state <= UInt<2>("h1") @[dut.scala 51:15]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 57:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 57:16]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 58:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 58:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 59:21]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 59:46]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 59:36]
    io.aaah <= _io_aaah_T_2 @[dut.scala 59:11]

