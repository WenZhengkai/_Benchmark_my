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
      when _T_1 : @[dut.scala 20:21]
        stateReg <= UInt<2>("h1") @[dut.scala 21:18]
      else :
        node _T_2 = bits(io.r, 0, 0) @[dut.scala 22:23]
        node _T_3 = eq(_T_2, UInt<1>("h0")) @[dut.scala 22:18]
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 22:34]
        node _T_5 = and(_T_3, _T_4) @[dut.scala 22:27]
        when _T_5 : @[dut.scala 22:39]
          stateReg <= UInt<2>("h2") @[dut.scala 23:18]
        else :
          node _T_6 = eq(io.r, UInt<3>("h4")) @[dut.scala 24:23]
          when _T_6 : @[dut.scala 24:37]
            stateReg <= UInt<2>("h3") @[dut.scala 25:18]
    else :
      node _T_7 = eq(UInt<2>("h1"), stateReg) @[dut.scala 18:20]
      when _T_7 : @[dut.scala 18:20]
        io.g <= UInt<1>("h1") @[dut.scala 30:12]
        node _T_8 = bits(io.r, 0, 0) @[dut.scala 31:17]
        node _T_9 = eq(_T_8, UInt<1>("h0")) @[dut.scala 31:12]
        when _T_9 : @[dut.scala 31:22]
          stateReg <= UInt<2>("h0") @[dut.scala 32:18]
      else :
        node _T_10 = eq(UInt<2>("h2"), stateReg) @[dut.scala 18:20]
        when _T_10 : @[dut.scala 18:20]
          io.g <= UInt<2>("h2") @[dut.scala 37:12]
          node _T_11 = bits(io.r, 1, 1) @[dut.scala 38:17]
          node _T_12 = eq(_T_11, UInt<1>("h0")) @[dut.scala 38:12]
          when _T_12 : @[dut.scala 38:22]
            stateReg <= UInt<2>("h0") @[dut.scala 39:18]
        else :
          node _T_13 = eq(UInt<2>("h3"), stateReg) @[dut.scala 18:20]
          when _T_13 : @[dut.scala 18:20]
            io.g <= UInt<3>("h4") @[dut.scala 44:12]
            node _T_14 = bits(io.r, 2, 2) @[dut.scala 45:17]
            node _T_15 = eq(_T_14, UInt<1>("h0")) @[dut.scala 45:12]
            when _T_15 : @[dut.scala 45:22]
              stateReg <= UInt<2>("h0") @[dut.scala 46:18]


