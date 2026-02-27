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
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 21:16]
      when _T_1 : @[dut.scala 21:21]
        state <= UInt<2>("h1") @[dut.scala 22:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 23:22]
        when _T_2 : @[dut.scala 23:27]
          state <= UInt<2>("h2") @[dut.scala 24:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 25:22]
          when _T_3 : @[dut.scala 25:27]
            state <= UInt<2>("h3") @[dut.scala 26:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 18:17]
      when _T_4 : @[dut.scala 18:17]
        node _io_g_T = shl(UInt<1>("h1"), 0) @[dut.scala 30:19]
        io.g <= _io_g_T @[dut.scala 30:12]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 31:17]
        node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 31:12]
        when _T_6 : @[dut.scala 31:22]
          state <= UInt<2>("h0") @[dut.scala 32:15]
      else :
        node _T_7 = eq(UInt<2>("h2"), state) @[dut.scala 18:17]
        when _T_7 : @[dut.scala 18:17]
          node _io_g_T_1 = shl(UInt<1>("h1"), 1) @[dut.scala 36:19]
          io.g <= _io_g_T_1 @[dut.scala 36:12]
          node _T_8 = bits(io.r, 1, 1) @[dut.scala 37:17]
          node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 37:12]
          when _T_9 : @[dut.scala 37:22]
            state <= UInt<2>("h0") @[dut.scala 38:15]
        else :
          node _T_10 = eq(UInt<2>("h3"), state) @[dut.scala 18:17]
          when _T_10 : @[dut.scala 18:17]
            node _io_g_T_2 = shl(UInt<1>("h1"), 2) @[dut.scala 42:19]
            io.g <= _io_g_T_2 @[dut.scala 42:12]
            node _T_11 = bits(io.r, 2, 2) @[dut.scala 43:17]
            node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 43:12]
            when _T_12 : @[dut.scala 43:22]
              state <= UInt<2>("h0") @[dut.scala 44:15]


