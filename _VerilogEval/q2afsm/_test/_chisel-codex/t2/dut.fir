circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 15:17]
    when _T : @[dut.scala 15:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 17:16]
      when _T_1 : @[dut.scala 17:21]
        state <= UInt<2>("h1") @[dut.scala 18:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 19:22]
        when _T_2 : @[dut.scala 19:27]
          state <= UInt<2>("h2") @[dut.scala 20:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 21:22]
          when _T_3 : @[dut.scala 21:27]
            state <= UInt<2>("h3") @[dut.scala 22:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 24:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 15:17]
      when _T_4 : @[dut.scala 15:17]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 28:16]
        when _T_5 : @[dut.scala 28:21]
          state <= UInt<2>("h1") @[dut.scala 28:29]
        else :
          state <= UInt<2>("h0") @[dut.scala 28:56]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 15:17]
        when _T_6 : @[dut.scala 15:17]
          node _T_7 = bits(io.r, 1, 1) @[dut.scala 31:16]
          when _T_7 : @[dut.scala 31:21]
            state <= UInt<2>("h2") @[dut.scala 31:29]
          else :
            state <= UInt<2>("h0") @[dut.scala 31:56]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 15:17]
          when _T_8 : @[dut.scala 15:17]
            node _T_9 = bits(io.r, 2, 2) @[dut.scala 34:16]
            when _T_9 : @[dut.scala 34:21]
              state <= UInt<2>("h3") @[dut.scala 34:29]
            else :
              state <= UInt<2>("h0") @[dut.scala 34:56]
    io.g <= UInt<1>("h0") @[dut.scala 39:8]
    node _T_10 = eq(UInt<2>("h1"), state) @[dut.scala 40:17]
    when _T_10 : @[dut.scala 40:17]
      io.g <= UInt<1>("h1") @[dut.scala 41:19]
    else :
      node _T_11 = eq(UInt<2>("h2"), state) @[dut.scala 40:17]
      when _T_11 : @[dut.scala 40:17]
        io.g <= UInt<2>("h2") @[dut.scala 42:19]
      else :
        node _T_12 = eq(UInt<2>("h3"), state) @[dut.scala 40:17]
        when _T_12 : @[dut.scala 40:17]
          io.g <= UInt<3>("h4") @[dut.scala 43:19]


