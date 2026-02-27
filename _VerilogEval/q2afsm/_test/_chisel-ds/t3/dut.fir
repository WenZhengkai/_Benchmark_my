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
      node _T_2 = eq(_T_1, UInt<1>("h1")) @[dut.scala 20:20]
      when _T_2 : @[dut.scala 20:29]
        state <= UInt<2>("h1") @[dut.scala 21:15]
      else :
        node _T_3 = bits(io.r, 1, 1) @[dut.scala 22:22]
        node _T_4 = eq(_T_3, UInt<1>("h1")) @[dut.scala 22:26]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 22:41]
        node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 22:45]
        node _T_7 = and(_T_4, _T_6) @[dut.scala 22:34]
        when _T_7 : @[dut.scala 22:54]
          state <= UInt<2>("h2") @[dut.scala 23:15]
        else :
          node _T_8 = bits(io.r, 2, 2) @[dut.scala 24:22]
          node _T_9 = eq(_T_8, UInt<1>("h1")) @[dut.scala 24:26]
          node _T_10 = bits(io.r, 1, 1) @[dut.scala 24:41]
          node _T_11 = eq(_T_10, UInt<1>("h0")) @[dut.scala 24:45]
          node _T_12 = and(_T_9, _T_11) @[dut.scala 24:34]
          node _T_13 = bits(io.r, 0, 0) @[dut.scala 24:60]
          node _T_14 = eq(_T_13, UInt<1>("h0")) @[dut.scala 24:64]
          node _T_15 = and(_T_12, _T_14) @[dut.scala 24:53]
          when _T_15 : @[dut.scala 24:73]
            state <= UInt<2>("h3") @[dut.scala 25:15]
    else :
      node _T_16 = eq(UInt<2>("h1"), state) @[dut.scala 18:17]
      when _T_16 : @[dut.scala 18:17]
        io.g <= UInt<1>("h1") @[dut.scala 29:12]
        node _T_17 = bits(io.r, 0, 0) @[dut.scala 30:16]
        node _T_18 = eq(_T_17, UInt<1>("h0")) @[dut.scala 30:20]
        when _T_18 : @[dut.scala 30:29]
          state <= UInt<2>("h0") @[dut.scala 31:15]
      else :
        node _T_19 = eq(UInt<2>("h2"), state) @[dut.scala 18:17]
        when _T_19 : @[dut.scala 18:17]
          io.g <= UInt<2>("h2") @[dut.scala 35:12]
          node _T_20 = bits(io.r, 1, 1) @[dut.scala 36:16]
          node _T_21 = eq(_T_20, UInt<1>("h0")) @[dut.scala 36:20]
          when _T_21 : @[dut.scala 36:29]
            state <= UInt<2>("h0") @[dut.scala 37:15]
        else :
          node _T_22 = eq(UInt<2>("h3"), state) @[dut.scala 18:17]
          when _T_22 : @[dut.scala 18:17]
            io.g <= UInt<3>("h4") @[dut.scala 41:12]
            node _T_23 = bits(io.r, 2, 2) @[dut.scala 42:16]
            node _T_24 = eq(_T_23, UInt<1>("h0")) @[dut.scala 42:20]
            when _T_24 : @[dut.scala 42:29]
              state <= UInt<2>("h0") @[dut.scala 43:15]


