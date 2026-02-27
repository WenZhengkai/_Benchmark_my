circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 17:22]
    wire nextState : UInt @[dut.scala 18:30]
    nextState <= state @[dut.scala 18:30]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 21:17]
    when _T : @[dut.scala 21:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 23:12]
      when _T_1 : @[dut.scala 23:24]
        nextState <= UInt<2>("h2") @[dut.scala 24:19]
      else :
        when io.bump_left : @[dut.scala 25:32]
          nextState <= UInt<2>("h1") @[dut.scala 26:19]
        else :
          nextState <= UInt<2>("h0") @[dut.scala 28:19]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[dut.scala 21:17]
      when _T_2 : @[dut.scala 21:17]
        node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 32:12]
        when _T_3 : @[dut.scala 32:24]
          nextState <= UInt<2>("h3") @[dut.scala 33:19]
        else :
          when io.bump_right : @[dut.scala 34:33]
            nextState <= UInt<2>("h0") @[dut.scala 35:19]
          else :
            nextState <= UInt<2>("h1") @[dut.scala 37:19]
      else :
        node _T_4 = eq(UInt<2>("h2"), state) @[dut.scala 21:17]
        when _T_4 : @[dut.scala 21:17]
          when io.ground : @[dut.scala 41:23]
            nextState <= UInt<2>("h0") @[dut.scala 42:19]
          else :
            nextState <= UInt<2>("h2") @[dut.scala 44:19]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 21:17]
          when _T_5 : @[dut.scala 21:17]
            when io.ground : @[dut.scala 48:23]
              nextState <= UInt<2>("h1") @[dut.scala 49:19]
            else :
              nextState <= UInt<2>("h3") @[dut.scala 51:19]
    state <= nextState @[dut.scala 56:9]
    node _io_walk_left_T = eq(state, UInt<2>("h0")) @[dut.scala 59:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 59:16]
    node _io_walk_right_T = eq(state, UInt<2>("h1")) @[dut.scala 60:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 60:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 61:21]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 61:46]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 61:36]
    io.aaah <= _io_aaah_T_2 @[dut.scala 61:11]

