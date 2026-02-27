circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:22]
    wire nextState : UInt<2> @[dut.scala 23:23]
    nextState <= state @[dut.scala 24:13]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 26:18]
    node _T_1 = asUInt(state) @[dut.scala 26:18]
    node _T_2 = eq(_T, _T_1) @[dut.scala 26:18]
    when _T_2 : @[dut.scala 26:18]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 28:13]
      when _T_3 : @[dut.scala 28:25]
        nextState <= UInt<2>("h2") @[dut.scala 29:19]
      else :
        when io.bump_left : @[dut.scala 30:34]
          nextState <= UInt<1>("h1") @[dut.scala 31:19]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 26:18]
      node _T_5 = asUInt(state) @[dut.scala 26:18]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 26:18]
      when _T_6 : @[dut.scala 26:18]
        node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 35:13]
        when _T_7 : @[dut.scala 35:25]
          nextState <= UInt<2>("h3") @[dut.scala 36:19]
        else :
          when io.bump_right : @[dut.scala 37:35]
            nextState <= UInt<1>("h0") @[dut.scala 38:19]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 26:18]
        node _T_9 = asUInt(state) @[dut.scala 26:18]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 26:18]
        when _T_10 : @[dut.scala 26:18]
          when io.ground : @[dut.scala 42:24]
            nextState <= UInt<1>("h0") @[dut.scala 43:19]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 26:18]
          node _T_12 = asUInt(state) @[dut.scala 26:18]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 26:18]
          when _T_13 : @[dut.scala 26:18]
            when io.ground : @[dut.scala 47:24]
              nextState <= UInt<1>("h1") @[dut.scala 48:19]
    state <= nextState @[dut.scala 54:9]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 57:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 57:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 58:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 58:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 59:21]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 59:49]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 59:40]
    io.aaah <= _io_aaah_T_2 @[dut.scala 59:11]
    node _T_14 = bits(reset, 0, 0) @[dut.scala 62:15]
    when _T_14 : @[dut.scala 62:23]
      state <= UInt<1>("h0") @[dut.scala 63:11]


