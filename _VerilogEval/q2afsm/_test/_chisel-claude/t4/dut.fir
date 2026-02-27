circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:22]
    io.g <= UInt<1>("h0") @[dut.scala 20:8]
    node r0 = bits(io.r, 0, 0) @[dut.scala 23:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 24:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 25:16]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 28:17]
    node _T_1 = asUInt(state) @[dut.scala 28:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 28:17]
    when _T_2 : @[dut.scala 28:17]
      when r0 : @[dut.scala 31:16]
        state <= UInt<1>("h1") @[dut.scala 32:15]
      else :
        when r1 : @[dut.scala 33:22]
          state <= UInt<2>("h2") @[dut.scala 34:15]
        else :
          when r2 : @[dut.scala 35:22]
            state <= UInt<2>("h3") @[dut.scala 36:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 38:15]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[dut.scala 28:17]
      node _T_4 = asUInt(state) @[dut.scala 28:17]
      node _T_5 = eq(_T_3, _T_4) @[dut.scala 28:17]
      when _T_5 : @[dut.scala 28:17]
        io.g <= UInt<1>("h1") @[dut.scala 44:12]
        when r0 : @[dut.scala 47:16]
          state <= UInt<1>("h1") @[dut.scala 48:15]
        else :
          state <= UInt<1>("h0") @[dut.scala 50:15]
      else :
        node _T_6 = asUInt(UInt<2>("h2")) @[dut.scala 28:17]
        node _T_7 = asUInt(state) @[dut.scala 28:17]
        node _T_8 = eq(_T_6, _T_7) @[dut.scala 28:17]
        when _T_8 : @[dut.scala 28:17]
          io.g <= UInt<2>("h2") @[dut.scala 56:12]
          when r1 : @[dut.scala 59:16]
            state <= UInt<2>("h2") @[dut.scala 60:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 62:15]
        else :
          node _T_9 = asUInt(UInt<2>("h3")) @[dut.scala 28:17]
          node _T_10 = asUInt(state) @[dut.scala 28:17]
          node _T_11 = eq(_T_9, _T_10) @[dut.scala 28:17]
          when _T_11 : @[dut.scala 28:17]
            io.g <= UInt<3>("h4") @[dut.scala 68:12]
            when r2 : @[dut.scala 71:16]
              state <= UInt<2>("h3") @[dut.scala 72:15]
            else :
              state <= UInt<1>("h0") @[dut.scala 74:15]


