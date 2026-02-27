circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 19:22]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 21:17]
    when _T : @[dut.scala 21:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 23:12]
      when _T_1 : @[dut.scala 23:24]
        state <= UInt<2>("h2") @[dut.scala 24:15]
      else :
        node _T_2 = or(io.bump_left, io.bump_right) @[dut.scala 26:27]
        when _T_2 : @[dut.scala 26:45]
          state <= UInt<2>("h1") @[dut.scala 27:17]
    else :
      node _T_3 = eq(UInt<2>("h1"), state) @[dut.scala 21:17]
      when _T_3 : @[dut.scala 21:17]
        node _T_4 = eq(io.ground, UInt<1>("h0")) @[dut.scala 33:12]
        when _T_4 : @[dut.scala 33:24]
          state <= UInt<2>("h3") @[dut.scala 34:15]
        else :
          node _T_5 = or(io.bump_left, io.bump_right) @[dut.scala 36:27]
          when _T_5 : @[dut.scala 36:45]
            state <= UInt<2>("h0") @[dut.scala 37:17]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 21:17]
        when _T_6 : @[dut.scala 21:17]
          when io.ground : @[dut.scala 43:23]
            state <= UInt<2>("h0") @[dut.scala 44:15]
        else :
          node _T_7 = eq(UInt<2>("h3"), state) @[dut.scala 21:17]
          when _T_7 : @[dut.scala 21:17]
            when io.ground : @[dut.scala 49:23]
              state <= UInt<2>("h1") @[dut.scala 50:15]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 56:25]
    io.walk_left <= _io_walk_left_T @[dut.scala 56:16]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 57:26]
    io.walk_right <= _io_walk_right_T @[dut.scala 57:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 58:20]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 58:45]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 58:36]
    io.aaah <= _io_aaah_T_2 @[dut.scala 58:11]

