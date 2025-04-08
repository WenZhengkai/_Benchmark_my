circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, flip reset : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:26]
    when io.reset : @[dut.scala 25:18]
      state <= UInt<1>("h0") @[dut.scala 26:11]
      prevState <= UInt<1>("h0") @[dut.scala 27:15]
    node _T = eq(io.ground, UInt<1>("h0")) @[dut.scala 31:8]
    when _T : @[dut.scala 31:20]
      prevState <= state @[dut.scala 32:15]
      state <= UInt<2>("h2") @[dut.scala 33:11]
    else :
      node _T_1 = eq(state, UInt<2>("h2")) @[dut.scala 34:21]
      node _T_2 = and(_T_1, io.ground) @[dut.scala 34:36]
      when _T_2 : @[dut.scala 34:50]
        state <= prevState @[dut.scala 36:11]
    node _T_3 = eq(state, UInt<1>("h0")) @[dut.scala 40:27]
    node _T_4 = and(io.ground, _T_3) @[dut.scala 40:18]
    node _T_5 = and(_T_4, io.bump_left) @[dut.scala 40:46]
    when _T_5 : @[dut.scala 40:63]
      state <= UInt<1>("h1") @[dut.scala 41:11]
    else :
      node _T_6 = eq(state, UInt<1>("h1")) @[dut.scala 42:34]
      node _T_7 = and(io.ground, _T_6) @[dut.scala 42:25]
      node _T_8 = and(_T_7, io.bump_right) @[dut.scala 42:54]
      when _T_8 : @[dut.scala 42:72]
        state <= UInt<1>("h0") @[dut.scala 43:11]
      else :
        node _T_9 = and(io.ground, io.bump_left) @[dut.scala 44:25]
        node _T_10 = and(_T_9, io.bump_right) @[dut.scala 44:41]
        when _T_10 : @[dut.scala 44:59]
          node _T_11 = eq(state, UInt<1>("h0")) @[dut.scala 46:16]
          when _T_11 : @[dut.scala 46:36]
            state <= UInt<1>("h1") @[dut.scala 47:13]
          else :
            node _T_12 = eq(state, UInt<1>("h1")) @[dut.scala 48:23]
            when _T_12 : @[dut.scala 48:44]
              state <= UInt<1>("h0") @[dut.scala 49:13]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 54:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 54:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 55:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 55:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 56:21]
    io.aaah <= _io_aaah_T @[dut.scala 56:11]

