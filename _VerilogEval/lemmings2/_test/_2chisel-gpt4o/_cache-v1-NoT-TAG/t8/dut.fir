circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:22]
    io.walk_left <= UInt<1>("h0") @[dut.scala 24:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 25:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 26:11]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 29:17]
    node _T_1 = asUInt(state) @[dut.scala 29:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 29:17]
    when _T_2 : @[dut.scala 29:17]
      io.walk_left <= UInt<1>("h1") @[dut.scala 33:20]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 34:12]
      when _T_3 : @[dut.scala 34:24]
        state <= UInt<2>("h2") @[dut.scala 35:15]
      else :
        when io.bump_left : @[dut.scala 36:32]
          state <= UInt<1>("h1") @[dut.scala 37:15]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 29:17]
      node _T_5 = asUInt(state) @[dut.scala 29:17]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 29:17]
      when _T_6 : @[dut.scala 29:17]
        io.walk_right <= UInt<1>("h1") @[dut.scala 43:21]
        node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 44:12]
        when _T_7 : @[dut.scala 44:24]
          state <= UInt<2>("h3") @[dut.scala 45:15]
        else :
          when io.bump_right : @[dut.scala 46:33]
            state <= UInt<1>("h0") @[dut.scala 47:15]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 29:17]
        node _T_9 = asUInt(state) @[dut.scala 29:17]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 29:17]
        when _T_10 : @[dut.scala 29:17]
          io.aaah <= UInt<1>("h1") @[dut.scala 53:15]
          when io.ground : @[dut.scala 54:23]
            state <= UInt<1>("h0") @[dut.scala 55:15]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 29:17]
          node _T_12 = asUInt(state) @[dut.scala 29:17]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 29:17]
          when _T_13 : @[dut.scala 29:17]
            io.aaah <= UInt<1>("h1") @[dut.scala 61:15]
            when io.ground : @[dut.scala 62:23]
              state <= UInt<1>("h1") @[dut.scala 63:15]


