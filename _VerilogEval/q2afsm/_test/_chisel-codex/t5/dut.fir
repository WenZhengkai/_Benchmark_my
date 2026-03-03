circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 11:22]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 14:17]
    when _T : @[dut.scala 14:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 16:16]
      when _T_1 : @[dut.scala 16:21]
        state <= UInt<2>("h1") @[dut.scala 17:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 18:22]
        when _T_2 : @[dut.scala 18:27]
          state <= UInt<2>("h2") @[dut.scala 19:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 20:22]
          when _T_3 : @[dut.scala 20:27]
            state <= UInt<2>("h3") @[dut.scala 21:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 23:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 14:17]
      when _T_4 : @[dut.scala 14:17]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 27:16]
        when _T_5 : @[dut.scala 27:21]
          state <= UInt<2>("h1") @[dut.scala 27:29]
        else :
          state <= UInt<2>("h0") @[dut.scala 28:28]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 14:17]
        when _T_6 : @[dut.scala 14:17]
          node _T_7 = bits(io.r, 1, 1) @[dut.scala 31:16]
          when _T_7 : @[dut.scala 31:21]
            state <= UInt<2>("h2") @[dut.scala 31:29]
          else :
            state <= UInt<2>("h0") @[dut.scala 32:28]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 14:17]
          when _T_8 : @[dut.scala 14:17]
            node _T_9 = bits(io.r, 2, 2) @[dut.scala 35:16]
            when _T_9 : @[dut.scala 35:21]
              state <= UInt<2>("h3") @[dut.scala 35:29]
            else :
              state <= UInt<2>("h0") @[dut.scala 36:28]
    node _io_g_T = eq(UInt<2>("h1"), state) @[Mux.scala 81:61]
    node _io_g_T_1 = mux(_io_g_T, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 81:58]
    node _io_g_T_2 = eq(UInt<2>("h2"), state) @[Mux.scala 81:61]
    node _io_g_T_3 = mux(_io_g_T_2, UInt<2>("h2"), _io_g_T_1) @[Mux.scala 81:58]
    node _io_g_T_4 = eq(UInt<2>("h3"), state) @[Mux.scala 81:61]
    node _io_g_T_5 = mux(_io_g_T_4, UInt<3>("h4"), _io_g_T_3) @[Mux.scala 81:58]
    io.g <= _io_g_T_5 @[dut.scala 41:8]

