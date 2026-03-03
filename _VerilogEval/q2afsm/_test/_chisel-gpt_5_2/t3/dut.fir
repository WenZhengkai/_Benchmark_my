circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    io.g <= UInt<1>("h0") @[dut.scala 15:8]
    node _T = eq(UInt<2>("h1"), state) @[dut.scala 18:17]
    when _T : @[dut.scala 18:17]
      io.g <= UInt<1>("h1") @[dut.scala 19:19]
    else :
      node _T_1 = eq(UInt<2>("h2"), state) @[dut.scala 18:17]
      when _T_1 : @[dut.scala 18:17]
        io.g <= UInt<2>("h2") @[dut.scala 20:19]
      else :
        node _T_2 = eq(UInt<2>("h3"), state) @[dut.scala 18:17]
        when _T_2 : @[dut.scala 18:17]
          io.g <= UInt<3>("h4") @[dut.scala 21:19]
    node _T_3 = eq(UInt<2>("h0"), state) @[dut.scala 25:17]
    when _T_3 : @[dut.scala 25:17]
      node _T_4 = bits(io.r, 0, 0) @[dut.scala 27:16]
      when _T_4 : @[dut.scala 27:21]
        state <= UInt<2>("h1") @[dut.scala 28:15]
      else :
        node _T_5 = bits(io.r, 1, 1) @[dut.scala 29:22]
        when _T_5 : @[dut.scala 29:27]
          state <= UInt<2>("h2") @[dut.scala 30:15]
        else :
          node _T_6 = bits(io.r, 2, 2) @[dut.scala 31:22]
          when _T_6 : @[dut.scala 31:27]
            state <= UInt<2>("h3") @[dut.scala 32:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 34:15]
    else :
      node _T_7 = eq(UInt<2>("h1"), state) @[dut.scala 25:17]
      when _T_7 : @[dut.scala 25:17]
        node _T_8 = bits(io.r, 0, 0) @[dut.scala 38:16]
        when _T_8 : @[dut.scala 38:21]
          state <= UInt<2>("h1") @[dut.scala 38:29]
        else :
          state <= UInt<2>("h0") @[dut.scala 38:56]
      else :
        node _T_9 = eq(UInt<2>("h2"), state) @[dut.scala 25:17]
        when _T_9 : @[dut.scala 25:17]
          node _T_10 = bits(io.r, 1, 1) @[dut.scala 41:16]
          when _T_10 : @[dut.scala 41:21]
            state <= UInt<2>("h2") @[dut.scala 41:29]
          else :
            state <= UInt<2>("h0") @[dut.scala 41:56]
        else :
          node _T_11 = eq(UInt<2>("h3"), state) @[dut.scala 25:17]
          when _T_11 : @[dut.scala 25:17]
            node _T_12 = bits(io.r, 2, 2) @[dut.scala 44:16]
            when _T_12 : @[dut.scala 44:21]
              state <= UInt<2>("h3") @[dut.scala 44:29]
            else :
              state <= UInt<2>("h0") @[dut.scala 44:56]


