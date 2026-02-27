circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg currentState : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:29]
    io.walk_left <= UInt<1>("h0") @[dut.scala 22:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 23:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 24:11]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 26:24]
    node _T_1 = asUInt(currentState) @[dut.scala 26:24]
    node _T_2 = eq(_T, _T_1) @[dut.scala 26:24]
    when _T_2 : @[dut.scala 26:24]
      io.walk_left <= UInt<1>("h1") @[dut.scala 28:20]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 29:12]
      when _T_3 : @[dut.scala 29:24]
        currentState <= UInt<2>("h2") @[dut.scala 30:22]
      else :
        node _T_4 = or(io.bump_left, io.bump_right) @[dut.scala 31:31]
        when _T_4 : @[dut.scala 31:49]
          currentState <= UInt<1>("h1") @[dut.scala 32:22]
    else :
      node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 26:24]
      node _T_6 = asUInt(currentState) @[dut.scala 26:24]
      node _T_7 = eq(_T_5, _T_6) @[dut.scala 26:24]
      when _T_7 : @[dut.scala 26:24]
        io.walk_right <= UInt<1>("h1") @[dut.scala 37:21]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 38:12]
        when _T_8 : @[dut.scala 38:24]
          currentState <= UInt<2>("h3") @[dut.scala 39:22]
        else :
          node _T_9 = or(io.bump_left, io.bump_right) @[dut.scala 40:31]
          when _T_9 : @[dut.scala 40:49]
            currentState <= UInt<1>("h0") @[dut.scala 41:22]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 26:24]
        node _T_11 = asUInt(currentState) @[dut.scala 26:24]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 26:24]
        when _T_12 : @[dut.scala 26:24]
          io.aaah <= UInt<1>("h1") @[dut.scala 46:15]
          when io.ground : @[dut.scala 47:23]
            currentState <= UInt<1>("h0") @[dut.scala 48:22]
        else :
          node _T_13 = asUInt(UInt<2>("h3")) @[dut.scala 26:24]
          node _T_14 = asUInt(currentState) @[dut.scala 26:24]
          node _T_15 = eq(_T_13, _T_14) @[dut.scala 26:24]
          when _T_15 : @[dut.scala 26:24]
            io.aaah <= UInt<1>("h1") @[dut.scala 53:15]
            when io.ground : @[dut.scala 54:23]
              currentState <= UInt<1>("h1") @[dut.scala 55:22]
    node _T_16 = bits(reset, 0, 0) @[dut.scala 61:20]
    when _T_16 : @[dut.scala 61:24]
      currentState <= UInt<1>("h0") @[dut.scala 62:18]


