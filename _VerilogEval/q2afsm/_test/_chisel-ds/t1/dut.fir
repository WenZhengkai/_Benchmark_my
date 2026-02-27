circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    io.g <= UInt<1>("h0") @[dut.scala 15:8]
    node _T = eq(UInt<2>("h1"), state) @[dut.scala 16:17]
    when _T : @[dut.scala 16:17]
      io.g <= UInt<1>("h1") @[dut.scala 17:19]
    else :
      node _T_1 = eq(UInt<2>("h2"), state) @[dut.scala 16:17]
      when _T_1 : @[dut.scala 16:17]
        io.g <= UInt<2>("h2") @[dut.scala 18:19]
      else :
        node _T_2 = eq(UInt<2>("h3"), state) @[dut.scala 16:17]
        when _T_2 : @[dut.scala 16:17]
          io.g <= UInt<3>("h4") @[dut.scala 19:19]
    node _T_3 = eq(UInt<2>("h0"), state) @[dut.scala 23:17]
    when _T_3 : @[dut.scala 23:17]
      node _T_4 = bits(io.r, 0, 0) @[dut.scala 25:16]
      when _T_4 : @[dut.scala 25:21]
        state <= UInt<2>("h1") @[dut.scala 26:15]
      else :
        node _T_5 = bits(io.r, 1, 1) @[dut.scala 27:22]
        when _T_5 : @[dut.scala 27:27]
          state <= UInt<2>("h2") @[dut.scala 28:15]
        else :
          node _T_6 = bits(io.r, 2, 2) @[dut.scala 29:22]
          when _T_6 : @[dut.scala 29:27]
            state <= UInt<2>("h3") @[dut.scala 30:15]
    else :
      node _T_7 = eq(UInt<2>("h1"), state) @[dut.scala 23:17]
      when _T_7 : @[dut.scala 23:17]
        node _T_8 = bits(io.r, 0, 0) @[dut.scala 34:17]
        node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 34:12]
        when _T_9 : @[dut.scala 34:22]
          state <= UInt<2>("h0") @[dut.scala 35:15]
      else :
        node _T_10 = eq(UInt<2>("h2"), state) @[dut.scala 23:17]
        when _T_10 : @[dut.scala 23:17]
          node _T_11 = bits(io.r, 1, 1) @[dut.scala 39:17]
          node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 39:12]
          when _T_12 : @[dut.scala 39:22]
            state <= UInt<2>("h0") @[dut.scala 40:15]
        else :
          node _T_13 = eq(UInt<2>("h3"), state) @[dut.scala 23:17]
          when _T_13 : @[dut.scala 23:17]
            node _T_14 = bits(io.r, 2, 2) @[dut.scala 44:17]
            node _T_15 = eq(_T_14, UInt<1>("h0")) @[dut.scala 44:12]
            when _T_15 : @[dut.scala 44:22]
              state <= UInt<2>("h0") @[dut.scala 45:15]


