circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    node _state_T = asAsyncReset(reset) @[dut.scala 20:31]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<1>("h0")) @[dut.scala 21:12]
    wire nextState : UInt<2> @[dut.scala 24:30]
    nextState <= state @[dut.scala 24:30]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 26:17]
    node _T_1 = asUInt(state) @[dut.scala 26:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 26:17]
    when _T_2 : @[dut.scala 26:17]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 28:12]
      when _T_3 : @[dut.scala 28:24]
        nextState <= UInt<2>("h2") @[dut.scala 29:19]
      else :
        when io.bump_left : @[dut.scala 30:32]
          nextState <= UInt<1>("h1") @[dut.scala 32:19]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 26:17]
      node _T_5 = asUInt(state) @[dut.scala 26:17]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 26:17]
      when _T_6 : @[dut.scala 26:17]
        node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 37:12]
        when _T_7 : @[dut.scala 37:24]
          nextState <= UInt<2>("h3") @[dut.scala 38:19]
        else :
          when io.bump_right : @[dut.scala 39:33]
            nextState <= UInt<1>("h0") @[dut.scala 41:19]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 26:17]
        node _T_9 = asUInt(state) @[dut.scala 26:17]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 26:17]
        when _T_10 : @[dut.scala 26:17]
          when io.ground : @[dut.scala 47:23]
            nextState <= UInt<1>("h0") @[dut.scala 48:19]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 26:17]
          node _T_12 = asUInt(state) @[dut.scala 26:17]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 26:17]
          when _T_13 : @[dut.scala 26:17]
            when io.ground : @[dut.scala 54:23]
              nextState <= UInt<1>("h1") @[dut.scala 55:19]
    state <= nextState @[dut.scala 60:9]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 63:27]
    io.walk_left <= _io_walk_left_T @[dut.scala 63:17]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 64:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 64:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 65:27]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 65:57]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 65:47]
    io.aaah <= _io_aaah_T_2 @[dut.scala 65:17]

