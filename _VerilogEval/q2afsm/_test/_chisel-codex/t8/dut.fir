circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    node _state_T = bits(reset, 0, 0) @[dut.scala 13:46]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<2>("h0")) @[dut.scala 14:12]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 18:17]
    when _T : @[dut.scala 18:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 20:16]
      when _T_1 : @[dut.scala 20:21]
        state <= UInt<2>("h1") @[dut.scala 21:15]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 22:22]
        when _T_2 : @[dut.scala 22:27]
          state <= UInt<2>("h2") @[dut.scala 23:15]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 24:22]
          when _T_3 : @[dut.scala 24:27]
            state <= UInt<2>("h3") @[dut.scala 25:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 27:15]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 18:17]
      when _T_4 : @[dut.scala 18:17]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 31:16]
        when _T_5 : @[dut.scala 31:21]
          state <= UInt<2>("h1") @[dut.scala 31:29]
        else :
          state <= UInt<2>("h0") @[dut.scala 31:56]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 18:17]
        when _T_6 : @[dut.scala 18:17]
          node _T_7 = bits(io.r, 1, 1) @[dut.scala 34:16]
          when _T_7 : @[dut.scala 34:21]
            state <= UInt<2>("h2") @[dut.scala 34:29]
          else :
            state <= UInt<2>("h0") @[dut.scala 34:56]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 18:17]
          when _T_8 : @[dut.scala 18:17]
            node _T_9 = bits(io.r, 2, 2) @[dut.scala 37:16]
            when _T_9 : @[dut.scala 37:21]
              state <= UInt<2>("h3") @[dut.scala 37:29]
            else :
              state <= UInt<2>("h0") @[dut.scala 37:56]
    io.g <= UInt<1>("h0") @[dut.scala 42:8]
    node _T_10 = eq(UInt<2>("h1"), state) @[dut.scala 43:17]
    when _T_10 : @[dut.scala 43:17]
      io.g <= UInt<1>("h1") @[dut.scala 44:19]
    else :
      node _T_11 = eq(UInt<2>("h2"), state) @[dut.scala 43:17]
      when _T_11 : @[dut.scala 43:17]
        io.g <= UInt<2>("h2") @[dut.scala 45:19]
      else :
        node _T_12 = eq(UInt<2>("h3"), state) @[dut.scala 43:17]
        when _T_12 : @[dut.scala 43:17]
          io.g <= UInt<3>("h4") @[dut.scala 46:19]


