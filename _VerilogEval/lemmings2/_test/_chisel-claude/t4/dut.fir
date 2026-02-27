circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:22]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 24:18]
    node _T_1 = asUInt(state) @[dut.scala 24:18]
    node _T_2 = eq(_T, _T_1) @[dut.scala 24:18]
    when _T_2 : @[dut.scala 24:18]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 26:13]
      when _T_3 : @[dut.scala 26:25]
        state <= UInt<2>("h2") @[dut.scala 27:15]
      else :
        when io.bump_left : @[dut.scala 28:33]
          state <= UInt<1>("h1") @[dut.scala 29:15]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 24:18]
      node _T_5 = asUInt(state) @[dut.scala 24:18]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 24:18]
      when _T_6 : @[dut.scala 24:18]
        node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 34:13]
        when _T_7 : @[dut.scala 34:25]
          state <= UInt<2>("h3") @[dut.scala 35:15]
        else :
          when io.bump_right : @[dut.scala 36:34]
            state <= UInt<1>("h0") @[dut.scala 37:15]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 24:18]
        node _T_9 = asUInt(state) @[dut.scala 24:18]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 24:18]
        when _T_10 : @[dut.scala 24:18]
          when io.ground : @[dut.scala 42:24]
            state <= UInt<1>("h0") @[dut.scala 43:15]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 24:18]
          node _T_12 = asUInt(state) @[dut.scala 24:18]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 24:18]
          when _T_13 : @[dut.scala 24:18]
            when io.ground : @[dut.scala 48:24]
              state <= UInt<1>("h1") @[dut.scala 49:15]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 55:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 55:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 56:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 56:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 57:21]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 57:44]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 57:35]
    io.aaah <= _io_aaah_T_2 @[dut.scala 57:11]

