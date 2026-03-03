circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    node _state_T = asAsyncReset(reset) @[dut.scala 17:31]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<2>("h0")) @[dut.scala 17:54]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 19:17]
    when _T : @[dut.scala 19:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 21:12]
      when _T_1 : @[dut.scala 21:24]
        state <= UInt<2>("h2") @[dut.scala 22:15]
      else :
        when io.bump_left : @[dut.scala 23:32]
          state <= UInt<2>("h1") @[dut.scala 24:15]
        else :
          state <= UInt<2>("h0") @[dut.scala 26:15]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[dut.scala 19:17]
      when _T_2 : @[dut.scala 19:17]
        node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 31:12]
        when _T_3 : @[dut.scala 31:24]
          state <= UInt<2>("h3") @[dut.scala 32:15]
        else :
          when io.bump_right : @[dut.scala 33:33]
            state <= UInt<2>("h0") @[dut.scala 34:15]
          else :
            state <= UInt<2>("h1") @[dut.scala 36:15]
      else :
        node _T_4 = eq(UInt<2>("h2"), state) @[dut.scala 19:17]
        when _T_4 : @[dut.scala 19:17]
          when io.ground : @[dut.scala 41:23]
            state <= UInt<2>("h0") @[dut.scala 42:15]
          else :
            state <= UInt<2>("h2") @[dut.scala 44:15]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 19:17]
          when _T_5 : @[dut.scala 19:17]
            when io.ground : @[dut.scala 49:23]
              state <= UInt<2>("h1") @[dut.scala 50:15]
            else :
              state <= UInt<2>("h3") @[dut.scala 52:15]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 58:27]
    io.walk_left <= _io_walk_left_T @[dut.scala 58:17]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 59:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 59:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 60:27]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 60:52]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 60:42]
    io.aaah <= _io_aaah_T_2 @[dut.scala 60:17]

