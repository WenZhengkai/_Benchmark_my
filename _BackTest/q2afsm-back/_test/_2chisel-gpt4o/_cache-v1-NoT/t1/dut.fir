circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg currentState : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:29]
    io.g <= UInt<1>("h0") @[dut.scala 20:8]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 23:24]
    node _T_1 = asUInt(currentState) @[dut.scala 23:24]
    node _T_2 = eq(_T, _T_1) @[dut.scala 23:24]
    when _T_2 : @[dut.scala 23:24]
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 25:16]
      when _T_3 : @[dut.scala 25:21]
        currentState <= UInt<1>("h1") @[dut.scala 26:22]
      else :
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 27:22]
        when _T_4 : @[dut.scala 27:27]
          currentState <= UInt<2>("h2") @[dut.scala 28:22]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 29:22]
          when _T_5 : @[dut.scala 29:27]
            currentState <= UInt<2>("h3") @[dut.scala 30:22]
          else :
            currentState <= UInt<1>("h0") @[dut.scala 32:22]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 23:24]
      node _T_7 = asUInt(currentState) @[dut.scala 23:24]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 23:24]
      when _T_8 : @[dut.scala 23:24]
        io.g <= UInt<1>("h1") @[dut.scala 36:12]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 37:16]
        when _T_9 : @[dut.scala 37:21]
          currentState <= UInt<1>("h1") @[dut.scala 38:22]
        else :
          currentState <= UInt<1>("h0") @[dut.scala 40:22]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 23:24]
        node _T_11 = asUInt(currentState) @[dut.scala 23:24]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 23:24]
        when _T_12 : @[dut.scala 23:24]
          io.g <= UInt<2>("h2") @[dut.scala 44:12]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 45:16]
          when _T_13 : @[dut.scala 45:21]
            currentState <= UInt<2>("h2") @[dut.scala 46:22]
          else :
            currentState <= UInt<1>("h0") @[dut.scala 48:22]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 23:24]
          node _T_15 = asUInt(currentState) @[dut.scala 23:24]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 23:24]
          when _T_16 : @[dut.scala 23:24]
            io.g <= UInt<3>("h4") @[dut.scala 52:12]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 53:16]
            when _T_17 : @[dut.scala 53:21]
              currentState <= UInt<2>("h3") @[dut.scala 54:22]
            else :
              currentState <= UInt<1>("h0") @[dut.scala 56:22]


