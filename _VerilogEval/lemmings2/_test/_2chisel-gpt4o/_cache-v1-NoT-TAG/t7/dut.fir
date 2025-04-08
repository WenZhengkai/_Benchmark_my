circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:22]
    io.walk_left <= UInt<1>("h0") @[dut.scala 23:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 24:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 25:11]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 28:17]
    node _T_1 = asUInt(state) @[dut.scala 28:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 28:17]
    when _T_2 : @[dut.scala 28:17]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 30:12]
      when _T_3 : @[dut.scala 30:24]
        state <= UInt<2>("h2") @[dut.scala 31:15]
      else :
        when io.bump_left : @[dut.scala 32:32]
          state <= UInt<1>("h1") @[dut.scala 33:15]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 28:17]
      node _T_5 = asUInt(state) @[dut.scala 28:17]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 28:17]
      when _T_6 : @[dut.scala 28:17]
        node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 38:12]
        when _T_7 : @[dut.scala 38:24]
          state <= UInt<2>("h3") @[dut.scala 39:15]
        else :
          when io.bump_right : @[dut.scala 40:33]
            state <= UInt<1>("h0") @[dut.scala 41:15]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 28:17]
        node _T_9 = asUInt(state) @[dut.scala 28:17]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 28:17]
        when _T_10 : @[dut.scala 28:17]
          when io.ground : @[dut.scala 46:23]
            state <= UInt<1>("h0") @[dut.scala 47:15]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 28:17]
          node _T_12 = asUInt(state) @[dut.scala 28:17]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 28:17]
          when _T_13 : @[dut.scala 28:17]
            when io.ground : @[dut.scala 52:23]
              state <= UInt<1>("h1") @[dut.scala 53:15]
    node _T_14 = asUInt(UInt<1>("h0")) @[dut.scala 60:17]
    node _T_15 = asUInt(state) @[dut.scala 60:17]
    node _T_16 = eq(_T_14, _T_15) @[dut.scala 60:17]
    when _T_16 : @[dut.scala 60:17]
      io.walk_left <= UInt<1>("h1") @[dut.scala 62:20]
    else :
      node _T_17 = asUInt(UInt<1>("h1")) @[dut.scala 60:17]
      node _T_18 = asUInt(state) @[dut.scala 60:17]
      node _T_19 = eq(_T_17, _T_18) @[dut.scala 60:17]
      when _T_19 : @[dut.scala 60:17]
        io.walk_right <= UInt<1>("h1") @[dut.scala 65:21]
      else :
        node _T_20 = asUInt(UInt<2>("h2")) @[dut.scala 60:17]
        node _T_21 = asUInt(state) @[dut.scala 60:17]
        node _T_22 = eq(_T_20, _T_21) @[dut.scala 60:17]
        when _T_22 : @[dut.scala 60:17]
          io.aaah <= UInt<1>("h1") @[dut.scala 68:15]
        else :
          node _T_23 = asUInt(UInt<2>("h3")) @[dut.scala 60:17]
          node _T_24 = asUInt(state) @[dut.scala 60:17]
          node _T_25 = eq(_T_23, _T_24) @[dut.scala 60:17]
          when _T_25 : @[dut.scala 60:17]
            io.aaah <= UInt<1>("h1") @[dut.scala 71:15]


