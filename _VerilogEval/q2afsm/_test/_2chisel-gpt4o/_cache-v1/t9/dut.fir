circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    io.g <= UInt<1>("h0") @[dut.scala 17:8]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 20:17]
    when _T : @[dut.scala 20:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 23:16]
      when _T_1 : @[dut.scala 23:21]
        state <= UInt<2>("h1") @[dut.scala 24:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 25:23]
        when _T_2 : @[dut.scala 25:28]
          state <= UInt<2>("h2") @[dut.scala 26:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 27:23]
          when _T_3 : @[dut.scala 27:28]
            state <= UInt<2>("h3") @[dut.scala 28:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 20:17]
      when _T_4 : @[dut.scala 20:17]
        io.g <= UInt<1>("h1") @[dut.scala 34:12]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 35:17]
        node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 35:12]
        when _T_6 : @[dut.scala 35:22]
          state <= UInt<2>("h0") @[dut.scala 36:15]
      else :
        node _T_7 = eq(UInt<2>("h2"), state) @[dut.scala 20:17]
        when _T_7 : @[dut.scala 20:17]
          io.g <= UInt<1>("h1") @[dut.scala 42:12]
          node _T_8 = bits(io.r, 1, 1) @[dut.scala 43:17]
          node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 43:12]
          when _T_9 : @[dut.scala 43:22]
            state <= UInt<2>("h0") @[dut.scala 44:15]
        else :
          node _T_10 = eq(UInt<2>("h3"), state) @[dut.scala 20:17]
          when _T_10 : @[dut.scala 20:17]
            io.g <= UInt<3>("h4") @[dut.scala 50:12]
            node _T_11 = bits(io.r, 2, 2) @[dut.scala 51:17]
            node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 51:12]
            when _T_12 : @[dut.scala 51:22]
              state <= UInt<2>("h0") @[dut.scala 52:15]


