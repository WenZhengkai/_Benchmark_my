circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, flip reset : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:22]
    reg preservedDirection : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:35]
    when io.reset : @[dut.scala 28:18]
      state <= UInt<1>("h0") @[dut.scala 29:11]
      preservedDirection <= UInt<1>("h0") @[dut.scala 30:24]
    else :
      node _T = asUInt(UInt<1>("h0")) @[dut.scala 33:19]
      node _T_1 = asUInt(state) @[dut.scala 33:19]
      node _T_2 = eq(_T, _T_1) @[dut.scala 33:19]
      when _T_2 : @[dut.scala 33:19]
        node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 35:14]
        when _T_3 : @[dut.scala 35:26]
          state <= UInt<2>("h2") @[dut.scala 36:17]
          preservedDirection <= UInt<1>("h0") @[dut.scala 37:30]
        else :
          node _T_4 = and(io.bump_left, io.bump_right) @[dut.scala 38:33]
          when _T_4 : @[dut.scala 38:51]
            state <= UInt<1>("h1") @[dut.scala 39:17]
          else :
            when io.bump_left : @[dut.scala 40:34]
              state <= UInt<1>("h1") @[dut.scala 41:17]
      else :
        node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 33:19]
        node _T_6 = asUInt(state) @[dut.scala 33:19]
        node _T_7 = eq(_T_5, _T_6) @[dut.scala 33:19]
        when _T_7 : @[dut.scala 33:19]
          node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 45:14]
          when _T_8 : @[dut.scala 45:26]
            state <= UInt<2>("h2") @[dut.scala 46:17]
            preservedDirection <= UInt<1>("h1") @[dut.scala 47:30]
          else :
            node _T_9 = and(io.bump_left, io.bump_right) @[dut.scala 48:33]
            when _T_9 : @[dut.scala 48:51]
              state <= UInt<1>("h0") @[dut.scala 49:17]
            else :
              when io.bump_right : @[dut.scala 50:35]
                state <= UInt<1>("h0") @[dut.scala 51:17]
        else :
          node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 33:19]
          node _T_11 = asUInt(state) @[dut.scala 33:19]
          node _T_12 = eq(_T_10, _T_11) @[dut.scala 33:19]
          when _T_12 : @[dut.scala 33:19]
            when io.ground : @[dut.scala 55:25]
              node _state_T = mux(preservedDirection, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 56:23]
              state <= _state_T @[dut.scala 56:17]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 63:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 63:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 64:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 64:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 65:21]
    io.aaah <= _io_aaah_T @[dut.scala 65:11]

