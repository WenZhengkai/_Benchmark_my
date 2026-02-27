circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 22:22]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 25:25]
    io.walk_left <= _io_walk_left_T @[dut.scala 25:16]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 26:26]
    io.walk_right <= _io_walk_right_T @[dut.scala 26:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 27:20]
    io.aaah <= _io_aaah_T @[dut.scala 27:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 30:17]
    when _T : @[dut.scala 30:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 32:12]
      when _T_1 : @[dut.scala 32:24]
        state <= UInt<2>("h2") @[dut.scala 33:15]
      else :
        node _T_2 = or(io.bump_left, io.bump_right) @[dut.scala 34:31]
        when _T_2 : @[dut.scala 34:49]
          state <= UInt<2>("h1") @[dut.scala 35:15]
    else :
      node _T_3 = eq(UInt<2>("h1"), state) @[dut.scala 30:17]
      when _T_3 : @[dut.scala 30:17]
        node _T_4 = eq(io.ground, UInt<1>("h0")) @[dut.scala 40:12]
        when _T_4 : @[dut.scala 40:24]
          state <= UInt<2>("h2") @[dut.scala 41:15]
        else :
          node _T_5 = or(io.bump_left, io.bump_right) @[dut.scala 42:31]
          when _T_5 : @[dut.scala 42:49]
            state <= UInt<2>("h0") @[dut.scala 43:15]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 30:17]
        when _T_6 : @[dut.scala 30:17]
          when io.ground : @[dut.scala 48:23]
            reg state_REG : UInt, clock with :
              reset => (UInt<1>("h0"), state_REG) @[dut.scala 50:25]
            state_REG <= state @[dut.scala 50:25]
            state <= state_REG @[dut.scala 50:15]


