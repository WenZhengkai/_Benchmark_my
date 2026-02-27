circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:25]
    io.g <= UInt<1>("h0") @[dut.scala 19:8]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 22:20]
    node _T_1 = asUInt(stateReg) @[dut.scala 22:20]
    node _T_2 = eq(_T, _T_1) @[dut.scala 22:20]
    when _T_2 : @[dut.scala 22:20]
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
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 22:20]
      node _T_7 = asUInt(stateReg) @[dut.scala 22:20]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 22:20]
      when _T_8 : @[dut.scala 22:20]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 38:16]
        when _T_9 : @[dut.scala 38:21]
          stateReg <= UInt<1>("h1") @[dut.scala 39:18]
        else :
          stateReg <= UInt<1>("h0") @[dut.scala 41:18]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 22:20]
        node _T_11 = asUInt(stateReg) @[dut.scala 22:20]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 22:20]
        when _T_12 : @[dut.scala 22:20]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 47:16]
          when _T_13 : @[dut.scala 47:21]
            stateReg <= UInt<2>("h2") @[dut.scala 48:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 50:18]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 22:20]
          node _T_15 = asUInt(stateReg) @[dut.scala 22:20]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 22:20]
          when _T_16 : @[dut.scala 22:20]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 56:16]
            when _T_17 : @[dut.scala 56:21]
              stateReg <= UInt<2>("h3") @[dut.scala 57:18]
            else :
              stateReg <= UInt<1>("h0") @[dut.scala 59:18]
    io.g <= UInt<1>("h0") @[dut.scala 65:8]
    node _T_18 = asUInt(UInt<1>("h1")) @[dut.scala 66:20]
    node _T_19 = asUInt(stateReg) @[dut.scala 66:20]
    node _T_20 = eq(_T_18, _T_19) @[dut.scala 66:20]
    when _T_20 : @[dut.scala 66:20]
      io.g <= UInt<1>("h1") @[dut.scala 67:24]
    else :
      node _T_21 = asUInt(UInt<2>("h2")) @[dut.scala 66:20]
      node _T_22 = asUInt(stateReg) @[dut.scala 66:20]
      node _T_23 = eq(_T_21, _T_22) @[dut.scala 66:20]
      when _T_23 : @[dut.scala 66:20]
        io.g <= UInt<2>("h2") @[dut.scala 68:24]
      else :
        node _T_24 = asUInt(UInt<2>("h3")) @[dut.scala 66:20]
        node _T_25 = asUInt(stateReg) @[dut.scala 66:20]
        node _T_26 = eq(_T_24, _T_25) @[dut.scala 66:20]
        when _T_26 : @[dut.scala 66:20]
          io.g <= UInt<3>("h4") @[dut.scala 69:24]


