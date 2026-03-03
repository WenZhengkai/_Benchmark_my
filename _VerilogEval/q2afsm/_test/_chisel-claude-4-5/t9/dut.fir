circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    node r0 = bits(io.r, 0, 0) @[dut.scala 17:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 18:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 19:16]
    io.g <= UInt<1>("h0") @[dut.scala 22:8]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 25:17]
    when _T : @[dut.scala 25:17]
      io.g <= UInt<1>("h0") @[dut.scala 27:12]
      node _T_1 = eq(r0, UInt<1>("h1")) @[dut.scala 28:15]
      when _T_1 : @[dut.scala 28:24]
        state <= UInt<2>("h1") @[dut.scala 29:15]
      else :
        node _T_2 = eq(r1, UInt<1>("h1")) @[dut.scala 30:21]
        when _T_2 : @[dut.scala 30:30]
          state <= UInt<2>("h2") @[dut.scala 31:15]
        else :
          node _T_3 = eq(r2, UInt<1>("h1")) @[dut.scala 32:21]
          when _T_3 : @[dut.scala 32:30]
            state <= UInt<2>("h3") @[dut.scala 33:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 35:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 25:17]
      when _T_4 : @[dut.scala 25:17]
        io.g <= UInt<1>("h1") @[dut.scala 40:12]
        node _T_5 = eq(r0, UInt<1>("h1")) @[dut.scala 41:15]
        when _T_5 : @[dut.scala 41:24]
          state <= UInt<2>("h1") @[dut.scala 42:15]
        else :
          state <= UInt<2>("h0") @[dut.scala 44:15]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 25:17]
        when _T_6 : @[dut.scala 25:17]
          io.g <= UInt<2>("h2") @[dut.scala 49:12]
          node _T_7 = eq(r1, UInt<1>("h1")) @[dut.scala 50:15]
          when _T_7 : @[dut.scala 50:24]
            state <= UInt<2>("h2") @[dut.scala 51:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 53:15]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 25:17]
          when _T_8 : @[dut.scala 25:17]
            io.g <= UInt<3>("h4") @[dut.scala 58:12]
            node _T_9 = eq(r2, UInt<1>("h1")) @[dut.scala 59:15]
            when _T_9 : @[dut.scala 59:24]
              state <= UInt<2>("h3") @[dut.scala 60:15]
            else :
              state <= UInt<2>("h0") @[dut.scala 62:15]


