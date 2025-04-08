circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    io.g <= UInt<1>("h0") @[dut.scala 15:8]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:25]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 21:20]
    node _T_1 = asUInt(stateReg) @[dut.scala 21:20]
    node _T_2 = eq(_T, _T_1) @[dut.scala 21:20]
    when _T_2 : @[dut.scala 21:20]
      io.g <= UInt<1>("h0") @[dut.scala 24:12]
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 26:16]
      when _T_3 : @[dut.scala 26:21]
        stateReg <= UInt<1>("h1") @[dut.scala 27:18]
      else :
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 28:22]
        when _T_4 : @[dut.scala 28:27]
          stateReg <= UInt<2>("h2") @[dut.scala 29:18]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 30:22]
          when _T_5 : @[dut.scala 30:27]
            stateReg <= UInt<2>("h3") @[dut.scala 31:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 33:18]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 21:20]
      node _T_7 = asUInt(stateReg) @[dut.scala 21:20]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 21:20]
      when _T_8 : @[dut.scala 21:20]
        io.g <= UInt<2>("h2") @[dut.scala 39:12]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 41:16]
        when _T_9 : @[dut.scala 41:21]
          stateReg <= UInt<1>("h1") @[dut.scala 42:18]
        else :
          stateReg <= UInt<1>("h0") @[dut.scala 44:18]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 21:20]
        node _T_11 = asUInt(stateReg) @[dut.scala 21:20]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 21:20]
        when _T_12 : @[dut.scala 21:20]
          io.g <= UInt<2>("h2") @[dut.scala 50:12]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 52:16]
          when _T_13 : @[dut.scala 52:21]
            stateReg <= UInt<2>("h2") @[dut.scala 53:18]
          else :
            stateReg <= UInt<1>("h0") @[dut.scala 55:18]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 21:20]
          node _T_15 = asUInt(stateReg) @[dut.scala 21:20]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 21:20]
          when _T_16 : @[dut.scala 21:20]
            io.g <= UInt<3>("h4") @[dut.scala 61:12]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 63:16]
            when _T_17 : @[dut.scala 63:21]
              stateReg <= UInt<2>("h3") @[dut.scala 64:18]
            else :
              stateReg <= UInt<1>("h0") @[dut.scala 66:18]


