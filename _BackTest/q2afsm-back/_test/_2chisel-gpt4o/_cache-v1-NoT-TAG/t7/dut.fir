circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:25]
    io.g <= UInt<1>("h0") @[dut.scala 20:8]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 23:20]
    node _T_1 = asUInt(stateReg) @[dut.scala 23:20]
    node _T_2 = eq(_T, _T_1) @[dut.scala 23:20]
    when _T_2 : @[dut.scala 23:20]
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 25:16]
      when _T_3 : @[dut.scala 25:21]
        stateReg <= UInt<1>("h1") @[dut.scala 26:18]
      else :
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 27:22]
        when _T_4 : @[dut.scala 27:27]
          stateReg <= UInt<2>("h2") @[dut.scala 28:18]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 29:22]
          when _T_5 : @[dut.scala 29:27]
            stateReg <= UInt<2>("h3") @[dut.scala 30:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 32:18]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 23:20]
      node _T_7 = asUInt(stateReg) @[dut.scala 23:20]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 23:20]
      when _T_8 : @[dut.scala 23:20]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 37:16]
        when _T_9 : @[dut.scala 37:21]
          stateReg <= UInt<1>("h1") @[dut.scala 38:18]
        else :
          stateReg <= UInt<1>("h0") @[dut.scala 40:18]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 23:20]
        node _T_11 = asUInt(stateReg) @[dut.scala 23:20]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 23:20]
        when _T_12 : @[dut.scala 23:20]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 45:16]
          when _T_13 : @[dut.scala 45:21]
            stateReg <= UInt<2>("h2") @[dut.scala 46:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 48:18]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 23:20]
          node _T_15 = asUInt(stateReg) @[dut.scala 23:20]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 23:20]
          when _T_16 : @[dut.scala 23:20]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 53:16]
            when _T_17 : @[dut.scala 53:21]
              stateReg <= UInt<2>("h3") @[dut.scala 54:18]
            else :
              stateReg <= UInt<1>("h0") @[dut.scala 56:18]
    node _io_g_T = eq(stateReg, UInt<1>("h1")) @[dut.scala 62:24]
    node _io_g_T_1 = eq(stateReg, UInt<2>("h2")) @[dut.scala 63:25]
    node _io_g_T_2 = eq(stateReg, UInt<2>("h3")) @[dut.scala 64:25]
    node _io_g_T_3 = mux(_io_g_T_2, UInt<3>("h4"), UInt<1>("h0")) @[dut.scala 64:15]
    node _io_g_T_4 = mux(_io_g_T_1, UInt<2>("h2"), _io_g_T_3) @[dut.scala 63:15]
    node _io_g_T_5 = mux(_io_g_T, UInt<1>("h1"), _io_g_T_4) @[dut.scala 62:14]
    io.g <= _io_g_T_5 @[dut.scala 62:8]

