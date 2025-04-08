circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    io.g <= UInt<1>("h0") @[dut.scala 17:8]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 20:17]
    when _T : @[dut.scala 20:17]
      node _T_1 = eq(io.r, UInt<1>("h0")) @[dut.scala 23:17]
      when _T_1 : @[dut.scala 23:26]
        state <= UInt<2>("h0") @[dut.scala 24:15]
      else :
        node _T_2 = bits(io.r, 0, 0) @[dut.scala 27:21]
        when _T_2 : @[dut.scala 27:26]
          state <= UInt<2>("h1") @[dut.scala 28:15]
        else :
          node _T_3 = bits(io.r, 1, 1) @[dut.scala 31:21]
          when _T_3 : @[dut.scala 31:26]
            state <= UInt<2>("h2") @[dut.scala 32:15]
          else :
            node _T_4 = bits(io.r, 2, 2) @[dut.scala 35:21]
            when _T_4 : @[dut.scala 35:26]
              state <= UInt<2>("h3") @[dut.scala 36:15]
    else :
      node _T_5 = eq(UInt<2>("h1"), state) @[dut.scala 20:17]
      when _T_5 : @[dut.scala 20:17]
        io.g <= UInt<1>("h1") @[dut.scala 41:12]
        node _T_6 = bits(io.r, 0, 0) @[dut.scala 43:16]
        when _T_6 : @[dut.scala 43:21]
          state <= UInt<2>("h1") @[dut.scala 44:15]
        else :
          state <= UInt<2>("h0") @[dut.scala 46:15]
      else :
        node _T_7 = eq(UInt<2>("h2"), state) @[dut.scala 20:17]
        when _T_7 : @[dut.scala 20:17]
          io.g <= UInt<2>("h2") @[dut.scala 51:12]
          node _T_8 = bits(io.r, 1, 1) @[dut.scala 53:16]
          when _T_8 : @[dut.scala 53:21]
            state <= UInt<2>("h2") @[dut.scala 54:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 56:15]
        else :
          node _T_9 = eq(UInt<2>("h3"), state) @[dut.scala 20:17]
          when _T_9 : @[dut.scala 20:17]
            io.g <= UInt<3>("h4") @[dut.scala 61:12]
            node _T_10 = bits(io.r, 2, 2) @[dut.scala 63:16]
            when _T_10 : @[dut.scala 63:21]
              state <= UInt<2>("h3") @[dut.scala 64:15]
            else :
              state <= UInt<2>("h0") @[dut.scala 66:15]


