circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    io.g <= UInt<1>("h0") @[dut.scala 15:8]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 18:17]
    when _T : @[dut.scala 18:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 20:16]
      when _T_1 : @[dut.scala 20:21]
        state <= UInt<2>("h1") @[dut.scala 21:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 22:23]
        when _T_2 : @[dut.scala 22:28]
          state <= UInt<2>("h2") @[dut.scala 23:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 24:23]
          when _T_3 : @[dut.scala 24:28]
            state <= UInt<2>("h3") @[dut.scala 25:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 18:17]
      when _T_4 : @[dut.scala 18:17]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 29:17]
        node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 29:12]
        when _T_6 : @[dut.scala 29:22]
          state <= UInt<2>("h0") @[dut.scala 30:15]
      else :
        node _T_7 = eq(UInt<2>("h2"), state) @[dut.scala 18:17]
        when _T_7 : @[dut.scala 18:17]
          node _T_8 = bits(io.r, 1, 1) @[dut.scala 34:17]
          node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 34:12]
          when _T_9 : @[dut.scala 34:22]
            state <= UInt<2>("h0") @[dut.scala 35:15]
        else :
          node _T_10 = eq(UInt<2>("h3"), state) @[dut.scala 18:17]
          when _T_10 : @[dut.scala 18:17]
            node _T_11 = bits(io.r, 2, 2) @[dut.scala 39:17]
            node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 39:12]
            when _T_12 : @[dut.scala 39:22]
              state <= UInt<2>("h0") @[dut.scala 40:15]
    node _T_13 = eq(UInt<2>("h1"), state) @[dut.scala 46:17]
    when _T_13 : @[dut.scala 46:17]
      io.g <= UInt<1>("h1") @[dut.scala 48:12]
    else :
      node _T_14 = eq(UInt<2>("h2"), state) @[dut.scala 46:17]
      when _T_14 : @[dut.scala 46:17]
        io.g <= UInt<2>("h2") @[dut.scala 51:12]
      else :
        node _T_15 = eq(UInt<2>("h3"), state) @[dut.scala 46:17]
        when _T_15 : @[dut.scala 46:17]
          io.g <= UInt<3>("h4") @[dut.scala 54:12]


