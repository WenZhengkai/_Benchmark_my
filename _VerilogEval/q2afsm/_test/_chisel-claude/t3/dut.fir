circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    node r0 = bits(io.r, 0, 0) @[dut.scala 17:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 18:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 19:16]
    io.g <= UInt<1>("h0") @[dut.scala 22:8]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 25:17]
    when _T : @[dut.scala 25:17]
      node _T_1 = eq(r0, UInt<1>("h1")) @[dut.scala 27:15]
      when _T_1 : @[dut.scala 27:24]
        state <= UInt<2>("h1") @[dut.scala 28:15]
      else :
        node _T_2 = eq(r0, UInt<1>("h0")) @[dut.scala 29:21]
        node _T_3 = eq(r1, UInt<1>("h1")) @[dut.scala 29:35]
        node _T_4 = and(_T_2, _T_3) @[dut.scala 29:29]
        when _T_4 : @[dut.scala 29:44]
          state <= UInt<2>("h2") @[dut.scala 30:15]
        else :
          node _T_5 = eq(r0, UInt<1>("h0")) @[dut.scala 31:21]
          node _T_6 = eq(r1, UInt<1>("h0")) @[dut.scala 31:35]
          node _T_7 = and(_T_5, _T_6) @[dut.scala 31:29]
          node _T_8 = eq(r2, UInt<1>("h1")) @[dut.scala 31:49]
          node _T_9 = and(_T_7, _T_8) @[dut.scala 31:43]
          when _T_9 : @[dut.scala 31:58]
            state <= UInt<2>("h3") @[dut.scala 32:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 34:15]
    else :
      node _T_10 = eq(UInt<2>("h1"), state) @[dut.scala 25:17]
      when _T_10 : @[dut.scala 25:17]
        io.g <= UInt<1>("h1") @[dut.scala 39:12]
        node _T_11 = eq(r0, UInt<1>("h0")) @[dut.scala 40:15]
        when _T_11 : @[dut.scala 40:24]
          state <= UInt<2>("h0") @[dut.scala 41:15]
        else :
          state <= UInt<2>("h1") @[dut.scala 43:15]
      else :
        node _T_12 = eq(UInt<2>("h2"), state) @[dut.scala 25:17]
        when _T_12 : @[dut.scala 25:17]
          io.g <= UInt<2>("h2") @[dut.scala 48:12]
          node _T_13 = eq(r1, UInt<1>("h0")) @[dut.scala 49:15]
          when _T_13 : @[dut.scala 49:24]
            state <= UInt<2>("h0") @[dut.scala 50:15]
          else :
            state <= UInt<2>("h2") @[dut.scala 52:15]
        else :
          node _T_14 = eq(UInt<2>("h3"), state) @[dut.scala 25:17]
          when _T_14 : @[dut.scala 25:17]
            io.g <= UInt<3>("h4") @[dut.scala 57:12]
            node _T_15 = eq(r2, UInt<1>("h0")) @[dut.scala 58:15]
            when _T_15 : @[dut.scala 58:24]
              state <= UInt<2>("h0") @[dut.scala 59:15]
            else :
              state <= UInt<2>("h3") @[dut.scala 61:15]


