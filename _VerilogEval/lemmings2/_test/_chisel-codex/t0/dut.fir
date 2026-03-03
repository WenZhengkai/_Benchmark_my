circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    node _state_T = asAsyncReset(reset) @[dut.scala 20:31]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<2>("h0")) @[dut.scala 20:54]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 22:17]
    when _T : @[dut.scala 22:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 24:12]
      when _T_1 : @[dut.scala 24:24]
        state <= UInt<2>("h2") @[dut.scala 25:15]
      else :
        when io.bump_left : @[dut.scala 26:32]
          state <= UInt<2>("h1") @[dut.scala 27:15]
        else :
          state <= UInt<2>("h0") @[dut.scala 29:15]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[dut.scala 22:17]
      when _T_2 : @[dut.scala 22:17]
        node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 34:12]
        when _T_3 : @[dut.scala 34:24]
          state <= UInt<2>("h3") @[dut.scala 35:15]
        else :
          when io.bump_right : @[dut.scala 36:33]
            state <= UInt<2>("h0") @[dut.scala 37:15]
          else :
            state <= UInt<2>("h1") @[dut.scala 39:15]
      else :
        node _T_4 = eq(UInt<2>("h2"), state) @[dut.scala 22:17]
        when _T_4 : @[dut.scala 22:17]
          when io.ground : @[dut.scala 44:23]
            state <= UInt<2>("h0") @[dut.scala 45:15]
          else :
            state <= UInt<2>("h2") @[dut.scala 47:15]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 22:17]
          when _T_5 : @[dut.scala 22:17]
            when io.ground : @[dut.scala 52:23]
              state <= UInt<2>("h1") @[dut.scala 53:15]
            else :
              state <= UInt<2>("h3") @[dut.scala 55:15]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 61:27]
    io.walk_left <= _io_walk_left_T @[dut.scala 61:17]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 62:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 62:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 63:27]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 63:52]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 63:42]
    io.aaah <= _io_aaah_T_2 @[dut.scala 63:17]

