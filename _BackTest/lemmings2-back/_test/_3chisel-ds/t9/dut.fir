circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:22]
    node _io_walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 22:26]
    io.walk_left <= _io_walk_left_T @[dut.scala 22:16]
    node _io_walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 23:27]
    io.walk_right <= _io_walk_right_T @[dut.scala 23:17]
    node _io_aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 24:21]
    node _io_aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 24:51]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 24:41]
    io.aaah <= _io_aaah_T_2 @[dut.scala 24:11]
    when io.ground : @[dut.scala 27:19]
      node _T = asUInt(UInt<1>("h0")) @[dut.scala 29:19]
      node _T_1 = asUInt(state) @[dut.scala 29:19]
      node _T_2 = eq(_T, _T_1) @[dut.scala 29:19]
      when _T_2 : @[dut.scala 29:19]
        when io.bump_left : @[dut.scala 31:28]
          state <= UInt<1>("h1") @[dut.scala 32:17]
      else :
        node _T_3 = asUInt(UInt<1>("h1")) @[dut.scala 29:19]
        node _T_4 = asUInt(state) @[dut.scala 29:19]
        node _T_5 = eq(_T_3, _T_4) @[dut.scala 29:19]
        when _T_5 : @[dut.scala 29:19]
          when io.bump_right : @[dut.scala 36:29]
            state <= UInt<1>("h0") @[dut.scala 37:17]
        else :
          node _T_6 = asUInt(UInt<2>("h2")) @[dut.scala 29:19]
          node _T_7 = asUInt(state) @[dut.scala 29:19]
          node _T_8 = eq(_T_6, _T_7) @[dut.scala 29:19]
          when _T_8 : @[dut.scala 29:19]
            state <= UInt<1>("h0") @[dut.scala 41:15]
          else :
            node _T_9 = asUInt(UInt<2>("h3")) @[dut.scala 29:19]
            node _T_10 = asUInt(state) @[dut.scala 29:19]
            node _T_11 = eq(_T_9, _T_10) @[dut.scala 29:19]
            when _T_11 : @[dut.scala 29:19]
              state <= UInt<1>("h1") @[dut.scala 44:15]
    else :
      node _T_12 = asUInt(UInt<1>("h0")) @[dut.scala 49:19]
      node _T_13 = asUInt(state) @[dut.scala 49:19]
      node _T_14 = eq(_T_12, _T_13) @[dut.scala 49:19]
      when _T_14 : @[dut.scala 49:19]
        state <= UInt<2>("h2") @[dut.scala 51:15]
      else :
        node _T_15 = asUInt(UInt<1>("h1")) @[dut.scala 49:19]
        node _T_16 = asUInt(state) @[dut.scala 49:19]
        node _T_17 = eq(_T_15, _T_16) @[dut.scala 49:19]
        when _T_17 : @[dut.scala 49:19]
          state <= UInt<2>("h3") @[dut.scala 54:15]


