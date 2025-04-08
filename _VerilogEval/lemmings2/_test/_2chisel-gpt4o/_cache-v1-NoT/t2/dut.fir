circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, flip reset : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:22]
    reg preservedDirection : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:35]
    io.walk_left <= UInt<1>("h0") @[dut.scala 23:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 24:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 25:11]
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
          when io.bump_right : @[dut.scala 38:36]
            state <= UInt<1>("h1") @[dut.scala 39:17]
      else :
        node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 33:19]
        node _T_5 = asUInt(state) @[dut.scala 33:19]
        node _T_6 = eq(_T_4, _T_5) @[dut.scala 33:19]
        when _T_6 : @[dut.scala 33:19]
          node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 43:14]
          when _T_7 : @[dut.scala 43:26]
            state <= UInt<2>("h2") @[dut.scala 44:17]
            preservedDirection <= UInt<1>("h1") @[dut.scala 45:30]
          else :
            when io.bump_left : @[dut.scala 46:35]
              state <= UInt<1>("h0") @[dut.scala 47:17]
        else :
          node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 33:19]
          node _T_9 = asUInt(state) @[dut.scala 33:19]
          node _T_10 = eq(_T_8, _T_9) @[dut.scala 33:19]
          when _T_10 : @[dut.scala 33:19]
            when io.ground : @[dut.scala 51:25]
              state <= preservedDirection @[dut.scala 52:17]
    node _T_11 = asUInt(UInt<1>("h0")) @[dut.scala 59:17]
    node _T_12 = asUInt(state) @[dut.scala 59:17]
    node _T_13 = eq(_T_11, _T_12) @[dut.scala 59:17]
    when _T_13 : @[dut.scala 59:17]
      io.walk_left <= UInt<1>("h1") @[dut.scala 61:20]
    else :
      node _T_14 = asUInt(UInt<1>("h1")) @[dut.scala 59:17]
      node _T_15 = asUInt(state) @[dut.scala 59:17]
      node _T_16 = eq(_T_14, _T_15) @[dut.scala 59:17]
      when _T_16 : @[dut.scala 59:17]
        io.walk_right <= UInt<1>("h1") @[dut.scala 64:21]
      else :
        node _T_17 = asUInt(UInt<2>("h2")) @[dut.scala 59:17]
        node _T_18 = asUInt(state) @[dut.scala 59:17]
        node _T_19 = eq(_T_17, _T_18) @[dut.scala 59:17]
        when _T_19 : @[dut.scala 59:17]
          io.aaah <= UInt<1>("h1") @[dut.scala 67:15]


