circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    wire g0 : UInt<1> @[dut.scala 17:23]
    g0 <= UInt<1>("h0") @[dut.scala 17:23]
    wire g1 : UInt<1> @[dut.scala 18:23]
    g1 <= UInt<1>("h0") @[dut.scala 18:23]
    wire g2 : UInt<1> @[dut.scala 19:23]
    g2 <= UInt<1>("h0") @[dut.scala 19:23]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 22:17]
    when _T : @[dut.scala 22:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 25:16]
      node _T_2 = eq(_T_1, UInt<1>("h1")) @[dut.scala 25:20]
      when _T_2 : @[dut.scala 25:29]
        state <= UInt<2>("h1") @[dut.scala 26:15]
      else :
        node _T_3 = bits(io.r, 1, 1) @[dut.scala 27:22]
        node _T_4 = eq(_T_3, UInt<1>("h1")) @[dut.scala 27:26]
        when _T_4 : @[dut.scala 27:35]
          state <= UInt<2>("h2") @[dut.scala 28:15]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 29:22]
          node _T_6 = eq(_T_5, UInt<1>("h1")) @[dut.scala 29:26]
          when _T_6 : @[dut.scala 29:35]
            state <= UInt<2>("h3") @[dut.scala 30:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 32:15]
    else :
      node _T_7 = eq(UInt<2>("h1"), state) @[dut.scala 22:17]
      when _T_7 : @[dut.scala 22:17]
        g0 <= UInt<1>("h1") @[dut.scala 37:10]
        node _T_8 = bits(io.r, 0, 0) @[dut.scala 38:16]
        node _T_9 = eq(_T_8, UInt<1>("h1")) @[dut.scala 38:20]
        when _T_9 : @[dut.scala 38:29]
          state <= UInt<2>("h1") @[dut.scala 39:15]
        else :
          state <= UInt<2>("h0") @[dut.scala 41:15]
      else :
        node _T_10 = eq(UInt<2>("h2"), state) @[dut.scala 22:17]
        when _T_10 : @[dut.scala 22:17]
          g1 <= UInt<1>("h1") @[dut.scala 46:10]
          node _T_11 = bits(io.r, 1, 1) @[dut.scala 47:16]
          node _T_12 = eq(_T_11, UInt<1>("h1")) @[dut.scala 47:20]
          when _T_12 : @[dut.scala 47:29]
            state <= UInt<2>("h2") @[dut.scala 48:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 50:15]
        else :
          node _T_13 = eq(UInt<2>("h3"), state) @[dut.scala 22:17]
          when _T_13 : @[dut.scala 22:17]
            g2 <= UInt<1>("h1") @[dut.scala 55:10]
            node _T_14 = bits(io.r, 2, 2) @[dut.scala 56:16]
            node _T_15 = eq(_T_14, UInt<1>("h1")) @[dut.scala 56:20]
            when _T_15 : @[dut.scala 56:29]
              state <= UInt<2>("h3") @[dut.scala 57:15]
            else :
              state <= UInt<2>("h0") @[dut.scala 59:15]
    node io_g_hi = cat(g2, g1) @[Cat.scala 33:92]
    node _io_g_T = cat(io_g_hi, g0) @[Cat.scala 33:92]
    io.g <= _io_g_T @[dut.scala 65:8]

