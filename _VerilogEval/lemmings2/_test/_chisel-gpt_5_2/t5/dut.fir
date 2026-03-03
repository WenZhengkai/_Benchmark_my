circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    node _T = asAsyncReset(reset) @[dut.scala 15:19]
    reg state : UInt<2>, clock with :
      reset => (_T, UInt<1>("h0")) @[dut.scala 22:24]
    node _T_1 = asUInt(UInt<1>("h0")) @[dut.scala 25:19]
    node _T_2 = asUInt(state) @[dut.scala 25:19]
    node _T_3 = eq(_T_1, _T_2) @[dut.scala 25:19]
    when _T_3 : @[dut.scala 25:19]
      node _T_4 = eq(io.ground, UInt<1>("h0")) @[dut.scala 27:14]
      when _T_4 : @[dut.scala 27:26]
        state <= UInt<2>("h2") @[dut.scala 29:17]
      else :
        node _T_5 = or(io.bump_left, io.bump_right) @[dut.scala 30:33]
        when _T_5 : @[dut.scala 30:51]
          state <= UInt<1>("h1") @[dut.scala 32:17]
        else :
          state <= UInt<1>("h0") @[dut.scala 34:17]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 25:19]
      node _T_7 = asUInt(state) @[dut.scala 25:19]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 25:19]
      when _T_8 : @[dut.scala 25:19]
        node _T_9 = eq(io.ground, UInt<1>("h0")) @[dut.scala 39:14]
        when _T_9 : @[dut.scala 39:26]
          state <= UInt<2>("h3") @[dut.scala 40:17]
        else :
          node _T_10 = or(io.bump_left, io.bump_right) @[dut.scala 41:33]
          when _T_10 : @[dut.scala 41:51]
            state <= UInt<1>("h0") @[dut.scala 42:17]
          else :
            state <= UInt<1>("h1") @[dut.scala 44:17]
      else :
        node _T_11 = asUInt(UInt<2>("h2")) @[dut.scala 25:19]
        node _T_12 = asUInt(state) @[dut.scala 25:19]
        node _T_13 = eq(_T_11, _T_12) @[dut.scala 25:19]
        when _T_13 : @[dut.scala 25:19]
          when io.ground : @[dut.scala 51:25]
            state <= UInt<1>("h0") @[dut.scala 52:17]
          else :
            state <= UInt<2>("h2") @[dut.scala 54:17]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 25:19]
          node _T_15 = asUInt(state) @[dut.scala 25:19]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 25:19]
          when _T_16 : @[dut.scala 25:19]
            when io.ground : @[dut.scala 59:25]
              state <= UInt<1>("h1") @[dut.scala 60:17]
            else :
              state <= UInt<2>("h3") @[dut.scala 62:17]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 68:29]
    io.walk_left <= _io_walk_left_T @[dut.scala 68:19]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 69:29]
    io.walk_right <= _io_walk_right_T @[dut.scala 69:19]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 70:29]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 70:53]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 70:43]
    io.aaah <= _io_aaah_T_2 @[dut.scala 70:19]

