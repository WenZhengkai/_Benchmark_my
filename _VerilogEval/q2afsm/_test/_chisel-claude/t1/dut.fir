circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:22]
    io.g <= UInt<1>("h0") @[dut.scala 22:8]
    node r0 = bits(io.r, 0, 0) @[dut.scala 25:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 26:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 27:16]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 30:17]
    node _T_1 = asUInt(state) @[dut.scala 30:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 30:17]
    when _T_2 : @[dut.scala 30:17]
      node _T_3 = eq(r0, UInt<1>("h1")) @[dut.scala 32:15]
      when _T_3 : @[dut.scala 32:24]
        state <= UInt<1>("h1") @[dut.scala 33:15]
      else :
        node _T_4 = eq(r0, UInt<1>("h0")) @[dut.scala 34:21]
        node _T_5 = eq(r1, UInt<1>("h1")) @[dut.scala 34:35]
        node _T_6 = and(_T_4, _T_5) @[dut.scala 34:29]
        when _T_6 : @[dut.scala 34:44]
          state <= UInt<2>("h2") @[dut.scala 35:15]
        else :
          node _T_7 = eq(r0, UInt<1>("h0")) @[dut.scala 36:21]
          node _T_8 = eq(r1, UInt<1>("h0")) @[dut.scala 36:35]
          node _T_9 = and(_T_7, _T_8) @[dut.scala 36:29]
          node _T_10 = eq(r2, UInt<1>("h1")) @[dut.scala 36:49]
          node _T_11 = and(_T_9, _T_10) @[dut.scala 36:43]
          when _T_11 : @[dut.scala 36:58]
            state <= UInt<2>("h3") @[dut.scala 37:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 39:15]
    else :
      node _T_12 = asUInt(UInt<1>("h1")) @[dut.scala 30:17]
      node _T_13 = asUInt(state) @[dut.scala 30:17]
      node _T_14 = eq(_T_12, _T_13) @[dut.scala 30:17]
      when _T_14 : @[dut.scala 30:17]
        io.g <= UInt<1>("h1") @[dut.scala 45:12]
        node _T_15 = eq(r0, UInt<1>("h0")) @[dut.scala 47:15]
        when _T_15 : @[dut.scala 47:24]
          state <= UInt<1>("h0") @[dut.scala 48:15]
        else :
          state <= UInt<1>("h1") @[dut.scala 50:15]
      else :
        node _T_16 = asUInt(UInt<2>("h2")) @[dut.scala 30:17]
        node _T_17 = asUInt(state) @[dut.scala 30:17]
        node _T_18 = eq(_T_16, _T_17) @[dut.scala 30:17]
        when _T_18 : @[dut.scala 30:17]
          io.g <= UInt<2>("h2") @[dut.scala 56:12]
          node _T_19 = eq(r1, UInt<1>("h0")) @[dut.scala 58:15]
          when _T_19 : @[dut.scala 58:24]
            state <= UInt<1>("h0") @[dut.scala 59:15]
          else :
            state <= UInt<2>("h2") @[dut.scala 61:15]
        else :
          node _T_20 = asUInt(UInt<2>("h3")) @[dut.scala 30:17]
          node _T_21 = asUInt(state) @[dut.scala 30:17]
          node _T_22 = eq(_T_20, _T_21) @[dut.scala 30:17]
          when _T_22 : @[dut.scala 30:17]
            io.g <= UInt<3>("h4") @[dut.scala 67:12]
            node _T_23 = eq(r2, UInt<1>("h0")) @[dut.scala 69:15]
            when _T_23 : @[dut.scala 69:24]
              state <= UInt<1>("h0") @[dut.scala 70:15]
            else :
              state <= UInt<2>("h3") @[dut.scala 72:15]


