circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:25]
    io.g <= UInt<1>("h0") @[dut.scala 15:8]
    node _T = eq(UInt<2>("h0"), stateReg) @[dut.scala 18:20]
    when _T : @[dut.scala 18:20]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 20:16]
      node _T_2 = eq(_T_1, UInt<1>("h1")) @[dut.scala 20:20]
      when _T_2 : @[dut.scala 20:29]
        stateReg <= UInt<2>("h1") @[dut.scala 21:18]
      else :
        node _T_3 = bits(io.r, 1, 1) @[dut.scala 22:22]
        node _T_4 = eq(_T_3, UInt<1>("h1")) @[dut.scala 22:26]
        when _T_4 : @[dut.scala 22:35]
          stateReg <= UInt<2>("h2") @[dut.scala 23:18]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 24:22]
          node _T_6 = eq(_T_5, UInt<1>("h1")) @[dut.scala 24:26]
          when _T_6 : @[dut.scala 24:35]
            stateReg <= UInt<2>("h3") @[dut.scala 25:18]
    else :
      node _T_7 = eq(UInt<2>("h1"), stateReg) @[dut.scala 18:20]
      when _T_7 : @[dut.scala 18:20]
        io.g <= UInt<1>("h1") @[dut.scala 29:12]
        node _T_8 = bits(io.r, 0, 0) @[dut.scala 30:16]
        node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 30:20]
        when _T_9 : @[dut.scala 30:29]
          stateReg <= UInt<2>("h0") @[dut.scala 31:18]
      else :
        node _T_10 = eq(UInt<2>("h2"), stateReg) @[dut.scala 18:20]
        when _T_10 : @[dut.scala 18:20]
          io.g <= UInt<2>("h2") @[dut.scala 35:12]
          node _T_11 = bits(io.r, 1, 1) @[dut.scala 36:16]
          node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 36:20]
          when _T_12 : @[dut.scala 36:29]
            stateReg <= UInt<2>("h0") @[dut.scala 37:18]
        else :
          node _T_13 = eq(UInt<2>("h3"), stateReg) @[dut.scala 18:20]
          when _T_13 : @[dut.scala 18:20]
            io.g <= UInt<3>("h4") @[dut.scala 41:12]
            node _T_14 = bits(io.r, 2, 2) @[dut.scala 42:16]
            node _T_15 = eq(_T_14, UInt<1>("h0")) @[dut.scala 42:20]
            when _T_15 : @[dut.scala 42:29]
              stateReg <= UInt<2>("h0") @[dut.scala 43:18]


