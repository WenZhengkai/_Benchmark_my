circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:25]
    io.g <= UInt<1>("h0") @[dut.scala 17:8]
    node _T = eq(UInt<2>("h1"), stateReg) @[dut.scala 18:20]
    when _T : @[dut.scala 18:20]
      io.g <= UInt<1>("h1") @[dut.scala 19:19]
    else :
      node _T_1 = eq(UInt<2>("h2"), stateReg) @[dut.scala 18:20]
      when _T_1 : @[dut.scala 18:20]
        io.g <= UInt<2>("h2") @[dut.scala 20:19]
      else :
        node _T_2 = eq(UInt<2>("h3"), stateReg) @[dut.scala 18:20]
        when _T_2 : @[dut.scala 18:20]
          io.g <= UInt<3>("h4") @[dut.scala 21:19]
    node _T_3 = eq(UInt<2>("h0"), stateReg) @[dut.scala 25:20]
    when _T_3 : @[dut.scala 25:20]
      node _T_4 = bits(io.r, 0, 0) @[dut.scala 27:16]
      when _T_4 : @[dut.scala 27:21]
        stateReg <= UInt<2>("h1") @[dut.scala 28:18]
      else :
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 29:23]
        node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 29:18]
        node _T_7 = bits(io.r, 1, 1) @[dut.scala 29:34]
        node _T_8 = and(_T_6, _T_7) @[dut.scala 29:27]
        when _T_8 : @[dut.scala 29:39]
          stateReg <= UInt<2>("h2") @[dut.scala 30:18]
        else :
          node _T_9 = eq(io.r, UInt<3>("h4")) @[dut.scala 31:23]
          when _T_9 : @[dut.scala 31:37]
            stateReg <= UInt<2>("h3") @[dut.scala 32:18]
    else :
      node _T_10 = eq(UInt<2>("h1"), stateReg) @[dut.scala 25:20]
      when _T_10 : @[dut.scala 25:20]
        node _T_11 = bits(io.r, 0, 0) @[dut.scala 37:17]
        node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 37:12]
        when _T_12 : @[dut.scala 37:22]
          stateReg <= UInt<2>("h0") @[dut.scala 38:18]
      else :
        node _T_13 = eq(UInt<2>("h2"), stateReg) @[dut.scala 25:20]
        when _T_13 : @[dut.scala 25:20]
          node _T_14 = bits(io.r, 1, 1) @[dut.scala 42:17]
          node _T_15 = eq(_T_14, UInt<1>("h0")) @[dut.scala 42:12]
          when _T_15 : @[dut.scala 42:22]
            stateReg <= UInt<2>("h0") @[dut.scala 43:18]
        else :
          node _T_16 = eq(UInt<2>("h3"), stateReg) @[dut.scala 25:20]
          when _T_16 : @[dut.scala 25:20]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 47:17]
            node _T_18 = eq(_T_17, UInt<1>("h0")) @[dut.scala 47:12]
            when _T_18 : @[dut.scala 47:22]
              stateReg <= UInt<2>("h0") @[dut.scala 48:18]


