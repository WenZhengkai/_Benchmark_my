circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 15:17]
    when _T : @[dut.scala 15:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 17:16]
      when _T_1 : @[dut.scala 17:21]
        state <= UInt<2>("h1") @[dut.scala 18:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 19:22]
        when _T_2 : @[dut.scala 19:27]
          state <= UInt<2>("h2") @[dut.scala 20:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 21:22]
          when _T_3 : @[dut.scala 21:27]
            state <= UInt<2>("h3") @[dut.scala 22:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 24:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 15:17]
      when _T_4 : @[dut.scala 15:17]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 28:16]
        when _T_5 : @[dut.scala 28:21]
          state <= UInt<2>("h1") @[dut.scala 28:29]
        else :
          state <= UInt<2>("h0") @[dut.scala 28:55]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 15:17]
        when _T_6 : @[dut.scala 15:17]
          node _T_7 = bits(io.r, 1, 1) @[dut.scala 31:16]
          when _T_7 : @[dut.scala 31:21]
            state <= UInt<2>("h2") @[dut.scala 31:29]
          else :
            state <= UInt<2>("h0") @[dut.scala 31:55]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 15:17]
          when _T_8 : @[dut.scala 15:17]
            node _T_9 = bits(io.r, 2, 2) @[dut.scala 34:16]
            when _T_9 : @[dut.scala 34:21]
              state <= UInt<2>("h3") @[dut.scala 34:29]
            else :
              state <= UInt<2>("h0") @[dut.scala 34:55]
    node _io_g_T = eq(UInt<2>("h1"), state) @[Mux.scala 81:61]
    node _io_g_T_1 = mux(_io_g_T, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 81:58]
    node _io_g_T_2 = eq(UInt<2>("h2"), state) @[Mux.scala 81:61]
    node _io_g_T_3 = mux(_io_g_T_2, UInt<2>("h2"), _io_g_T_1) @[Mux.scala 81:58]
    node _io_g_T_4 = eq(UInt<2>("h3"), state) @[Mux.scala 81:61]
    node _io_g_T_5 = mux(_io_g_T_4, UInt<3>("h4"), _io_g_T_3) @[Mux.scala 81:58]
    io.g <= _io_g_T_5 @[dut.scala 39:8]

