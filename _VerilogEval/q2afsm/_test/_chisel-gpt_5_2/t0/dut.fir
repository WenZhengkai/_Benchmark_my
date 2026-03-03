circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    node r0 = bits(io.r, 0, 0) @[dut.scala 14:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 15:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 16:16]
    io.g <= UInt<1>("h0") @[dut.scala 19:8]
    node _T = eq(UInt<2>("h1"), state) @[dut.scala 22:17]
    when _T : @[dut.scala 22:17]
      io.g <= UInt<1>("h1") @[dut.scala 23:19]
    else :
      node _T_1 = eq(UInt<2>("h2"), state) @[dut.scala 22:17]
      when _T_1 : @[dut.scala 22:17]
        io.g <= UInt<2>("h2") @[dut.scala 24:19]
      else :
        node _T_2 = eq(UInt<2>("h3"), state) @[dut.scala 22:17]
        when _T_2 : @[dut.scala 22:17]
          io.g <= UInt<3>("h4") @[dut.scala 25:19]
    node _T_3 = eq(UInt<2>("h0"), state) @[dut.scala 29:17]
    when _T_3 : @[dut.scala 29:17]
      node _T_4 = eq(r0, UInt<1>("h1")) @[dut.scala 31:15]
      when _T_4 : @[dut.scala 31:24]
        state <= UInt<2>("h1") @[dut.scala 32:15]
      else :
        node _T_5 = eq(r1, UInt<1>("h1")) @[dut.scala 33:21]
        when _T_5 : @[dut.scala 33:30]
          state <= UInt<2>("h2") @[dut.scala 34:15]
        else :
          node _T_6 = eq(r2, UInt<1>("h1")) @[dut.scala 35:21]
          when _T_6 : @[dut.scala 35:30]
            state <= UInt<2>("h3") @[dut.scala 36:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 38:15]
    else :
      node _T_7 = eq(UInt<2>("h1"), state) @[dut.scala 29:17]
      when _T_7 : @[dut.scala 29:17]
        node _T_8 = eq(r0, UInt<1>("h1")) @[dut.scala 43:15]
        when _T_8 : @[dut.scala 43:24]
          state <= UInt<2>("h1") @[dut.scala 43:32]
        else :
          state <= UInt<2>("h0") @[dut.scala 43:59]
      else :
        node _T_9 = eq(UInt<2>("h2"), state) @[dut.scala 29:17]
        when _T_9 : @[dut.scala 29:17]
          node _T_10 = eq(r1, UInt<1>("h1")) @[dut.scala 47:15]
          when _T_10 : @[dut.scala 47:24]
            state <= UInt<2>("h2") @[dut.scala 47:32]
          else :
            state <= UInt<2>("h0") @[dut.scala 47:59]
        else :
          node _T_11 = eq(UInt<2>("h3"), state) @[dut.scala 29:17]
          when _T_11 : @[dut.scala 29:17]
            node _T_12 = eq(r2, UInt<1>("h1")) @[dut.scala 51:15]
            when _T_12 : @[dut.scala 51:24]
              state <= UInt<2>("h3") @[dut.scala 51:32]
            else :
              state <= UInt<2>("h0") @[dut.scala 51:59]


