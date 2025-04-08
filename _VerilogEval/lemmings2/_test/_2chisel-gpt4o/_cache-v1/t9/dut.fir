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
      io.walk_left <= UInt<1>("h1") @[dut.scala 30:20]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 31:12]
      when _T_3 : @[dut.scala 31:24]
        state <= UInt<2>("h2") @[dut.scala 32:15]
      else :
        node _T_4 = or(io.bump_left, io.bump_right) @[dut.scala 33:31]
        when _T_4 : @[dut.scala 33:49]
          state <= UInt<1>("h1") @[dut.scala 34:15]
    else :
      node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 28:17]
      node _T_6 = asUInt(state) @[dut.scala 28:17]
      node _T_7 = eq(_T_5, _T_6) @[dut.scala 28:17]
      when _T_7 : @[dut.scala 28:17]
        io.walk_right <= UInt<1>("h1") @[dut.scala 38:21]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 39:12]
        when _T_8 : @[dut.scala 39:24]
          state <= UInt<2>("h3") @[dut.scala 40:15]
        else :
          node _T_9 = or(io.bump_left, io.bump_right) @[dut.scala 41:31]
          when _T_9 : @[dut.scala 41:49]
            state <= UInt<1>("h0") @[dut.scala 42:15]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 28:17]
        node _T_11 = asUInt(state) @[dut.scala 28:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 28:17]
        when _T_12 : @[dut.scala 28:17]
          io.aaah <= UInt<1>("h1") @[dut.scala 46:15]
          when io.ground : @[dut.scala 47:23]
            state <= UInt<1>("h0") @[dut.scala 48:15]
        else :
          node _T_13 = asUInt(UInt<2>("h3")) @[dut.scala 28:17]
          node _T_14 = asUInt(state) @[dut.scala 28:17]
          node _T_15 = eq(_T_13, _T_14) @[dut.scala 28:17]
          when _T_15 : @[dut.scala 28:17]
            io.aaah <= UInt<1>("h1") @[dut.scala 52:15]
            when io.ground : @[dut.scala 53:23]
              state <= UInt<1>("h1") @[dut.scala 54:15]


