circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:22]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 18:17]
    node _T_1 = asUInt(state) @[dut.scala 18:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 18:17]
    when _T_2 : @[dut.scala 18:17]
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 20:16]
      when _T_3 : @[dut.scala 20:21]
        state <= UInt<1>("h1") @[dut.scala 21:15]
      else :
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 22:22]
        when _T_4 : @[dut.scala 22:27]
          state <= UInt<2>("h2") @[dut.scala 23:15]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 24:22]
          when _T_5 : @[dut.scala 24:27]
            state <= UInt<2>("h3") @[dut.scala 25:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 27:15]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 18:17]
      node _T_7 = asUInt(state) @[dut.scala 18:17]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 18:17]
      when _T_8 : @[dut.scala 18:17]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 32:16]
        when _T_9 : @[dut.scala 32:21]
          state <= UInt<1>("h1") @[dut.scala 32:29]
        else :
          state <= UInt<1>("h0") @[dut.scala 33:30]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 18:17]
        node _T_11 = asUInt(state) @[dut.scala 18:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 18:17]
        when _T_12 : @[dut.scala 18:17]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 37:16]
          when _T_13 : @[dut.scala 37:21]
            state <= UInt<2>("h2") @[dut.scala 37:29]
          else :
            state <= UInt<1>("h0") @[dut.scala 38:30]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 18:17]
          node _T_15 = asUInt(state) @[dut.scala 18:17]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 18:17]
          when _T_16 : @[dut.scala 18:17]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 42:16]
            when _T_17 : @[dut.scala 42:21]
              state <= UInt<2>("h3") @[dut.scala 42:29]
            else :
              state <= UInt<1>("h0") @[dut.scala 43:30]
    node _io_g_T = asUInt(state) @[dut.scala 49:11]
    node _io_g_T_1 = asUInt(UInt<1>("h1")) @[dut.scala 52:15]
    node _io_g_T_2 = asUInt(UInt<2>("h2")) @[dut.scala 53:15]
    node _io_g_T_3 = asUInt(UInt<2>("h3")) @[dut.scala 54:15]
    node _io_g_T_4 = eq(_io_g_T_1, _io_g_T) @[Mux.scala 81:61]
    node _io_g_T_5 = mux(_io_g_T_4, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 81:58]
    node _io_g_T_6 = eq(_io_g_T_2, _io_g_T) @[Mux.scala 81:61]
    node _io_g_T_7 = mux(_io_g_T_6, UInt<2>("h2"), _io_g_T_5) @[Mux.scala 81:58]
    node _io_g_T_8 = eq(_io_g_T_3, _io_g_T) @[Mux.scala 81:61]
    node _io_g_T_9 = mux(_io_g_T_8, UInt<3>("h4"), _io_g_T_7) @[Mux.scala 81:58]
    io.g <= _io_g_T_9 @[dut.scala 48:8]

