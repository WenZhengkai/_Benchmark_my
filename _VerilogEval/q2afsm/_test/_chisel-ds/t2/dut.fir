circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:25]
    io.g <= UInt<1>("h0") @[dut.scala 17:8]
    node _T = eq(UInt<2>("h0"), stateReg) @[dut.scala 20:20]
    when _T : @[dut.scala 20:20]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 22:16]
      when _T_1 : @[dut.scala 22:21]
        stateReg <= UInt<2>("h1") @[dut.scala 23:18]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 24:22]
        when _T_2 : @[dut.scala 24:27]
          stateReg <= UInt<2>("h2") @[dut.scala 25:18]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 26:22]
          when _T_3 : @[dut.scala 26:27]
            stateReg <= UInt<2>("h3") @[dut.scala 27:18]
    else :
      node _T_4 = eq(UInt<2>("h1"), stateReg) @[dut.scala 20:20]
      when _T_4 : @[dut.scala 20:20]
        io.g <= UInt<1>("h1") @[dut.scala 31:12]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 32:17]
        node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 32:12]
        when _T_6 : @[dut.scala 32:22]
          stateReg <= UInt<2>("h0") @[dut.scala 33:18]
      else :
        node _T_7 = eq(UInt<2>("h2"), stateReg) @[dut.scala 20:20]
        when _T_7 : @[dut.scala 20:20]
          io.g <= UInt<2>("h2") @[dut.scala 37:12]
          node _T_8 = bits(io.r, 1, 1) @[dut.scala 38:17]
          node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 38:12]
          when _T_9 : @[dut.scala 38:22]
            stateReg <= UInt<2>("h0") @[dut.scala 39:18]
        else :
          node _T_10 = eq(UInt<2>("h3"), stateReg) @[dut.scala 20:20]
          when _T_10 : @[dut.scala 20:20]
            io.g <= UInt<3>("h4") @[dut.scala 43:12]
            node _T_11 = bits(io.r, 2, 2) @[dut.scala 44:17]
            node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 44:12]
            when _T_12 : @[dut.scala 44:22]
              stateReg <= UInt<2>("h0") @[dut.scala 45:18]


