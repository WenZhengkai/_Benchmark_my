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
      node _T_4 = eq(_T_3, UInt<1>("h1")) @[dut.scala 25:20]
      when _T_4 : @[dut.scala 25:29]
        stateReg <= UInt<1>("h1") @[dut.scala 26:18]
      else :
        node _T_5 = bits(io.r, 1, 1) @[dut.scala 27:22]
        node _T_6 = eq(_T_5, UInt<1>("h1")) @[dut.scala 27:26]
        when _T_6 : @[dut.scala 27:35]
          stateReg <= UInt<2>("h2") @[dut.scala 28:18]
        else :
          node _T_7 = bits(io.r, 2, 2) @[dut.scala 29:22]
          node _T_8 = eq(_T_7, UInt<1>("h1")) @[dut.scala 29:26]
          when _T_8 : @[dut.scala 29:35]
            stateReg <= UInt<2>("h3") @[dut.scala 30:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 32:18]
    else :
      node _T_9 = asUInt(UInt<1>("h1")) @[dut.scala 23:20]
      node _T_10 = asUInt(stateReg) @[dut.scala 23:20]
      node _T_11 = eq(_T_9, _T_10) @[dut.scala 23:20]
      when _T_11 : @[dut.scala 23:20]
        node _T_12 = bits(io.r, 0, 0) @[dut.scala 36:16]
        node _T_13 = eq(_T_12, UInt<1>("h1")) @[dut.scala 36:20]
        when _T_13 : @[dut.scala 36:29]
          stateReg <= UInt<1>("h1") @[dut.scala 37:18]
        else :
          stateReg <= UInt<1>("h0") @[dut.scala 39:18]
        io.g <= UInt<1>("h1") @[dut.scala 41:12]
      else :
        node _T_14 = asUInt(UInt<2>("h2")) @[dut.scala 23:20]
        node _T_15 = asUInt(stateReg) @[dut.scala 23:20]
        node _T_16 = eq(_T_14, _T_15) @[dut.scala 23:20]
        when _T_16 : @[dut.scala 23:20]
          node _T_17 = bits(io.r, 1, 1) @[dut.scala 44:16]
          node _T_18 = eq(_T_17, UInt<1>("h1")) @[dut.scala 44:20]
          when _T_18 : @[dut.scala 44:29]
            stateReg <= UInt<2>("h2") @[dut.scala 45:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 47:18]
          io.g <= UInt<2>("h2") @[dut.scala 49:12]
        else :
          node _T_19 = asUInt(UInt<2>("h3")) @[dut.scala 23:20]
          node _T_20 = asUInt(stateReg) @[dut.scala 23:20]
          node _T_21 = eq(_T_19, _T_20) @[dut.scala 23:20]
          when _T_21 : @[dut.scala 23:20]
            node _T_22 = bits(io.r, 2, 2) @[dut.scala 52:16]
            node _T_23 = eq(_T_22, UInt<1>("h1")) @[dut.scala 52:20]
            when _T_23 : @[dut.scala 52:29]
              stateReg <= UInt<2>("h3") @[dut.scala 53:18]
            else :
              stateReg <= UInt<1>("h0") @[dut.scala 55:18]
            io.g <= UInt<3>("h4") @[dut.scala 57:12]


