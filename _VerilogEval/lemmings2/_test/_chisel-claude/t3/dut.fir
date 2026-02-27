circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 23:22]
    wire nextState : UInt<2> @[dut.scala 26:23]
    nextState <= state @[dut.scala 27:13]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 29:17]
    when _T : @[dut.scala 29:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 31:12]
      when _T_1 : @[dut.scala 31:24]
        nextState <= UInt<2>("h2") @[dut.scala 32:19]
      else :
        when io.bump_left : @[dut.scala 33:32]
          nextState <= UInt<2>("h1") @[dut.scala 34:19]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[dut.scala 29:17]
      when _T_2 : @[dut.scala 29:17]
        node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 38:12]
        when _T_3 : @[dut.scala 38:24]
          nextState <= UInt<2>("h3") @[dut.scala 39:19]
        else :
          when io.bump_right : @[dut.scala 40:33]
            nextState <= UInt<2>("h0") @[dut.scala 41:19]
      else :
        node _T_4 = eq(UInt<2>("h2"), state) @[dut.scala 29:17]
        when _T_4 : @[dut.scala 29:17]
          when io.ground : @[dut.scala 45:23]
            nextState <= UInt<2>("h0") @[dut.scala 46:19]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 29:17]
          when _T_5 : @[dut.scala 29:17]
            when io.ground : @[dut.scala 50:23]
              nextState <= UInt<2>("h1") @[dut.scala 51:19]
    state <= nextState @[dut.scala 57:9]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 60:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 60:16]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 61:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 61:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 62:21]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 62:50]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 62:41]
    io.aaah <= _io_aaah_T_2 @[dut.scala 62:11]

