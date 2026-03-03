circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    node _state_T = asAsyncReset(reset) @[dut.scala 21:31]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<1>("h0")) @[dut.scala 21:54]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 24:17]
    node _T_1 = asUInt(state) @[dut.scala 24:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 24:17]
    when _T_2 : @[dut.scala 24:17]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 26:12]
      when _T_3 : @[dut.scala 26:24]
        state <= UInt<2>("h2") @[dut.scala 27:15]
      else :
        node _T_4 = or(io.bump_left, io.bump_right) @[dut.scala 28:31]
        when _T_4 : @[dut.scala 28:49]
          state <= UInt<1>("h1") @[dut.scala 30:15]
        else :
          state <= UInt<1>("h0") @[dut.scala 32:15]
    else :
      node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 24:17]
      node _T_6 = asUInt(state) @[dut.scala 24:17]
      node _T_7 = eq(_T_5, _T_6) @[dut.scala 24:17]
      when _T_7 : @[dut.scala 24:17]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 37:12]
        when _T_8 : @[dut.scala 37:24]
          state <= UInt<2>("h3") @[dut.scala 38:15]
        else :
          node _T_9 = or(io.bump_left, io.bump_right) @[dut.scala 39:31]
          when _T_9 : @[dut.scala 39:49]
            state <= UInt<1>("h0") @[dut.scala 40:15]
          else :
            state <= UInt<1>("h1") @[dut.scala 42:15]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 24:17]
        node _T_11 = asUInt(state) @[dut.scala 24:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 24:17]
        when _T_12 : @[dut.scala 24:17]
          when io.ground : @[dut.scala 49:23]
            state <= UInt<1>("h0") @[dut.scala 49:31]
          else :
            state <= UInt<2>("h2") @[dut.scala 49:63]
        else :
          node _T_13 = asUInt(UInt<2>("h3")) @[dut.scala 24:17]
          node _T_14 = asUInt(state) @[dut.scala 24:17]
          node _T_15 = eq(_T_13, _T_14) @[dut.scala 24:17]
          when _T_15 : @[dut.scala 24:17]
            when io.ground : @[dut.scala 52:23]
              state <= UInt<1>("h1") @[dut.scala 52:31]
            else :
              state <= UInt<2>("h3") @[dut.scala 52:64]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 57:27]
    io.walk_left <= _io_walk_left_T @[dut.scala 57:17]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 58:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 58:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 59:27]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 59:51]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 59:41]
    io.aaah <= _io_aaah_T_2 @[dut.scala 59:17]

